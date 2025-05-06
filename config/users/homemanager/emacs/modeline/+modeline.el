(defvar mode-line-total-lines
  '(:eval (format "%%l:%d" 
                  (count-lines (point-min) (point-max))
                  ))
  "Show total lines and current line.")

(setq mode-line-format
      `((:eval evil-mode-line-tag)
	" [%b] "
	" [%&]"
	mode-line-format-right-align
	" ["
	(:eval (propertize (symbol-name major-mode)
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
	"  "
	;; have to evaluate this for some reason. Not sure why.
	))

(propertize "hi" 'mouse-face highlight 'help-echo "hi there")
