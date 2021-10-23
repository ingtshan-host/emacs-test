;;; do-dump.el
(require 'cl-lib)

(setq *do-dump* t)

(load (expand-file-name "early-init.el" user-emacs-directory))
(load (expand-file-name "init.el" user-emacs-directory))

(message "load file done")

;;(setq dump-exclude-packages '(ivy))
(setq dump-exclude-packages nil)

(dolist (package package-activated-list)
  (unless (member package dump-exclude-packages)
	(require package)))

(setq *do-dump* nil)
(setq *dumped-init-path* load-path)

(message "clean setup done")

(dump-emacs-portable
 (expand-file-name "var/dumper/Emacs-init.pdmp" user-emacs-directory))

(message "%s" *dumped-init-path*)

;;------------------------------------------------------------------
;;; do-dump.el ends
;; (provide 'do-dump)
