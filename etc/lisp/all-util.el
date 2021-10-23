;;; all-util.el -*- lexical-binding: t -*-

;; all pure util function here

;;;;-----------------------------README-----------------------------
;;  /pkg package

(defun pkg/replace-string (what with in)
  "basic string replace"
  (replace-regexp-in-string (regexp-quote what) with in nil 'literal))

(defun pkg/break-line-string (symbol)
  "break line with sign : and ("
  (pkg/replace-string ;; no single (
   "\n(\n" "("
   (pkg/replace-string ;; break at :
    ":" "\n:"
    (pkg/replace-string ;; break at (
     "(" "\n(" (format "%s" symbol)))))

(defmacro pkg/convert (&rest args)
  "leaf-convert then inserat after"
  `(insert (pkg/break-line-string (leaf-convert ,@args))))

;;;;-----------------------------README-----------------------------
;; /os, multi-os config tool

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

;;;;-----------------------------README-----------------------------
;;  /dum, dumper

(defun dmp/do-dump ()
  "Dump Emacs."
  (interactive)
  (let ((buf "*dump process*"))
	(make-process
	 :name "dump"
	 :buffer buf
	 :command
	 (list "emacs" "--batch" "-q" "-l"
		   (expand-file-name "etc/lisp/do-dump.el" user-emacs-directory )))
	(display-buffer buf)))

;;;;-----------------------------README-----------------------------
;; /wf, workflow

;; wf of generate template el file
(defun wf/create-new-config (file-path)
  "create file from template"
  (with-temp-buffer
    (insert (format ";;; %s -*- lexical-binding: t -*-\n\n"
		            (file-name-nondirectory file-path)))
    (insert ";;;;==============================note==============================\n")
    (insert ";;  \n")
    (insert ";;;;================================================================\n\n")
    (insert
     (format ";;------------------------------------------------------------------\n;;; %s ends\n(provide '%s)"
	         (file-name-nondirectory file-path)
	         (file-name-base file-path)))
    (write-file file-path)))

(defun wf/new-config-file(prompt nameseed)
  "workflow of crating new config-file.el"
  
  (let* ((input (read-string prompt))
	     (file-path
	      (expand-file-name
	       (format nameseed input) user-emacs-directory)))
    
    (if (file-exists-p file-path)
	    (error (format "file %s exits" file-path)))
    
    (insert (format "(require '%s)                ;"
		            (file-name-base file-path)))
    
    (wf/create-new-config file-path)
    
    (switch-to-buffer (find-file-noselect file-path))
    (goto-line 4)
    (end-of-line)))

;;; interactive function 

(defun wf/new-init()
  "workflow of crating new init-lisp.el"
  (interactive)
  (wf/new-config-file "new init-config: init-" "etc/lisp/init-%s.el"))

;; wf of new plug-in
(defun wf/new-plug-in()
  "workflow of crating new use-plugin.el"
  (interactive)
  (wf/new-config-file "new plug-in: use-" "etc/plug-in/use-%s.el"))

;; wf of new plug-in
(defun wf/new-module()
  "workflow of crating new load-module.el"
  (interactive)
  (wf/new-config-file "new module: load-" "etc/module/load-%s.el"))

;;------------------------------------------------------------------
;;; all-util.el ends
(provide 'all-util)
