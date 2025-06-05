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
		:states '(normal visual motion)
		:keymaps '(override)
)

(add-to-list 'load-path "/home/david/.config/emacs/")

(make-directory "~/.emacs.d/autosaves" t)
(make-directory "~/.emacs.d/backups" t)
(setq auto-save-file-name-transforms
			`((".*" "~/.emacs.d/autosaves/" t)))
(setq backup-directory-alist `(("." . "~/.emacs.d/backups")))
(setq backup-by-copying t)

(setq custom-file (locate-user-emacs-file "custom.el"))

;; Unicode hack to allow plover to input things into it
;; For some reason, plover just inputs a C-S-u and a unicode hex rather than
;; actually inserting the relevant character
(defun +insert-unicode-hex (hex)
  "Insert a Unicode character by hexadecimal code, padding to 4+ digits if needed."
  (interactive "sUnicode hex (e.g. 22): ")
  (let* ((padded (format "%04x" (string-to-number hex 16)))
         (char (decode-char 'ucs (string-to-number padded 16))))
    (if char
        (insert-char char)
      (message "Invalid Unicode codepoint: %s" hex))))

(global-set-key (kbd "C-S-u") '+insert-unicode-hex)


(use-package niximports)

(use-package ivy
  :init
  (ivy-mode 1)
  (setq ivy-use-selectable-prompt t)
  )
(use-package counsel
	:after ivy
	:init (counsel-mode 1))

(use-package company
	:config
	(add-hook 'after-init-hook 'global-company-mode)
 )

(use-package git-gutter
  :init (global-git-gutter-mode +1))

(use-package treemacs
  :commands (treemacs)
  :general
  (leader-definer
    "t" '( "filetree" . treemacs)))

(use-package treemacs-evil
  :after treemacs
  )

