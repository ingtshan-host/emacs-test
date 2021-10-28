;;; init-ns.el -*- lexical-binding: t; no-byte-compile: t; -*-

;;;;-----------------------------README-----------------------------
;; basic noting env

;; cdlate org org-roam deft
;; (leaf cdlatex
;;   :after org
;;   :diminish t
;;   :hook
;;   (org-mode-hook . turn-on-org-cdlatex))

(leaf org
  :require org-element org-tempo
  :bind ((org-mode-map 
          ("C-c l" . ei/org-kill-link-at-point)))
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
          (plist-put org-format-latex-options :scale =org-latex-scale))))

;; visually hid PROPERTIES in org
;; re-defun org-cycle-hide-drawers
(defun org-cycle-hide-drawers (state)
  "Re-hide all drawers after a visibility state change."
  (when (and (derived-mode-p 'org-mode)
             (not (memq state '(overview folded contents))))
    (save-excursion
      (let* ((globalp (memq state '(contents all)))
             (beg (if globalp
                      (point-min)
                    (point)))
             (end (if globalp
                      (point-max)
                    (if (eq state 'children)
                        (save-excursion
                          (outline-next-heading)
                          (point))
                      (org-end-of-subtree t)))))
        (goto-char beg)
        (while (re-search-forward org-drawer-regexp end t)
          (save-excursion
            (beginning-of-line 1)
            (when (looking-at org-drawer-regexp)
              (let* ((start (1- (match-beginning 0)))
                     (limit
                      (save-excursion
                        (outline-next-heading)
                        (point)))
                     (msg (format
                           (concat
                            "org-cycle-hide-drawers:  "
                            "`:END:`"
                            " line missing at position %s")
                           (1+ start))))
                (if (re-search-forward "^[ \t]*:END:" limit t)
                    (outline-flag-region start (point-at-eol) t)
                  (user-error msg))))))))))


;; (leaf literate-calc-mode
;;   :after org
;;   :bind ("C-x x n" . literate-calc-eval-buffer))

(leaf writeroom-mode
  :after org
  :bind ("H-i" . writeroom-mode)
  :custom (writeroom-maximize-window . nil))

;; (leaf deft
;;   :after org
;;   :bind ("C-c 2" . deft)
;;   :custom
;;   (deft-directory . =org-dir)
;;   (deft-recursive . t)
;;   (deft-default-extension . "org")
;;   (deft-extensions . '("md" "org" "txt" "tex"))
;;   :config
;;   (unless (file-directory-p deft-directory)
;;     (deft-setup)))
;; move to notdeft

;; notdeft-xapian install xapian in os
;; follow https://github.com/hasu/notdeft to make program
(leaf notdeft
  :ensure nil
  :straight nil
  :config
  (setq notdeft-extension "org")
  (setq notdeft-secondary-extensions '("md" "org" "el"))
  (setq notdeft-directories
        `(,(file-truename =org-dir)
          ;; because sometime note in comment
          ;;,(expand-file-name "etc" user-emacs-directory)
          ;;,(expand-file-name "example" user-emacs-directory)
          ))
  (setq notdeft-xapian-program =notdeft-xapian)
  (setq notdeft-allow-org-property-drawers t)
  ;; 支持中文搜索
  ;; (setenv "XAPIAN_CJK_NGRAM" "1")
  :bind (("C-c 2" . notdeft)
         (notdeft-mode-map
          ("C-q" . notdeft-quit)
          ("C-r" . notdeft-refresh))))

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
;;;;-----------------------------README-----------------------------
;;  noting framework
;; Roam
(require 'load-org-roam)

;;;;-------------------------------END------------------------------
(provide 'init-ns)
;;; init-ns.el ends here
