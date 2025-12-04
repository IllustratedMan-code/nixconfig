
(with-eval-after-load 'lsp-mode
	(add-to-list 'lsp-language-id-configuration '(typst-ts-mode . "typst"))
	(lsp-register-client (make-lsp-client
			      :new-connection (lsp-stdio-connection "tinymist")
			      :activation-fn (lsp-activate-on "typst")
			      :server-id 'tinymist)
			     ))

;; (with-eval-after-load 'eglot
;;   (with-eval-after-load 'typst-ts-mode
;;     (add-to-list 'eglot-server-programs
;;                 `((typst-ts-mode) .
;;                   ,(eglot-alternatives `("tinymist"))))))

(eglot-add typst ("tinymist"))

(setq-default eglot-workspace-configuration
	      '(:tinymist (:formatterMode "typstyle")))


(add-to-list 'load-path "/home/david/Documents/Personal-Projects/ox-typst/")
(use-package ox-typst
  :after org
  :config
  (setq org-typst-from-latex-environment #'org-typst-from-latex-with-pandoc)
  (setq org-typst-from-latex-fragment #'org-typst-from-latex-with-pandoc)
  (setq org-typst-default-header "#import \"@local/assignments:1.0.0\": conf\n#show: doc => conf(title: context{document.title}, date: context{if document.date == auto {datetime.today().display(\"[month repr:long] [day], [year]\")} else {document.date.display(\"[month repr:long] [day], [year]\")}}, doc)")
  )

;;(add-hook 'typst-ts-mode-hook 'eglot-ensure)
(provide '+typst)
