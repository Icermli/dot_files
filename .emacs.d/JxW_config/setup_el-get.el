
;; setup_el-get.el by JxW created on Jan 28 2016
;; This file check and installs el-get from melpa, using its online installer
;; programmer interface.

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(require 'el-get-elpa)
;; Build the El-Get copy of the package.el packages if we have not
;; built it before.  Will have to look into updating later MANUALLY
(unless (file-directory-p el-get-recipe-path-elpa)
  (el-get-elpa-build-local-recipes))

(setq my:el-get-packages
      '(org-mode
	org-bullets
	yasnippet
	dash
        s
	ob-ipython
	org-reveal
        pdf-tools
        org-pdfview
	yaml-mode
        dracula-theme
        mode-icons
        restart-emacs
	undo-tree
        ))

(el-get 'sync my:el-get-packages)

;; If you install themes via elpa / package.el you'll need to add each theme folder 
;; into your custom-theme-load-path manually.
;; This is a scrip to do this automatically.
(require 'dash)
(require 's)
(-each
   (-map
      (lambda (item)
      (format "~/.emacs.d/elpa/%s" item))
   (-filter
      (lambda (item) (s-contains? "theme" item))
      (directory-files "~/.emacs.d/elpa/")))
   (lambda (item)
      (add-to-list 'custom-theme-load-path item)))
