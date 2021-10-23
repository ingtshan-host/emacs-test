;;; sys-info.el

;;;;-----------------------------README-----------------------------
;; #support muitl os config tool
;; e.g same variable but different value base on sytem-type
(defconst *is-mac* (string-equal system-type "darwin"))
(defconst *is-linux* (string-equal system-type "gnu/linux"))
(defconst *is-win* (string-equal system-type "windows-nt"))

;; /os, multi-os config tool
;; (require 'dash)
(require 'cl-macs)

;; 值 1 对 1
(cl-defmacro get-value/os (&key macos linux windows default)
  "Value depended on `system-type',
  each clause using a keyword, `:windows', `:macos', or `:linux',
  and an optional `:default' clause."
  `(cond (*is-mac* ,macos)
	     (*is-linux* ,linux)
	     (*is-win* ,windows)
	     (t ,default)))
(cl-defmacro defconst/os (id &key macos linux windows default)
  "Define constant based on `system-type'"
  `(defconst ,id
     (cond (*is-mac* ,macos)
	       (*is-linux* ,linux)
	       (*is-win* ,windows)
	       (t ,default))))

(cl-defmacro defvar/os (id &key macos linux windows default)
  "Define variable based on `system-type'"
  `(defvar ,id
     (cond (*is-mac* ,macos)
	       (*is-linux* ,linux)
	       (*is-win* ,windows)
	       (t ,default))))

(cl-defmacro let/os
    (varlist &key co-start macos linux windows default co-final)
  "Execute by order of co-start then oneos(based on `system-type') then co-final"
  `(let (,@varlist) ,@co-start
	    (cond (*is-mac* ,@macos)
	          (*is-linux* ,@linux)
	          (*is-win* ,@windows)
	          (t ,@default))
	    ,@co-final))

(cl-defmacro let*/os
    (varlist &key co-start macos linux windows default co-final)
  "Execute by order of co-start then oneos(based on `system-type') then co-final"
  `(let* (,@varlist) ,@co-start
	     (cond (*is-mac* ,@macos)
	           (*is-linux* ,@linux)
	           (*is-win* ,@windows)
	           (t ,@default))
	     ,@co-final))

(cl-defmacro progn/os
    (&key macos linux windows default)
  "Execute based on `system-type'"
  `(progn
     (cond (*is-mac* ,@macos)
	       (*is-linux* ,@linux)
	       (*is-win* ,@windows)
	       (t ,@default))))
;;;;-----------------------------README-----------------------------
;; emacs process type
(defconst *is-app* (and (display-graphic-p) (not (daemonp))))
(defconst *is-server-m* (string-equal "main" (daemonp)))
(defconst *is-server-c* (string-equal "coding" (daemonp)))
(defconst *is-server-t* (string-equal "tty" (daemonp)))
(defconst *is-gui*  (or *is-app* *is-server-m* *is-server-c*))
(defconst *is-cli* (or (not *is-gui*) *is-server-t*))
;;------------------------------------------------------------------
;;; sys-info.el ends
(provide 'sys-info)
