;;; init-const.el -*- lexical-binding: t -*-

;;;;==============================note==============================
;;
;;;;================================================================

;;------------------------------------------------------------------
;;; os
;; system
(defconst *is-mac* (string-equal system-type "darwin"))
(defconst *is-linux* (string-equal system-type "gnu/linux"))
(defconst *is-win* (string-equal system-type "windows-nt"))


;;------------------------------------------------------------------
;;; url
(defconst *Novicemacs-url* "https://github.com/ingtshan/novicemacs")
(defconst *novicemacs-stars-url* (concat *Novicemacs-url* "/stargazers"))
(defconst *novicemacs-issue-url* (concat *Novicemacs-url* "/issues/new"))

;;------------------------------------------------------------------
;;; init-const.el ends
(provide 'init-const)
