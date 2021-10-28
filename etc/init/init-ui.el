;;; init-ui.el -*- lexical-binding: t; no-byte-compile: t; -*-

;;;  界面美化
;;;  交互优化

;;;;-----------------------------README-----------------------------
;;  ui tool fun
(defun ui/stop-using-minibuffer ()
  "kill the minibuffer"
  (when (and (>= (recursion-depth) 1)
	         (active-minibuffer-window))
    (abort-recursive-edit)))
;;;;-----------------------------README-----------------------------
;;  ui default set

(setq fill-column 88)
(global-visual-line-mode t)    ; visual-line-mode

(leaf nlinum
  :hook ((org-mode-hook . nlinum-mode)
         (prog-mode-hook . nlinum-mode))
  :config
  ;; fix hl
  (leaf nlinum-hl :require t)
  (require 'nlinum-hl)
  (setq nlinum-highlight-current-line t)
  (defconst my-nlinum-format-function
    (lambda (line width)
      (let* ((is-current-line (= line nlinum--current-line))
             (str (format nlinum-format line)))
        ;; use -> as current line
        ;; or change to any symbol you like
        ;; here
        ;; (and is-current-line (setq str "->"))
        (when is-current-line
          (let* ((ms "->")
                 (el (- (length str) 2)))
            (while (> el 0)
              (setq ms (concat "-" ms))
              (setq el (1- el)))
            (setq str ms)))
        (when (< (length str) width)
          ;; Left pad to try and right-align the line-numbers.
          (setq str (concat (make-string (- width (length str)) ?\ ) str)))
        
        (put-text-property 0 width 'face
                           (if (and nlinum-highlight-current-line
                                    is-current-line)
                               'nlinum-current-line
                             'linum)
                           str)
        str)))
  ;;take effect
  (setq nlinum-format-function my-nlinum-format-function))
;;;;-----------------------------README-----------------------------
;;  font and thems
;;; font
;; (defunit +set-font (height en-font en-rescale zh-font zh-rescale)
;;   ;; 若未设置英文字体，只启用中文字体
;;   (unless en-font
;;     (when zh-font
;;       (set-face-attribute
;;        'default nil
;;        :font zh-font
;;        :weight 'normal
;;        :width 'normal
;;        :height height)))
;;   ;; 设置中英文字体
;;   (when en-font
;;     (set-face-attribute
;;      'default nil
;;      :font en-font
;;      :weight 'normal
;;      :width 'normal
;;      :height height)
;;     (when zh-font
;;       (dolist (charset '(kana han symbol cjk-misc bopomofo))
;;         (set-fontset-font (frame-parameter nil 'font)
;; 		                  charset
;; 		                  (font-spec :family zh-font)))
;;       ;; (setq face-font-rescale-alist
;;       ;;       (list `(,en-font . ,en-rescale)
;;       ;;             `(,zh-font . ,zh-rescale)))
;;       )))
;; (fmakunbound '+set-font)
;; (callunit +set-font t 160 =en-font-name 1.3 =zh-font-name 0.9)
;; (leaf cnfonts)

(defunit +set-fonts (en-font en-size zh-font rescale)
  (set-face-attribute
   'default nil
   :font (font-spec  :family en-font
                     :weight 'normal
                     :slant 'normal
                     :size en-size
                     ))
  (dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font
     (frame-parameter nil 'font)
     charset
     (font-spec :family zh-font
                :weight 'normal
                :slant 'normal
                ;; :size zh-size 在这里设置会影响缩放
                )))
  (setq face-font-rescale-alist
        (list `(,en-font . 1) `(,zh-font . ,rescale)))
  )
(callunit +set-fonts nil =en-font-name 16.5 =zh-font-name 1.1)

;;; themes
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
       (lambda (&rest _) (browse-url =nviem-url)))
      (,(if (fboundp 'all-the-icons-octicon)
	        (all-the-icons-octicon
	         "heart"
	         :height 1.1 :v-adjust  0.0) "♥")
       "Stars" "Show stars"
       (lambda (&rest _) (browse-url =nviem-stars-url)))
      (,(if (fboundp 'all-the-icons-material)
	        (all-the-icons-material
	         "report_problem"
	         :height 1.1 :v-adjust -0.2) "⚑")
       "Issue" "Report issue"
       (lambda (&rest _) (browse-url =nviem-issue-url)) warning)
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

;;;;-----------------------------README-----------------------------
;;  user-emacs interaction

(require 'load-search-a-completion)
(require 'load-company)

;; kill minibuffer while unfocus
(add-hook 'mouse-leave-buffer-hook 'ui/stop-using-minibuffer)

;; better window switch
(leaf switch-window
  :bind (("C-x o" . switch-window) 
         ("C-x 1" . switch-window-then-maximize) 
         ("C-x 2" . switch-window-then-split-below) 
         ("C-x 3" . switch-window-then-split-right) 
         ("C-x 0" . switch-window-then-delete) 
         ("C-x 4 d" . switch-window-then-dired) 
         ("C-x 4 f" . switch-window-then-find-file) 
         ("C-x 4 m" . switch-window-then-compose-mail) 
         ("C-x 4 r" . switch-window-then-find-file-read-only) 
         ("C-x 4 C-o" . switch-window-then-display-buffer)
         ;; 两个窗口时保留当前
         ;; 多个窗口选择一个 kill
         ;; but I prefer my H-w
         ("C-x 4 0" . switch-window-then-kill-buffer))
  :setq ((switch-window-shortcut-style . 'qwerty)
         (switch-window-multiple-frames . t)))
;;;;-----------------------------README-----------------------------
;;  Chinese
;; 解决中英混输表格对齐问题
(leaf valign
  :hook ((org-mode-hook . valign-mode)))
;; 手动安装词库
;; 词库文件的编码必须为 utf-8-unix
(let ((a "var/pyim-dicts/pyim/chengyusuyu-guanfangtuijian.pyim")
      (b "var/pyim-dicts/pyim/shuxuecihuidaquan-guanfangtuijian.pyim")
      (c "var/pyim-dicts/pyim/shuxuezhuanyongcihui.pyim")
      (d "var/pyim-dicts/pyim/xinlixuecihuidaquan-guanfangtuijian.pyim")
      (e "var/pyim-dicts/pyim/jisuanjicihuidaquan-guanfangtuijian.pyim")
      (f "var/pyim-dicts/pyim/kaifadashenzhuanyongciku-guanfangtuijian.pyim"))
  (setq
   pyim-dicts
   (list `(:name
           "成语俗语"
           :file ,(expand-file-name a user-emacs-directory))
         `(:name
           "数学词汇大全"
           :file ,(expand-file-name b user-emacs-directory))
         `(:name
           "数学专用词汇"
           :file ,(expand-file-name c user-emacs-directory))
         `(:name
           "心理学词汇大全"
           :file ,(expand-file-name d user-emacs-directory))
         `(:name
           "计算机词汇大全"
           :file ,(expand-file-name e user-emacs-directory))
         `(:name
           "开发大神专用词库"
           :file ,(expand-file-name f user-emacs-directory)))))
;; 中文输入法
(leaf pyim
  :config
  (setq default-input-method "pyim")
  ;; 金手指设置，可以将光标处的编码，比如：拼音字符串，转换为中文。
  (global-set-key (kbd "H-j") 'pyim-convert-string-at-point)
  ;; 按 "C-<return>" 将光标前的 regexp 转换为可以搜索中文的 regexp.
  (define-key minibuffer-local-map (kbd "C-<return>") 'pyim-cregexp-convert-at-point)
  ;; pyim 探针设置
  ;; 设置 pyim 探针设置，这是 pyim 高级功能设置，可以实现 *无痛* 中英文切换 :-)
  ;; 我自己使用的中英文动态切换规则是：
  ;; 1. 光标只有在注释里面时，才可以输入中文。
  ;; 2. 光标前是汉字字符时，才能输入中文。
  ;; 3. 使用 H-j 快捷键，强制将光标前的拼音字符串转换为中文。
  (setq-default pyim-english-input-switch-functions
                '(pyim-probe-dynamic-english
                  ;;pyim-probe-isearch-mode
                  pyim-probe-program-mode
                  pyim-probe-org-structure-template
                  ))
  (setq-default pyim-punctuation-half-width-functions
                '(pyim-probe-punctuation-line-beginning
                  pyim-probe-punctuation-after-punctuation))
  ;; 我使用全拼
  (pyim-default-scheme 'quanpin)
  ;; 开启代码搜索中文功能（比如拼音，五笔码等）
  ;; (pyim-isearch-mode 1)
  ;; 设置选词框的绘制方式
  (if (posframe-workable-p)
      (setq pyim-page-tooltip 'posframe)
    (setq pyim-page-tooltip 'popup))
  ;; 显示5个候选词
  (setq pyim-page-length 5)
  ;; Basedict 词库
  (leaf pyim-basedict
    :require pyim
    :config
    ;; 启用基本词库
    (pyim-basedict-enable)))
;; Emacs 启动时加载 pyim 词库
(add-hook 'emacs-startup-hook
          (lambda () (pyim-restart-1 t)))
;; https://emacs-china.org/t/straight-ivy-helm-selectrum/11523/81
;; 对 orderless 增加拼音搜索功能
;; need pyim support
(defun eh-orderless-regexp (orig_func component)
  (let ((result (funcall orig_func component)))
    (pyim-cregexp-build result)))
;; (advice-add 'orderless-regexp :around #'eh-orderless-regexp)
;;;;-------------------------------END------------------------------
(provide 'init-ui)
;;; init-ui.el ends her
