;;; Compiled snippets and support files for `c-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'c-mode
                     '(("wpid" "int return_status;\nif (waitpid(child_pid, &return_status, 0) == -1) {\nperror(\"waitpid\");\nexit(EXIT_FAILURE);\n}\n" "wpid" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/c-mode/wpid" nil nil)
                       ("tdstruct" "typedef struct ${1:name}_s {\n$0\n} $1_t;\n" "typedef_struct" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/c-mode/typedef_struct" nil nil)
                       ("tdenum" "typedef enum {\n$0\n} ${1:name}_t;\n" "typedef_enum" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/c-mode/typedef_enum" nil nil)
                       ("signal_handler_siginfo" "static void ${1:handler}(int signum, siginfo_t *si, void *data)\n{\n	${0:TARGET}\n}\n" "signal_handler_siginfo" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/c-mode/signal_handler_siginfo" nil nil)
                       ("signal_handler_basic" "static void ${1:handler}(int signum)\n{\n	${0:TARGET}\n}\n" "signal_handler_basic" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/c-mode/signal_handler_basic" nil nil)
                       ("sigaction_set" "struct sigaction sa;\nsa.sa_flags = ${1:0};\nsa.sa_handler = ${2:handler};\nsigaction(SIG${3:SEGV}, &sa, NULL);\n${0:TARGET}\n" "sigaction_set" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/c-mode/sigaction_set" nil nil)
                       ("prd" "printf(\"%s:%d ${1:#:here}\\n\", __func__, __LINE__${2:#:}); // prdbg\n" "print_debug" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/c-mode/print_debug" nil nil)
                       ("pr" "echo \"$0\"\n" "print" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/c-mode/print" nil nil)
                       ("print-bits" "int i;\nfor (i = 0; i < ${1:#:NB}; i++) {\nprintf(\"%c\", (${2:#:SRC} & (1 << i)) ? '1' : '0');\nif ((i + 1) % 16 == 0)\nprintf(\"\\n\");\n}\n" "prb" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/c-mode/prb" nil nil)
                       ("pr" "printf(\"${1}\\n\"${2});\n" "pr" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/c-mode/pr" nil nil)
                       ("perror_return" "perror(\"${1:function}\");\nreturn -1;\n" "perror_return" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/c-mode/perror_return" nil nil)
                       ("perror_exit" "perror(\"${1:function}\");\nexit(EXIT_FAILURE);\n" "perror_exit" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/c-mode/perror_exit" nil nil)
                       ("pe" "perror(\"$0\");\n" "pe" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/c-mode/pe" nil nil)
                       ("once" "#ifndef ${1:`(upcase (file-name-nondirectory (file-name-sans-extension (buffer-file-name))))`_H}\n#define $1\n\n$0\n\n#endif /* $1 */\n" "once" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/c-mode/once" nil nil)
                       ("kbhitf" "if (kbhit() == 1) {\nchar c = getchar();\nif (c == 32) {\nprintf(\"\\n\");\n${1:ACTION}\nprintf(\"Press <Space> for statistics or <Esc> for exit\\n\");\n} else if (c == 27) break;\n}\n" "kbhitf" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/c-mode/kbhitf" nil nil)
                       ("function_once" "static short _once = 0;\nif (_once == 1) return;\n_once = 1;\n" "function_once" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/c-mode/function_once" nil nil)
                       ("func_strerror" "const char *strerror_${1:name}(int errno_)\n{\nswitch(errno_) {\ncase ${0:E}:\nreturn \"$0\";\ndefault:\nreturn strerror(errno_);\n}\n}\n" "func_strerror" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/c-mode/func_strerror" nil nil)
                       ("func_print_usage" "void print_usage(const char *argv0)\n{\nprintf(\"Usage: %s ${1}\\n\", argv0);\n}\n" "func_print_usage" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/c-mode/func_print_usage" nil nil)
                       ("fork_signal" "switch (child_pid = fork()) {\ncase -1:\nperror(\"fork\");\nexit(EXIT_FAILURE);\ncase 0:\n/* Waits for parent signal */\nsigemptyset(&empty_mask);\nif (sigsuspend(&empty_mask) == -1 && errno != EINTR) {\nperror(\"sigsuspend\");\nexit(EXIT_FAILURE);\n}\n\n${0:CHILD_ACTIONS}\nexit(EXIT_SUCCESS);\ndefault:\n${0:PARENT_ACTIONS}\n\n/* Awake child */\nif (kill(child_pid, SYNC_SIG) == -1) {\nperror(\"kill\");\nexit(EXIT_FAILURE);\n}\nbreak;\n}\n" "fork_signal" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/c-mode/fork_signal" nil nil)
                       ("fork" "switch (child_pid = fork()) {\ncase -1:\nperror(\"fork\");\nexit(EXIT_FAILURE);\ncase 0: {\n${0:TARGET}\nexit(EXIT_SUCCESS);\n}\ndefault:\nbreak;\n}\n" "fork" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/c-mode/fork" nil nil)
                       ("exs" "exit(EXIT_SUCCESS);\n" "exs" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/c-mode/exs" nil nil)
                       ("exf" "exit(EXIT_FAILURE);\n" "exf" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/c-mode/exf" nil nil)
                       ("dxbrief" "/** @brief $0 */\n" "doxygen_brief" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/c-mode/doxygen_brief" nil nil)
                       ("def_max" "#define max(a, b) ((a) > (b) ? (a) : (b))\n" "def_max" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/c-mode/def_max" nil nil)
                       ("def_err_print" "#define err(fmt, args...) fprintf(stderr, \"[${1:ERR}]: \" fmt \"\\n\", ##args)\n" "def_err_print" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/c-mode/def_err_print" nil nil)
                       ("def_dbg_print" "#define dbg(fmt, args...) do { if (${2:DEBUG_ENABLED}) fprintf(stderr, \"[${1:DBG}]: \" fmt \"\\n\", ##args); } while (0)\n" "def_dbg_print" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/c-mode/def_dbg_print" nil nil)
                       ("def_begins_with" "#define BEGINS_WITH(haystack, needle) (strncmp(haystack, needle, strlen(needle)) == 0)\n" "def_begins_with" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/c-mode/def_begins_with" nil nil)
                       ("def_array_size" "# define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))\n" "def_array_size" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/c-mode/def_array_size" nil nil)
                       ("cmrete" "0 if success, -1 and sets errno otherwise\n" "cmrete" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/c-mode/cmrete" nil nil)
                       ("cmret" "0 if success, -1 otherwise\n" "cmret" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/c-mode/cmret" nil nil)
                       ("cmake_define0" "#cmakedefine ${1} @$1@\n#ifndef $1\n#define $1    0\n#endif // $1\n" "cmake_define0" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/c-mode/cmake_define0" nil nil)
                       ("check_root" "if (setuid(0) < 0) {\nperror(\"Must be root.\");\nexit(EXIT_FAILURE);\n}\n" "check_root" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/c-mode/check_root" nil nil)
                       ("ifnrc" "if (rc == -1) {\n$0\nreturn -1;\n}\n" "check_rc" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/c-mode/check_rc" nil nil)
                       ("check_dir" "DIR *dir = opendir(${1});\nif (dir)\nclosedir(dir);\nelse if (errno = ENOENT) {\n${2}\n} else {\n${3}\n}\n\n$0\n" "check_dir" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/c-mode/check_dir" nil nil)
                       ("cformatm2" "// clang-format off\n${0}\n// clang-format on\n" "cformatm2" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/c-mode/cformatm2" nil nil)
                       ("cformatm" "/* clang-format off */\n${0}\n/* clang-format on */\n" "cformatm" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/c-mode/cformatm" nil nil)
                       ("cformat2" "// clang-format ${0}\n" "cformat2" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/c-mode/cformat2" nil nil)
                       ("cformat" "/* clang-format ${0} */\n" "cformat" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/c-mode/cformat" nil nil)
                       ("bwtt" "& (1 << ${0:BIT})\n" "bwtt" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/c-mode/bwtt" nil nil)
                       ("bwt" "^= (1 << ${0:BIT})\n" "bwt" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/c-mode/bwt" nil nil)
                       ("bws" "|= (1 << ${0:BIT})\n" "bws" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/c-mode/bws" nil nil)
                       ("bwc" "&= ~(1 << ${0:BIT})\n" "bwc" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/c-mode/bwc" nil nil)
                       ("any_key" "printf(\"Press any key to continue...\\n\");\ngetchar();\n" "any_key" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/c-mode/any_key" nil nil)))


;;; Do not edit! File generated at Fri Jul 26 21:02:55 2019