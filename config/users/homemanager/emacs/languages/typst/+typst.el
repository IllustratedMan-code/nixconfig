
(with-eval-after-load 'lsp-mode
	(add-to-list 'lsp-language-id-configuration '(typst-ts-mode . "typst"))
	(lsp-register-client (make-lsp-client
												:new-connection (lsp-stdio-connection "tinymist")
												:activation-fn (lsp-activate-on "typst")
												:server-id 'tinymist)
												 ))

(with-eval-after-load 'eglot
  (with-eval-after-load 'typst-ts-mode
    (add-to-list 'eglot-server-programs
                `((typst-ts-mode) .
                   ,(eglot-alternatives `("tinymist"))))))
(setq-default eglot-workspace-configuration
							'(:tinymist (:formatterMode "typstyle")))

(use-package ox-typst
	:after org
	:config
	(setq org-typst-from-latex-environment #'org-typst-from-latex-with-pandoc)
	(setq org-typst-from-latex-fragment #'org-typst-from-latex-with-pandoc)
	)

;;(add-hook 'typst-ts-mode-hook 'eglot-ensure)
(provide '+typst)
