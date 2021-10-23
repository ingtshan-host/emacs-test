;;; init-const.el -*- lexical-binding: t -*-

(require 'sys-info)
;;;;-----------------------------README-----------------------------
;;  font
(defconst/os *font-size-int*
  :macos 15)
(defconst/os *en-font-name*
  :macos "JetBrains Mono" ; JetBrains Mono 为程序员出的一套西语字体(不支持中文)
  )
(defconst/os *zh-font-name*
  :macos "Sarasa Mono SC Nerd" ; 简体中文等距更纱黑体+Nerd图标字体库
  )
;;;;-----------------------------README-----------------------------
;;  all kinds of dir path and url
(defconst/os *org-dir*
  :macos "~/Org")

(defconst *Novicemacs-url* "https://github.com/ingtshan/novicemacs")
(defconst *novicemacs-stars-url* (concat *Novicemacs-url* "/stargazers"))
(defconst *novicemacs-issue-url* (concat *Novicemacs-url* "/issues/new"))
;;;;-----------------------------README-----------------------------
;;  editor detail setup
(defconst/os *org-latex-scale*
  :macos 1.0)
;;;;-------------------------------END------------------------------
;;; init-const.el ends
(provide 'init-const)
