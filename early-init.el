;;; early-init.el
;; This file is loaded before the package system and GUI is initialized

;; 版本检查
(when (version< emacs-version "26.1")
  (error "This requires Emacs 26.1 and above!"))

;; 基本设置
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; 递归遍历加载路径
(defun add-subdirs-to-load-path(dir)
    "Recursive add directories to `load-path`."
    (let ((default-directory (file-name-as-directory dir)))
      (add-to-list 'load-path dir)
      (normal-top-level-add-subdirs-to-load-path)))

;; 将配置文件添加进load-path
(add-subdirs-to-load-path "~/.emacs.d/etc/")

;; stop emacs automatically editing .emacs
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
