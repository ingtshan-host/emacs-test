;;; use-cnfonts.el -*- lexical-binding: t -*-

;;;;==============================note==============================
;; 中文/英文 混用 org 表格对其问题
;; 思路：用不同字号
;; cnfonts 添加了许多辅助工具，使配置和调节字体和字号的工作更加简便快捷
;;;;================================================================

;; install and enable
(prog1 'cnfonts
  (let
      ((file
        (leaf-this-file)))
    (unless
        (boundp 'leaf--paths)
      (defvar leaf--paths nil))
    (when file
      (add-to-list 'leaf--paths
                   (cons 'cnfonts file))))
  (condition-case err
      (progn
        (unless
            (package-installed-p 'cnfonts)
          (unless
              (assoc 'cnfonts package-archive-contents)
            (package-refresh-contents))
          (condition-case _err
              (package-install 'cnfonts)
            (error
             (condition-case err
                 (progn
                   (package-refresh-contents)
                   (package-install 'cnfonts))
               (error
                (display-warning 'leaf
                                 (format "In `cnfonts' block, failed to :package of `cnfonts'.  Error msg: %s"
                                         (error-message-string err))))))))
        (straight-use-package 'cnfonts)
        (cnfonts-enable))
    (error
     (display-warning 'leaf
                      (format "Error in `cnfonts' block.  Error msg: %s"
                              (error-message-string err))))))

(unless
    (fboundp 'test)
  (defun test
      (keep)
    nil
    (unless keep
      (fmakunbound 'test))
    t))

;; M-x cnfonts-ui to use

;;;;==============================note==============================
;; cnfonts 如何添加字体进选择列表？
;; 编辑 profile 文件
;; M-x cnfonts-edit-profile-without-ui
;;;;================================================================


;;------------------------------------------------------------------
;;; use-cnfont.el ends
(provide 'use-cnfonts)
