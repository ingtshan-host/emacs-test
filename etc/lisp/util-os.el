;;; util-os.el -*- lexical-binding: t -*-

;;;;==============================note==============================
;;  C-H f 了解这些的作用
;; , 和 ,@ 
;; plist-member
;; cadr
;; pcase cond
;; cl-defmacro
;;;;================================================================

;; (require 'dash)

;; system type
(defconst *is-mac* (string-equal system-type "darwin"))
(defconst *is-linux* (string-equal system-type "gnu/linux"))
(defconst *is-win* (string-equal system-type "windows-nt"))

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
;;------------------------------------------------------------------
;;; util-os.el ends
(provide 'util-os)
