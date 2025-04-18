(use-package markdown-mode
	:mode ("README\\.md\\'". gfm-mode)
	:init (setq markdown-command "multimarkdown")
	)

(use-package apheleia
	:defer t
	:hook (markdown-mode . apheleia-mode)
	:config
	(add-to-list 'apheleia-mode-alist '(gfm-mode . prettier-markdown))
	:general
	(local-leader-definer
		;; markdown-mode won't work here
		:keymaps '(markdown-mode-map) ;; no idea why map has to be explicit here
		"f" '( "format buffer" . apheleia-format-buffer)
		)
	)

(provide '+markdown)
