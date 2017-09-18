;; Path to hugo blog
(setq blog-path "/home/jubnzv/Blog/idie_blog/")

(defun ff ()
  "Prompt user to enter a file name to create a new blog entry"
  (interactive)
  (let ((x (read-file-name "Enter file name:" (concat blog-path "content/blog"))))
    x))

(provide 'rc-experimental)
