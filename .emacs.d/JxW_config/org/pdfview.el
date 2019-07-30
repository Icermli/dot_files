(eval-after-load 'org '(require 'org-pdfview))
(delete '("\\.pdf\\'" . default) org-file-apps)
(add-to-list 'org-file-apps '("\\.pdf\\'" . (lambda (file link) (org-pdfview-open link))))
(add-to-list 'org-file-apps '("\\.pdf::\\([[:digit:]]+\\)\\'" . (lambda (file link) (org-pdfview-open link))))

;; Set a higher dpi
(require 'doc-view)
(setq doc-view-resolution 400)
