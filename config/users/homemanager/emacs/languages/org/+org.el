
(use-package org-modern
  :hook
  (org-mode . org-modern-mode)
  (org-agenda-finalize . org-modern-agenda)
  )

(use-package org-roam
  :config
  (setq org-roam-directory (file-truename "~/Documents/roam-wiki"))
  (setq org-roam-db-location (file-truename "~/Documents/roam-wiki/roamdb.db"))
  (org-roam-db-autosync-mode)
  (defun +org-roam-select-node-by-tag (&optional tag)
    "Prompt for a TAG (or use TAG if supplied), then select an Org-roam node with that tag."
    (interactive)
    (let* ((tag (or tag
		    (completing-read
		    "Tag: "
		    (mapcar #'car
			    (org-roam-db-query
				[:select :distinct tag :from tags]))
		    nil t)))
	    (rows (org-roam-db-query
		    [:select [title file id]
		    :from nodes
		    :inner-join tags
		    :on (= tags:node-id nodes:id)]
		    tag))
	    (candidates
	    (mapcar (lambda (row)
			(cons (format "%s (%s)"
				    (nth 0 row)
				    (file-name-nondirectory (nth 1 row)))
			    (nth 2 row)))
		    rows))
	    (selected (completing-read
			(format "Nodes tagged %s: " tag)
			candidates nil t)))
	(org-roam-node-visit
	(org-roam-node-from-id (cdr (assoc selected candidates))))))
  :general-config
  (leader-definer
    :states '(normal visual)
    :keymaps 'override
    "r" '(:ignore t :which-key "Roam" )
    "rf" '("find node" . org-roam-node-find)
    "ri" '("insert node at point" . org-roam-node-insert)
    "rc" '("capture node" . org-roam-capture)
    "r/" '("capture node" . (lambda () (interactive)
			      (let ((default-directory org-roam-directory))
				(counsel-rg)
				)))
    "rt" '("Search Nodes by Tag" . +org-roam-select-node-by-tag)
    "rT" '("Search Incomplete Nodes" . (lambda () (interactive) (+org-roam-select-node-by-tag "TODO")))
    )
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
    "o" '("Open" . org-open-at-point)
    ))



(provide '+org)
