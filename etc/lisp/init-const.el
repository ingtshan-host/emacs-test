;;; init-const.el -*- lexical-binding: t -*-

;;;;==============================note==============================
;;
;;;;================================================================

;; multi-os util
(require 'util-os)

;;------------------------------------------------------------------
;;; user info
(defconst/os *org-dir*
  :macos "~/Org")

;;------------------------------------------------------------------
;;; url
(defconst *Novicemacs-url* "https://github.com/ingtshan/novicemacs")
(defconst *novicemacs-stars-url* (concat *Novicemacs-url* "/stargazers"))
(defconst *novicemacs-issue-url* (concat *Novicemacs-url* "/issues/new"))

;;------------------------------------------------------------------
;;; init-const.el ends
(provide 'init-const)
