;; This buffer is for text that is not saved, and for Lisp evaluation.
;; To create a file, visit it with ‘SPC f f’ and enter text in its buffer.


(defun cite-open (datum y)
  (setq cite-open-debug-x datum)
  (setq cite-open-debug-y y)
  (let* ((key
          (if (org-element-type-p datum 'citation-reference)
              (org-element-property :key datum)
            (pcase (org-cite-get-references datum t)
              (`(,key) key)
              (keys
               (or (completing-read "Select citation key: " keys nil t)
                   (user-error "Aborted"))))))
         (file
          (pcase (seq-find (pcase-lambda (`(,_ . ,entries))
                             (gethash key entries))
                           (org-cite-basic--parse-bibliography))
            (`(,_ . ,f) f)
            (_  (user-error "Cannot find citation key: %S" key)))))
    (setq cite-open-debug (gethash key file)))

  )

(org-cite-register-processor 'opener :follow #'cite-open)

(setq org-cite-follow-processor 'opener)


(defun org-cite-basic-goto (datum _)
  "Follow citation or citation reference DATUM.
When DATUM is a citation reference, open bibliography entry referencing
the citation key.  Otherwise, select which key to follow among all keys
present in the citation."
  (let* ((key
          (if (org-element-type-p datum 'citation-reference)
              (org-element-property :key datum)
            (pcase (org-cite-get-references datum t)
              (`(,key) key)
              (keys
               (or (completing-read "Select citation key: " keys nil t)
                   (user-error "Aborted"))))))
         (file
          (pcase (seq-find (pcase-lambda (`(,_ . ,entries))
                             (gethash key entries))
                           (org-cite-basic--parse-bibliography))
            (`(,f . ,_) f)
            (_  (user-error "Cannot find citation key: %S" key)))))
    (org-open-file file '(4))
    (pcase (file-name-extension file)
      ("json"
       ;; `rx' can not be used with Emacs <27.1 since `literal' form
       ;; is not supported.
       (let ((regexp (rx-to-string `(seq "\"id\":" (0+ (any "[ \t]")) "\"" ,key "\"") t)))
         (goto-char (point-min))
         (re-search-forward regexp)
         (search-backward "{")))
      (_
       (bibtex-set-dialect)
       (bibtex-search-entry key)))))
