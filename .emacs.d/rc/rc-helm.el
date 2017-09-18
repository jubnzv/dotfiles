;; Helm mode settings
(require 'helm-config)
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(helm-mode 1)

(setq helm-ff-newfile-prompt-p nil) ;; Prevent asking when create new buffer
(setq helm-ff-auto-update-initial-value t)

;; Search
(require 'helm-swoop)
(global-set-key (kbd "C-s") 'helm-swoop)
;; Move up and down like isearch
(define-key helm-swoop-map (kbd "C-r") 'helm-previous-line)
(define-key helm-swoop-map (kbd "C-s") 'helm-next-line)
(define-key helm-multi-swoop-map (kbd "C-r") 'helm-previous-line)
(define-key helm-multi-swoop-map (kbd "C-s") 'helm-next-line)
;; When doing evil-search, hand the word over to helm-swoop
;; (define-key evil-motion-state-map (kbd "M-i") 'helm-swoop-from-evil-search)
;; Split direcion. 'split-window-vertically or split-window-horizontally
(setq helm-swoop-split-direction 'split-window-vertically)
;; If you prefer fuzzy matching
(setq helm-swoop-use-fuzzy-match t)

(provide 'rc-helm)
