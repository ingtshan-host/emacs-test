;;; init-bas.el -*- lexical-binding: t; no-byte-compile: t; -*-

;; #自动生成文件机制
;; 自动备份 backuops filename~ (一直存在)
;; 自动保存 auto-saving #filename# (执行保存后消失，但还是不太方便)
;; 文件编辑锁 file locks .#filename (emacs 释放文件资源后消失)
;; No backup auto-saving lock files (you should know what will case)
(setq make-backup-files nil
      auto-save-default nil
      create-lockfiles nil)

;; put configuration files in no-littering-etc-directory
;; (defaulting to "etc/" under user-emacs-directory, thus usually "~/.emacs.d/etc/")
;; persistent data files in no-littering-var-directory
;; (defaulting to "var/" under user-emacs-directory, thus usually "~/.emacs.d/var/")
(leaf no-littering
  :leaf-defer nil
  :custom
  ;; store these files in the var directory
  (auto-save-file-name-transforms
   . `((".*" ,(no-littering-expand-var-file-name "auto-save/") t))))

;; Enforce a sneaky Garbage Collection strategy to minimize GC interference 
(leaf gcmh
  :diminish t
  :leaf-defer nil
  :custom 
  (gcmh-verbose . nil)
  (gcmh-lows-cons-threshold . #x800000)
  (gcmh-high-cons-threshold . #x10000000)
  (gcmh-idle-delay . 10)
  :config
  (gcmh-mode))

;; load environment setting
;; if you can't use certain executable, please add it to the path
(leaf exec-path-from-shell
  :hook (after-init-hook . exec-path-from-shell-initialize))

;; start server
;; (leaf server
;;   :ensure nil
;;   :defer 1
;;   :config
;;   (unless (server-running-p)
;;     (server-start)))

;; saveplace
(leaf saveplace
  :hook (after-init-hook . save-place-mode))

;; show a bar at 80th characters
(custom-set-faces
 '(fill-column-indicator
   ((t (:foreground "#f2c9ed")))))
(add-hook 'after-init-hook 'global-display-fill-column-indicator-mode)

;; recentf
(leaf recentf
  :hook
  (after-init-hook . recentf-mode)
  :bind
  ("C-x C-r" . recentf-open-files)
  :custom
  (recentf-max-saved-items . 300)
  (recentf-exclude . '("\\.?cache"
                       ".cask"
                       "url"
                       "COMMIT_EDITMSG\\'"
                       "bookmarks"
                       "\\.\\(?:gz\\|gif\\|svg\\|png\\|jpe?g\\|bmp\\|xpm\\)$"
                       "\\.?ido\\.last$" "\\.revive$" "/G?TAGS$" "/.elfeed/"
                       (lambda (file) (file-in-directory-p file package-user-dir))))
  :init
  (add-to-list 'recentf-exclude no-littering-var-directory)
  (add-to-list 'recentf-exclude no-littering-etc-directory)
  :config
  (push (expand-file-name recentf-save-file) recentf-exclude))

;; savehist
(leaf savehist
  :custom
  (enable-recursive-minibuffers . t) ; Allow commands in minibuffers
  (history-length . 1000)
  (savehist-additional-variables . '(mark-ring
                                     global-mark-ring
                                     search-ring
                                     regexp-search-ring
                                     extended-command-history))
  (savehist-autosave-interval . 300)
  :global-minor-mode savehist-mode)

;; show information in modeline
;; show line/column/filesize
(leaf simple
  :ensure nil
  :straight nil
  :diminish (visual-line-mode auto-fill-function)
  :hook
  (after-init-hook . global-visual-line-mode)
  ((org-mode-hook markdown-mode-hook) . auto-fill-mode)
  :custom 
  (line-number-mode . t)
  (column-number-mode . t)
  (size-infication-mode . t)
  (visual-line-fringe-indicators . '(nil right-curly-arrow))
  ;; save clipoard text
  (save-interprogram-paste-before-kill . t)
  ;; show character of the cursor postion
  (what-cursor-show-names . t)
  ;; include newline
  (kill-whole-line . t))

;;minibuffer
(leaf minibuffer
  :ensure nil
  :straight nil
  :bind
  ((:minibuffer-local-map
    ([remap escape] . abort-recursive-edit))
   (:minibuffer-local-ns-map
    ([remap escape] . abort-recursive-edit))
   (:minibuffer-local-completion-map
    ([remap escape] . abort-recursive-edit))
   (:minibuffer-local-must-match-map
    ([remap escape] . abort-recursive-edit))
   (:minibuffer-local-isearch-map
    ([remap escape] . abort-recursive-edit)))
  :custom
  (minibuffer-depth-indicate-mode . t)
  (minibuffer-electric-default-mode . t)
  (enable-recursive-minibuffers . t))

(setq-default major-mode 'text-mode
              fill-column 80
              tab-width 4
              ;; Permanently indent with spaces, never with TABs
              indent-tabs-mode nil)

;; auto indent
(leaf aggressive-indent
  :hook ((emacs-lisp-mode-hook . aggressive-indent-mode)))

(setq visible-bell t
      inhibit-compacting-font-caches t  ; Don’t compact font caches during GC.
      delete-by-moving-to-trash t       ; Deleting files go to OS's trash folder
      make-backup-files nil             ; Forbide to make backup files
      auto-save-default nil             ; Disable auto save

      uniquify-buffer-name-style 'post-forward-angle-brackets
                                        ; Show path if names are same
      adaptive-fill-regexp "[ t]+|[ t]*([0-9]+.|*+)[ t]*"
      adaptive-fill-first-line-regexp "^* *$"
      sentence-end "\\([。！？]\\|……\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*"
      sentence-end-double-space nil)

;; "transient command"
(leaf transient
  :require t
  :custom (transient-enable-popup-navigation . nil)
  :config
  (transient-bind-q-to-quit))

;; for consult
;; Add prompt indicator to `completing-read-multiple'.
;; Alternatively try `consult-completing-read-multiple'.
(defun bas/crm-indicator (args)
  (cons (concat "[CRM] " (car args)) (cdr args)))
(advice-add #'completing-read-multiple :filter-args #'bas/crm-indicator)

;; Do not allow the cursor in the minibuffer prompt
(setq minibuffer-prompt-properties
      '(read-only t cursor-intangible t face minibuffer-prompt))
(add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

;; Emacs 28: Hide commands in M-x which do not work in the current mode.
;; Vertico commands are hidden in normal buffers.
;; (setq read-extended-command-predicate
;;       #'command-completion-default-include-p)

;; Enable recursive minibuffers
(setq enable-recursive-minibuffers t)

;; short confirm
(fset 'yes-or-no-p 'y-or-n-p)

(provide 'init-bas)
;;; init-bas.el ends here
