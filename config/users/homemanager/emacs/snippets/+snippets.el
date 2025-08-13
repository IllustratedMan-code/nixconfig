(use-package yasnippet
  :config
  (setq yas-snippet-dirs (list (expand-file-name "snippets" emacs-config)))
  (yas-global-mode 1)
  :demand t
  :general
  (leader-definer
    "fcs" '("New Snippet" . yas-new-snippet))
  )


(provide '+snippets)
