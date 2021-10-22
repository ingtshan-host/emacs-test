;;; init-os.el -*- lexical-binding: t -*-

;;;;==============================note==============================
;;
;;;;================================================================

;;------------------------------------------------------------------
;;; 1. improve quit emacs
;;; 2. improve undo

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

;; use undo history of individual file buffers persistently
(leaf undohist
  :require t
  :config
  (setq undohist-ignored-files
	'("\\.git/COMMIT_EDITMSG$"))
  (undohist-initialize))

;; for emacs 27 for vundo

(unless (boundp 'undo--last-change-was-undo-p)
  (defun undo--last-change-was-undo-p (undo-list)
    (while (and (consp undo-list) (eq (car undo-list) nil))
      (setq undo-list (cdr undo-list)))
    (gethash undo-list undo-equiv-table))

  (defun undo-redo (&optional arg)
    "Undo the last ARG undos."
    (interactive "*p")
    (cond
     ((not (undo--last-change-was-undo-p buffer-undo-list))
      (user-error "No undo to undo"))
     (t
      (let* ((ul buffer-undo-list)
             (new-ul
              (let ((undo-in-progress t))
                (while (and (consp ul) (eq (car ul) nil))
                  (setq ul (cdr ul)))
                (primitive-undo arg ul)))
             (new-pul (undo--last-change-was-undo-p new-ul)))
        (message "Redo%s" (if undo-in-region " in region" ""))
        (setq this-command 'undo)
        (setq pending-undo-list new-pul)
        (setq buffer-undo-list new-ul))))))

(require 'vundo)

;;------------------------------------------------------------------
;;; MacOS

;; bind key to 'hyper and 'meta
(progn/os
 :macos
 ;; 绑定为 Comand 键 和 option 键
 ((setq mac-command-modifier 'hyper mac-option-modifier 'meta)))

;; what different between (kbd "H-v") and [(hyper v)] ?
(global-set-key (kbd "H-a") #'mark-page)         ;; 全选
(global-set-key (kbd "H-v") #'yank)              ;; 粘贴
(global-set-key (kbd "H-x") #'kill-region)       ;; 剪切
(global-set-key (kbd "H-c") #'kill-ring-save)    ;; 复制
(global-set-key (kbd "H-s") #'save-buffer)       ;; 保存
(global-set-key (kbd "H-z") #'vundo)             ;; 撤销编辑修改
(global-set-key (kbd "H-l") #'goto-line)         ;; 行跳转

(global-set-key [(hyper n)] #'make-frame-command);; 新建窗口
(global-set-key [(hyper q)] #'os/quit-emacs)     ;; 退出
(global-set-key [(hyper w)] #'os/close-frame)    ;; 退出frame

;; use shift to extend select
(global-set-key (kbd "<S-down-mouse-1>") #'mouse-save-then-kill)
;;------------------------------------------------------------------
;;; init-os.el ends
(provide 'init-os)
