;;; init-wf.el -*- lexical-binding: t -*-

;;;;-----------------------------README-----------------------------
;; wf short of workflow
;;;;----------------------------------------------------------------

;;------------------------------------------------------------------
;;; reuse function

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
    
    (insert (format "(require '%s)                ;;"
		    (file-name-base file-path)))
    
    (wf/create-new-config file-path)
    
    (switch-to-buffer (find-file-noselect file-path))
    (goto-line 4)
    (end-of-line)))

;;------------------------------------------------------------------
;;; interactive function 
;; wf of new init
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
;;; init-wf.el ends
  (provide 'init-wf)
