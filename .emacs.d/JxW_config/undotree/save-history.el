(setq undo-tree-auto-save-history t
         undo-tree-history-directory-alist
         `(("." . ,"~/.undodir/")))
   (unless (file-exists-p "~/.undodir/")
(make-directory "~/.undodir/"))
