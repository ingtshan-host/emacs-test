;;; init-ui.el -*- lexical-binding: t -*-

;;;;==============================note==============================
;;  界面美化
;;  交互优化
;;;;================================================================

;;------------------------------------------------------------------
;;; function
(defun ui/stop-using-minibuffer ()
  "kill the minibuffer"
  (when (and (>= (recursion-depth) 1)
	     (active-minibuffer-window))
    (abort-recursive-edit)))

;;------------------------------------------------------------------
;;; user interface

;; themes
(leaf doom-themes 
  :require t 
  :config
  (load-theme 'doom-dracula t) 
  (doom-themes-org-config))

(leaf doom-modeline 
  :hook 
  (after-init-hook)
  :custom ;; :custom is for variables so setq is equivalent
  (doom-modeline-irc . nil)
  (doom-modeline-mu4e . nil)
  (doom-modeline-gnus . nil)
  (doom-modeline-github . nil)
  (doom-modeline-persp-name . nil)
  (doom-modeline-unicode-fallback . t)
  (doom-modeline-enable-word-count . nil))

;; You can still use `winner-mode' on Emacs 26 or early. On Emacs 27, it's
;; prefered over `winner-mode' for better compatibility with `tab-bar-mode'.
(add-hook 'after-init-hook #'tab-bar-history-mode)
(setq tab-bar-history-buttons-show nil)

(leaf all-the-icons 
  :config 
  (when (display-graphic-p) 
    (require 'all-the-icons nil nil)))

(leaf dashboard
  :init
  ;; 
  (defconst homepage-url "https://github.com/ingtshan/novicemacs")
  (defconst stars-url (concat homepage-url "/stargazers"))
  (defconst issue-url (concat homepage-url "/issues/new"))
  ;; close welcom screen
  (setq inhibit-startup-screen t)
  ;; Format: "(icon title help action face prefix suffix)"
  (setq
   dashboard-navigator-buttons
   `(((,(if (fboundp 'all-the-icons-octicon)
	    (all-the-icons-octicon
	     "mark-github"
	     :height 1.0 :v-adjust  0.0) "★")
       "GitHub" "Browse"
       (lambda (&rest _) (browse-url homepage-url)))
      (,(if (fboundp 'all-the-icons-octicon)
	    (all-the-icons-octicon
	     "heart"
	     :height 1.1 :v-adjust  0.0) "♥")
       "Stars" "Show stars"
       (lambda (&rest _) (browse-url stars-url)))
      (,(if (fboundp 'all-the-icons-material)
	    (all-the-icons-material
	     "report_problem"
	     :height 1.1 :v-adjust -0.2) "⚑")
       "Issue" "Report issue"
       (lambda (&rest _) (browse-url issue-url)) warning)
      (,(if (fboundp 'all-the-icons-material)
	    (all-the-icons-material
	     "update"
	     :height 1.1 :v-adjust -0.2) "♺")
       "Update" "Update packages synchronously"
       (lambda (&rest _) (auto-package-update-now)) success))))
  :hook ((after-init-hook . dashboard-setup-startup-hook)
	 (dashboard-mode-hook
	  .
	  (lambda () (setq-local global-hl-line-mode nil))))
  :custom
  (dashboard-startup-banner . 'logo)
  (dashboard-set-heading-icons . t)
  (dashboard-set-file-icons . t)
  (dashboard-set-init-info . t)
  (dashboard-set-navigator . t)
  (dashboard-items . '((recents   . 10)
		       (projects  . 5)
		       (bookmarks . 5))))

;;------------------------------------------------------------------
;;; user-emacs interaction

(require 'load-search-and-command-competion)
(require 'load-company)

;; kill minibuffer while unfocus
(add-hook 'mouse-leave-buffer-hook 'ui/stop-using-minibuffer)

;;------------------------------------------------------------------
;;; init-ui ends
(provide 'init-ui)
