;;; init-wf.el -*- lexical-binding: t -*-

;;;;-----------------------------README-----------------------------
;; wf short of workflow
;;;;----------------------------------------------------------------

;; wf of new moduole
(defun wf/new-module()
  (interactive)
  "workflow of crating new module"
  (unless
      (or (string= (buffer-name) "init.el")
	  (string= (buffer-name) "init.el<.emacs.d>"))
    (error "only support on init.el"))
  
  (let* ((input (read-string "new module: init-"))
	 (file-path (format "./etc/init-%s.el" input)))
    
    (if (file-exists-p file-path)
	(error (format "module file %s exits" file-path)))
    
    (insert (format "(require 'init-%s)                ;;" input))
    (with-temp-buffer
      (insert (format ";;; init-%s.el -*- lexical-binding: t -*-\n\n" input))
      (insert ";;;;==============================note==============================\n")
      (insert ";;\n")
      (insert ";;;;================================================================\n\n")
      (insert (format "(provide 'init-%s)\n;;; init-%s.el ends here" input input))
      (write-file file-path))
    
    (switch-to-buffer (find-file-noselect file-path))
    (goto-line 4)
    (end-of-line)))

(provide 'init-wf)
;;; init-wf.el ends here
