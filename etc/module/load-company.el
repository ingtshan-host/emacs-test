;;; load-company.el -*- lexical-binding: t -*-

;;;;==============================note==============================
;;
;;;;================================================================

;; `company'
(leaf company
  :diminish company-mode
  :hook
  (after-init-hook . global-company-mode)
  :custom
  (company-tooltip-align-annotations . t)
  (company-tooltip-limit . 12)
  (company-idle-delay . 0)
  (company-echo-delay . 0)
  (company-minimum-prefix-length . 3)
  (company-require-match . nil)
  (company-dabbrev-ignore-case . nil)
  (company-show-numbers . t)
  (company-dabbrev-downcase . nil)
  (company-global-modes . '(not
                            erc-mode message-mode help-mode
                            gud-mode eshell-mode shell-mode))
  (company-backends . '(company-capf company-files))
  (company-frontends . '(company-pseudo-tooltip-frontend
                         company-echo-metadata-frontend))
  :bind
  (("M-/" . company-yasnippet)
   (:company-active-map
    ("C-p" . company-select-previous)
    ("C-n" . company-select-next)
    ("<tab>" . company-complete-common-or-cycle)
    ("<C-return>". company-complete-selection))
   (:company-search-map
    ("C-p" . company-select-previous)
    ("C-n" . company-select-next)))
  :config
  (leaf company-quickhelp
    :hook (global-company-mode-hook . company-quickhelp-mode)
    :custom (company-quickhelp-delay . 0.5)))

;; `yasnippet'
(leaf yasnippet
  :diminish (yas-minor-mode)
  :hook (after-init-hook . yas-global-mode)
  :bind ("C-c y" . yas-visit-snippet-file)
  :config (leaf yasnippet-snippets))
;;------------------------------------------------------------------
;;; load-company.el ends
(provide 'load-company)
