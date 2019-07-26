;;; Compiled snippets and support files for `python-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'python-mode
                     '(("snoop_with" "import pysnooper\nwith pysnooper.snoop():\n$0\n" "snoop_with" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/python-mode/snoop_with" nil nil)
                       ("snoop" "import pysnooper\n@pysnooper.snoop()$0\n" "snoop" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/python-mode/snoop" nil nil)
                       ("sizeof" "import sys\nsys.getsizeof($0)\n" "sizeof" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/python-mode/sizeof" nil nil)
                       ("rni" "raise NotImplementedError\n" "raise_ni" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/python-mode/raise_ni" nil nil)
                       ("pr" "print(${1})\n" "print" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/python-mode/print" nil nil)
                       ("ppr" "import pprint; pp = pprint.PrettyPrinter(indent=2);\npp.pprint(${1})\n" "pprint" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/python-mode/pprint" nil nil)
                       ("import" "import ${1:sys}\n" "inc" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/python-mode/inc" nil nil)
                       ("execute_once" "def execute_once(f):\ndef wrapper(*args, **kwargs):\nif not wrapper.has_run:\nwrapper.has_run = True\nwrapper.value = f(*args, **kwargs)\nreturn wrapper.value\nwrapper.has_run = False\nreturn functools.update_wrapper(wrapper, f)\n" "execute_once" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/python-mode/execute_once" nil nil)
                       ("detect_exception" "try:\n${1}\nexcept Exception as e:\n_m = f\"An exception {e.__class__.__name__} occurred. Arguments: {e.args}\"\nprint(_m)\n" "detect_exception" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/python-mode/detect_exception" nil nil)
                       ("bzch" "code = []\ncode.append(\"${1}\")\nreturn \"\\n\".join(code)\n" "bzch" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/python-mode/bzch" nil nil)
                       ("bzc" "code.append(\"${1}\")\n" "bzc" nil nil nil "/home/jubnzv/.emacs.d/etc/yasnippet/snippets/python-mode/bzc" nil nil)))


;;; Do not edit! File generated at Fri Jul 26 21:02:55 2019
