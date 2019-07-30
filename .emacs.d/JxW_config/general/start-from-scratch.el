;; Hide the welcome screen at start and
;; show scratch instead. Also provides a way
;; to create a scratch as often as you like

(defun my/new-scratch ()
    ; Returns the existing *scratch* buffer or creates a new one
    (interactive)
    (switch-to-buffer (get-buffer-create "*scratch*")))

;; replaces set-goal-column on C-x C-n
(global-set-key (kbd "C-x C-n") 'my/new-scratch)

(setq inhibit-splash-screen t)
(my/new-scratch)
