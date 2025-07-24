(with-eval-after-load 'elisp-mode
    (defun eval-dev-buffer ()
    "Execute the current buffer as Lisp code.
    Top-level forms are evaluated with `eval-defun' so that `defvar'
    and `defcustom' forms reset their default values."
    (interactive)
    (save-excursion
      (goto-char (point-min))
      (while (not (eobp))
	(forward-sexp)
	(eval-defun nil))))
    (local-leader-definer
      :keymaps 'emacs-lisp-mode-map
      "b" '("eval buffer (dev)" . eval-dev-buffer)
      "s" '("eval last sexp" . eval-last-sexp)
      "f" '("eval defun" . eval-defun)
	    ))

(provide '+elisp)
