
(use-package plantuml-mode
  :mode ("\\.puml\\'" . plantuml-mode)
  :config
  (setq plantuml-default-exec-mode 'executable)
  )

(use-package mermaid-mode
  :mode ("\\.puml\\'" . mermaid-mode)
  :config
  )
(with-eval-after-load 'org
  (add-to-list 'org-src-lang-modes '("mermaid" . mermaid)))

(use-package ob-mermaid
  :after org
  :config
  (with-eval-after-load '+org
    (+add-babel-languages '((mermaid . t))))

  )


(with-eval-after-load '+org
  (+add-babel-languages '((plantuml . t))))

(with-eval-after-load 'org
  (setq org-plantuml-exec-mode 'plantuml))
  ;; (add-to-list 'org-src-lang-modes '("plantuml" . plantuml)))

(provide '+plantuml)
