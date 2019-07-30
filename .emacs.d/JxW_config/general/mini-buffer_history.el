;; Let emacs save mini-buffer history and make it consistent
;; across sessions

(savehist-mode 1)
(setq savehist-additional-variables '(kill-ring search-ring regexp-search-ring))

(shell-command "mkdir -p ~/.emacs.d/tmp/") 
(shell-command "touch ~/.emacs.d/tmp/mini-buffer-history") 
(setq savehist-file "~/.emacs.d/tmp/mini-buffer-history")
