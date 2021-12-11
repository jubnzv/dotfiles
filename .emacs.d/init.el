;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; A minimal Emacs configuration file.
;; I use it for org-mode and REPL-based development.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Configuration variables
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconst jbz/c-ocaml t
  "Setup OCaml layer.")
(defconst jbz/c-lua t
  "Setup Lua layer.")
(defconst jbz/c-org t
  "Setup org-mode layer.")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Helper macroses and functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun jbz/define-evil-key (k fn)
  (define-key evil-normal-state-map (kbd (concat "SPC " k)) fn)
  (define-key evil-insert-state-map (kbd (concat "C-c " k)) fn)
  (define-key evil-visual-state-map (kbd (concat "C-c " k)) fn))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Setup functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun jbz/setup-packages ()
  "Configure package manager and repositories."
  (require 'package)
  (customize-set-variable 'package-archives
                          `(("melpa" . "https://melpa.org/packages/")
                            ("org" . "https://orgmode.org/elpa/")
                            ,@package-archives))
  (customize-set-variable 'package-enable-at-startup nil)
  (package-initialize)
  (unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package))
  (eval-when-compile
    (require 'use-package)
    (setq use-package-always-ensure t)))

(defun jbz/setup-general ()
  "Most general settings and configuration for the common plugins
   which are essential in my configuration."
  ;; Increase GC
  ;; Increasing GC is a common way to speed up Emacs:
  ;; https://bling.github.io/blog/2016/01/18/why-are-you-changing-gc-cons-threshold/
  (defvar file-name-handler-alist-backup
          file-name-handler-alist)
  (setq gc-cons-threshold
          most-positive-fixnum
        file-name-handler-alist nil)
  (add-hook 'after-init-hook
    (lambda ()
      (garbage-collect)
      (setq gc-cons-threshold
              (car (get 'gc-cons-threshold 'standard-value))
        file-name-handler-alist
          (append
            file-name-handler-alist-backup
            file-name-handler-alist))))
  ;; Keep backup files in the separate directory
  (setq backup-by-copying t
        create-lockfiles nil
        backup-directory-alist '(("." . "~/.cache/emacs-backups"))
        auto-save-file-name-transforms '((".*" "~/.cache/emacs-backups" t)))
  ;; Automatically save place in files, so that visiting them later
  ;; (even during a different Emacs session) automatically moves point
  ;; to the saved position, when the file is first found.
  (save-place-mode 1)
  ;; Track recent files
  (recentf-mode 1)
  (setq recentf-max-menu-items 1000)
  ;; Disable auto save
  (setq auto-save-default nil)
  ;; Use system clipboard
  (setq x-select-enable-clipboard t)
  ;; Setup some options from my vim config
  (setq redisplay-dont-pause t ; lazyredraw
        scroll-step 7          ; scroll
        scroll-margin 7)       ; scrolloff
  ;; Autocomplete brackets
  (electric-pair-mode t)
  ;; Advise function to transparently create parent directories
  (defadvice find-file (before make-directory-maybe (filename &optional wildcards) activate)
  "Create parent directory if not exists while visiting file."
  (unless (file-exists-p filename)
    (let ((dir (file-name-directory filename)))
      (unless (file-exists-p dir)
        (make-directory dir t)))))
  ;; Set *scratch* buffer
  (setq initial-major-mode 'org-mode
        inhibit-splash-screen t
        initial-scratch-message nil)
  ;; Store auto-generated settings in the separate file
  (setq custom-file (expand-file-name "custom.el" user-emacs-directory))
  (load custom-file :noerror)
  ;; Hide some mode names from the modeline
  (use-package diminish
    :config
    (diminish eldoc-mode))
  ;; Highlight symbol under the cursor
  (use-package highlight-symbol
    :init (highlight-symbol-mode)
    :config
    (setq highlight-symbol-idle-delay 0.01))
  (use-package which-key
    :init (which-key-mode)
    :diminish which-key-mode)
  (use-package projectile
    :init (projectile-mode)
    :diminish projectile-mode)
  (use-package undo-tree
    :diminish undo-tree-mode
    :init (global-undo-tree-mode))
  (use-package key-chord
    :init (key-chord-mode 1)
    :config
    (setq key-chord-two-keys-delay 0.5)))

(defun jbz/setup-gui ()
  "GUI options."
  ;; Start Emacs in fullscreen mode on MS-Windows
  (add-hook 'emacs-startup-hook 'toggle-frame-maximized)
  ;; Show file name in window title
  (setq-default frame-title-format '("%b — Emacs"))
  ;; Disable cursor blinking
  (blink-cursor-mode -1)
  ;; Show trailing whitespaces
  (setq-default show-trailing-whitespace t)
  ;; Use y/n instead of yes/no
  (fset 'yes-or-no-p 'y-or-n-p)
  ;; Display relative line numbers
  (global-display-line-numbers-mode 1)
  (setq display-line-numbers-type 'relative)
  ;; Always highlight current line
  (global-hl-line-mode)
  ;; Set colorscheme
  (use-package doom-themes
    :config
    (setq doom-themes-enable-bold t
          doom-themes-enable-italic t)
    ;; Corrects (and improves) org-mode's native fontification.
    (doom-themes-org-config))
  (load-theme 'doom-gruvbox t))

(defun jbz/setup-evil ()
  "Configuration of evil-mode and related plugins.
   Evil keybindings for particular pluings has been configured separately."
  ;; Must be set before loading evil no matter what
  (setq evil-want-keybinding nil)
  (use-package evil
    :init  (evil-mode)
    :config
    ;; End of sentence markers used by `(' and `)'
    (setq sentence-end "[\\.\\?\\!] +")
    ;; Undo functionality
    (evil-set-undo-system 'undo-tree))
    ;; Set evil variables
    (setq evil-search-module 'evil-search
          ;; Vim keybinds behaviour
          evil-want-C-i-jump t
          evil-want-C-u-scroll t
          evil-want-C-d-scroll t
  	  evil-want-fine-undo t
          evil-want-Y-yank-to-eol t
          ;; Case-sensitive search
          evil-ex-search-case 'sensitive
          ;; Emacs commands (M-x) in Evil command mode
          evil-ex-complete-emacs-commands t
          ;; Windows behaviour
          evil-vsplit-window-right t
          evil-split-window-below t
          evil-shift-round nil)
    (key-chord-define evil-insert-state-map "jj" 'evil-normal-state)
    (define-key evil-motion-state-map (kbd "C-i") #'evil-jump-forward)
    (define-key evil-normal-state-map (kbd "C-i") #'evil-jump-forward)
    (define-key evil-normal-state-map (kbd "SPC h") #'evil-ex-nohighlight)
    (define-key evil-normal-state-map (kbd "SPC w") #'save-buffer)
    (define-key evil-normal-state-map (kbd "SPC f o") #'counsel-recentf)
    (define-key evil-normal-state-map (kbd "SPC f p") #'counsel-projectile-switch-project)
    (define-key evil-normal-state-map (kbd "M-p") #'counsel-projectile-find-file)
    (define-key evil-normal-state-map (kbd "SPC e w") #'find-file)
    (define-key evil-normal-state-map (kbd "C-]") #'dumb-jump-go)
    (define-key evil-normal-state-map (kbd "SPC b") #'switch-to-buffer)
    (when evil-want-C-u-scroll
     (define-key evil-insert-state-map (kbd "C-u") 'evil-scroll-up)
     (define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
     (define-key evil-visual-state-map (kbd "C-u") 'evil-scroll-up)
     (define-key evil-motion-state-map (kbd "C-u") 'evil-scroll-up))
  (use-package evil-collection
    :after (evil))
  (use-package evil-surround
    :init (global-evil-surround-mode 1))
  ;; (use-package evil-numbers
  ;;   :config
  ;;   (define-key evil-normal-state-map (kbd "C-a") #'evil-numbers/inc-at-pt)
  ;;   (define-key evil-normal-state-map (kbd "C-x") #'evil-numbers/dec-at-pt))
  (use-package evil-nerd-commenter
    :bind ("C-/" . evilnc-comment-or-uncomment-lines)))

(defun jbz/setup-prog ()
  "Common setup for programming modes."
  (use-package rainbow-delimiters
    :ensure rainbow-delimiters
    :hook (prog-mode . rainbow-delimiters-mode))
  ;; Highlight TODO and FIXME entries
  (use-package hl-todo
    :hook
    (prog-mode . hl-todo-mode)
    (org-mode . hl-todo-mode)
    :config
    (setq hl-todo-keyword-faces
      '(("TODO"   . "#cc241d")
        ("FIXME"  . "#d79921"))))
  ;; dumb-jump is a ctags alternative
  (use-package dumb-jump
    :init
    (add-hook 'xref-backend-functions #'dumb-jump-xref-activate))
  (use-package magit
    :defer t)
  (use-package company
    :init
    (add-hook 'after-init-hook 'global-company-mode)
    :diminish company-mode
    :config
    (define-key company-active-map (kbd "M-q") 'company-abort)
    (define-key company-active-map (kbd "M-l") 'company-complete)
    (define-key company-active-map (kbd "M-j") 'company-select-next)
    (define-key company-active-map (kbd "M-k") 'company-select-previous)
    (define-key company-search-map (kbd "M-q") 'company-abort)
    (define-key company-search-map (kbd "M-l") 'company-complete)
    (define-key company-search-map (kbd "M-j") 'company-select-next)
    (define-key company-search-map (kbd "M-k") 'company-select-previous)
    (define-key company-search-map (kbd "M-f") 'company-search-toggle-filtering))
  ;; Setup LSP
  (use-package lsp-mode
      :hook
      (tuareg-mode . lsp)))

(defun jbz/setup-ivy ()
  "Configuration for ivy fuzzy-finder and related packages."
  (use-package ivy
    :diminish ivy-mode
    :custom
    ;; (ivy-re-builders-alist '((t . ivy--regex-fuzzy)))
    (ivy-count-format "%d/%d " "Show anzu-like counter")
    (ivy-use-selectable-prompt t "Make the prompt line selectable")
    (ivy-current-match ((t (:inherit 'hl-line))))
    :bind
    (:map mode-specific-map
          ("C-r" . ivy-resume))
    :config
    (ivy-mode t))
  (use-package counsel
    :init (counsel-mode)
    :diminish counsel-mode
    :bind
    (("M-x" . counsel-M-x))
    :custom
    (counsel-grep-base-command
     "rg -i -M 100 --no-heading --line-number --color never %s %s"))
  (use-package swiper)
  (use-package counsel-projectile))

(defun jbz/setup-ocaml ()
  "Configuration related to OCaml language."
  (use-package tuareg
    :defer t
    :hook
    (tuareg-mode . (lambda ()
  		       (setq tab-width 2))))
  (use-package utop
    :defer t
    :init (add-hook 'tuareg-mode-hook 'utop-minor-mode)
    :diminish utop-minor-mode))

(defun jbz/setup-lua ()
  "Configuration related to Lua language."
  (use-package lua-mode
    :defer t
    :bind ("C-x C-r" . lua-send-region)
    :config
    (setq lua-always-show t)))

(defun jbz/setup-org ()
  "Configuration for org-mode and related plugins."
  ;; Configuration variables for all org-related things.
  (setq org-directory (expand-file-name "~/Org/org-mode/")
        org-agenda-files (list org-directory)
        org-roam-directory (concat org-directory "/z/")
        references-directory '("~/Org/references.bib")
        org-default-notes-file (concat org-directory "/Notes.org"))
  (setq org-capture-templates
        '(("t" "Todo" entry (file org-default-notes-file)
           "* TODO %?\n  %i\n  %a")))
  (use-package org
    :hook
    ;; Fix extra indentation provided by evil-mode
    (org-mode . (lambda () (setq evil-auto-indent nil)))
    :config
    (setq org-startup-truncated nil
	  org-startup-with-inline-images t)
    (jbz/define-evil-key "o c" #'org-capture)
    (jbz/define-evil-key "o f" #'counsel-find-file))
  (use-package org-alert
    :commands
    (org-alert-enable)
    :config
    (setq alert-default-style 'libnotify
  	org-alert-interval 60))
  (use-package evil-org
    :after (org evil)
    :hook (org-mode . (lambda () evil-org-mode))
    :config
    (require 'evil-org-agenda)
    (evil-org-agenda-set-keys))
  (use-package org-roam
    :after (org evil)
    :init
    (setq org-roam-v2-ack t)
    :config
    (org-roam-db-autosync-mode)
    (setq org-roam-completion-everywhere t)
    (require 'org-roam-protocol)
    (jbz/define-evil-key "n l" #'org-roam-buffer-toggle)
    (jbz/define-evil-key "n f" #'org-roam-node-find)
    (jbz/define-evil-key "n g" #'org-roam-graph)
    (jbz/define-evil-key "n i" #'org-roam-node-insert)
    (jbz/define-evil-key "n c" #'org-roam-capture)
    (jbz/define-evil-key "n j" #'org-roam-dailies-capture-today))
  ;; Paste pictures from clipboard.
  (use-package org-download
    :config
    (jbz/define-evil-key "p y" #'org-download-yank)      ;; Paste from URL
    (jbz/define-evil-key "p c" #'org-download-clipboard) ;; Paste from clipboard
    :custom
    (org-download-method 'directory)
    (org-download-image-dir "img"))
  ;; Paste URL from clipboard as org-mode link.
  (use-package org-cliplink
    :config
    (jbz/define-evil-key "P" #'org-cliplink))
  (use-package org-roam-ui
    :after (org-roam)
    :config
    (setq org-roam-ui-sync-theme t
	  ;org-roam-ui-follow t
	  org-roam-ui-update-on-save t)
    (jbz/define-evil-key "n u" #'org-roam-ui-open))
  (use-package org-ref
    :config
    (setq org-ref-default-bibliography references-directory
  	bibtex-completion-bibliography references-directory
          bibtex-completion-pdf-field "file"
          org-ref-completion-library 'org-ref-ivy-cite
          org-ref-notes-function 'orb-edit-notes
          org-ref-default-citation-link "parencite"))
  (use-package org-roam-bibtex
    :ensure ivy-bibtex
    :after (org-roam org-ref)
    :hook (org-roam-mode . org-roam-bibtex-mode)
    :config
    (setq org-roam-bibtex-preformat-keywords
     '("=key=" "title" "url" "file" "author-or-editor" "keywords"))
    (setq orb-templates
  	'(("p" "paper" plain (function org-roam-capture--get-point)
  	   ""
  	   :file-name "paper:${slug}"
  	   :head "#+TITLE: ${=key=}: ${title}

      - tags ::
      - keywords :: ${keywords}

      \n* ${title}\n  :PROPERTIES:\n  :Custom_ID: ${=key=}\n  :URL: ${url}\n  :AUTHOR: ${author-or-editor}\n  :NOTER_DOCUMENT: %(orb-process-file-field \"${=key=}\")\n  :NOTER_PAGE: \n  :END:\n\n"
  	   :unnarrowed t)))
    :custom
    (orb-roam-ref-format "org-ref-v3")
    (orb-insert-interface "ivy-bibtex")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Setup driver
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(jbz/setup-packages)
(jbz/setup-general)
(jbz/setup-gui)
(jbz/setup-evil)
(jbz/setup-prog)
(jbz/setup-ivy)
(jbz/setup-prog)
(when jbz/c-ocaml (jbz/setup-ocaml))
(when jbz/c-lua   (jbz/setup-lua))
(when jbz/c-org   (jbz/setup-org))
