;;; init-const.el -*- lexical-binding: t; no-byte-compile: t; -*-

;; default value here
;; you should use `devar' here for multi device

;;;;-----------------------------README-----------------------------
;;  font
(defvar =font-size-int 11)
(defvar =en-font-name "JetBrains Mono")
(defvar =zh-font-name "Sarasa Mono SC Nerd")
;;;;-----------------------------README-----------------------------
;;  all kinds of dir path and url
(defvar =org-dir "~/org")
(defvar =roam-dir (expand-file-name "roam-v2" =org-dir))
;; xapian for notdeft
(defvar =notdeft-xapian "etc/site-lisp/notdeft/xapian/mac-nt-xa")
(defvar =nviem-url "https://github.com/ingtshan/novicemacs")
(defvar =nviem-stars-url (concat =nviem-url "/stargazers"))
(defvar =nviem-issue-url (concat =nviem-url "/issues/new"))
;;;;-----------------------------README-----------------------------
;;  editor detail setup
(defvar =org-latex-scale 1.0)
;;;;-------------------------------END------------------------------
(provide 'init-const)
;;; init-const.el ends here
