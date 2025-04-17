(eval-when-compile (require 'use-package))
(add-to-list 'load-path "/home/david/.config/emacs/")

(make-directory "~/.emacs.d/autosaves" t)
(make-directory "~/.emacs.d/backups" t)
(setq auto-save-file-name-transforms
			`((".*" "~/.emacs.d/autosaves/" t)))
(setq backup-directory-alist `(("." . "~/.emacs.d/backups")))
(setq backup-by-copying t)


(use-package niximports)

(setq inhibit-startup-screen t)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(setq ring-bell-function 'ignore)
(setq scroll-step 1)
(setq-default tab-width 2)
(setq-default indent-tabs-mode t)


(use-package markdown-mode
	:mode ("README\\.md\\'". gfm-mode)
	:init (setq markdown-command "multimarkdown")
	)

(use-package projectile
	:after general
	)

(use-package ivy
	:init (ivy-mode 1))
(use-package counsel
	:after ivy
	:init (counsel-mode 1))

(use-package company
	:config
	(add-hook 'after-init-hook 'global-company-mode)
 )
