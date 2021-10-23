
(defvar *dumped-init-path* nil
  "Not nil when dumped-init.")
(defvar *do-dump* nil
  "Not nil when do-dump.")

;; 拒绝 dump-init
(unless *dumped-init-path*
  ;; normal-init
  ;; but do-dump
  
  (require 'init-pkg)               ; packages manage tool (use leaf)
  (require 'init-const)             ; control and info
  (require 'init-bas)               ; basic setting
  (require 'init-os)                ; OS adapt
  (require 'init-ns)                ; build my noting sys
  (require 'init-dev)               ; dev support
  
  )

;; 拒绝 normal-init
(when *dumped-init-path*
  ;; dumped-init
  (setq load-path *dumped-init-path*)
  (setq warning-minimum-level :emergency)
  (global-font-lock-mode t)
  (transient-mark-mode t))

;; load after

;; 拒绝 do-dump
(unless *do-dump*
  ;; init remaining
  ;; but don't do-dump
  
  (require 'init-ui)                 ; pretty face and smart interactive
  
  )
