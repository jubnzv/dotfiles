;;; Compiled snippets and support files for `tex-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'tex-mode
                     '(("snoop_with" "import pysnooper\nwith pysnooper.snoop():\n$0\n" "snoop_with" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/tex-mode/snoop_with" nil nil)
                       ("snoop" "import pysnooper\n@pysnooper.snoop()$0\n" "snoop" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/tex-mode/snoop" nil nil)
                       ("sizeof" "import sys\nsys.getsizeof($0)\n" "sizeof" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/tex-mode/sizeof" nil nil)
                       ("rni" "raise NotImplementedError\n" "raise_ni" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/tex-mode/raise_ni" nil nil)
                       ("pr" "message(\"$0\")\n" "print" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/tex-mode/print" nil nil)
                       ("ppr" "import pprint; pp = pprint.PrettyPrinter(indent=2);\npp.pprint(${1})\n" "pprint" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/tex-mode/pprint" nil nil)
                       ("include-guard" "#ifndef ${1:#:SYMBOL}\n#define $1\n\n${0:TARGET}\n#endif // $1\n" "once" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/tex-mode/once" nil nil)
                       ("nl" "\\newline\n" "nl" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/tex-mode/nl" nil nil)
                       ("ln" "[${1:#:link}](${2:#:url})${3}\n" "link" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/tex-mode/link" nil nil)
                       ("incgrx" "\\usepackage{graphicx}\n\\graphicspath{ {./img/} }\n\\DeclareGraphicsExtensions{.png}\n\\usepackage{float}\n" "incgrx" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/tex-mode/incgrx" nil nil)
                       ("import" "import ${1:sys}\n" "inc" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/tex-mode/inc" nil nil)
                       ("head_alpine" "FROM alpine:3.7\n\nLABEL MAINTAINER=\"Georgy Komarov <jubnzv@gmail.com>\"\n\n$0\n\nCMD [\"/bin/sh\"]\n# vim: set ft=dockerfile :\n" "head_alpine" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/tex-mode/head_alpine" nil nil)
                       ("gtest-timeout-success" "std::promise<bool> promisedFinished;\nauto futureResult = promisedFinished.get_future();\nstd::thread(\n[](std::promise<bool> &finished) {\n${0}\nfinished.set_value(true);\n},\nstd::ref(promisedFinished))\n.detach();\nEXPECT_FALSE(futureResult.wait_for(std::chrono::milliseconds(3000)) != std::future_status::timeout);\n" "gtest-timeout-success" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/tex-mode/gtest-timeout-success" nil nil)
                       ("gtest-timeout-fail" "std::promise<bool> promisedFinished;\nauto futureResult = promisedFinished.get_future();\nstd::thread(\n[](std::promise<bool> &finished) {\n${0}\nfinished.set_value(true);\n},\nstd::ref(promisedFinished))\n.detach();\nEXPECT_TRUE(futureResult.wait_for(std::chrono::milliseconds(3000)) != std::future_status::timeout);\n" "gtest-timeout-fail" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/tex-mode/gtest-timeout-fail" nil nil)
                       ("graphics" "\\begin{figure}[H]\n\\label{fig:$1}\n\\includegraphics[scale=0.5]{${1:#:PICTURE}}\n\\caption{${2:DESCRIPTION}}\n\\end{figure}\n" "graphics" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/tex-mode/graphics" nil nil)
                       ("fora" "for (${1:auto const& }${2:var} : ${3:container}) {\n${0:TARGET}\n}\n" "fora" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/tex-mode/fora" nil nil)
                       ("execute_once" "def execute_once(f):\ndef wrapper(*args, **kwargs):\nif not wrapper.has_run:\nwrapper.has_run = True\nwrapper.value = f(*args, **kwargs)\nreturn wrapper.value\nwrapper.has_run = False\nreturn functools.update_wrapper(wrapper, f)\n" "execute_once" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/tex-mode/execute_once" nil nil)
                       ("detect_exception" "try:\n${1}\nexcept Exception as e:\n_m = f\"An exception {e.__class__.__name__} occurred. Arguments: {e.args}\"\nprint(_m)\n" "detect_exception" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/tex-mode/detect_exception" nil nil)
                       ("cb" "\\`\\`\\`${1:#:language}\n${2:#:code }\n\\`\\`\\`\n" "codeblock" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/tex-mode/codeblock" nil nil)
                       ("clang-format-multi" "// clang-format off\n${0}\n// clang-format on\n" "clang-format-multi" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/tex-mode/clang-format-multi" nil nil)
                       ("clang-format" "// clang-format ${0}\n" "clang-format" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/tex-mode/clang-format" nil nil)
                       ("bzch" "code = []\ncode.append(\"${1}\")\nreturn \"\\n\".join(code)\n" "bzch" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/tex-mode/bzch" nil nil)
                       ("bzc" "code.append(\"${1}\")\n" "bzc" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/tex-mode/bzc" nil nil)
                       ("bmtmpl" "\\documentclass{beamer}\n\\usetheme{Rochester}\n\n\\title[${1:#:TITLE}]{$1}\n\\author[G. Komarov]{Georgy Komarov}\n\\date{\\today}\n\n\\begin{document}\n\n%--- the titlepage frame -------------------------%\n\\begin{frame}[plain]\n\\titlepage\n\\end{frame}\n\n${0:TARGET}\n\n\\end{document}\n" "bmtmpl" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/tex-mode/bmtmpl" nil nil)
                       ("bmfri" "\\begin{frame}{}\n\\begin{itemize}\n\\setlength{\\itemindent}{1em}\n\\item[${1:#:ITEM}] ${0:DESCRIPTION}\n\\end{itemize}\n\\end{frame}\n" "bmfri" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/tex-mode/bmfri" nil nil)
                       ("bmfrend" "\\begin{frame}{}\n\\Huge Thank you for your attention.\n\\end{frame}\n" "bmfrend" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/tex-mode/bmfrend" nil nil)
                       ("bmfr" "\\begin{frame}{${1:TITLE}}\n${0:TARGET}\n\\end{frame}\n" "bmfr" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/tex-mode/bmfr" nil nil)))


;;; Do not edit! File generated at Fri Jul 26 21:02:55 2019
