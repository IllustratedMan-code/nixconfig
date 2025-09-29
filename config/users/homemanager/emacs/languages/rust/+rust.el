
(add-hook 'rust-ts-mode-hook 'eglot-ensure)

(provide '+rust)

(with-eval-after-load 'rust-ts-mode
	(local-leader-definer
		:keymaps 'rust-ts-mode-map
		"f" '("format buffer" . eglot-format-buffer)
		))
