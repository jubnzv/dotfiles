;;; Compiled snippets and support files for `sh-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'sh-mode
                     '(("strict_mode" "set -euo pipefail\n" "strict_mode" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/sh-mode/strict_mode" nil nil)
                       ("pushd_popd" "pushd ${1:./} >/dev/null\n${0}\npopd >/dev/null\n" "pushd_popd" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/sh-mode/pushd_popd" nil nil)
                       ("pr" "echo \"$0\"\n" "print" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/sh-mode/print" nil nil)
                       ("nl" "\\newline\n" "nl" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/sh-mode/nl" nil nil)
                       ("logger" "logger \"$0\"\n" "log" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/sh-mode/log" nil nil)
                       ("getopts_verbose" "vison=0\n\nwhile getopts \"iv\" option; do\ncase \"$option\" in\nv)\necho \"verbose mode\"\nvison=1 ;;\n*)\nexit 1 ;;\nesac\ndone\nshift $(( OPTIND - 1 ))\n\n(( vison )) && echo 'Verbose mode'\n$0\n" "getopts_verbose" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/sh-mode/getopts_verbose" nil nil)
                       ("getnum_cores" "num_cores=$(grep -c ^processor /proc/cpuinfo)\nif [ -z \"$num_cores\" ]; then\nnum_cores=4\nfi\n$0\n" "getnum_cores" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/sh-mode/getnum_cores" nil nil)
                       ("for_dirs" "for [ d in * ]; do\nif [[ -d $d ]]; then\n${0}\nfi\ndone\n" "for_dirs" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/sh-mode/for_dirs" nil nil)
                       ("file_filename" "filename=\"\\${${1:varname}%.*}\"$0\n" "file_filename" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/sh-mode/file_filename" nil nil)
                       ("file_extension" "fileext=\"\\${${1:varname}##.*}\"$0\n" "file_extension" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/sh-mode/file_extension" nil nil)
                       ("fdisk_partitioning" "(\necho o   # Create a new empty DOS partition table\necho n   # Add a new partition\necho p   # Primary partition\necho 1   # Partition number\necho     # First sector\necho     # Last sector\necho w   # Write changes\n) | fdisk ${0}\n" "fdisk_partitioning" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/sh-mode/fdisk_partitioning" nil nil)
                       ("exs" "exit 0\n$0\n" "exit_success" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/sh-mode/exit_success" nil nil)
                       ("exf" "exit 1\n$0\n" "exit_failure" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/sh-mode/exit_failure" nil nil)
                       ("ch_tmux" "if [[ -z \"$TMUX\" ]]; then\necho \"tmux is not running.\"\nexit 1\nfi\n$0\n" "ch_tmux" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/sh-mode/ch_tmux" nil nil)
                       ("ch_systemd_service" "if [[ \"\\$(systemctl is-active ${1:service})\" != \"active\" ]]; then\necho \"systemctl: Starting '$1'...\"\nsystemctl start $1\nfi\n$0\n" "ch_systemd_service" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/sh-mode/ch_systemd_service" nil nil)
                       ("ch_root" "if [[ $EUID -ne 0 ]]; then\necho \"Please run this script as root.\"\nexit 1\nfi\n$0\n" "ch_root" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/sh-mode/ch_root" nil nil)
                       ("ch_rc" "${1:#:command}\nif [ $? == 0 ]; then\n$0\nfi\n" "ch_rc" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/sh-mode/ch_rc" nil nil)
                       ("ch_process" "pgrep -a ${1:PROCESS_NAME} >/dev/null 2>&1\nif [[ $? -ne 0 ]]; then\necho \"$1: process not running.\"\nexit 1\nfi\n$0\n" "ch_process" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/sh-mode/ch_process" nil nil)
                       ("ch_file" "if [ ! -f ${1:/} ]; then\necho \"$1 is inaccessible\"\nexit 127\nfi\n$0\n" "ch_file" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/sh-mode/ch_file" nil nil)
                       ("ch_docker_image" "if [[ \"\\$(docker images -q ${1:myimage\\:mytag} 2> /dev/null)\" == \"\" ]]; then\necho \"docker: Could not find image '$1' locally.\"\nexit 127\nfi\n$0\n" "ch_docker_image" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/sh-mode/ch_docker_image" nil nil)
                       ("ch_dir" "if [ ! -d ${1:/} ]; then\necho \"$1 is inaccessible\"\nexit 127\nfi\n$0\n" "ch_dir" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/sh-mode/ch_dir" nil nil)
                       ("ch_connection" "wget -q --spider http://google.com\nif [ ! $? -eq 0 ]; then\necho \"Please connect to the internet before continuing.\"\nfi\n$0\n" "ch_connection" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/sh-mode/ch_connection" nil nil)
                       ("ch_command" "if [[ ! -x \"$(command -v ${1})\" ]]; then\necho \"$1: command not found\"\nexit 1\nfi\n$0\n" "ch_command" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/sh-mode/ch_command" nil nil)
                       ("ch_args" "if [ $# -ne ${1:1} ]; then\necho \"Usage: \\$0 $1\"\nexit 1\nfi\n$0\n" "ch_args" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/sh-mode/ch_args" nil nil)
                       ("NUL" ">/dev/null 2>&1\n" "NUL" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/sh-mode/NUL" nil nil)
                       ("NE" "2>/dev/null\n" "NE" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/sh-mode/NE" nil nil)
                       ("KE" "2>&1\n" "KE" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/sh-mode/KE" nil nil)
                       ("G" "'|& ag -i'\n" "G" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/sh-mode/G" nil nil)))


;;; Do not edit! File generated at Fri Jul 26 21:02:55 2019
