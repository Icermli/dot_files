(fset 'my-complete-file-name
        (make-hippie-expand-function '(try-complete-file-name-partially
                                       try-complete-file-name)))
 (global-set-key "\M-/" 'my-complete-file-name)
