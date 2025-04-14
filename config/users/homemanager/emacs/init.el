(eval-when-compile (require 'use-package))
(add-to-list 'load-path "/home/david/.config/emacs/")

(make-directory "~/.emacs.d/autosaves" t)
(make-directory "~/.emacs.d/backups" t)
(setq auto-save-file-name-transforms
			`((".*" "~/.emacs.d/autosaves/" t)))
(setq backup-directory-alist `(("." . "~/.emacs.d/backups")))
(setq backup-by-copying t)


(use-package userkeymap
	:load-path "keymap/")

(use-package treesit-auto
	:config
	(treesit-auto-add-to-auto-mode-alist)
	(global-treesit-auto-mode))


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

(use-package nix-ts-mode
	:mode "\\.nix\\'")


(use-package projectile
	:after general
	)
