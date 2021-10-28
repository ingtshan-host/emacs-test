;;; init test with `emacs --batch -l'

;; load tool form sys-info.el
(defmacro defunit (fun-name arg-list &rest body)
  "macro of device adpat, generate code such as

(unless (fboundp '+system-key-adapte)
  (defun +system-key-adapte(keep)
    ;; progn here
    ;; excute one time
    (unless keep)   
      (fmakunbound '+system-key-adapte)))

"
  `(unless (fboundp ',fun-name)
     (defun ,fun-name (keep ,@arg-list)
       ,@body
       (unless keep
         ;; excute one time
         (fmakunbound ',fun-name)) t)))
;; enable gui module in --batch
(setq *is-gui* t)
;; disable font set due to error: Fontset `tty' does not exist
(defunit +set-fonts (en-font size zh-font rescale)
  (message "[warning] test-init detected, +set-font unit disabled"))
(require 'benchmark)
(let ((timer 
       (benchmark-elapse
        (load-file (expand-file-name "early-init.el" user-emacs-directory))
        (load-file (expand-file-name "init.el" user-emacs-directory)))))
  (message "\nload all init casue %ss" timer))
