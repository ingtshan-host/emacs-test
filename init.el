
(defvar *dumped-init-path* nil
  "Not nil when dumped-init.")
(defvar *do-dump* nil
  "Not nil when do-dump.")

;; 拒绝 dump-init but do-dump
(unless *dumped-init-path*
  ;; normal-init and add to dump
  
  (require 'init-pkg)               ; packages manage tool (use leaf)
  (require 'init-const)             ; control and info
  (require 'init-bas)               ; basic setting
  (require 'init-os)                ; OS adapt
  (require 'init-ns)                ; build my noting sys
  (require 'init-dev)               ; dev support
  
  )

;; 拒绝 normal-init
(when *dumped-init-path*
  ;; dumped-init what is above
  (setq load-path *dumped-init-path*)
  (setq warning-minimum-level :emergency)
  (global-font-lock-mode t)
  (transient-mark-mode t))

;; load after

;; 拒绝 do-dump but init whatever
(unless *do-dump*
  ;; init remaining add not add to dump

  ;; gui/console
  ;; put here becaus in dumper can't get right info
  (defconst *is-app* (and (display-graphic-p) (not (daemonp))))
  (defconst *is-server-m* (string-equal "main" (daemonp)))
  (defconst *is-server-c* (string-equal "coding" (daemonp)))
  (defconst *is-server-t* (string-equal "tty" (daemonp)))
  (defconst *is-gui*  (or *is-app* *is-server-m* *is-server-c*))
  (defconst *is-cli* (or (not *is-gui*) *is-server-t*))
  
  (when *is-gui*
    (require 'init-ui)                 ; pretty face and smart interactive
    
    ))
