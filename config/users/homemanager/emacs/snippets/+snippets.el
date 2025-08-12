(use-package yasnippet
  :config
  (yas-global-mode 1)
  (setq yas-snippet-dirs (list (expand-file-name "snippets" emacs-config)))
  :general
  (leader-definer
    "fcs" '("New Snippet" . yas-new-snippet))
  )


(provide '+snippets)
