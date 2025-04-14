;;; userkeymap.el --- The User's Keymap  -*- lexical-binding: t; -*-

(use-package evil
  :demand t
  :bind (("<escape>" . keyboard-escape-quit))
  :init
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-owl
	:after evil
  :config
  (setq evil-owl-max-string-length 500)
  (add-to-list 'display-buffer-alist
               '("*evil-owl*"
                 (display-buffer-in-side-window)
                 (side . bottom)
                 (window-height . 0.3)))
  (evil-owl-mode))


(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package which-key
	:hook (after-init . which-key-mode))

(use-package general
	:after evil
	:config
  (setq general-emit-autoloads nil)

  (general-create-definer leader-definer
    :prefix "SPC"
		:states 'normal
    :keymaps 'override
    )

  (leader-definer
   "l" '("Previous Buffer" . evil-switch-to-windows-last-buffer)
   "f" '(:ignore t :which-key "find")
   "ff" '("file" . find-file)
   "fc" '("config" . (lambda ()
		       (interactive)
		       (find-file "~/nixconfig/config/users/homemanager/emacs")))
	 
   )

  (general-create-definer window-definer
    ;; local leader
    :prefix "SPC w"
		:states 'normal
    :keymaps 'override
    )

	(window-definer
   "" '(:ignore t :which-key "window")
	 "h" '("move left" . windmove-left)
	 "l" '("move left" . windmove-right)
	 "k" '("move left" . windmove-up)
	 "j" '("move left" . windmove-down)
	 "s" '("Split horizontally" . split-window-below)
	 "v" '("Split vertically" . split-window-right)
	 "d" '("Delete Window" . delete-window)
	 "m" '("Delete Other Windows" . delete-other-windows)
	 )

  (general-create-definer local-leader-definer
    ;; local leader
    :prefix "SPC m"
		:states 'normal
    :keymaps 'override
    )

  (local-leader-definer
    "" '(:ignore t :which-key "local leader")
    "l" '("Previous Buffer" . previous-buffer)
    )

  (general-create-definer help-definer
    ;; local leader
    :prefix "SPC h"
		:states 'normal
    :keymaps 'override
    )
	(help-definer
    "" '(:ignore t :which-key "help")
    "f" '("Describe Function" . describe-function)
		"v" '("Describe Variable" . describe-variable)
		"k" '("Describe Keybinding" . describe-key)
	 )

	)

(provide 'userkeymap)

