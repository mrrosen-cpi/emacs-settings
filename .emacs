(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(global-set-key [?\C-f] 'isearch-forward)
(define-key isearch-mode-map "\C-f" 'isearch-repeat-forward)

(global-set-key (kbd "C-c C-g") 'goto-line)
(global-set-key (kbd "C-c C-r") 'replace-string)
(global-set-key (kbd "C-c C-t") 'delete-trailing-whitespace)

(setq-default scroll-step 4)
(setq-default indent-tabs-mode nil)
(setq-default show-trailing-whitespace t)
(setq-default tab-width 4)
(setq-default c-default-style "linux")
(defvaralias 'c-basic-offset 'tab-width)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

(load-theme 'vs-dark t)
(c-set-offset 'innamespace 0)
(c-set-offset 'inlambda 0)
(c-set-offset 'inline-open 0)
(c-set-offset 'inextern-lang 0)
(define-globalized-minor-mode global-ruler-mode ruler-mode
  (lambda () (ruler-mode 1)))

(global-ruler-mode 1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(dts-mode cmake-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(add-to-list 'auto-mode-alist '("\\.overlay\\'" . dts-mode))
