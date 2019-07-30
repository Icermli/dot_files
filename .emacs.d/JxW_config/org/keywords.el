;; Define TODO keywords and how they look
(setq org-todo-keywords
      '((sequence "TODO"
		  "NEXT"
		  "PROJECT"
		  "WAITING"
		  "SOMEDAY"
		  "|"
		  "DONE"
		  "CANCELED")))

(setq org-todo-keyword-faces
      '(("PROJECT" :background "blue" :foreground "white" :weight bold :box (:line-width 2 :style released-button))))

;; For anything undefined word-wise, use the following:
(set-face-attribute 'org-todo nil
		    :background "orange"
		    :foreground "black"
		    :weight 'bold
		    :box '(:line-width 2 :style released-button))
(set-face-attribute 'org-done nil
		    :background "lime green"
		    :foreground "black"
		    :weight 'bold
		    :box '(:line-width 2 :style released-button))
(set-face-attribute 'org-priority nil
		    :inherit font-lock-keyword-face
		    :box '(:line-width 2 :style released-button))
