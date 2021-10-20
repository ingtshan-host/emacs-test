;;;;==============================note==============================
;;; goole: file site:https://www.gnu.org/software/emacs/manual/
;;
;; visiting: file -copy-> buffer
;;  - read file
;;  - prepare a buffer to contain copy text
;; editing and save: buffer -write-> file
;;
;; other file operation
;; - delete
;; - copy
;; - rename
;; ...
;;
;; 文件是操作系统 持久存储数据的文件对象，而 buffer 是 emacs 的概念。
;; Q: emacs 打开文件 其实是 copy text 到 buffer 之后就释放文件资源？应该是
;; Q: 理论上 emacs 怎么新建文件？temp-buffer -write-> file
;;
;; 获取 buffer 对象
;; 对象信息
;; name
;;;;================================================================

;; 获取 buffer 对象
(current-buffer)
(other-buffer)

;;; 读取 信息
;; full path
(buffer-file-name (other-buffer))
(buffer-file-name)
;; file name (not sync)
(buffer-name (other-buffer))
(buffer-name)

;;; insert text to buffer (current cursor)
(insert "(requre '")

;;; read from user input
(read-from-minibuffer
 (concat
  (propertize "Bold" 'face '(bold default))
  (propertize " and normal: " 'face '(default))))

(read-string "new module: ")

;; file exists
(file-exists-p "../init.el")

;; switch-to-buffer
(switch-to-buffer (find-file-noselect "./etc/init-ok.el"))

;;; 实现
;; - 若当前是 "init.el" buffer
;; 插入 "(requre '用户输入)"
;; 新建 "./etc/用户输入.el" 并跳转到该 buffer
;; 插入 ";;; 用户输入.el -*- lexical-binding: t -*-"
;; （光标回到这里）
;; 插入 "(provide '用户输入)"
;; 插入 ";;; 用户输入.el ends here"
(defun wf/new-module()
  (interactive)
  "workflow of crating new module"
  (unless (string= (buffer-name) "init.el")
    (error "only support on init.el"))
  
  (let* ((input (read-string "new module: init-"))
	 (file-path (format "./etc/init-%s.el" input)))
    
    (if (file-exists-p file-path)
	(error (format "module file %s exits" file-path)))
    
    (insert (format "(require 'init-%s)" input))
    (with-temp-buffer
      (insert (format ";;; %s.el -*- lexical-binding: t -*-\n\n" input))
      (insert ";;;;==============================note==============================\n")
      (insert ";;\n")
      (insert ";;;;================================================================\n\n")
      (insert (format "(provide 'init-%s)\n;;; %s.el ends here" input input))
      (write-file file-path))
    
    (switch-to-buffer (find-file-noselect file-path))
    (goto-line 4)
    (end-of-line)))
