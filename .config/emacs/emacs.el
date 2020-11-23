(custom-set-variables
 '(package-selected-packages (quote (evil)))
 '(tool-bar-mode nil))

(custom-set-faces
 '(region ((t (:background "color-238")))))

;; disable startup screen
(setq inhibit-startup-screen t)

;; disable menu bar
(menu-bar-mode -1)

;; use spaces for indentation
(setq-default indent-tabs-mode nil)

;; set up package.el to work with melpa
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; enable slime
(setq inferior-lisp-program "sbcl")
(unless (package-installed-p 'slime)
  (package-install 'slime))

;; enable evil
(unless (package-installed-p 'evil)
  (package-install 'evil))
(require 'evil)
(evil-mode 1)
