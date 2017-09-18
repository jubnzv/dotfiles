;; Separate custom file
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; Package management
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

;; Save backup files in one place
(setq backup-directory-alist `(("." . "~/.emacs-saves")))

;; Disable GUI components
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(tooltip-mode -1)
(blink-cursor-mode -1)
(setq use-dialog-box     nil)
(setq redisplay-dont-pause t)
(setq ring-bell-function 'ignore)

;; Highlight current line
(global-hl-line-mode)

;; Font
(set-fontset-font t 'koi8-r "Inconsolata LGC")

;; Column number mode
(column-number-mode)

;; Use y/n instead of yes/no
(fset 'yes-or-no-p 'y-or-n-p)

;; Solarized color theme
(setq solarized-distinct-fringe-background nil) ;; Make the fringe stand out from the background
(setq solarized-use-variable-pitch nil) ;; Don't change the font for some headings and titles
(setq solarized-emphasize-indicators nil) ;; Use less colors for indicators such as git:gutter, flycheck and similar
(setq solarized-high-contrast-mode-line t) ;; Make the modeline high contrast
(setq solarized-scale-org-headlines nil) ;; Don't change size of org-mode headlines (but keep other size-changes)
(load-theme 'solarized-dark t)

;; Disable line truncating in some modes
(add-hook 'prog-mode-hook (lambda () (setq truncate-lines nil)))
(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))

;; Custom emacs window title format
(setq frame-title-format
      '("%S" (buffer-file-name "%f" (dired-directory dired-directory "%b"))))

;; Disable startup message
(setq inhibit-startup-message t)

;; PageUp/PageDown behave like M-v/C-v
(defun cfg:page-up ()
  (interactive)
  (condition-case nil (scroll-down)
    (beginning-of-buffer (goto-char (point-min)))))
(global-set-key (kbd "<prior>") 'cfg:page-up)
(global-set-key (kbd "M-v") 'cfg:page-up)

(defun cfg:page-down ()
  (interactive)
  (condition-case nil (scroll-up)
    (end-of-buffer (goto-char (point-max)))))
(global-set-key (kbd "<next>") 'cfg:page-down)
(global-set-key (kbd "C-v") 'cfg:page-down)

(global-set-key [(control ?h)] 'delete-backward-char)

;; *scratch* content
(setq initial-major-mode 'org-mode)
(setq initial-scratch-message "")

;; Finally, read other configuration files from ./rc
(add-to-list 'load-path (expand-file-name "~/.emacs.d/rc"))
;; rc-evil: Settings for evil-mode that includes hotkeys and modes-specific configuration.
(require 'rc-evil)
;; rc-helm: Helm-related options
;; (require 'rc-helm)
;; rc-ivy
(require 'rc-ivy)
;; rc-prog: General prog-mode settings
(require 'rc-prog) 
;; rc-prog-go: Go lang environment
(require 'rc-prog-go)
;; rc-prog-haskell: Haskell programming environment
(require 'rc-prog-haskell)
;; rc-prog-haskell: C environment
(require 'rc-prog-c)
;; rc-org: org-mode settings
(require 'rc-org)
;; rc-experimental: debugging my elisp code
(require 'rc-experimental)
