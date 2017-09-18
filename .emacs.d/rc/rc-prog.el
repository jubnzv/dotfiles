;; Prog-mode settings
;;
;; cscope
(require 'xcscope)

;; Autopair
(require 'autopair)
(autopair-global-mode)

(require 'evil-surround)
(global-evil-surround-mode 1)

;; nlinum: show relative number for current line
(require 'nlinum-relative)
(nlinum-relative-setup-evil)
(setq nlinum-relative-current-symbol "~")
(setq nlinum-relative-redisplay-delay 0) 
(add-hook 'prog-mode-hook 'nlinum-relative-mode)

;; Highlight HEX color codes in sources
(add-hook 'prog-mode-hook 'rainbow-mode)

;; Highlight TODO/FIXME entries
(require 'hl-todo)
(add-hook 'prog-mode-hook 'hl-todo)

;; Show current function name
(which-function-mode 1)

;; ctags integration
(require 'eproject)
(defun build-ctags ()
  (interactive)
  (message "building project tags")
  (let ((root (eproject-root)))
    (shell-command (concat "ctags -e -R --extra=+fq --exclude=.git -f " root "TAGS " root)))
  (visit-project-tags)
  (message "tags built successfully"))

(defun visit-project-tags ()
  (interactive)
  (let ((tags-file (concat (eproject-root) "TAGS")))
    (visit-tags-table tags-file)
    (message (concat "Loaded " tags-file))))

(defun my-find-tag ()
  (interactive)
  (if (file-exists-p (concat (eproject-root) "TAGS"))
      (visit-project-tags)
    (build-ctags))
  (etags-select-find-tag-at-point))

(global-set-key (kbd "M-.") 'my-find-tag)

(provide 'rc-prog)
