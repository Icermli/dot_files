;; recentf mode has been part of GNU Emacs since version 21.
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; By default, Recentf saves the list of recent files on exiting Emacs
(run-at-time nil (* 5 60) 'recentf-save-list)

