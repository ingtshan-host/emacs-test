;;; init-dev.el -*- lexical-binding: t; no-byte-compile: t; -*-

;; Use ripgrep in Emacs
(leaf rg)

(leaf projectile
  :init
  (projectile-mode +1)
  :custom
  (projectile-indexing-method          . 'hybrid)
  (projectile-require-project-root     . 'prompt)
  (projectile-project-root-files-top-down-recurring
   .
   (append '("compile_commands.json" ".cquery")
	       projectile-project-root-files-top-down-recurring)))

;; for hacking noviemacs
(defun dev/find-noviemacs-config ()
  "Jump to .emacs.d to search config file"
  (interactive)
  (projectile-find-file-in-directory user-emacs-directory))

(global-set-key (kbd "C-c def") #'dev/find-noviemacs-config)
(global-set-key (kbd "C-c df") #'projectile-find-file)
(global-set-key (kbd "C-c dr") #'projectile-ripgrep)

(provide 'init-dev)
;;; init-dev.el ends here
