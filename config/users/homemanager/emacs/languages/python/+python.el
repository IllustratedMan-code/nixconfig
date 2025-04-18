(use-package lsp-pyright
	:defer t
  :custom (lsp-pyright-langserver-command "pyright")
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp-deferred)))
  :hook (python-ts-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp-deferred)))
	)


(use-package apheleia
	:hook (python-mode . apheleia-mode)
	:hook (python-ts-mode . apheleia-mode)
	:general
	(local-leader-definer
		:keymaps '(python-mode-map python-ts-mode-map)
		"f" '( "format buffer" . apheleia-format-buffer)
		)
	)
	



(provide '+python)
