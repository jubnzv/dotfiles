// The MIT License (MIT)
// Copyright (C) 2019 Georgy Komarov <jubnzv@gmail.com>

package main

import (
	"bytes"
	"fmt"
	"io"
	"os"
	"os/exec"
	"strings"
	"time"

	tw "github.com/jubnzv/go-taskwarrior"
	"gopkg.in/alecthomas/kingpin.v2"
)

var LOCAL_MAIL = "jubnzv@remilia"

const (
	version = "1.0.0"
)

const (
	Weekly  = iota
	Monthly = iota
)

var (
	app     = kingpin.New("taskwarrior-reporter", "A utility to e-mail taskwarrior tasks.")
	verbose = app.Flag("verbose", "Enable additional output").Bool()

	weekly  = app.Command("weekly", "Send report with tasks completed this week.")
	monthly = app.Command("monthly", "Send report with tasks completed this month.")
)

func sendMail(report string, periodStr string) {
	c1 := exec.Command(
		"echo", "-e",
		"Content-Type: text/plain; charset=\"utf-8\";\nSubject: taskwarrior (", periodStr, ")",
		"\n\n", report)
	c2 := exec.Command("/usr/sbin/sendmail", LOCAL_MAIL)

	r, w := io.Pipe()
	c1.Stdout = w
	c2.Stdin = r

	var b2 bytes.Buffer
	c2.Stdout = &b2

	c1.Start()
	c2.Start()
	c1.Wait()
	w.Close()
	c2.Wait()
	io.Copy(os.Stdout, &b2)
}

// Return number of days in current month
func getNumDaysInMonth(monthTimestamp time.Time) int {
    currentLocation := monthTimestamp.Location()
    currentYear, currentMonth, _ := monthTimestamp.Date()
    firstOfMonth := time.Date(currentYear, currentMonth, 1, 0, 0, 0, 0, currentLocation)
    lastOfMonth := firstOfMonth.AddDate(0, 1, -1)
    return lastOfMonth.Day() - firstOfMonth.Day() + 1
}

// Filter tasks for a given period
func applyPeriodFilter(tasks []tw.Task, period int) (filteredTasks []tw.Task, err error) {
	layout := "20060102T150405"

	var daysDiff int
	switch period {
	case Weekly:
		daysDiff = 7
	case Monthly:
        now := time.Now()
        daysDiff = getNumDaysInMonth(now)
	}

	for _, task := range tasks {
        taskTime, err := time.Parse(layout, task.Entry[:len(task.Entry)-1])
		if err != nil {
			return filteredTasks, err
		}

        diffDate := time.Since(taskTime)
		if diffDate.Hours()/24 <= float64(daysDiff) {
			filteredTasks = append(filteredTasks, task)
		}
	}

	return filteredTasks, nil
}

// Get text with completed tasks report
func getCompletedTasks(ss []tw.Task, test func(tw.Task) bool) (ret []string) {
	for _, s := range ss {
		if test(s) {
			project := s.Project
			if len(project) == 0 {
				project = "<no project>"
			}
			entry := fmt.Sprintf("%-12.12s :: %s", project, s.Description)
			// fmt.Printf("%+v\n", s)
			ret = append(ret, entry)
		}
	}
	return
}

func main() {
	var periodType int
	var reportStr string
	reportMailText := ""

	switch kingpin.MustParse(app.Parse(os.Args[1:])) {
	case weekly.FullCommand():
		periodType = Weekly
		reportStr = "week"
	case monthly.FullCommand():
		periodType = Monthly
		reportStr = "month"
	}

	// Initialize taskwarrior context
	ctx, err := tw.NewTaskWarrior("~/.taskrc")
	if err != nil {
		fmt.Printf("%s\n", err)
		os.Exit(1)
	}
	ctx.FetchAllTasks()
	// if *verbose {
	//      ctx.PrintTasks()
	// }

	// Apply period filter
	tasksFiltered, err := applyPeriodFilter(ctx.Tasks, periodType)
	if err != nil {
		fmt.Printf("%s\n", err)
		os.Exit(1)
	}

	// Fetch completed tasks
	completedFunc := func(s tw.Task) bool { return s.Status == "completed" }
	tasksCompleted := getCompletedTasks(tasksFiltered, completedFunc)
	if *verbose {
		fmt.Printf("There are %d completed tasks at this %s.\n", len(tasksCompleted), reportStr)
	}
	titleCompleted := fmt.Sprintf("\nCompleted this %s (%d tasks):\n", reportStr, len(tasksCompleted))
	tasksCompletedStr := strings.Join(tasksCompleted, "\n")
	reportMailText += titleCompleted + tasksCompletedStr + "\n"

	// Send the mail
	sendMail(reportMailText, reportStr)

	os.Exit(0)
}
