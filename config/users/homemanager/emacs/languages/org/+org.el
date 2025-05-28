
(use-package org-modern
  :hook
  (org-mode . org-modern-mode)
  (org-agenda-finalize . org-modern-agenda)
  )

(use-package evil-org
  :hook ((org-mode . evil-org-mode)
	 (org-agenda-mode . evil-org-agenda-set-keys))
  :config
  (require 'evil-org-agenda)
  (general-auto-unbind-keys)
  :general-config
  (general-define-key :keymaps 'org-mode-map
		      :states '(insert normal)
		      "C-RET" '("org insert item" . org-insert-item))
  )

(use-package org
  :defer t
  :config
  (defun +org/update-agenda-files ()
    """Update the list of files in the org agenda."""
    (interactive)
    (setq org-agenda-files
	    (seq-remove
	    (lambda (file) (string-match-p "/old-classes/" file))
	    (directory-files-recursively (expand-file-name "~/planner/") "\\.org$")))
    )
  (+org/update-agenda-files)
  (setq org-confirm-babel-evaluate nil)
  (setq org-src-preserve-indentation t)
  (add-to-list 'org-babel-default-header-args '(:exports . "both"))
  (setq org-babel-default-header-args
	'((:session . "none")
	  (:results . "replace")
	  (:exports . "both")
	  (:cache . "no")
	  (:noweb . "no")
	  (:hlines . "no")
	  (:tangle . "no")))
  (setq org-log-done 'time)
  :general
  (general-define-key :keymaps 'org-mode-map
		      :states '(insert normal)
		      "C-<return>" '("org insert item" . org-insert-item))
  (local-leader-definer
    :keymaps 'org-mode-map
    "d" '("Timestamp" . org-timestamp)
    "t" '("Insert Structure Template" . org-insert-structure-template)
    "s" '("Run Code Block" . org-babel-execute-src-block)
    "T" '("Tangle" . org-babel-tangle)
    "a" '("Run All Code Blocks" . org-babel-execute-buffer)
    "i" '("Insert Item" . org-insert-item)
    ))



(provide '+org)
