;; Go language programming environment

;; Set paths
(add-to-list 'exec-path "/home/jubnzv/Dev/go/bin/")
(setenv "GOPATH" "/home/jubnzv/Dev/go/")

;; Run gofmt after safe
(add-hook 'before-save-hook 'gofmt-before-save)

;; Run current buffer
(defun go-run-buffer()
  (interactive)
  (shell-command (concat "go run " (buffer-name))))

(provide 'rc-prog-go)
