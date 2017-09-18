;; Org-mode settings 
(require 'org)

;; Path to static hugo blog content
(setq blog-path "/home/jubnzv/Blog/idie_blog/")

;; Capture templates for fast notekeping
(global-set-key (kbd "C-c c") 'org-capture)

(setq org-capture-templates
      '(
        ("j" "Note" entry (file+datetree "/media/vc_misc/Journal.org" "Note")
         "* %?\nEntered on %U\n  %i\n  %a")
	("b" "Blog entry" plain (file (concat blog-path "/content/blog/draft.org")) template-blog
	 :immediate-finish t)
        ))

;; Template with blog entry's header
(setq template-blog (concat
		     "#+TITLE: ?\n#+AUTHOR: Georgy Komarov\n#+DATE: "
		     ;; ISO-8601 timestamp format: 2016-12-14T10:17:43Z
		     (format-time-string "%Y-%m-%dT%TZ")
		     "\n#+DRAFT: false\n"))

(add-to-list 'org-structure-template-alist
	     (list "b" template-blog))

(setq org-refile-targets '((org-agenda-files . (:maxlevel . 6))))

(provide 'rc-org)
