(defun jbz-int-to-binary-string (i)
  "Convert an integer into it's binary representation in string format"
  ;(interactive "Enter integer: ")
  (let ((res ""))
    (while (not (= i 0))
      (setq res (concat (if (= 1 (logand i 1)) "1" "0") res))
      (setq i (lsh i -1)))
    (if (string= res "")
        (setq res "0"))
    res))

(provide 'jzv-functions)
