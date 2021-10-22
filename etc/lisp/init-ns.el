;;; init-ns.el -*- lexical-binding: t -*-

;;;;==============================note==============================
;;  noting system, ns for short
;;;;================================================================

;;------------------------------------------------------------------
;;; basic env
;; cdlate org org-roam deft
(leaf cdlatex
  :after org
  :diminish t
  :straight t
  :hook
  (org-mode-hook . turn-on-org-cdlatex))

;; Org mode
(leaf org
  :custom
  (org-src-preserve-indentation . nil)
  (org-edit-src-content-indentation . 0)
  (org-src-tab-acts-natively . t)
  (org-src-fontify-natively . t)
  (org-src-tab-acts-natively . t)
  ;; latex in org
  (org-highlight-latex-and-related . '(native script entities))
  (org-export-with-latex . t)
  ;; literature programming
  (org-confirm-babel-evaluate . nil)
  (org-babel-load-languages . '((C . t)
                                (lisp . t)
                                (python . t)
                                (scheme . t)
                                (ocaml . t)
                                (haskell .t)))
  :config
  (with-eval-after-load 'org
    (setq org-format-latex-options
          (plist-put org-format-latex-options :scale my-org-latex-scale))))

;; pretty symbols
(leaf org-bullets
  :straight t
  :hook (org-mode-hook . org-bullets-mode))

(leaf literate-calc-mode
  :straight t
  :bind ("C-x x n" . literate-calc-eval-buffer))

(leaf writeroom-mode
  :straight t
  :bind ("C-c ~" . writeroom-mode)
  :custom (writeroom-maximize-window . nil))

(leaf deft
  :straight t
  :bind ("C-c 2" . deft)
  :custom
  (deft-directoryi . "~/Org")
  (deft-recursive . t)
  (deft-default-extension . "org")
  (deft-extensions . '("md" "org" "txt" "tex"))
  :config
  (unless (file-directory-p deft-directoryi)
    (deft-setup)))

;;------------------------------------------------------------------
;;; init-ns.el ends
(provide 'init-ns)
