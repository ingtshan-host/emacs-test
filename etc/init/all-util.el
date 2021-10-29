;;; all-util.el -*- lexical-binding: t; no-byte-compile: t; -*-

;; all pure util function here

;;;;-----------------------------README-----------------------------
;;  os/ os action
(defun os/quit-emacs (&optional pfx)
  "quit emacs with need-test check"
  (interactive "P")
  (save-some-buffers)
  (cond ((or nil
             (and *need-test*
                  (y-or-n-p "Seems Your init configs need test, do it?")))
         (wf/int-test-gui))
        (t (os/do-kill-9))))

(defun os/do-kill-9 (&optional pfx)
  "quit emacs with confirm"
  (when (or pfx (y-or-n-p "Quit emacs now?"))
    (save-buffers-kill-terminal)))

(defun os/close-frame (&optional pfx)
  "close emacs frame"
  (interactive "P")
  (let ((q nil))
    (condition-case ex
	    (delete-window) ('error (setq q t)))
    (if q (progn (setq q nil)
		         (condition-case ex
		             (delete-frame) ('error (setq q t)))
		         (if q (os/quit-emacs pfx))))))
(defun os/fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen
                       (if (frame-parameter nil 'fullscreen) nil 'fullboth)))
;;;;-----------------------------README-----------------------------
;;  pkg/ package
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

(defun pkg/upgrad-package-async ()
  "package upgrad"
  (interactive)
  (let ((buf "*package upgrad process*"))
	(make-process
	 :name "pkg-upgrad"
	 :buffer buf
	 :command
	 (list "emacs" "--batch" "-q" "--eval"
		   (format
            "(progn (load \"%s\") (load \"%s\") (require 'async) (require 'paradox) (paradox-enable) (paradox-upgrade-packages))"
            (expand-file-name "early-init.el" user-emacs-directory)
            (expand-file-name "init.el" user-emacs-directory))))
	(display-buffer buf)))
;;;;-----------------------------README-----------------------------
;;  dmp/, dumper

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
;; wf/, workflow

;; wf of generate template el file
(defun wf/create-new-config (file-path)
  "create file from template"
  (with-temp-buffer
    (insert (format
             ";;; %s -*- lexical-binding: t; no-byte-compile: t; -*-\n\n"
             (file-name-nondirectory file-path)))
    (insert
     (format "(provide '%s)\n;;; %s ends here"
	         (file-name-base file-path)
             (file-name-nondirectory file-path)))
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
    (goto-line 2)(end-of-line)))

;;; interactive function 
(defun wf/new-init()
  "workflow of crating new init-lisp.el"
  (interactive)
  (wf/new-config-file "new init-config: init-" "etc/init/init-%s.el"))

;; wf of new plug-in
(defun wf/new-plug-in()
  "workflow of crating new use-plugin.el"
  (interactive)
  (wf/new-config-file "new plug-in: use-" "example/plug-in/use-%s.el")
  (insert "\nnt\n")
  (goto-line 3)(end-of-line))

;; wf of new plug-in
(defun wf/new-module()
  "workflow of crating new load-module.el"
  (interactive)
  (wf/new-config-file "new module: load-" "etc/module/load-%s.el"))

;; wf of config test
(defun wf/int-test-gui ()
  "Dump Emacs."
  (interactive)
  (save-some-buffers)
  (let ((buf "*init gui test process*")
        (timer 0))
	(make-process
	 :name "init-test"
	 :buffer buf
	 :command
	 (list "emacs" "--batch"
           "-l" (expand-file-name
                 "etc/device/do-init-test.el" user-emacs-directory)))
    (display-buffer buf))
  (setq *need-test* nil))

;; wf of remind me to test
(defun wf/update-need-test ()
  (and (or (;;use regex to math file you want to check
            string-match-p
            (expand-file-name
             (concat user-emacs-directory "etc/.*/*.el$" ))
            (buffer-file-name))
           
           (;;use regex to math file you want to check
            string-match-p
            (expand-file-name
             (concat user-emacs-directory "*init.el$" ))
            (buffer-file-name)))
       (defconst *need-test* t)))
  (with-eval-after-load 'elisp-mode
    (add-hook 'emacs-lisp-mode-hook
              (lambda () 
                (add-hook
                 'after-save-hook 'wf/update-need-test nil 'make-it-local))))
;;;;-----------------------------README-----------------------------
;;  ei/ editor
;; cursor 在 org 链接中任意位置时执行下面的函数就可以自动识别链接区域并剪切
(defun ei/org-kill-link-at-point ()
  (interactive)
  (when (eq major-mode 'org-mode)
    (let* ((context (org-element-context))
           (type (org-element-type context))
           (beg (org-element-property :begin context))
           (end (org-element-property :end context)))
      (when (eq type 'link)
        (kill-region beg end)))))
;;;;-------------------------------END------------------------------
(provide 'all-util)
;;; all-util.el ends here
