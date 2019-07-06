;;; init.el --- Emacs main configuration file
;;; Commentary:
;;; Emacs config by Georgy Komarov
;;; Code:

; ; Set user info
; (setq user-full-name
;   (replace-regexp-in-string "\n$" ""
;   (shell-command-to-string "git config --get user.name")))
; (setq user-mail-address
;   (replace-regexp-in-string "\n$" ""
;   (shell-command-to-string "git config --get user.email")))
; 
; ; Initialize package manager
; (require 'package)
; (setq package-enable-at-startup nil)
; (setq package-archives
;       '(("gnu"     . "https://elpa.gnu.org/packages/")
;         ("melpa"        . "https://melpa.org/packages/"))
;       package-archive-priorities
;       '(("gnu"     . 5)
;         ("melpa"        . 0)))
; (package-initialize)
; (when (not package-archive-contents) (package-refresh-contents))
; 
; ; Bootstrap use-package
; (unless (package-installed-p 'use-package)
;   (package-refresh-contents)
;   (package-install 'use-package))
; (require 'use-package)
; (setq use-package-always-ensure t)
; 
; ; Load local packages
; (add-to-list 'load-path "~/.emacs.d/lisp/")
; 
; ; The :chords keyword allows you to define key-chord bindings for use-package declarations in the same manner as the :bind keyword.
; (use-package use-package-chords
;   :ensure t
;   :config (key-chord-mode 1))
; 
; ; UI options
; (ignore-errors
;   (menu-bar-mode -1)
;   (scroll-bar-mode -1)
;   (tool-bar-mode -1)
;   (tooltip-mode -1)
;   (fset 'menu-bar-open nil))
; (fset 'yes-or-no-p 'y-or-n-p)
; (blink-cursor-mode 0)
; (setq-default frame-title-format '("%b (%m) — Emacs"))
; (show-paren-mode t) ;; Highlight matching parens
; (setq ring-bell-function 'ignore) ;; Disable bell
; (setq-default whitespace-style '(face trailing spaces space-mark))
; (setq-default show-trailing-whitespace t)
; (global-hl-line-mode t)
; (column-number-mode)
; (setq-default display-line-numbers-current-absolute nil
;               display-line-numbers 'visual
;               display-line-numbers-widen nil
;               display-line-numbers-width 2)
; 
; (save-place-mode 1) ;; Save buffer position at exit
; (setq auto-save-default nil) ;; Disable autosave
; (setq x-select-enable-clipboard t) ;; Use system clipboard
; (setq ad-redefinition-action 'accept) ;; Supress defadvice warnings
; 
; ;; Set default apps
; (setq browse-url-browser-function 'browse-url-generic
;       browse-url-generic-program "firefox")
; 
; ;; Color scheme
; (use-package gruvbox-theme
;   :ensure t
;   :init
;   (load-theme 'gruvbox-dark-medium t))
; (set-face-attribute 'line-number nil
;                     :background "#282828")
; (set-face-attribute 'line-number-current-line nil
;                     :background "#282828"
;                     :foreground "#fabd2f")
; (set-face-attribute 'default nil :font "Iosevka-12")
; 
; ;; Diminish setup
; (use-package diminish :ensure t)
; (diminish 'abbrev-mode)
; (diminish 'auto-revert-mode)
; 
; ;; *scratch*
; (setq inhibit-startup-screen t)
; (setq initial-scratch-message nil)
; 
; ;; Scrolling
; (setq scroll-step 1) ;; Don't center frame
; (setq scroll-margin 7)
; 
; ;; Evil
; (use-package evil
;   :ensure t
;   :init
;   (setq evil-search-module 'evil-search)
;   ;; Vim keybinds behaviour
;   (setq evil-want-C-i-jump t)
;   (setq evil-want-C-u-scroll t)
;   (setq evil-want-Y-yank-to-eol t)
;   ;; Case-sensitive search
;   (setq evil-ex-search-case 'sensitive)
;   ;; Emacs commands (M-x) in Evil command mode
;   (setq evil-ex-complete-emacs-commands t)
;   ;; Windows behaviour
;   (setq evil-vsplit-window-right t)
;   (setq evil-split-window-below t)
;   (setq evil-shift-round nil)
;   :config
;   (evil-mode))
; (use-package evil-numbers
;   :ensure t
;   :after evil)
; (defvar evil-leader-map (make-sparse-keymap)
;     "Keymap for \"leader key\" shortcuts.")
; (define-key evil-normal-state-map (kbd "SPC") evil-leader-map)
; (use-package evil-leader
;   :commands (evil-leader-mode)
;   :ensure t
;   :init
;   (global-evil-leader-mode))
; (define-key evil-normal-state-map (kbd "<C-i>") 'evil-jump-forward) ;; Fix C-i
; ;; gj/gk
; (define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
; (define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)
; ;; jj to leave insert mode
; (use-package key-chord
;   :config
;   (key-chord-define evil-insert-state-map "jj" 'evil-normal-state))
; 
; ;; Surround plugin
; (use-package evil-surround
;   :ensure t
;   :config
;   (global-evil-surround-mode 1))
; 
; ;; Nerdcommenter plugin
; (use-package evil-nerd-commenter
;   :ensure t
;   :after evil
;   :config
;   (evilnc-default-hotkeys nil t))
; (evil-leader/set-key "ci" 'evilnc-comment-or-uncomment-lines)
; (evil-leader/set-key "cl" 'evilnc-quick-comment-or-uncomment-to-the-line)
; (evil-leader/set-key "ll" 'evilnc-quick-comment-or-uncomment-to-the-line)
; (evil-leader/set-key "cc" 'evilnc-copy-and-comment-lines)
; (evil-leader/set-key "cp" 'evilnc-comment-or-uncomment-paragraphs)
; (evil-leader/set-key "cr" 'comment-or-uncomment-region)
; (evil-leader/set-key "cr" 'comment-or-uncomment-region)
; (evil-leader/set-key "cv" 'evilnc-toggle-invert-comment-line-by-line)
; (evil-leader/set-key "."  'evilnc-copy-and-comment-operator)
; 
; ;; Treemacs
; (use-package treemacs
;   :ensure t
;   :config
;   (setq treemacs-no-png-images 't) ;; disable icons
;   ;; Keybindings
;   (global-set-key (kbd "M-1") 'treemacs))
; (use-package treemacs-evil
;   :ensure t
;   :after treemacs)
; 
; ;; Configure evil behaviour in some Emacs-native modes
; (evil-define-key 'normal image-mode-map "q" 'quit-window)
; (evil-define-key 'normal help-mode-map "q" 'quit-window)
; 
; ;; Common keybindings
; (evil-leader/set-key "xf" 'counsel-find-file)
; (evil-leader/set-key "xr" 'counsel-recentf)
; (evil-leader/set-key "xs" 'save-buffer)
; (evil-leader/set-key "s" 'save-buffer)
; (evil-leader/set-key "xc" 'save-buffers-kill-terminal)
; (evil-leader/set-key "SPC" 'counsel-M-x)
; (evil-leader/set-key "h"  'evil-ex-nohighlight)
; (evil-leader/set-key "es"  'delete-trailing-whitespace)
; 
; ;; Expand-region
; (use-package expand-region :ensure t :config)
; (evil-declare-key 'normal global-map "+" 'er/expand-region)
; (evil-declare-key 'visual global-map "+" 'er/expand-region)
; (evil-declare-key 'normal global-map "_" 'er/contract-region)
; (evil-declare-key 'visual global-map "_" 'er/contract-region)
; 
; ;; Kill all buffer expect the current one
; (defun kill-other-buffers ()
;   "Kill all other buffers."
;   (interactive)
;   (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))
; (evil-leader/set-key "Ko"  'kill-other-buffers)
; 
; ;; Avy
; (use-package avy
;   :ensure t
;   :config
;   (global-set-key (kbd "M-;") 'avy-goto-char)
;   (global-set-key (kbd "M-C-;") 'avy-resume))
; 
; ;; ivy
; (use-package ivy
;   :ensure t
;   :diminish ivy-mode
;   :config
;   (ivy-mode 1))
; (define-key ivy-minibuffer-map (kbd "<escape>") 'minibuffer-keyboard-quit)
; (define-key ivy-minibuffer-map (kbd "M-q") 'minibuffer-keyboard-quit)
; (define-key ivy-minibuffer-map (kbd "M-j") 'ivy-next-line)
; (define-key ivy-minibuffer-map (kbd "M-k") 'ivy-previous-line)
; (define-key ivy-minibuffer-map (kbd "M-l") 'ivy-alt-done)
; (evil-leader/set-key "b"  'ivy-switch-buffer)
; (evil-leader/set-key "fs" 'counsel-rg)
; 
; ;; Smex. required to show most recent commands with counsel-M-x.
; (use-package smex
;   :ensure t
;   :config
;   (setq smex-save-file (concat user-emacs-directory "smex-items")))
; 
; ;; Counsel
; (use-package counsel
;   :ensure t
;   :config
;   (setcdr (assoc 'counsel-M-x ivy-initial-inputs-alist) "") ;; Remove initial "^"
;   ;; Global ignore patterns
;   (setq counsel-find-file-ignore-regexp "^.cquery")
;   ;; Replace default `find-file-at-point'
;   (setq counsel-find-file-at-point t)
;   ;; Set matching style
;   (setq ivy-re-builders-alist
;     '((swiper . ivy--regex-plus)
;       (counsel-rg . ivy--regex-plus)
;       (counsel-projectile-switch-project . ivy--regex-plus)
;       (counsel-projectile-rg . ivy--regex-plus)
;       (t . ivy--regex-plus))))
; 
; ;; Search with rg in specific files
; (defmacro def-counsel-rg--ft (filetype)
; (let ((funsymbol (intern (concat "counsel-rg--ft-" filetype))))
;   `(defun ,funsymbol ()
;      (interactive)
;      (counsel-rg
;       nil
;       nil
;       (format "--type %s" ,filetype)
;       (format "rg %s: " (capitalize ,filetype))))))
; (def-counsel-rg--ft "c")
; (def-counsel-rg--ft "cpp")
; (def-counsel-rg--ft "elisp")
; (def-counsel-rg--ft "rust")
; (def-counsel-rg--ft "py")
; (def-counsel-rg--ft "sh")
; (evil-leader/set-key "fac" 'counsel-rg--ft-c)
; (evil-leader/set-key "fax" 'counsel-rg--ft-cpp)
; (evil-leader/set-key "far" 'counsel-rg--ft-rust)
; (evil-leader/set-key "fap" 'counsel-rg--ft-py)
; (evil-leader/set-key "fas" 'counsel-rg--ft-sh)
; 
; ;; Swiper
; (use-package swiper :ensure t)
; 
; ;; popup shell
; (defun eshell-here ()
;   "Opens up a new shell in the directory associated with the
; current buffer's file. The eshell is renamed to match that
; directory to make multiple eshell windows easier."
;   (interactive)
;   (let* ((parent (if (buffer-file-name)
;                      (file-name-directory (buffer-file-name))
;                    default-directory))
;          (height (/ (window-total-height) 3))
;          (name   (car (last (split-string parent "/" t)))))
;     (split-window-vertically (- height))
;     (other-window 1)
;     (eshell "new")
;     (rename-buffer (concat "*eshell: " name "*"))
;     (insert (concat "ls"))
;     (eshell-send-input)))
; (evil-declare-key 'normal global-map "`\\" 'eshell-here)
; (evil-declare-key 'normal eshell-mode-map (kbd "M-j") 'eshell-previous-prompt)
; (evil-declare-key 'normal eshell-mode-map (kbd "M-k") 'eshell-next-prompt)
; 
; ;; TRAMP
; (setq tramp-default-method "ssh")
; 
; ;; which-key mode
; (use-package which-key
;   :ensure t
;   :diminish which-key-mode
;   :after evil
;   :config
;   (setq which-key-allow-evil-operators t)
;   (which-key-mode))
; 
; ;; recentf configuration
; (use-package recentf
;   :ensure t
;   :init
;   (add-hook 'after-init-hook #'recentf-mode)
;   (setq recentf-max-saved-items 300)
;   :config
;   (add-to-list 'recentf-exclude (expand-file-name package-user-dir))
;   (add-to-list 'recentf-exclude ".cache")
;   (add-to-list 'recentf-exclude ".mypy_cache")
;   (add-to-list 'recentf-exclude ".elfeed")
;   (add-to-list 'recentf-exclude "bookmarks")
;   (add-to-list 'recentf-exclude "recentf")
;   (add-to-list 'recentf-exclude "url")
;   (add-to-list 'recentf-exclude "TAGS")
;   (add-to-list 'recentf-exclude "COMMIT_EDITMSG\\'"))
; 
; ;; Undo-tree
; (use-package undo-tree
;   :ensure t
;   :diminish undo-tree-mode
;   :config
;   (setq undo-tree-auto-save-history t
;         undo-tree-history-directory-alist
;         `(("." . ,(concat user-emacs-directory "undo"))))
;   (unless (file-exists-p (concat user-emacs-directory "undo"))
;   (make-directory (concat user-emacs-directory "undo")))
;   (global-undo-tree-mode 1))
; 
; ;; Save backup files in separate directory
; (setq backup-by-copying t
;     create-lockfiles nil
;     backup-directory-alist '(("." . "~/.cache/emacs-backups"))
;     auto-save-file-name-transforms '((".*" "~/.cache/emacs-backups" t)))
; 
; ;; Custom file
; (setq custom-file (expand-file-name "custom.el" user-emacs-directory))
; (load custom-file :noerror)
; 
; ;; Delete current file and buffer
; (defun delete-file-and-buffer ()
;   "Kill the current buffer and deletes the file it is visiting."
;   (interactive)
;   (let ((filename (buffer-file-name)))
;     (when filename
;       (if (vc-backend filename)
;           (vc-delete-file filename)
;         (progn
;           (delete-file filename)
;           (message "Deleted file %s" filename)
;           (kill-buffer))))))
; (evil-ex-define-cmd "Delele" 'delete-file-and-buffer)
; 
; ;; Rename current file and buffer
; (defun rename-file-and-buffer (new-name)
;   "Renames both current buffer and file it's visiting to NEW-NAME."
;   (interactive "sNew name: ")
;   (let ((name (buffer-name))
;         (filename (buffer-file-name)))
;     (if (not filename)
;         (message "Buffer '%s' is not visiting a file!" name)
;       (if (get-buffer new-name)
;           (message "A buffer named '%s' already exists!" new-name)
;         (progn
;           (rename-file filename new-name 1)
;           (rename-buffer new-name)
;           (set-visited-file-name new-name)
;           (set-buffer-modified-p nil))))))
; (evil-ex-define-cmd "Rename" 'rename-file-and-buffer)
; 
; ;; Open files in system applications
; (use-package openwith
;   :ensure t
;   :config
;   (openwith-mode t)
;   (setq openwith-associations '(("\\.pdf\\'" "zathura" (file)))))
; 
; 
; ;; Prog-mode configuration
; (add-hook 'prog-mode-hook (lambda () (setq show-trailing-whitespace t)))
; (setq-default tab-width 2 indent-tabs-mode nil)
; (setq-default indent-tabs-mode nil)

(org-babel-load-file "~/.emacs.d/config.org")

(provide 'init)
;;; init.el ends here
