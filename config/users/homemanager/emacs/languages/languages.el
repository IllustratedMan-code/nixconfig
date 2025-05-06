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
  (setq ispell-alternate-dictionary (expand-file-name "~/.emacs.d/ispell/wordlist.txt"))
  (add-to-list 'company-backends 'company-ispell))

(provide 'languages)
