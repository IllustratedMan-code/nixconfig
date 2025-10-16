(with-eval-after-load '+org
  (+add-babel-languages '((gnuplot . t))))

(with-eval-after-load 'ob-gnuplot
  (add-to-list '*org-babel-gnuplot-terms*
	  '(png . "pngcairo")))



(provide '+gnuplot)
