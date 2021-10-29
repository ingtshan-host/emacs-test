;;; use-nlinum-relative.el -*- lexical-binding: t; no-byte-compile: t; -*-

;; 开启相对行号
(leaf nlinum-relative 
  :hook ((prog-mode-hook . nlinum-relative-mode))
  :config 
  (nlinum-relative-setup-evil))


(provide 'use-nlinum-relative)
;;; use-nlinum-relative.el ends here
