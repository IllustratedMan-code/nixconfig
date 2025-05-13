
(setq-default bmicluster_USER "lew4xi")
(setq-default bmicluster_ADDRESS "bmiclusterp.chmcres.cchmc.org")


(cl-defmacro +remote/add-connection-hook (hook fun &key (append nil) (local nil) machine user protocol)
  "Add function to hook that runs only if connection matches criteria"
  `(with-eval-after-load tramp
     (add-hook ,hook
	    (lambda ()
	       (let ((tramp-string (tramp-dissect-file-name default-directory)))
	       (when (and (tramp-tramp-file-p default-directory)
			  (or  (not ,machine)
			    (string=
			      (tramp-file-name-host
			       tramp-string)
			       ,machine))
			  (or (not ,user)
			    (string=
			      (tramp-file-name-user
			       tramp-string)
			       ,user))
			  (or (not ,protocol)
			    (string=
			      (tramp-file-name-method
			       tramp-string)
			       ,protocol)))
		 (funcall ,fun))))
	    ,append ,local))

(defun +remote/install ()
  (interactive)

  (let ((return-code
	 (call-process-shell-command
	   (format "%s %s %s"
		  (expand-file-name "remote/install" user-emacs-directory)
		  bmicluster_USER bmicluster_ADDRESS))
	  ))
    (when (not (eq return-code 0)) (message (format "%i" return-code)))
    (when (eq return-code 255)
      (message "could not connect to host, are you connected to the VPN?")))
  )


(+remote/add-connection-hook
 'ess-mode-hook
 #'(lambda ()
     (setq-local inferior-ess-r-program (format "/users/%s/.envs/R.sh" bmicluster_USER))
     (setq-local eglot-server-programs ((ess-r-mode . ((format "/users/%s/.envs/R.sh" bmicluster_USER)))))
   )
 :machine bmicluster_ADDRESS
 :user bmicluster_USER
 )

(+remote/add-connection-hook
 'python-ts-mode-hook
 #'(setq-local eglot-server-programs
	       ((python-ts-mode .
				((format "/users/%s/.envs/python.sh" bmicluster_USER))))))

;; alternate method for setting global variables in remote.   
;; (connection-local-set-profile-variables
;;  'bmicluster-ess
;;  `((inferior-ess-r-program . ,(format "/users/%s/.envs/R.sh" bmicluster_USER))
;;    (eglot-server-programs . ((ess-r-mode . (,(format "/users/%s/.envs/R.sh" bmicluster_USER) "--slave" "-e" "languageserver::run()"))))))

;; (connection-local-set-profiles
;;  `(:application tramp :user ,bmicluster_USER :machine ,bmicluster_ADDRESS)
;;  'bmicluster-ess)

(provide +remote)
