;;; init-default.el -*- lexical-binding: t -*-

;;;;==============================note==============================
;;; 自动生成文件机制
;; 自动备份 backuops filename~ (一直存在)
;; 自动保存 auto-saving #filename# (执行保存后消失，但还是不太方便)
;; 文件编辑锁 file locks .#filename (emacs 释放文件资源后消失)
;;;;================================================================

;; No backup auto-saving lock files (you should know what will case)
(setq make-backup-files nil
      auto-save-default nil
      create-lockfiles nil
      )

(provide 'init-default)
;;; init-default.el ends here
