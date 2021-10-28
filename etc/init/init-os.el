;;; init-os.el -*- lexical-binding: t; no-byte-compile: t; -*-

;;;;-----------------------------README-----------------------------
;;  OS adapt
;; bind key to 'hyper and 'meta
(callunit +system-key-adapte)

;; what different between (kbd "H-v") and [(hyper v)] ?
(global-set-key (kbd "H-a") #'mark-page)         ; 全选
(global-set-key (kbd "H-v") #'yank)              ; 粘贴
(global-set-key (kbd "H-x") #'kill-region)       ; 剪切
(global-set-key (kbd "H-c") #'kill-ring-save)    ; 复制
(global-set-key (kbd "H-s") #'save-buffer)       ; 保存
(global-set-key (kbd "H-z") #'vundo)             ; 撤销编辑修改
(global-set-key (kbd "H-l") #'goto-line)         ; 行跳转

(global-set-key [(hyper n)] #'make-frame-command); 新建窗口
(global-set-key [(hyper q)] #'os/quit-emacs)     ; 退出
(global-set-key [(hyper w)] #'os/close-frame)    ; 退出frame
;; make select more like other editro
(delete-selection-mode 1)                 
;; use shift to extend select
(global-set-key (kbd "<S-down-mouse-1>") #'mouse-save-then-kill)
;;;;-------------------------------END------------------------------
(provide 'init-os)
;;; init-os.el ends here
