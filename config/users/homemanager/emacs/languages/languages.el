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

(provide 'languages)
