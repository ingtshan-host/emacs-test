;;; init-const.el -*- lexical-binding: t -*-

;;;;==============================note==============================
;; #字体
;; 简体中文等距更纱黑体+Nerd图标字体库
;; https://github.com/laishulu/Sarasa-Mono-SC-Nerd
;; 
;; Free variable writing fonts from iA
;; https://github.com/iaolo/iA-Fonts
;;
;; JetBrains Mono 是JetBrains专门为程序员出的一套西语字体(不支持中文)
;; https://www.jetbrains.com/lp/mono/
;;;;================================================================

;; multi-os util
(require 'all-util)

;; gui/console
(defconst *is-app* (and (display-graphic-p) (not (daemonp))))
(defconst *is-server-m* (string-equal "main" (daemonp)))
(defconst *is-server-c* (string-equal "coding" (daemonp)))
(defconst *is-server-t* (string-equal "tty" (daemonp)))
(defconst *is-gui*  (or *is-app* *is-server-m* *is-server-c*))
(defconst *is-cli* (or (not *is-gui*) *is-server-t*))

;;------------------------------------------------------------------
;;; ui

(defconst/os *font-size-int*
  :macos 15)
(defconst/os *en-font-name*
  :macos "JetBrains Mono")
(defconst/os *zh-font-name*
  :macos "Sarasa Mono SC Nerd")

;;------------------------------------------------------------------
;;; user dir info
(defconst/os *org-dir*
  :macos "~/Org")

;;------------------------------------------------------------------
;;; editor setup
(defconst/os *org-latex-scale*
  :macos 1.0)

;;------------------------------------------------------------------
;;; url
(defconst *Novicemacs-url* "https://github.com/ingtshan/novicemacs")
(defconst *novicemacs-stars-url* (concat *Novicemacs-url* "/stargazers"))
(defconst *novicemacs-issue-url* (concat *Novicemacs-url* "/issues/new"))

;;------------------------------------------------------------------
;;; init-const.el ends
(provide 'init-const)
