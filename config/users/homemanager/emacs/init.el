(eval-when-compile (require 'use-package))
(add-to-list 'load-path "/home/david/.config/emacs/")

(make-directory "~/.emacs.d/autosaves" t)
(make-directory "~/.emacs.d/backups" t)
(setq auto-save-file-name-transforms
			`((".*" "~/.emacs.d/autosaves/" t)))
(setq backup-directory-alist `(("." . "~/.emacs.d/backups")))
(setq backup-by-copying t)

(use-package treesit-auto
	:config
	(treesit-auto-add-to-auto-mode-alist)
	(global-treesit-auto-mode))

(use-package evil
  :demand t
  :bind (("<escape>" . keyboard-escape-quit))
  :init
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

;;; Vim Bindings Everywhere else
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(setq inhibit-startup-screen t)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(setq ring-bell-function 'ignore)
(setq scroll-step 1)
(setq-default tab-width 2)
(setq-default indent-tabs-mode t)


(use-package which-key
  :hook (after-init . which-key-mode)
)


(use-package general
  :after evil
  :config
  (setq general-emit-autoloads nil)

  (general-create-definer leader-definer
    :prefix "SPC"
    :keymaps 'normal
    )

  (general-create-definer local-leader-definer
    ;; local leader
    :prefix "SPC m"
    :keymaps 'normal
    )

  (leader-definer
   "l" '("Previous Buffer" . previous-buffer)
   "f" '(:ignore t :which-key "find")
   "ff" '("file" . find-file)
   "fc" '("config" . (lambda ()
		       (interactive)
		       (find-file "~/nixconfig/config/users/homemanager/emacs")))
   )

  (local-leader-definer
    :keymaps 'normal
    "" '(:ignore t :which-key "local leader")
    "l" '("Previous Buffer" . previous-buffer)
    )
)  

(use-package nix-ts-mode
	:mode "\\.nix\\'")
