(require 'evil)
(evil-mode 1)
(define-key evil-normal-state-map (kbd "-") nil)

;; jj interrupts INSERT mode 
(setq key-chord-two-keys-delay 0.5)
(key-chord-define evil-insert-state-map "jj" 'evil-normal-state)
(key-chord-mode 1)

;; Leader for emacs
(require 'evil-leader)
(global-evil-leader-mode)
(evil-leader/set-leader "-")
(evil-leader/set-key
  "ci" 'evilnc-comment-or-uncomment-lines
  "cl" 'evilnc-quick-comment-or-uncomment-to-the-line
  ;; "ll" 'evilnc-quick-comment-or-uncomment-to-the-line
  "cc" 'evilnc-copy-and-comment-lines
  "cp" 'evilnc-comment-or-uncomment-paragraphs
  "cr" 'comment-or-uncomment-region
  "cv" 'evilnc-toggle-invert-comment-line-by-line
  "."  'evilnc-copy-and-comment-operator
  "\\" 'evilnc-comment-operator ; if you prefer backslash key
)
(evil-leader/set-key
  "w" 'save-buffer
  "W" 'save-some-buffers
  "`" 'kill-emacs
  "x" 'save-buffers-kill-emacs
)
(evil-leader/set-key
  "s" 'avy-goto-char
)

;; General mode: "a more convenient way to bind keys in emacs"
(require 'general)
;; bind a key globally in normal state; keymaps must be quoted
(setq general-default-keymaps 'evil-normal-state-map)
;; bind j and k in normal state globally
(general-define-key
 "j" 'evil-next-visual-line
 "k" 'evil-previous-visual-line)

(general-evil-setup)
;; all keywords arguments are still supported
;; (general-nmap :prefix "M"
;;               "j" 'helm-mini)
(general-nmap "M-u" 'helm-mini)

;; bind in motion state (inherited by the normal, visual, and operator states)
(general-mmap "j" 'evil-next-visual-line
              "k" 'evil-previous-visual-line)

;; Evil settings for specific packages/modes
;;
;; Magit
(require 'evil-magit)

(provide 'rc-evil)
