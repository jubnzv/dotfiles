(defun jbz-cc-find-in-function ()
    "Find string in function body."
    (interactive)
    (c-beginning-of-defun)
    (push-mark)
    (c-end-of-defun))

(provide 'jbz-cc-mode)
