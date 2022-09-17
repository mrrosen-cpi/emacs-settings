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
(setq-default tab-width 4)
(setq-default c-default-style "linux")
(defvaralias 'c-basic-offset 'tab-width)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

(load-theme 'vs-dark t)
(c-set-offset 'innamespace 0)
(c-set-offset 'inlambda 0)
(c-set-offset 'inline-open 0)
(define-globalized-minor-mode global-ruler-mode ruler-mode
  (lambda () (ruler-mode 1)))

(global-ruler-mode 1)

