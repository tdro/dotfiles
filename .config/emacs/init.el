(custom-set-variables
 '(package-selected-packages (quote (evil)))
 '(slime-repl-history-file "~/.cache/slime-history.eld")) ; Set slime history file location.

(custom-set-faces
 '(region ((t (:background "color-238")))))

(setq inhibit-startup-screen t) ; Disable startup screen.
(setq-default indent-tabs-mode nil) ; Use spaces for indentation.

(menu-bar-mode -1)   ; Disable menu bar.
(tool-bar-mode -1)   ; Disable tool bar.
(tooltip-mode -1)    ; Disable tool tips.
(scroll-bar-mode -1) ; Disable scroll bar.
(set-fringe-mode 10) ; Create space.

(require 'package) ; Set up package.el to work with melpa.
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(setq inferior-lisp-program "sbcl") ; Enable slime.
(unless (package-installed-p 'slime)
  (package-install 'slime))

(unless (package-installed-p 'evil) ; Enable evil.
  (package-install 'evil))
(require 'evil)
(evil-mode 1)
