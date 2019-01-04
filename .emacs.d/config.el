(ignore-errors
    (menu-bar-mode -1)
    (scroll-bar-mode -1)
    (tool-bar-mode -1)
    (tooltip-mode -1)
    (fset 'menu-bar-open nil))

(set-face-attribute 'default nil :font "Iosevka-11")

(setq ring-bell-function 'ignore)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file :noerror)

(setq backup-by-copying t
    create-lockfiles nil
    backup-directory-alist '(("." . "~/.cache/emacs-backups"))
    auto-save-file-name-transforms '((".*" "~/.cache/emacs-backups" t)))

(setq x-select-enable-clipboard t)

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

(global-set-key (kbd "C-s") 'save-buffer)

(use-package ace-jump-mode
  :ensure t ;; install the ace-jump-mode package if not installed
  :bind ("M-;" . ace-jump-mode))

(use-package evil
  :ensure t ;; install the evil package if not installed
  :init     ;; tweak evil's configuration before loading it
  (setq evil-search-module 'evil-search)
  (setq evil-want-C-i-jump nil)         ;; fix TAB key behaviour in evil-org extension
  (setq evil-ex-complete-emacs-commands nil)
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)
  (setq evil-shift-round nil)
  (setq evil-want-C-u-scroll t)
  :config   ;; tweak evil after loading it
  (evil-mode))

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
