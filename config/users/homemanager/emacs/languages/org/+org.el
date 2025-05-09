
(use-package org-modern
	:hook
	(org-mode . org-modern-mode)
	(org-agenda-finalize . org-modern-agenda)
	)


(use-package org
	:defer t
	:config
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
	:general
	(local-leader-definer
		:keymaps 'org-mode-map
		"t" '("Insert Structure Template" . org-insert-structure-template)
		"s" '("Run Code Block" . org-babel-execute-src-block)
		"T" '("Tangle" . org-babel-tangle)
		"a" '("Run All Code Blocks" . org-babel-execute-buffer)
		"i" '("Insert Item" . org-insert-item)
		))


(provide '+org)
