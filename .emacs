;; Setup straight.el
(setq package-enable-at-startup nil)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
    (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)

;; Fix temporary file placement
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Add custom key bindings
(global-set-key [?\C-f] 'isearch-forward)
(define-key isearch-mode-map "\C-f" 'isearch-repeat-forward)

(global-set-key (kbd "C-c C-g") 'goto-line)
(global-set-key (kbd "C-c C-r") 'replace-string)
(global-set-key (kbd "C-c C-t") 'delete-trailing-whitespace)
(global-set-key (kbd "C-c C-w") 'delete-whitespace-rectangle)
(global-set-key (kbd "C-c C-d") 'redraw-display)

;; Custom style
(setq-default fill-column 90)
(setq-default scroll-step 4)
(setq-default indent-tabs-mode nil)
(setq-default show-trailing-whitespace t)
(setq-default tab-width 4)
(setq-default c-default-style "linux")
(defvaralias 'c-basic-offset 'tab-width)

(setq-default cmake-tab-width tab-width)

;; Theme path
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

;; Setup git commit editing
(add-to-list 'auto-mode-alist '("/COMMIT_EDITMSG" . git-commit-mode))
(define-generic-mode git-commit-mode
  ()
  ()
  ()
  ()
  ()
  "Git commit-editting minor mode")
(add-hook 'git-commit-mode-hook (lambda () (set-fill-column 67)))

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
(put 'narrow-to-region 'disabled nil)

;; default hexl-mode for bin/elf/img files
(add-to-list 'auto-mode-alist '("\\.\\(bin\\|elf\\|img\\)\\'" . hexl-mode))

;; Copilot
(use-package copilot
             :straight (:host github :repo "zerolfx/copilot.el" :files ("dist" "*.el"))
             :ensure t)
(add-hook 'prog-mode-hook 'copilot-mode)
(define-key copilot-completion-map (kbd "<tab>") 'copilot-accept-completion)
(define-key copilot-completion-map (kbd "TAB") 'copilot-accept-completion)

;; Kconfig
;;; kconfig.el - a major mode for editing linux kernel config (Kconfig) files
;; Copyright © 2014 Yu Peng
;; Copyright © 2014 Michal Sojka

(defvar kconfig-mode-font-lock-keywords
  '(("^[\t, ]*\\_<bool\\_>" . font-lock-type-face)
    ("^[\t, ]*\\_<int\\_>" . font-lock-type-face)
    ("^[\t, ]*\\_<boolean\\_>" . font-lock-type-face)
    ("^[\t, ]*\\_<tristate\\_>" . font-lock-type-face)
    ("^[\t, ]*\\_<depends on\\_>" . font-lock-variable-name-face)
    ("^[\t, ]*\\_<select\\_>" . font-lock-variable-name-face)
    ("^[\t, ]*\\_<help\\_>" . font-lock-variable-name-face)
    ("^[\t, ]*\\_<---help---\\_>" . font-lock-variable-name-face)
    ("^[\t, ]*\\_<default\\_>" . font-lock-variable-name-face)
    ("^[\t, ]*\\_<range\\_>" . font-lock-variable-name-face)
    ("^\\_<config\\_>" . font-lock-constant-face)
    ("^\\_<comment\\_>" . font-lock-constant-face)
    ("^\\_<menu\\_>" . font-lock-constant-face)
    ("^\\_<endmenu\\_>" . font-lock-constant-face)
    ("^\\_<if\\_>" . font-lock-constant-face)
    ("^\\_<endif\\_>" . font-lock-constant-face)
    ("^\\_<menuconfig\\_>" . font-lock-constant-face)
    ("^\\_<source\\_>" . font-lock-keyword-face)
    ("\#.*" . font-lock-comment-face)
    ("\".*\"$" . font-lock-string-face)))

(defvar kconfig-headings
  '("bool" "int" "boolean" "tristate" "depends on" "select"
    "help" "---help---" "default" "range" "config" "comment"
    "menu" "endmenu" "if" "endif" "menuconfig" "source"))

(defun kconfig-outline-level ()
  (looking-at "[\t ]*")
  (let ((prefix (match-string 0))
        (result 0))
    (dotimes (i (length prefix) result)
      (setq result (+ result
                      (if (equal (elt prefix i) ?\s)
                          1 tab-width))))))

(define-derived-mode kconfig-mode text-mode
  "kconfig"
  (set (make-local-variable 'font-lock-defaults)
       '(kconfig-mode-font-lock-keywords t))
  (set (make-local-variable 'outline-regexp)
       (concat "^[\t ]*" (regexp-opt kconfig-headings)))
  (set (make-local-variable 'outline-level)
       'kconfig-outline-level))

(add-to-list 'auto-mode-alist '("Kconfig" . kconfig-mode))
