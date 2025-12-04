;;; userkeymap.el --- The User's Keymap  -*- lexical-binding: t; -*-

(use-package evil
  :demand t
  :bind (("<escape>" . keyboard-escape-quit))
  :init
  (setq evil-want-keybinding nil)
  (setq evil-undo-system 'undo-redo)
  :config
  (evil-mode 1))

(use-package magit
  :general
  (leader-definer
    "g" '("git" . magit-status))
  )

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
  (evil-collection-init)
	)

(use-package which-key
	:hook (after-init . which-key-mode))

(setq general-emit-autoloads nil)


(use-package avy
	:commands 'avy-goto-char-timer
	:general
	(:states '(normal visual)
	 :keymaps 'override
	 "s" 'avy-goto-char-timer)
	:config
	(defun avy-action-mark-to-char (pt)
		(activate-mark)
		(goto-char pt))
	(setf (alist-get ?v avy-dispatch-alist) 'avy-action-mark-to-char)
	(setq avy-timeout-seconds 0.2)
	)
 

(leader-definer
  "SPC" '("M-x" . counsel-M-x)
  "z" '("Zen Mode" . writeroom-mode)
  "a" '("Org Agenda" . org-agenda)
  "l" '("Last Buffer" . evil-switch-to-windows-last-buffer)
  "f" '(:ignore t :which-key "find")
  "ff" '("file" . find-file)
  "fc" '(:ignore t :which-key "config")
  "fcn" '("nix config" . (lambda ()
		      (interactive)
		      (find-file (getenv "nixconfig"))))
  "fch" '("home manager config" . (lambda ()
		      (interactive)
		      (find-file (file-name-concat (getenv "nixconfig") "config/users/homemanager"))))
  "fce" '("emacs config" . (lambda ()
		      (interactive)
		      (find-file (getenv "emacsconfig"))))
  "fp" '("planner" . (lambda ()
		      (interactive)
		      (find-file (getenv "planner"))))
  "fw" '("wiki" . (lambda ()
		    (interactive)
		    (find-file "~/Wiki/wiki")))
  ";" '("comment" . comment-or-uncomment-region)
		)

(general-create-definer project-definer
	:prefix "SPC p"
	:states '(normal visual)
	:keymaps 'override
	)

(defun org-project-todos ()
		"Show only TODO entries from the current project."
		(interactive)
		(require 'org)
		(let ((org-agenda-files
		       (directory-files-recursively
			(project-root (project-current t))
			"\\.org$")))
			(org-todo-list)))

(project-definer
	"" '(:ignore t :which-key "project")
	"s" '("switch project" . project-switch-project)
	"t" '("project todos" . org-project-todos)
	"f" '("find file in project" . project-find-file)
 )




(general-create-definer window-definer
		:prefix "SPC w"
		:states '(normal visual motion)
		:keymaps 'override
		)

(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
(custom-set-faces
 '(aw-leading-char-face ((t (:inherit font-lock-keyword-face )))))

(winner-mode 1)
(window-definer
	"" '(:ignore t :which-key "window")
	"a" '("ace" . ace-window)
	"u" '("Undo Window Change" . winner-undo)
	"r" '("Redo Window Change" . winner-redo)
	"h" '("move left" . windmove-left)
	"l" '("move left" . windmove-right)
	"k" '("move left" . windmove-up)
	"j" '("move left" . windmove-down)
	"s" '("split horizontally" . split-window-below)
	"v" '("split vertically" . split-window-right)
	"d" '("delete window" . delete-window)
	"m" '("delete other windows" . delete-other-windows)
	"=" '("balance windows" . balance-windows)
)


(general-create-definer help-definer
		:prefix "SPC h"
		:states '(normal visual)
		:keymaps 'override
)
(help-definer
		"" '(:ignore t :which-key "help")
		"f" '("Describe Function" . describe-function)
		"v" '("Describe Variable" . describe-variable)
		"k" '("Describe Keybinding" . describe-key)
		"F" '("Describe Face" . describe-face)
		"m" '("Describe Mode" . describe-mode)
		)

(general-create-definer buffer-definer
  :prefix "SPC b"
  :states '(normal visual)
  :keymaps 'override
  )

(buffer-definer
 "" '(:ignore t :which-key "buffer")
 "s" '("Switch Buffer" . switch-to-buffer)
 "p" '("Previous Buffer" . previous-buffer )
 "n" '("Next Buffer" . next-buffer )
 "k" '("Kill Buffer" . kill-buffer )
 "d" '("Kill Buffer and Window" . kill-buffer-and-window)
 )
  

(provide '+keymap)

