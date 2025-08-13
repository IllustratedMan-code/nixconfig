(use-package treesit-auto
	:config
	(treesit-auto-add-to-auto-mode-alist)
	(global-treesit-auto-mode))

(use-package lsp-mode
	:commands lsp-deferred
	:config
	(setq lsp-headerline-breadcrumb-enable nil)
	(setq lsp-format-buffer-on-save 't)
	)

(use-package lsp-ivy)

(with-eval-after-load 'company
  (setq-default ispell-alternate-dictionary (expand-file-name "~/.emacs.d/ispell/all-words.txt"))
  (setq company-minimum-prefix-length 1)
  (setq company-backends '(
			   (company-capf
			    company-dabbrev-code
			    company-dabbrev
			    company-files
			    company-keywords
			    company-yasnippet))))
(provide 'languages)
