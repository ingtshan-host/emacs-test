;;; os-macOS.el -*- lexical-binding: t; no-byte-compile: t; -*-

;; os adapt config here, you should keep the file name same as one of candidates in `os-name' wit prefix `os-' such as `os-macOS.el'

;;;;-----------------------------README-----------------------------
;;  value
(defvar =font-size-int 14
  "Load customize in device/os-macOS.el")
(defvar =en-font-name "Fira Code"
  "Load customize in os-macOS.el")
(defvar =zh-font-name "Glow Sans SC"
  "Load customize in os-macOS.el")
(defconst =test "ok"
  "Load customize in os-macOS.el")
;;;;-----------------------------README-----------------------------
;;  function
(defunit +system-key-adapte()
  ;; set right command key of macOS
  (setq mac-command-modifier
        'hyper mac-option-modifier 'meta))

;;; os-macOS.el ends here
(provide 'os-macOS)
