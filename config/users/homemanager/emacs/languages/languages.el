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
  (setq lsp-completion-provider :none) ;; needed to prevent capf from stealing all the completions
  (setq company-backends '(
			   (company-yasnippet
			    company-capf
			    company-keywords
			    company-dabbrev-code
			    company-dabbrev
			    company-files
			    ))))

(use-package smartparens
  :config
  (require 'smartparens-config)
  (smartparens-global-mode)
  (defun +sp-wrap-interactive ()
    (interactive)
    (sp-wrap-with-pair (string (read-key "wrap with: ")))
    )
  :general-config
  (leader-definer
    :states '(normal visual)
    :keymaps 'override
    "s" '(:ignore t :which-key "smartparens")
    "sw" '("wrap region" . +sp-wrap-interactive)
    "ss" '("swap sexp" . sp-rewrap-sexp)
    "sl" '("slurp forward" . sp-forward-slurp-sexp)
    "sk" '("barf forward" . sp-forward-barf-sexp)
    "sj" '("barf backward" . sp-backward-barf-sexp)
    "sh" '("slurp backward" . sp-backward-slurp-sexp)
    )
  )

(provide 'languages)
