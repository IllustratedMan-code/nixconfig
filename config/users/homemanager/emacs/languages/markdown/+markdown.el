(use-package markdown-mode
	:mode ("README\\.md\\'". gfm-mode)
	:init
		(setq markdown-command "multimarkdown")
		(setq markdown-fontify-code-blocks-natively t)
		(defvar nb/current-line '(0 . 0)
		"(start . end) of current line in current buffer")
		(make-variable-buffer-local 'nb/current-line)
		(defconst markdown-language-keyword-properties
			'(face markdown-language-keyword-face ))
		(defun nb/unhide-current-line (limit)
		  "Font-lock function"
		  (let ((start (max (point) (car nb/current-line)))
			(end (min limit (cdr nb/current-line))))
		    (when (< start end)
		      (remove-text-properties start end
					      '(invisible t display "" composition ""))
		      (goto-char limit)
		      t)))

		(defun nb/refontify-on-linemove ()
		  "Post-command-hook"
		  (let* ((start (line-beginning-position))
			 (end (line-beginning-position 2))
			 (needs-update (not (equal start (car nb/current-line)))))
		    (setq nb/current-line (cons start end))
		    (when needs-update
		      (font-lock-fontify-block 3))))

		(defun nb/unhide-fences (limit)
		  "Unhide code block fences ``` in markdown."
		  (when (re-search-forward "^\\([[:space:]]*\\(```\\)+.*\\)\\(\n\\)?" limit t)
		    (remove-text-properties (match-beginning 0) (match-end 0)
					    '(invisible t display "" composition ""))
		    t))

		(defun nb/unhide-yaml-fence-if-block (limit)
		  "Unhide YAML fences only if they enclose at least one key-value pair."
		  (when (re-search-forward "^---\n\\(.+?\\)\n---\\(\n\\|\\'\\)" limit t)
		    ;; Unhide the entire fenced block if non-empty content exists.
		    (remove-text-properties (match-beginning 0) (match-end 0)
					    '(invisible t display "" composition ""))
		    ;; Remove fontification inside YAML content
		    (let ((content-start (match-beginning 0))
			  (content-end (match-end 0)))
		      (remove-text-properties content-start content-end
					      '(face nil invisible nil display nil composition nil)))
		    t))
		
		(defun nb/markdown-unhighlight ()
		  "Enable markdown concealling"
		  (interactive)
		  (markdown-toggle-markup-hiding 'toggle)
		  (font-lock-add-keywords nil '((nb/unhide-fences)
						(nb/unhide-yaml-fence-if-block)
						(nb/unhide-current-line)) t)
		  (add-hook 'post-command-hook #'nb/refontify-on-linemove nil t))
		(require 'base16-stylix-theme)
		(custom-set-faces
		 `(markdown-code-face ((t (:background ,(plist-get base16-stylix-theme-colors :base01) :extend t)))))
		(setq markdown-header-scaling t)
		(add-hook 'markdown-mode-hook #'nb/markdown-unhighlight)
)

(use-package apheleia
	:defer t
	:hook ((markdown-mode . apheleia-mode)
	       (gfm-mode . apheleia-mode))
	:config
	(add-to-list 'apheleia-mode-alist '(gfm-mode . prettier))
	(add-to-list 'apheleia-mode-alist '(markdown-mode . prettier))
	:general
	(local-leader-definer
		;; markdown-mode won't work here
		:keymaps '(markdown-mode-map) ;; no idea why map has to be explicit here
		"f" '( "format buffer" . apheleia-format-buffer)
		)
	)

(provide '+markdown)
