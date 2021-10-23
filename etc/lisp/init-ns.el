;;; init-ns.el -*- lexical-binding: t -*-

;;;;==============================note==============================
;;  noting system, ns for short
;;;;================================================================

;;------------------------------------------------------------------
;;; basic env
;; cdlate org org-roam deft
;; (leaf cdlatex
;;   :after org
;;   :diminish t
;;   :hook
;;   (org-mode-hook . turn-on-org-cdlatex))

;; Org mode
(leaf org
  :require org-element
  :custom
  (org-src-preserve-indentation . nil)
  (org-edit-src-content-indentation . 0)
  (org-src-tab-acts-natively . t)
  (org-src-fontify-natively . t)
  (org-src-tab-acts-natively . t)
  ;; latex in org
  (org-highlight-latex-and-related . '(native script entities))
  ;; (org-export-with-latex . t)
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
          (plist-put org-format-latex-options :scale *org-latex-scale*))))

;; (leaf literate-calc-mode
;;   :after org
;;   :bind ("C-x x n" . literate-calc-eval-buffer))

(leaf writeroom-mode
  :after org
  :bind ("H-i" . writeroom-mode)
  :custom (writeroom-maximize-window . nil))

(leaf deft
  :after org
  :bind ("C-c 2" . deft)
  :custom
  (deft-directory . *org-dir*)
  (deft-recursive . t)
  (deft-default-extension . "org")
  (deft-extensions . '("md" "org" "txt" "tex"))
  :config
  (unless (file-directory-p deft-directory)
    (deft-setup)))


;; use undo history of individual file buffers persistently
(leaf undohist
  :require t
  :config
  (setq undohist-ignored-files
	'("\\.git/COMMIT_EDITMSG$"))
  (undohist-initialize))

;; for emacs 27 for vundo
(unless (boundp 'undo--last-change-was-undo-p)
  (defun undo--last-change-was-undo-p (undo-list)
    (while (and (consp undo-list) (eq (car undo-list) nil))
      (setq undo-list (cdr undo-list)))
    (gethash undo-list undo-equiv-table))

  (defun undo-redo (&optional arg)
    "Undo the last ARG undos."
    (interactive "*p")
    (cond
     ((not (undo--last-change-was-undo-p buffer-undo-list))
      (user-error "No undo to undo"))
     (t
      (let* ((ul buffer-undo-list)
             (new-ul
              (let ((undo-in-progress t))
                (while (and (consp ul) (eq (car ul) nil))
                  (setq ul (cdr ul)))
                (primitive-undo arg ul)))
             (new-pul (undo--last-change-was-undo-p new-ul)))
        (message "Redo%s" (if undo-in-region " in region" ""))
        (setq this-command 'undo)
        (setq pending-undo-list new-pul)
        (setq buffer-undo-list new-ul))))))

(require 'vundo)

;;------------------------------------------------------------------
;;; init-ns.el ends
(provide 'init-ns)
