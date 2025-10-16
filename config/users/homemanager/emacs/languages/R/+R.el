(use-package ess :defer t)

(with-eval-after-load '+org
  (+add-babel-languages '((R . t))))

(eglot-add ess-r
	   ("R" "--slave" "-e" "languageserver::run()")
	   )
(add-hook 'ess-r-mode-hook 'eglot-ensure)


(with-eval-after-load 'ess-r-mode
	(local-leader-definer
		:keymaps 'ess-r-mode-map
		"f" '("format buffer" . eglot-format-buffer)
		))
(with-eval-after-load 'tramp
  (add-to-list 'tramp-remote-path 'tramp-own-remote-path))

;; (with-eval-after-load 'tramp
;;   (connection-local-set-profile-variables
;;    'remote-path-with-bin
;;    '((tramp-remote-path . ("~/bins" tramp-default-remote-path)))))

;; (with-eval-after-load 'tramp
;;   (connection-local-set-profiles
;;    '(:application tramp :machine "bmiclusterp.chmcres.cchmc.org") 'remote-path-with-bin))

(provide '+R)
