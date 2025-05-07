(defvar mode-line-total-lines
  '(:eval
    (format
     "%%l:%d" 
     (+
      (count-lines (point-min) (point-max))
      1))) ;; need to increment by 1
  "Show total lines and current line.")

(with-eval-after-load 'evil
  (setq-default mode-line-format
      `((:eval evil-mode-line-tag)
	" [%b] "
	" [%&]"
	mode-line-format-right-align
	" ["
	(:eval
	 (propertize (symbol-name major-mode)
		     'help-echo
		     (let ((modes '()))
		       (dolist (mode minor-mode-alist)
			 (when (and (boundp (car mode))
				    (symbol-value (car mode))
				    (cadr mode))
			   (push (format "%s" (cadr mode)) modes)))
		       (if modes
			   (mapconcat #'identity (reverse modes) ", ")
			 "No minor modes enabled"))))
	"] "
        ,mode-line-total-lines
	;; have to evaluate this for some reason. Not sure why.
	"  "
	)))

(provide '+modeline)
