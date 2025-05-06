
(use-package nix-mode
	:hook (nix-mode . lsp-deferred)
	:hook (nix-ts-mode . lsp-deferred)
	:mode "\\.nix\\'"
	:general-config
	(local-leader-definer
	  :keymaps 'nix-mode-map
	  "r" '("start repl" . nix-repl)
	  "c" '("rebuild system config" . (lambda () (interactive)
					    (let ((shell-command-switch "-Sic"))
					      (shell-command "nrs"))))
	  )
 )

(use-package lsp-nix
	:after (lsp-mode)
	:custom
	(lsp-nix-nil-formatter ["nixfmt"])
	:general-config
	(local-leader-definer
	  :keymaps 'nix-mode-map
	  "f" '("format buffer" . lsp-format-buffer)
	  )
 )

(provide '+nix)
