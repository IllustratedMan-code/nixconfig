
(use-package org-modern
  :hook
  (org-mode . org-modern-mode)
  (org-agenda-finalize . org-modern-agenda)
  )

(defun +insert-file-name-no-ext-and-create-dir ()
  (interactive)
  (let ((filename  (file-name-sans-extension (buffer-name))))
    (insert filename)
    (mkdir filename)
  ))


(use-package org-roam-ui
  :after org-roam base16-stylix-theme
  :config
  (setq org-roam-ui-sync-theme nil) ; need to disable for custom theme to work
  (setq org-roam-ui-custom-theme
    `((bg . ,(plist-get base16-stylix-theme-colors :base00))
      (bg-alt . ,(plist-get base16-stylix-theme-colors :base01))
      (fg . ,(plist-get base16-stylix-theme-colors :base05))
      (fg-alt . ,(plist-get base16-stylix-theme-colors  :base06))
      (red . ,(plist-get base16-stylix-theme-colors  :base08))
      (cyan . ,(plist-get base16-stylix-theme-colors  :base0C))
      (blue . ,(plist-get base16-stylix-theme-colors  :base0D))
      (orange . ,(plist-get base16-stylix-theme-colors  :base09))
      (violet . ,(plist-get base16-stylix-theme-colors  :base0A))
      (magenta . ,(plist-get base16-stylix-theme-colors  :base0E))
      (base0 . ,(plist-get base16-stylix-theme-colors :base00))
      (base1 . ,(plist-get base16-stylix-theme-colors :base01))
      (base2 . ,(plist-get base16-stylix-theme-colors :base02))
      (base3 . ,(plist-get base16-stylix-theme-colors :base03))
      (base4 . ,(plist-get base16-stylix-theme-colors :base04))
      (base5 . ,(plist-get base16-stylix-theme-colors :base05))
      (base6 . ,(plist-get base16-stylix-theme-colors :base06))
      (base7 . ,(plist-get base16-stylix-theme-colors :base07))
      (base8 . ,(plist-get base16-stylix-theme-colors :base08))
      )))


(use-package org-roam
  :config
  (setq org-roam-directory (file-truename (file-name-concat (getenv "roam") "nodes")))
  (setq org-roam-dailies-directory (file-name-concat org-roam-directory "dailies"))
  (setq org-roam-db-location (file-truename (file-name-concat org-roam-directory "roamdb.db")))
  (org-roam-db-autosync-mode)
  (setq-default org-cite-global-bibliography (list (file-truename (file-name-concat org-roam-directory "../citations.json"))))
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
  (setq-default org-roam-capture-templates
		'(("d" "default" plain
		   "%?"
		   :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}")
		   :unnarrowed t)
		  ("t" "todo" plain
		   "#+filetags: TODO\n%?"
		   :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}")
		   :unnarrowed t)))
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
    "rv" '("view network" . org-roam-ui-open)
    "rz" '("Zoom in" . org-roam-ui-node-zoom)
    "rd" '("Daily Today" . org-roam-dailies-goto-today)
    "rD" '("Daily At Date" . org-roam-dailies-goto-date)
    )
  )
(use-package org-download
  :after org
  :general-config
  (local-leader-definer
    :keymaps 'org-mode-map
    "P" '("paste image" . org-download-clipboard)
    )
  )
  


(use-package evil-org
  :hook ((org-mode . evil-org-mode)
	 (org-agenda-mode . evil-org-agenda-set-keys)
	 )
  :after evil
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
	    (directory-files-recursively (expand-file-name (getenv "planner")) "\\.org$")))
    )
  (defun +org/escape-char ()
    (interactive)
    (insert-char (char-from-name "ZERO WIDTH SPACE")))

  (defun +org-hide-done ()
    (interactive)
    (org-map-entries
     '(org-toggle-tag "ARCHIVE" 'on )
     "/+DONE" 'file 'archive 'comment))
  (setq org-cycle-open-archived-trees nil)
  (setq org-startup-folded 'nofold)
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
  (setq org-agenda-custom-commands
  '(("d" "Only deadline entries in init.org sorted by time" agenda ""
     ((org-agenda-entry-types '(:deadline))
      (org-agenda-span 'year)
      (org-agenda-include-diary nil)
      (org-agenda-show-all-dates nil)))))
  (setq org-agenda-breadcrumbs-separator "/")
  (setq org-agenda-prefix-format
	'((agenda . " %i %-12:c%?-12t% s")
	  ;(todo . "%i %?(if (org-get-outline-path) \"\n\t\" \"\")")
	  (todo . "%i%-20c%?(if (org-get-outline-path) \"\n  \" \"\") %?-18:b")
	 (tags . " %i %-12:c")
	 (search . " %i %-12:c")))
 
  :general
  (general-define-key :keymaps 'org-mode-map
		      :states '(insert normal)
		      "C-<return>" '("org insert item" . org-insert-item))
  (local-leader-definer
    :keymaps 'org-mode-map
    "d" '("Timestamp" . org-timestamp)
    "s" '("Insert Structure Template" . org-insert-structure-template)
    "b" '(:ignore t :which-key "babel")
    "br" '("Run Code Block" . org-babel-execute-src-block)
    "ba" '("Run All Code Blocks" . org-babel-execute-buffer)
    "bt" '("Tangle" . org-babel-tangle)
    "ii" '("Insert Item" . org-insert-item)
    "il" '("Insert Item" . org-insert-link)
    "o" '("Open" . org-open-at-point)
    "t" '("toggle todo" . org-todo)
    "T" '("toggle checkbox" . org-toggle-checkbox)
    "n" '("add note" . org-add-note)
    "D" '("Deadline" . org-deadline)
    "p" '("Set property" . org-set-property)
    "e" '("escape character" . +org/escape-char)
    "E" '("export" . org-export-dispatch)
    "h" '(:ignore t :which-key "hide")
    "hd" '("Hide Done" . +org-hide-done)
    "TAB" '("Force cycle" . org-cycle-force-archived)
    ))


(use-package org-appear
  :hook
  (org-mode . org-appear-mode)
  :config
  (setq org-appear-autoemphasis 't)
  (setq org-appear-autolinks 't)
  (setq org-appear-autosubmarkers 't)
  (setq org-appear-autoentities 't)
  (setq org-appear-autokeywords 't)
  (setq org-appear-inside-latex 't)
  )

(with-eval-after-load 'org
  (add-hook 'org-mode-hook
	    (lambda () (add-hook 'before-save-hook
				 (lambda () (org-update-statistics-cookies 'entire-buffer)) nil 'local )))
  (add-hook 'org-mode-hook
	    'turn-on-flyspell)
  (add-hook 'org-mode-hook
	    'glyphless-display-mode)
  (add-hook 'org-mode-hook 'org-fragtog-mode)
  (add-hook 'org-mode-hook
	    (lambda () (auto-fill-mode t)))
  (setq org-cite-csl-styles-dir (expand-file-name "~/Zotero/styles/"))
  (setq org-pretty-entities 't)
  (setq org-startup-with-latex-preview 't)
  (setq org-hide-emphasis-markers 't)
  (setq org-format-latex-options (plist-put org-format-latex-options :scale 2.0))
  (setq org-cite-export-processors
	'((apa . (csl "apa.csl"))
	  (acs . (csl "american-chemical-society"))
	  (t . (csl "american-medical-association.csl"))))
	  
  )

(defun +add-babel-languages (l)
    (with-eval-after-load 'org
	    (org-babel-do-load-languages
	    'org-babel-load-languages
	    (append org-babel-load-languages l))))

(use-package org-pomodoro
  :commands (org-pomodoro)
  :config
  (setq
   org-pomodoro-length 25
   org-pomodoro-short-break-length 5
   org-pomodoro-finished-sound (f-join emacs-config "languages" "org" "pomodoro-ding.wav")
   org-pomodoro-short-break-sound (f-join emacs-config "languages" "org" "pomodoro-ding.wav")
   org-pomodoro-long-break-sound (f-join emacs-config "languages" "org" "pomodoro-ding.wav")

   )
  :general
  (local-leader-definer
    :keymaps 'org-mode-map
    "P" '("pomodoro" . org-pomodoro)
    )
  
  )

(defun +org-pomodoro-time ()
  "Return the remaining pomodoro time"
  (interactive)
  (if (fboundp 'org-pomodoro-active-p)
  (if (org-pomodoro-active-p)
      (cl-case org-pomodoro-state
        (:pomodoro
           (format " %d minutes - %s" (/ (org-pomodoro-remaining-seconds) 60) org-clock-heading))
        (:short-break
         (format " %d minutes" (/ (org-pomodoro-remaining-seconds) 60)))
        (:long-break
         (format " %d minutes" (/ (org-pomodoro-remaining-seconds) 60)))
        (:overtime
         (format " %d minutes" (/ (org-pomodoro-remaining-seconds) 60))))
    "") ""))




(provide '+org)
