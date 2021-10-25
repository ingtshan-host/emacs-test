;;; init-const.el -*- lexical-binding: t; no-byte-compile: t; -*-

(require 'sys-info)
;;;;-----------------------------README-----------------------------
;;  font
(defconst =font-size-int
  (select-default 13
    (macOS . 15)
    (windows . 17)))
                      
(defconst =en-font-name
  (select-default nil
    (macOS . "JetBrains Mono")))

(defconst =zh-font-name
  (select-default nil
    (macOS . "Sarasa Mono SC Nerd")))
;;;;-----------------------------README-----------------------------
;;  all kinds of dir path and url

(defconst =org-dir "~/org")

(defconst =roam-dir (expand-file-name "roam-v2" =org-dir))

(select-default (expand-file-name "roam-v2" =org-dir))

;; xapian for notdeft
(defconst =notdeft-xapian
  (select-default nil
    (macOS . (expand-file-name
              "etc/site-lisp/notdeft/xapian/mac-nt-xa"
              user-emacs-directory))
    (windows . (expand-file-name
           "etc/site-lisp/notdeft/xapian/win-nt-xa"
           user-emacs-directory))
    ))

(defconst =nviem-url "https://github.com/ingtshan/novicemacs")
(defconst =nviem-stars-url (concat =nviem-url "/stargazers"))
(defconst =nviem-issue-url (concat =nviem-url "/issues/new"))
;;;;-----------------------------README-----------------------------
;;  editor detail setup
(defconst =org-latex-scale 1.0)
;;;;-------------------------------END------------------------------
(provide 'init-const)
;;; init-const.el ends here
