;;; init-os.el -*- lexical-binding: t -*-

;;;;==============================note==============================
;;
;;;;================================================================

;; ----------------------------------------------------------------
;; function
;; ----------------------------------------------------------------

;; quit emacs
(defun os/quit-emacs (&optional pfx)
  "quit emacs with confirm"
     (interactive "P")
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
		 (if q (ingt/quit-emacs pfx))))))
					
;; ----------------------------------------------------------------
;; MacOS
;; ----------------------------------------------------------------

(setq *is-mac* t)

(when *is-mac*
  ;; Coomand 键 和 option 键
  (setq mac-command-modifier 'hyper
	mac-option-modifier 'meta)

  (global-set-key [(hyper a)] #'mark-whole-buffer) ;; 全选
  (global-set-key [(hyper v)] #'yank)              ;; 粘贴
  (global-set-key [(hyper x)] #'kill-region)       ;; 剪切
  (global-set-key [(hyper c)] #'kill-ring-save)    ;; 复制
  (global-set-key [(hyper s)] #'save-buffer)       ;; 保存
  (global-set-key [(hyper z)] #'undo)              ;; 撤销编辑修改
  (global-set-key [(hyper l)] #'goto-line)         ;; 行跳转

  (global-set-key [(hyper n)] #'make-frame-command);; 新建窗口
  (global-set-key [(hyper q)] #'os/quit-emacs)     ;; 退出
  (global-set-key [(hyper w)] #'os/close-frame)    ;; H-w 
  )

(provide 'init-os)
;;; init-os.el ends here
