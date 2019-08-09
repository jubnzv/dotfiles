// The MIT License (MIT)
// Copyright (C) 2019 Georgy Komarov <jubnzv@gmail.com>

package main

import (
	"errors"
	"fmt"
	"io/ioutil"
	"os"
	"os/user"
	"path/filepath"
	"reflect"
	"strings"

	tmux "github.com/jubnzv/go-tmux"
	"gopkg.in/alecthomas/kingpin.v2"
	"gopkg.in/yaml.v2"
)

// Default path to store session configurations
var DEFAULT_PATH = "~/.tmux/sessions/"

// Message to print in stoud when session differs
var DIFF_MESSAGE = " "

const (
	version = "1.1.0"
)

var (
	app     = kingpin.New("tmux-session", "A utility to manage tmux sessions.")
	verbose = app.Flag("verbose", "Enable additional output").Bool()

	save     = app.Command("save", "Write current tmux session in yaml")
	savePath = save.Arg("path", "Path to saving yaml configuration").String()
	fileName = save.Arg("name", "yaml file name").String()

	load     = app.Command("load", "Load tmux configuration from a yaml file")
	loadPath = load.Arg("path", "Path to yaml configuration").String()

	diff          = app.Command("diff", "Check that the current session is different from saved yaml configuration.")
	diffPath      = diff.Arg("path", "Path to yaml configuration").String()
	print_message = diff.Flag("print-message", "Print message in stdout when sessions are different").Bool()
)

// Represents a tmux window configuration
type WindowConf struct {
	WindowName     string `yaml:"window_name"`
	StartDirectory string `yaml:"start_directory"`
}

// Represents a tmux session configuration
type SessionConf struct {
	SessionName string       `yaml:"session_name"`
	Windows     []WindowConf `yaml:"windows"`
}

// Expand ~ in path.
func expandTilde(path string) (string, error) {
	if strings.HasPrefix(path, "~/") {
		usr, err := user.Current()
		if err != nil {
			return "", err
		}
		path = filepath.Join(usr.HomeDir, path[2:])
	}
	return path, nil
}

// Generate tmux session name from yaml configuration filepath
func getSessionNameFromFilepath(fpath string) string {
	session_name := filepath.Base(fpath)
	session_name = session_name[0 : len(fpath)-len(filepath.Ext(session_name))]
	return session_name
}

// Read active tmux session configuration
func readCurrentSessionConf(filename string) (SessionConf, error) {
	session_conf := SessionConf{}

	// if !tmux.IsInsideTmux() {
	//     return errors.New("Not inside tmux.")
	// }

	// Get current session configuration
	session_name, err := tmux.GetAttachedSessionName()
	if err != nil {
		return session_conf, err
	}
	session := tmux.Session{Name: session_name}
	windows, err := session.ListWindows()
	if err != nil {
		return session_conf, err
	}

	// Generate filename if not specified
	if len(filename) == 0 {
		filename = session_name
	}

	// Collect windows configurations
	windows_conf := []WindowConf{}
	for _, w := range windows {
		windows_conf = append(windows_conf, WindowConf{
			WindowName:     w.Name,
			StartDirectory: w.StartDirectory})
	}

	// Prepare session configuration
	session_conf = SessionConf{
		SessionName: filename,
		Windows:     windows_conf}

	return session_conf, nil
}

// Reads SessionConf object from a yaml file.
func readSessionConfFromFile(filepath string) (SessionConf, error) {
	session_conf := SessionConf{}

	// Parse configuration
	file_content, err := ioutil.ReadFile(filepath)
	if err != nil {
		return session_conf, err
	}

	err = yaml.Unmarshal(file_content, &session_conf)
	if err != nil {
		return session_conf, err
	}

	return session_conf, nil
}

// Reads go-tmux Session object from a yaml file.
func readSessionFromFile(filepath string) (tmux.Session, error) {
	session := tmux.Session{}

	conf_in, err := readSessionConfFromFile(filepath)
	if err != nil {
		return session, err
	}

	// Prepare go-tmux session
	session = tmux.Session{Name: conf_in.SessionName}
	for idx, w := range conf_in.Windows {
		session.AddWindow(tmux.Window{
			Name: w.WindowName,
			// TODO: Read base-index from .tmux.conf
			Id:             idx + 1,
			SessionId:      session.Id,
			SessionName:    session.Name,
			StartDirectory: w.StartDirectory,
		})
	}

	return session, nil
}

