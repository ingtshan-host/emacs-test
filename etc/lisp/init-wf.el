;;; init-wf.el -*- lexical-binding: t -*-

;;;;-----------------------------README-----------------------------
;; wf short of workflow
;;;;----------------------------------------------------------------

;; wf of generate template el file
(defun wf/create-new-config (file-path)
  "create file from template"
  (with-temp-buffer
    (insert (format ";;; %s -*- lexical-binding: t -*-\n\n"
		    (file-name-nondirectory file-path)))
    (insert ";;;;==============================note==============================\n")
    (insert ";;\n")
    (insert ";;;;================================================================\n\n")
    (insert
     (format ";;------------------------------------------------------------------\n;;; %s ends\n(provide '%s)"
	     (file-name-nondirectory file-path)
	     (file-name-base file-path)))
    (write-file file-path)))

;; wf of new init
(defun wf/new-init()
  "workflow of crating new init-lisp.el"
  (interactive)

  (unless
      (or (string= (buffer-name) "init.el")
	  (string= (buffer-name) "init.el<.emacs.d>"))
    (error "only support on init.el"))
  
  (let* ((input (read-string "new init-config: init-"))
	 (file-path (format "./etc/lisp/init-%s.el" input)))
    
    (if (file-exists-p file-path)
	(error (format "module file %s exits" file-path)))
    
    (insert (format "(require 'init-%s)                ;;" input))
    
    (wf/create-new-config file-path)
    
    (switch-to-buffer (find-file-noselect file-path))
    (goto-line 4)
    (end-of-line)))

;; wf of new plug-in
(defun wf/new-plug-in()
  "workflow of crating new use-plugin.el"
  (interactive)
  
  (let* ((input (read-string "new plug-in: use-"))
	 (file-path (format "~/.emacs.d/etc/plug-in/use-%s.el" input)))
    
    (if (file-exists-p file-path)
	(error (format "file %s exits" file-path)))
    
    (insert (format "(require 'use-%s)" input))
    
    (wf/create-new-config file-path)
    
    (switch-to-buffer (find-file-noselect file-path))
    (goto-line 4)
    (end-of-line)))

;; wf of new plug-in
(defun wf/new-module()
  "workflow of crating new load-module.el"
  (interactive)
  
  (let* ((input (read-string "new module: load-"))
	 (file-path (format "~/.emacs.d/etc/module/load-%s.el" input)))
    
    (if (file-exists-p file-path)
	(error (format "file %s exits" file-path)))
    
    (insert (format "(require 'load-%s)" input))
    
    (wf/create-new-config file-path)
    
    (switch-to-buffer (find-file-noselect file-path))
    (goto-line 4)
    (end-of-line)))

;;------------------------------------------------------------------
;;; init-wf.el ends
(provide 'init-wf)
