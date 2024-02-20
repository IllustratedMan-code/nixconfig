(TeX-add-style-hook
 "assignments"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("article" "12pt")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("geometry" "letterpaper" "margin=1in") ("tcolorbox" "most")))
   (add-to-list 'LaTeX-verbatim-environments-local "minted")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "href")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art12"
    "siunitx"
    "gensymb"
    "setspace"
    "pdfpages"
    "geometry"
    "tcolorbox"
    "etoolbox"
    "environ"
    "minted"
    "adjustbox"
    "hyperref"
    "fontspec"
    "fancyhdr"
    "float")
   (TeX-add-symbols
    "thanks"
    "maketitle"
    "title"
    "author"
    "date"
    "and"
    "footnote")
   (LaTeX-add-environments
    '("tabular" 1)
    "tabularold")
   (LaTeX-add-pagestyles
    "firstpage"))
 :latex)

