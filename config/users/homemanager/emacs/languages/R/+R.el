(use-package ess :defer t)

(with-eval-after-load 'org
	(org-babel-do-load-languages
	 'org-babel-load-languages
	 '((R . t))))

(eglot-add ess-r ("R" "--slave" "-e" "languageserver::run()"))
(add-hook 'ess-r-mode-hook 'eglot-ensure)


(with-eval-after-load 'ess-r-mode
	(local-leader-definer
		:keymaps 'ess-r-mode-map
		"f" '("format buffer" . eglot-format-buffer)
		))


(provide '+R)
