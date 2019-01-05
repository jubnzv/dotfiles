(setq user-mail-address "jubnzv@gmail.com")

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
    '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(when (not package-archive-contents) (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

(use-package use-package-chords
  :ensure t
  :config (key-chord-mode 1))

(ignore-errors
    (menu-bar-mode -1)
    (scroll-bar-mode -1)
    (tool-bar-mode -1)
    (tooltip-mode -1)
    (fset 'menu-bar-open nil))

(fset 'yes-or-no-p 'y-or-n-p)

(use-package doom-modeline
  :ensure t
  :defer t
  :config
  (setq doom-modeline-height 15)
  (setq doom-modeline-icon nil)
  :hook (after-init . doom-modeline-init))

(show-paren-mode t)

(setq show-trailing-whitespace t)
(setq whitespace-style '(face trailing spaces space-mark))

(global-hl-line-mode t)

(setq redisplay-dont-pause t)

(column-number-mode)

(setq display-line-numbers-current-absolute t)
(setq display-line-numbers 'visual)

(setq inhibit-startup-screen t)

(blink-cursor-mode 0)

(use-package gruvbox-theme :ensure t)

(set-face-attribute 'default nil :font "Iosevka-12")

(setq scroll-margin 7)

(setq ring-bell-function 'ignore)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file :noerror)

(setq backup-by-copying t
    create-lockfiles nil
    backup-directory-alist '(("." . "~/.cache/emacs-backups"))
    auto-save-file-name-transforms '((".*" "~/.cache/emacs-backups" t)))

(setq x-select-enable-clipboard t)

(use-package evil
  :ensure t
  :init
  (setq evil-search-module 'evil-search)
  (setq evil-want-C-i-jump nil) ;; fix TAB key behaviour in evil-org extension
  (setq evil-ex-complete-emacs-commands nil)
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)
  (setq evil-shift-round nil)
  (setq evil-want-C-u-scroll t)
  :config   ;; tweak evil after loading it
  (evil-mode))

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

(defvar evil-leader-map (make-sparse-keymap)
    "Keymap for \"leader key\" shortcuts.")
(define-key evil-normal-state-map (kbd "SPC") evil-leader-map)

(use-package key-chord
    :config
    (key-chord-define evil-insert-state-map "jj" 'evil-normal-state))

(use-package evil-org
  :ensure t
  :after org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
            (lambda ()
              (evil-org-set-key-theme)))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(global-set-key (kbd "C-s") 'save-buffer)

(use-package ace-jump-mode
  :ensure t ;; install the ace-jump-mode package if not installed
  :bind ("M-;" . ace-jump-mode))

(define-key evil-leader-map "R"  (lambda() (interactive)(load-file "~/.emacs.d/init.el")))

(global-set-key (kbd "M-h") 'evil-ex-nohighlight)

(define-key evil-leader-map "es"  'delete-trailing-whitespace)

(use-package ivy
    :ensure t
    :config
    (ivy-mode 1))

(use-package counsel
    :ensure t)

(use-package swiper
    :ensure t)

(define-key ivy-minibuffer-map (kbd "<escape>") 'minibuffer-keyboard-quit)
(define-key ivy-minibuffer-map (kbd "M-q") 'minibuffer-keyboard-quit)
(define-key ivy-minibuffer-map (kbd "M-j") 'ivy-next-line)
(define-key ivy-minibuffer-map (kbd "M-k") 'ivy-previous-line)

(define-key evil-leader-map "b"  'ivy-switch-buffer)
(define-key evil-leader-map "fs" 'counsel-ag)

(use-package easy-hugo
    :ensure t
    :init
    (setq easy-hugo-basedir "~/Idie/")
    (setq easy-hugo-url "https://idie.ru/")
    (setq easy-hugo-root "~/Idie/public/")
    (setq easy-hugo-previewtime "300"))

(define-key evil-leader-map "H"  'easy-hugo)

(use-package indent-guide
    :ensure t
    :diminish indent-guide-mode
    :config
    (indent-guide-global-mode 1))

(use-package company
    :ensure t
    :diminish company-mode
    :config
    (setq company-backends (remove 'company-ropemacs company-backends))
    (setq company-tooltip-limit 20)
    (setq company-idle-delay 0)
    (global-company-mode 1))

(define-key company-active-map (kbd "M-j") 'company-select-next)
(define-key company-active-map (kbd "M-k") 'company-select-previous)
(define-key company-search-map (kbd "M-j") 'company-select-next)
(define-key company-search-map (kbd "M-k") 'company-select-previous)
