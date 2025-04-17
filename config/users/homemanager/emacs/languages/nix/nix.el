
;; (use-package nix-ts-mode ;; shouldn't have to do this for every ts mode, but it should change in the future.
;; 	:hook (nix-ts-mode . lsp-deferred)
;; 	:mode "\\.nix\\'"
;; 	:config
;; 	(local-leader-definer
;; 		"t" '("previous buffer" . previous-buffer) 
;; 		)
;; 	)
(use-package nix-mode
	:hook (nix-mode . lsp-deferred)
	:mode "\\.nix\\'"
	;;:config
	;;(local-leader-definer
 )

(provide 'nix)
