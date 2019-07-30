;; Setup babel languages

;; dot / Graphviz
(org-babel-do-load-languages
 (quote org-babel-load-languages)
 (quote ((emacs-lisp . t)
	(dot . t)
	(R . t)
	(C . t)
	(python . t)
	(ruby . t)
	(gnuplot . t)
	(sh . t)
	(org . t)
	(latex . t))))
