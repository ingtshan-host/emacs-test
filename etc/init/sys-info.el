;;; sys-info.el -*- lexical-binding: t; no-byte-compile: t; -*-

;; important sys-info
;; you should use `defconst' here

;; #support muitl os config tool
;; e.g same variable but different value base on sytem-type

(defconst *device-alist*
  '(;; name your device here
    (ingtshans-MacBook-Pro.local . 19mbp)
    ;; end
    )
  "Naming your device base on `system-name'.
You can't use any candidate of `os-name'")

;;;;-----------------------------README-----------------------------
;; multi os and device config tool

(defconst os-name
  (cond
   ;; Translate system-type to os-name
   ((eq system-type 'darwin) 'macOS)
   ((memq system-type '(ms-dos windows-nt cygwin)) 'windows)
   (t 'linux))
  "Value base on `system-type'. 
Three candidates `macOS', `windows' and `linux'.")

(defconst device-name
  ;; Translate system-name to device-name
  (cdr (assq (intern system-name) *device-alist*))
  "Value base on `system-name' and `device-alist'")

;; multi device adapte scaffold
;; abandon on <2021-10-25 Mon>

;; (defmacro os-p (os)
;;   "Return non-nil if OS corresponds to the current operating system.
;; Allowable values see `device-name'"
;;   (eq os-name os))

;; (defmacro device-p (device)
;;   "Return non-nil if OS corresponds to the current operating system.
;; Allowable values see `device-name'"
;;   (eq device-name device))

;; (defmacro read/os (alist)
;;   "Get value from alist base on `os-name' "
;;   (declare (indent 1))
;;   (eval `(cdr (assq os-name ,alist))))

;; (defmacro read/device (alist)
;;   "Get value from alist base on `os-name' "
;;   (declare (indent 1))
;;   (eval `(cdr (assq device-name ,alist))))

;; (defmacro select-default (defatult &rest cells)
;;   "Select Value base on `os-name'"
;;   (declare (indent 1))
;;   `(let ((re (read/os '(,@cells))))
;;      (if re re ,defatult)))

;; (defmacro select-specific (default &rest cells)
;;   "Select Value base on `device-name'(priority) and `os-name'"
;;   (declare (indent 1))
;;   `(let ((re (read/device '(,@cells))))
;;      (if re re (select-default ,@default ,@cells))))

;; (defmacro eval-with (id &rest body)
;;   "If id corresponds to the `os-name' or `device-name' eval and return BODY.
;; If not, return nil.
;; Allowable values for id (not quoted) see `os-name' and `device-name'(`*device-alist*')."
;;   (declare (indent 1))
;;   `(when (or (os-p ,id) (device-p ,id))
;;      ,@body))

;; new multi device adapte method
;; start on <2021-10-25 Mon>

(defmacro defunit (fun-name arg-list &rest body)
  "macro of device adpat, generate code such as

(unless (fboundp '+system-key-adapte)
  (defun +system-key-adapte()
    ;; progn here
    ;; excute one time
    (fmakunbound '+system-key-adapte)))

"
  `(unless (fboundp ',fun-name)
     (defun ,fun-name (,arg-list)
       ,@body
       ;; excute one time
       (fmakunbound ',fun-name))))

(defmacro funitcall (fun-name &rest argument)
  "macro of device adpat, generate code such as

(and (fboundp '+system-key-adapte) (+system-key-adapte))"
  `(and (fboundp ',fun-name) (,fun-name ,argument)))
;;;;-----------------------------README-----------------------------
;; emacs process typeq
(defconst *is-app* (and (display-graphic-p) (not (daemonp))))
(defconst *is-server-m* (string-equal "main" (daemonp)))
(defconst *is-server-c* (string-equal "coding" (daemonp)))
(defconst *is-server-t* (string-equal "tty" (daemonp)))
(defconst *is-gui*  (or *is-app* *is-server-m* *is-server-c*))
(defconst *is-cli* (or (not *is-gui*) *is-server-t*))
;; versions
(defconst *emacs/>=26p* (>= emacs-major-version 26) "Emacs is 26 or above.")
(defconst *emacs/>=27p* (>= emacs-major-version 27) "Emacs is 27 or above.")
;;;;-----------------------------README-----------------------------
;;  env

;;------------------------------------------------------------------
;;; sys-info.el ends
(provide 'sys-info)
