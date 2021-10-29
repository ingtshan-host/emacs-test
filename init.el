;;; init.el -*- lexical-binding: t; no-byte-compile: t; -*-

(defvar *dumped-init-path* nil
  "Not nil when dumped-init.")
(defvar *do-dump* nil
  "Not nil when do-dump.")

;; 拒绝 do-dump but init first whatever
(unless *do-dump*
  ;; important init and can't add to dump

  ;; load rely file
  (load-file
   (expand-file-name "etc/init/sys-info.el" user-emacs-directory))
  ;; (require 'sys-info)
  
  )

;; 拒绝 dump-init but do-dump
(unless *dumped-init-path*
  ;; normal-init and add to dump
  (require 'sys-info)               ; for do-dump
  ;; load all rely files as library
  (add-to-list
   'load-path
   (expand-file-name "etc/init" user-emacs-directory))
  (add-to-list
   'load-path
   (expand-file-name "etc/module" user-emacs-directory))
  (add-to-list
   'load-path
   (expand-file-name "etc/site-lisp/notdeft" user-emacs-directory))
  (add-to-list
   'load-path
   (expand-file-name "etc/site-lisp/vundo" user-emacs-directory))
  (add-to-list
   'load-path
   (expand-file-name "etc/site-lisp/single" user-emacs-directory))
  (add-to-list
   'load-path
   (expand-file-name "var/rime/liberime" user-emacs-directory))
  ;; (add-subdirs-to-load-path
  ;;  (expand-file-name "etc/site-lisp" user-emacs-directory))

  ;; init config
  (require 'init-pkg)               ; packages manage tool (use leaf)
  (require 'all-util)               ; all pure function tool
  (require 'init-evil)                ;
  ;; etc/device/                    ; control and info (device adapt)
  ;; load device file in order
  (let ((device-file
         (expand-file-name
          (format "etc/device/device-%s.el" device-name)
          user-emacs-directory) )
        (os-file
         (expand-file-name
          (format "etc/device/os-%s.el" os-name)
          user-emacs-directory) ))
    (and (file-exists-p device-file) (load-file device-file))
    (and (file-exists-p os-file) (load-file os-file)))
  (require 'init-const)             ; control and info (default value)
  (require 'init-bas)               ; basic setting
  (require 'init-os)                ; OS adapt
  (require 'init-ns)                ; build my noting sys
  (require 'init-dev)               ; dev support

  )

;; 拒绝 normal-init
(when *dumped-init-path*
  ;; dumped-init what is above
  ;; load-path is void befor, now copy from dump
  ;; then init
  (setq load-path *dumped-init-path*)
  (setq warning-minimum-level :emergency)
  (global-font-lock-mode t)
  (transient-mark-mode t))

;; load after

;; 拒绝 do-dump but final init whatever
(unless *do-dump*
  ;; init remaining and can't add to dump

  ;; load-path is right set
  ;; so init directly

  (when *is-gui*
    ;; gui only
    (require 'init-ui)                 ; pretty face and smart interactiveac
    ))

;; (require 'server)
;; (unless (server-running-p)
;;   (server-start))

;;; init.el ends here
