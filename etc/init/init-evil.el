;;; init-evil.el -*- lexical-binding: t; no-byte-compile: t; -*-

;; evil
;; Emacs的evil模拟器

;; general
;; 提供了类leader键的方法
;; 使用leader键可以减少按Ctrl和Alt等控制键的次数
;; 不依赖于evil，可直接为Emacs配置快捷键

;; evil-surround
;; 类于vim-surround
;; 可以在evil模式下方便地操作匹配的符号

;; evil-exchange
;; 类vim-exchange
;; 可以方便地交换两处字符

;; evil-visualstar
;; 在可视模式中选中了部分文本后可以直接按*和#键搜索对应的内容

;; evil-nerd-commenter
;; 快速进行注释，不依赖于evil
(leaf which-key
  :config
  (which-key-mode))
(leaf general
  :config
  ;; 将<SPC>设为leader键之一
  ;; 与当前编辑模式或编辑无关的通用操作，诸如打开文件、保存文件、切换minor-mode等
  (general-create-definer gaeric-space-leader-def
    :prefix "SPC"
    :states '(normal visual))
  ;; Spaces keybinds for vanilla Emacs
  (gaeric-space-leader-def
    "f"     '(:wk "file operation")
    "ff"    'find-file
    "fo"    'find-file-other-window
    "fs"    '(save-buffer :wk "file save")
    ;;"fed"   'open-init-file
    "b"     '(:wk "buffer operation")
    "bo"    'switch-to-buffer-other-window
    "bw"    '(kill-this-buffer :wk "like H-w but with kill this buffer")
    "bs"    '(consult-buffer :wk "swith to buffer in current window")
    ;;"bc"    '(switch-to-scratch-buffer :wk "*scratch*")
    ;;"bm"    'switch-to-message-buffer

    ;;"w/"    'split-window-right
    ;;"w-"    'split-window-below
    ;;"ad"    'dired
    ;;"tl"    'toggle-truncate-lines
    ;;"tn"    'linum-mode
    ;;"wc"    'count-words
    ;;"nw"    'widen
    "!"     'shell-command
    "n"     '(:wk "note org-roam")
    "nn"    '(org-roam-node-find :wk "node")
    "ni"    '(org-roam-node-insert :wk "insert node")
    "nj"    '(org-roam-dailies-goto-today :wk "jump to today")
    "nr"    '(ns/org-roam-rg-search :wk "rg search your roam note")
    "nf"    '(ns/org-roam-rg-file-search :wk "find roam file")
    )
  ;; 将,键设置为另一个leader
  ;; 与编辑或编辑模式强相关的操作，诸如：org-mode下打开org-pomodoro、org-clock等
  (general-create-definer gaeric-comma-leader-def
    :prefix ","
    :states '(normal visual))
  (gaeric-comma-leader-def
    "c"   '(:wk "copy-paset-killring")
    "cc"  'copy-to-x-clipboard
    "cp"  'paste-from-x-clipboard
    "ck"  'kill-ring-to-clipboard
    ","   'evil-repeat-find-char-reverse)
  )

(leaf evil
  :require evil evil-core evil-common
  :config
  ;; 切换至normal模式时，光标会回退一位（与vim行为保持一致）
  (setq evil-move-cursor-back t)
  (evil-declare-key 'normal org-mode-map
    ;;smarter behaviour on headlines 
    "$" 'org-end-of-line
    "^" 'org-beginning-of-line 
    (kbd "TAB") 'org-cycle);; ditto
  ;;使evil在这些模式下使用指定的模式
  ;;emacs代表emacs默认的编辑模式，而normal则是evil的normal模式
  ;;在某些特定的模式下，并不需要开启evil以编辑文本
  ;; (dolist (p 
  ;;          '((minibuffer-inactive-mode . emacs)
  ;;            ;; (calendar-mode . emacs)
  ;; (special-mode . emacs)
  ;; (grep-mode . emacs)
  ;; (Info-mode . emacs)
  ;; (term-mode . emacs)
  ;; (sdcv-mode . emacs)
  ;; (anaconda-nav-mode . emacs)
  ;; (log-edit-mode . emacs)
  ;; (vc-log-edit-mode . emacs)
  ;; (magit-log-edit-mode . emacs)
  ;; (erc-mode . emacs)
  ;; (neotree-mode . emacs)
  ;; (w3m-mode . emacs)
  ;; (gud-mode . emacs)
  ;; (help-mode . emacs)
  ;; (eshell-mode . emacs)
  ;; (shell-mode . emacs)
  ;; (xref--xref-buffer-mode . emacs)
  ;; (message-mode . emacs)
  ;; (epa-key-list-mode . emacs)
  ;; (fundamental-mode . emacs)
  ;; (weibo-timeline-mode . emacs)
  ;; (weibo-post-mode . emacs)
  ;; (woman-mode . emacs)
  ;; (sr-mode . emacs)
  ;; (profiler-report-mode . emacs)
  ;; (dired-mode . emacs)
  ;; (compilation-mode . emacs)
  ;; (speedbar-mode . emacs)
  ;; (ivy-occur-mode . emacs)
  ;; (ffip-file-mode . emacs)
  ;; (ivy-occur-grep-mode . normal)
  ;; (messages-buffer-mode . normal)
  ;; (js2-error-buffer-mode . emacs)
  ;; ))
  ;;   (evil-set-initial-state (car p) (cdr p)))
  ;; ;; Prefer Emacs way after pressing ":" in evil-mode
  ;; (define-key evil-ex-completion-map (kbd "C-a") 'move-beginning-of-line)
  ;; (define-key evil-ex-completion-map (kbd "C-b") 'backward-char)
  ;; (define-key evil-ex-completion-map (kbd "M-p") 'previous-complete-history-element)
  ;; (define-key evil-ex-completion-map (kbd "M-n") 'next-complete-history-element)
  ;; ;;   ;;Change cursor color depending on mode
  ;;   ;; (setq evil-emacs-state-cursor '("red" box))
  ;;   ;; (setq evil-normal-state-cursor '("green" box))
  ;;   ;; (setq evil-visual-state-cursor '("orange" box))
  ;;   ;; (setq evil-insert-state-cursor '("red" bar))
  ;;   ;; (setq evil-replace-state-cursor '("red" bar))
  ;;   ;; (setq evil-operator-state-cursor '("red" hollow))
  ;;   ;; (setq evil-emacs-state-cursor '("white" box))
  ;;   (setq evil-normal-state-cursor '("blue" box))
  ;;   (setq evil-visual-state-cursor '("gray" box))
  ;;   ;; (setq evil-insert-state-cursor '("white" box))
  ;;   (setq evil-replace-state-cursor '("red" box))
  ;;   (setq evil-operator-state-cursor '("red" hollow))
  ;; mevil
  ;; remove all keybindings from insert-state keymap
  (setcdr evil-insert-state-map nil)
  ;; but [escape] should switch back to normal state
  (define-key evil-insert-state-map [escape] 'evil-normal-state)
  ;; (define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
  ;; (define-key evil-normal-state-map (kbd "[ m") 'beginning-of-defun)
  ;; (define-key evil-normal-state-map (kbd "] m") 'end-of-defun)
  ;; (define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)
  ;; (define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
  ;; (setq evil-jumps-cross-buffers nil) ;; for C-o and C-i to not cross buffers
  
  (evil-mode 1));; end of leaf evil

(provide 'init-evil)
;;; init-evil.el ends here
