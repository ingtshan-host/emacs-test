;;; use-interaction-log.el -*- lexical-binding: t -*-

;;;;==============================note==============================
;;  
;;;;================================================================

(leaf interaction-log
  :straight (interaction-log :type git :host github
                             :repo "michael-heerdegen/interaction-log.el")
  :ensure nil
  :require interaction-log)

(provide 'use-interaction-log)
;;; use-interaction-log.el ends here