// Saves current tmux session in yaml file
func DoSave(savePath string, filename string, verbose bool) error {
	// Get current session configuration
	session_conf, err := readCurrentSessionConf(filename)
	if err != nil {
		return err
	}

	conf_out, err := yaml.Marshal(&session_conf)
	if err != nil {
		return err
	}

	savePath, err = expandTilde(savePath)
	if err != nil {
		return err
	}

	err = ioutil.WriteFile(savePath, conf_out, 0644)
	if err != nil {
		return err
	}

	if verbose {
		fmt.Printf("Saved in %s\n", savePath)
	}

	return nil
}

// Loads tmux session from json configuration file and attach to it.
func DoLoad(loadPath string) error {
	session, err := readSessionFromFile(loadPath)
	if err != nil {
		return err
	}

	// Create new session
	server := new(tmux.Server)
	server.AddSession(session)
	sessions := []*tmux.Session{}
	sessions = append(sessions, &session)
	conf := tmux.Configuration{
		Server:        server,
		Sessions:      sessions,
		ActiveSession: nil}

	// Apply created session configuration
	err = conf.Apply()
	if err != nil {
		return err
	}

	// Attach to created session
	err = session.AttachSession()
	if err != nil {
		return err
	}

	return nil
}

// Checks that current session is different from saved yaml configuration
// Returns 0 if sessions are same, -1 otherwise.
func DoDiff(filepath string, verbose bool) (int, error) {
	rc := 0

	if !tmux.IsInsideTmux() {
		return -1, errors.New("Not in tmux.")
	}

	// Get information about current session
	session_conf_current, err := readCurrentSessionConf(filepath)
	if err != nil {
		return -1, err
	}

	// Generate filename if not specified
	if len(filepath) == 0 {
		session_name := session_conf_current.SessionName
		filepath = fmt.Sprintf("%s/%s.yaml", DEFAULT_PATH, session_name)
		filepath, err = expandTilde(filepath)
		if err != nil {
			return -1, err
		}
	}

	// Session was never saved before
	if _, err := os.Stat(filepath); os.IsNotExist(err) {
		if verbose {
			fmt.Printf("Can't open configuration file %s\n", filepath)
		}
		return -1, nil
	}

	// Read existing configuration file
	session_conf_file, err := readSessionConfFromFile(filepath)
	if err != nil {
		return -1, err
	}

	// Compare SessionConf objects
	if !reflect.DeepEqual(session_conf_current, session_conf_file) {
		rc = -1
		if verbose {
			fmt.Println("Sessions are differs")
		}
	} else if verbose {
		fmt.Println("Sessions are same")
	}

	return rc, nil
}

func main() {
	rc := 0
	var err error
	switch kingpin.MustParse(app.Parse(os.Args[1:])) {
	case save.FullCommand():
		// Prepare filepath
		var path_to_save string
		if *savePath == "" {
			session_name, err := tmux.GetAttachedSessionName()
			if err != nil {
				fmt.Printf("%s", err)
				os.Exit(1)
			}
			path_to_save = fmt.Sprintf("%s/%s.yaml", DEFAULT_PATH, session_name)
		} else {
			path_to_save = *savePath
		}

		// Perform saving
		err = DoSave(path_to_save, *fileName, *verbose)
		if err != nil {
			fmt.Printf("%s", err)
			os.Exit(1)
		}

	case load.FullCommand():
		// Perform loading
		err = DoLoad(*loadPath)
		if err != nil {
			fmt.Printf("%s", err)
			os.Exit(1)
		}

	case diff.FullCommand():
		// Check difference
		rc, err = DoDiff(*diffPath, *verbose)
		if err != nil {
			fmt.Printf("%s", err)
			os.Exit(1)
		}
		if (rc != 0) && (*print_message) {
			fmt.Printf("%s\n", DIFF_MESSAGE)
		}
	}

	if err != nil {
		rc = -1
	}

	os.Exit(rc)
}
