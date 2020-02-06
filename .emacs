(custom-set-variables
 '(package-selected-packages (quote (evil)))
 '(tool-bar-mode nil))

(custom-set-faces
 )

;; load quicklisp
(load (expand-file-name "~/.config/quicklisp/slime-helper.el"))

;; set lisp to sbcl
(setq inferior-lisp-program "sbcl")

;; disable startup screen
(setq inhibit-startup-screen t)

;; use spaces for indentation
(setq-default indent-tabs-mode nil)

;; Set up package.el to work with MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; enable evil
(require 'evil)
(evil-mode 1)
