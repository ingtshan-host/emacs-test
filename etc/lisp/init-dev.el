;;; init-dev.el -*- lexical-binding: t -*-

;;;;==============================note==============================
;;
;;;;================================================================
(leaf projectile
  :init
  (projectile-mode +1)
  :bind
  (:projectile-mode-map ("C-x p" . projectile-command-map)
                        ("C-x p ." . projectile-ripgrep))
  :custom
  (projectile-indexing-method          . 'hybrid)
  (projectile-require-project-root     . 'prompt)
  (projectile-project-root-files-top-down-recurring
   .
   (append '("compile_commands.json" ".cquery")
	   projectile-project-root-files-top-down-recurring)))
;;------------------------------------------------------------------
;;; init-dev.el ends
(provide 'init-dev)
