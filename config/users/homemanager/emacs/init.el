(eval-when-compile (require 'use-package))
(eval-when-compile (require 'general))

(eval-when-compile
	(defmacro eglot-add (mode &rest servers)
		"Add a language server to eglot (eglot-add foo (\"server\" \"commands\")"
		(let ((mode-name (intern (concat (symbol-name mode) "-mode")))
					(mode-ts-name (intern (concat (symbol-name mode) "-ts-mode"))))
		`(with-eval-after-load 'eglot
			 (add-to-list 'eglot-server-programs
										`(,',mode-name . ,(eglot-alternatives ',servers))
										`(,',mode-ts-name . ,(eglot-alternatives ',servers))
										))
		)))

(general-create-definer local-leader-definer
		:prefix "SPC m"
		:states '(normal visual)
)

(general-create-definer leader-definer
		:prefix "SPC"
		:states '(normal visual motion)
		:keymaps '(override)
)

(add-to-list 'load-path "/home/david/.config/emacs/")

(make-directory "~/.emacs.d/autosaves" t)
(make-directory "~/.emacs.d/backups" t)
(setq auto-save-file-name-transforms
			`((".*" "~/.emacs.d/autosaves/" t)))
(setq backup-directory-alist `(("." . "~/.emacs.d/backups")))
(setq backup-by-copying t)


(use-package niximports)

(use-package ivy
  :init
  (ivy-mode 1)
  (setq ivy-use-selectable-prompt t)
  )
(use-package counsel
	:after ivy
	:init (counsel-mode 1))

(use-package company
	:config
	(add-hook 'after-init-hook 'global-company-mode)
 )

(use-package git-gutter
  :init (global-git-gutter-mode +1))

(use-package treemacs
  :commands (treemacs)
  :general
  (leader-definer
    "t" '( "filetree" . treemacs)))

(use-package treemacs-evil
  :after treemacs
  )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files
   '("/home/david/planner/non-classes/lisp/grammars.org"
     "/home/david/planner/non-classes/lisp/lisp.org"
     "/home/david/planner/old-classes/AI/Quiz1/quiz1-review.org"
     "/home/david/planner/old-classes/AI/midterm/hist.org"
     "/home/david/planner/old-classes/AI/midterm/midterm_review.org"
     "/home/david/planner/old-classes/AI/notes.org"
     "/home/david/planner/old-classes/AI/search.org"
     "/home/david/planner/old-classes/Automata/Week2/notes.org"
     "/home/david/planner/old-classes/Automata/Week3/notes.org"
     "/home/david/planner/old-classes/Automata/Week4/notes.org"
     "/home/david/planner/old-classes/Automata/ndimgrammar/grammar.org"
     "/home/david/planner/old-classes/Automata/week1/preliminary_math_concepts.org"
     "/home/david/planner/old-classes/Automata/README.org"
     "/home/david/planner/old-classes/Discrete-Structures/Discrete-Structures.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/Assignments/lec10/lec10.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/Assignments/lec12/lec12.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/Assignments/lec13/lec13.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/Assignments/lec14/lec14.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/Assignments/lec15/lec15.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/Assignments/lec16/lec16.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/Assignments/lec17/lec17.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/Assignments/lec19/lec19.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/Assignments/lec2/lec2.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/Assignments/lec20/lec20.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/Assignments/lec21/lec21.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/Assignments/lec22/lec22.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/Assignments/lec23/lec23.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/Assignments/lec24/lec24.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/Assignments/lec25/lec25.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/Assignments/lec26/lec26.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/Assignments/lec3/lec3.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/Assignments/lec4.org/lec4.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/Assignments/lec5/le5.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/Assignments/lec6/lec6.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/Assignments/lec7/lec7.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/Assignments/lec9/lec9.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/Assignments/lec12.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/cards/cards.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/cards/exam2.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/lec8/lec8.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/quiz-review/Quiz1.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/quiz-review/Quiz10.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/quiz-review/Quiz13.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/quiz-review/Quiz14.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/quiz-review/Quiz15.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/quiz-review/Quiz16.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/quiz-review/Quiz2.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/quiz-review/Quiz3.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/quiz-review/Quiz4.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/quiz-review/Quiz5.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/quiz-review/Quiz6.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/quiz-review/Quiz7.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/quiz-review/all_quizzes.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/quiz-review/exam1.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/quiz-review/exam2.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/quiz-review/lec12.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/Lec2.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/chapter1.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/chapter2.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/chapter20.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/chapter3.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/chapter4.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/chapter7.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/chapter8.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/conversation_about_svms.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/important_notes.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/lec1.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/lec10.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/lec12.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/lec13.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/lec14.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/lec15.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/lec16.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/lec17.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/lec20.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/lec21.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/lec23.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/lec3.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/lec4.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/lec5.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/lec6.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/lec7.org"
     "/home/david/planner/old-classes/Intelligent_Data_Design/lec9.org"
     "/home/david/planner/old-classes/Networking/hw1/hw.org"
     "/home/david/planner/old-classes/Networking/lab0/README.org"
     "/home/david/planner/old-classes/Networking/lab1/lab1.org"
     "/home/david/planner/old-classes/Networking/lab4/hw.org"
     "/home/david/planner/old-classes/Networking/lab4/lab4.org"
     "/home/david/planner/old-classes/Networking/exam.org"
     "/home/david/planner/old-classes/Networking/hw.org"
     "/home/david/planner/old-classes/Networking/notes.org"
     "/home/david/planner/old-classes/Operating_Systems/hw1/hw1.org"
     "/home/david/planner/old-classes/Operating_Systems/notes.org"
     "/home/david/planner/old-classes/OrganicChemistry/class1.org"
     "/home/david/planner/old-classes/ParallelComputing/answers.org"
     "/home/david/planner/old-classes/ParallelComputing/ch1.org"
     "/home/david/planner/old-classes/ParallelComputing/exam_review.org"
     "/home/david/planner/old-classes/ParallelComputing/mock_exam.org"
     "/home/david/planner/old-classes/Physics2001/PHYS2001.org"
     "/home/david/planner/old-classes/bioinformatics/notes.org"
     "/home/david/planner/old-classes/bioinformatics/python_cheat_sheet.org"
     "/home/david/planner/old-classes/comp-systems/compPosts.org"
     "/home/david/planner/old-classes/comp-systems/hardvmicro.org"
     "/home/david/planner/old-classes/ecology/ecology.org"
     "/home/david/planner/old-classes/intro-to-bioinformatics/read-to-genome.org"
     "/home/david/planner/old-classes/programming-languages/programming-languages.org"
     "/home/david/planner/weirauchlab/HPV/README.org"
     "/home/david/planner/weirauchlab/PU1/PU1-meeting-1.org"
     "/home/david/planner/weirauchlab/PU1/README.org"
     "/home/david/planner/weirauchlab/TF-meetings/TF-meeting-1.org"
     "/home/david/planner/weirauchlab/comp-meetings/comp-meeting-1.org"
     "/home/david/planner/weirauchlab/pipeline-meetings/pipeline-meetings-1.org"
     "/home/david/planner/weirauchlab/wet-lab-meetings/wet-lab-meeting-1.org"
     "/home/david/planner/agenda.org")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-char-face ((t (:inherit font-lock-keyword-face))))
 '(markdown-code-face ((t (:background "#374247" :extend t)))))
