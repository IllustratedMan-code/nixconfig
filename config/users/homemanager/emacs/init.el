(eval-when-compile (require 'use-package))
(eval-when-compile (require 'general))

(eval-when-compile
	(defmacro eglot-add (mode &rest servers)
		"Add a language server to eglot (eglot-add foo (\"server\" \"commands\")"
		(let ((mode-name (intern (concat (symbol-name mode) "-mode")))
					(mode-ts-name (intern (concat (symbol-name mode) "-ts-mode"))))
		`(with-eval-after-load 'eglot
			 (add-to-list 'eglot-server-programs
										`(,',mode-name . ,(eglot-alternatives ',servers))
										`(,',mode-ts-name . ,(eglot-alternatives ',servers))
										))
		)))

(general-create-definer local-leader-definer
		:prefix "SPC m"
		:states '(normal visual)
)

(general-create-definer leader-definer
		:prefix "SPC"
		:states '(normal visual)
		:keymaps 'override
)

(add-to-list 'load-path "/home/david/.config/emacs/")

(make-directory "~/.emacs.d/autosaves" t)
(make-directory "~/.emacs.d/backups" t)
(setq auto-save-file-name-transforms
			`((".*" "~/.emacs.d/autosaves/" t)))
(setq backup-directory-alist `(("." . "~/.emacs.d/backups")))
(setq backup-by-copying t)


(use-package niximports)

(use-package ivy
	:init (ivy-mode 1))
(use-package counsel
	:after ivy
	:init (counsel-mode 1))

(use-package company
	:config
	(add-hook 'after-init-hook 'global-company-mode)
 )
