(defun +ispell/merge_dicts
  (interactive)
  (let* ((personal_dict (expand-file-name "~/.aspell.en.pws"))
	 (all_words (locate-user-emacs-file "ispell/all-words.txt")):w)
    )

(with-eval-after-load 'ispell
  (setq-default ispell-alternate-dictionary (expand-file-name "~/.emacs.d/ispell/all-words.txt"))
  (when (file-exists-p "~/.aspell.en.pws")
    
    ))
