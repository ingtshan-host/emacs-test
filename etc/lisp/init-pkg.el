;;; init-pkg.el -*- lexical-binding: t -*-

;;;;==============================note==============================
;; straight.el
;; Install Emacs packages
;; listed on MELPA, GNU ELPA, or Emacsmirror, or provide your own recipes.
;; Packages are cloned as Git (or other) repositories, not as opaque tarballs.
;;
;; integrated to leaf is my choice
;;
;; leaf.el is yet another use-package.
;; leaf-keywords.el add additional keywords for leaf.el
;;;;================================================================

;; optional proxy setup
(setq url-proxy-services
      '(("http" . "127.0.0.1:8889")
        ("https" . "127.0.0.1:8889")))

;; setup package archives
(require 'package)

;; ensure being up-to-date to update Emacs's GPG keyring for GNU ELPA
;; (package-install 'gnu-elpa-keyring-update)

(eval-and-compile
  ;; package-archives
  (customize-set-variable
   'package-archives '(("gnu"   . "https://elpa.gnu.org/packages/")
		       ("org"   . "http://orgmode.org/elpa/")
		       ("melpa-stable" . "https://stable.melpa.org/packages/")
		       ("melpa" . "https://melpa.org/packages/")))
  
  ;; initialize packages
  (unless (bound-and-true-p package--initialized) ; To avoid warnings in 27
    (package-initialize))

  ;; initialize straight
  (defvar bootstrap-version)
  (setq straight-vc-git-default-clone-depth 1
	straight-check-for-modifications '(find-when-checking)
	straight-use-package-by-default t
	straight-recipes-gnu-elpa-use-mirror t)

  ;; loading bootstrap file
  (let ((bootstrap-file
	 (expand-file-name
	  "straight/repos/straight.el/bootstrap.el"
	  user-emacs-directory))
	(bootstrap-version 5))
    
    (unless (file-exists-p bootstrap-file)
      (with-current-buffer
          (url-retrieve-synchronously
           "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
           'silent 'inhibit-cookies)
	(goto-char (point-max))
	(eval-print-last-sexp)))
    (load bootstrap-file nil 'nomessage)
    
    ;; make sure leaf is install
    (unless (package-installed-p 'leaf)
      (cond ((file-exists-p bootstrap-file) ;; install by straight
	     (straight-use-package 'leaf)
	     (straight-use-package 'leaf-keywords))
	    (t ;; install tradition way
	     (package-refresh-contents)
	     (package-install 'leaf)
	     (package-install 'leaf-keywords))))))

(leaf leaf-keywords
  :config
  ;; optional packages if you want to use :hydra, :el-get, :blackout,,,
  ;; (leaf hydra :ensure t)
  ;; (leaf el-get :ensure t)
  ;; (leaf blackout :ensure t)
  (leaf diminish :ensure t)

  ;; initialize leaf-keywords.el
  (leaf-keywords-init))

;; now you can use leaf!

;; always ensure
(leaf leaf
  ;; feel free to change default here
  :custom ((leaf-defaults . '(:ensure t :straight t))))
;; dot operator means add iterm to list

;;;;==============================note==============================
;; Interactive side-bar feature for init.el using leaf.el.
;; usage M-x leaf-tree-mode
;;
;; Convert from a plain Elisp to an expression using a leaf.
;; usage (leaf-convert elisp-code)
;;
;; use-package support for convert
;;;;================================================================

(leaf leaf-tree)
(leaf leaf-convert)

;; for conver use-package paradigm to leaf
(leaf use-package)

;;------------------------------------------------------------------
;;; init-pkg.el ends
(provide 'init-pkg)
