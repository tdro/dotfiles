(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/")) ; Set up package.el to work with melpa.

(use-package slime :ensure t)

(custom-set-variables
 '(package-selected-packages '(orderless consult marginalia vertico evil slime))
 '(slime-repl-history-file "~/.cache/slime-history.eld")) ; Set slime history file location.


(set-face-attribute 'menu nil ; Set context menu colors.
                    :background "black"
                    :foreground "white")

(set-face-attribute 'mode-line nil ; Set status bar colors.
                    :background "black"
                    :foreground "white"
                    :box        "white")

(custom-set-faces
 '(region ((t (:background "color-238")))))

(set-face-background 'fringe "color-238") ; Set border color.
(set-default 'truncate-lines t)           ; Disable line wrapping.
(setq inferior-lisp-program "sbcl")       ; Enable slime.
(setq inhibit-startup-screen t)           ; Disable startup screen.
(setq warning-minimum-level :error)       ; Set minimum warning level.
(setq-default indent-tabs-mode nil)       ; Use spaces for indentation.

(menu-bar-mode   -1) ; Disable menu bar.
(tool-bar-mode   -1) ; Disable tool bar.
(tooltip-mode    -1) ; Disable tool tips.
(scroll-bar-mode -1) ; Disable scroll bar.
(set-fringe-mode 10) ; Create space.

(setq backup-directory-alist
      '(("." . "~/.config/emacs/backups")))

(use-package evil :ensure t :config
             (evil-mode 0)) ; Disable evil mode.

(use-package vertico
             :ensure t
             :config
             (setq vertico-cycle t)
             (setq vertico-resize nil)
             (vertico-mode 1))

(use-package marginalia
             :ensure t
             :config
             (marginalia-mode 1))

(use-package orderless
             :ensure t
             :config
             (setq completion-styles '(orderless basic)))

(use-package consult
             :ensure t
             :bind (("M-s M-g" . consult-grep)
                    ("M-s M-f" . consult-find)
                    ("M-s M-o" . consult-outline)
                    ("M-s M-l" . consult-line)
                    ("M-s M-b" . consult-buffer)))
