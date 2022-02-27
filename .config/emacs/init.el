(custom-set-variables
 '(package-selected-packages '(slime smex evil))
 '(slime-repl-history-file "~/.cache/slime-history.eld")) ; Set slime history file location.

(custom-set-faces
 '(region ((t (:background "color-238")))))

(setq inhibit-startup-screen t)     ; Disable startup screen.
(setq-default indent-tabs-mode nil) ; Use spaces for indentation.
(setq inferior-lisp-program "sbcl") ; Enable slime.


(menu-bar-mode -1)      ; Disable menu bar.
(tool-bar-mode -1)      ; Disable tool bar.
(tooltip-mode -1)       ; Disable tool tips.
(scroll-bar-mode -1)    ; Disable scroll bar.
(set-fringe-mode 10)    ; Create space.
(ido-mode t)            ; Enable file search interactive mode C-x C-f.

(require 'package)                                             ; Set up package.el to work with melpa.
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(unless package-archive-contents (package-refresh-contents))
(package-install-selected-packages)

(evil-mode 1)                                                  ; Enable evil.

(global-set-key (kbd "M-x") 'smex)                             ; Enable smex interactive M-x.
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command) ; Native M-x binding.
