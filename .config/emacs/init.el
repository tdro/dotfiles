;;; Garbage collection threshold

(defun restore-gc-cons-threshold ()
  (setq gc-cons-threshold (* 16 1024 1024)
        gc-cons-percentage 0.1))

(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)
(add-hook 'emacs-startup-hook #'restore-gc-cons-threshold 105)

;;; -----------------------------------------------------------

;;; Colors

(when (display-graphic-p) ; Graphical mode.
  (set-face-background 'fringe "#2c303c")                                                        ; Set border color.
  (set-face-attribute  'menu                    nil :foreground "#000000" :background "#ffffff") ; Set context menu colors.
  (set-face-attribute  'completions-annotations nil :foreground "#bfbfbf" :underline nil)        ; Set M-x menu descriptions.
  (set-face-attribute  'highlight               nil :background "#353b48")
  (set-face-attribute  'link                    nil :foreground "#86c5f9")
  (set-face-attribute  'link-visited            nil :foreground "#f3a5f3")
  (set-face-attribute  'minibuffer-prompt       nil :foreground "#ffffff")
  (set-face-attribute  'mode-line               nil :background "#000000" :foreground "#ffffff" :background "#515560" :box "#777777") ; Set status bar colors.
  (set-face-attribute  'mode-line-inactive      nil :background "#000000" :foreground "#ffffff" :background "#515560" :box "#777777")
  (set-face-attribute  'font-lock-keyword-face  nil :foreground "#fffff")
  (set-face-attribute  'region                  nil :background "#2c303c")
  (custom-set-faces
   '(ansi-color-blue            ((t (:background "#adbcfb" :foreground "#adbcfb"))))
   '(ansi-color-green           ((t (:background "#79d279" :foreground "#79d279"))))
   '(ansi-color-bright-blue     ((t (:background "#86c5f9" :foreground "#86c5f9"))))
   '(ansi-color-bright-cyan     ((t (:background "#76ffff" :foreground "#76ffff"))))
   '(ansi-color-bright-green    ((t (:background "#cde2a7" :foreground "#cde2a7"))))
   '(ansi-color-bright-magenta  ((t (:background "#ff99ff" :foreground "#ff99ff"))))
   '(ansi-color-bright-red      ((t (:background "#ff7474" :foreground "#ff7474"))))
   '(ansi-color-bright-yellow   ((t (:background "#fff070" :foreground "#fff070"))))
   '(ansi-color-italic          ((t (:inherit nil))))
   '(line-number-major-tick     ((t (:background "#bfbfbf" :foreground "#303030" :weight bold))))
   '(line-number-minor-tick     ((t (:background "#969696" :foreground "#000000" :weight bold))))
   '(custom-button              ((t (:box (:line-width (2 . 2) :style released-button) :foreground "#ffffff" :background "#515560"))))
   '(lazy-highlight             ((t (:background "#d7d787" :foreground "#000000" :weight medium))))
   '(isearch                    ((t (:background "#ffc136" :foreground "#361411" :weight medium))))
   '(isearch-group-1            ((t (:background "#ff82ab" :foreground "#361411"))))
   '(isearch-group-2            ((t (:background "#d47d9a" :foreground "#000000"))))
   '(italic                     ((t (:inherit nil))))
   '(Info-quoted                ((t (:inherit mono))))
   '(font-lock-constant-face    ((t (:foreground "#cbff8e"))))
   '(font-lock-comment-face     ((t (:foreground "#cccccc"))))
   '(font-lock-string-face      ((t (:foreground "#ffd980"))))
   '(window-divider             ((t (:foreground "#777777"))))
   '(window-divider-last-pixel  ((t (:foreground "#777777"))))
   '(window-divider-first-pixel ((t (:foreground "#777777"))))
   '(org-checkbox               ((t (:weight normal))))
   '(org-block                  ((t (:foreground "#eeeeee" :extend t :inherit shadow))))
   '(org-block-begin-line       ((t (:box (:line-width (1 . 10) :color "#2c303c" :style flat) :extend t :inherit shadow))))
   '(org-block-end-line         ((t (:box (:line-width (1 . 10) :color "#2c303c" :style flat) :extend t :inherit shadow))))
   '(outline-1                  ((t (:foreground "#cccccc" :height 1.5 :weight bold))))
   '(outline-2                  ((t (:foreground "#cccccc" :height 1.3 :weight bold))))
   '(outline-3                  ((t (:foreground "#cccccc" :height 1.1 :weight bold))))
   '(outline-4                  ((t (:extend nil :inherit outline-3))))
   '(outline-5                  ((t (:extend nil :inherit outline-3))))
   '(outline-6                  ((t (:extend nil :inherit outline-3))))
   '(outline-7                  ((t (:extend nil :inherit outline-3))))
   '(outline-8                  ((t (:extend nil :inherit outline-3))))
   '(orderless-match-face-0     ((t (:foreground "#9ec0ff" :weight bold))))))

(when (not (display-graphic-p)) ; Terminal mode.
  (set-face-attribute 'completions-annotations nil :italic nil) ; Set M-x menu descriptions.
  (set-face-attribute 'font-lock-keyword-face  nil :foreground "color-255")
  (set-face-attribute 'minibuffer-prompt       nil :foreground "color-255")
  (set-face-attribute 'highlight               nil :background "color-237")
  (set-face-attribute 'mode-line               nil :background "none" :foreground "color-255" :box "color-255")
  (set-face-attribute 'mode-line-inactive      nil :background "none" :foreground "color-255" :box "color-255") ; Set status bar colors.
  (custom-set-faces
   '(font-lock-comment-face ((t (:foreground "color-251"))))
   '(org-block              ((t (:foreground "color-255" :extend t :inherit shadow))))
   '(org-block-begin-line   ((t (:extend t :inherit shadow))))
   '(org-block-end-line     ((t (:extend t :inherit shadow))))))

(custom-set-faces)

;;; -----------------------------------------------------------

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/")) ; Set up package.el to work with melpa.

(set-default 'truncate-lines t)           ; Disable line wrapping.
(setq inferior-lisp-program "sbcl")       ; Enable slime.
(setq inhibit-startup-screen t)           ; Disable startup screen.
(setq warning-minimum-level :error)       ; Set minimum warning level.
(setq initial-scratch-message "")         ; Remove scratch buffer message.
(setq-default indent-tabs-mode nil)       ; Use spaces for indentation.
(setq-default fringe-indicator-alist nil) ; Truncation indicator list.

(window-divider-mode 1) ; Enable window dividers.
(menu-bar-mode      -1) ; Disable menu bar.
(tool-bar-mode      -1) ; Disable tool bar.
(tooltip-mode       -1) ; Disable tool tips.
(scroll-bar-mode    -1) ; Disable scroll bar.
(set-fringe-mode    20) ; Create space.

(setq backup-directory-alist         '(("." . "~/.config/emacs/backups")))
(setq auto-save-file-name-transforms '((".*" "~/.config/emacs/autosaves/" t)))

(use-package slime :ensure t
             :config
             (custom-set-variables
              '(slime-repl-history-file "~/.cache/slime-history.eld"))) ; Set slime history file location.

(use-package olivetti :ensure t)

(use-package org :ensure t
             :config
             (add-hook 'org-mode-hook 'olivetti-mode)     ; Set pretty width
             (add-hook 'org-mode-hook 'visual-line-mode)) ; Wrap lines

(use-package evil
             :ensure t
             :config
             (evil-mode 0)) ; Disable evil mode.

;;; Source: https://protesilaos.com/codelog/2024-02-17-emacs-modern-minibuffer-packages/

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

(use-package dired
             :ensure nil
             :commands (dired)
             :config
             (setq dired-recursive-copies 'always)
             (setq dired-recursive-deletes 'always)
             (setq delete-by-moving-to-trash t)
             (setq dired-dwim-target t)
             (setq dired-listing-switches "-Sahl --group-directories-first") ; Pass options to `ls` command.

             (defun dired-find-directory ()
               "Traverse directories only"
               (interactive)
               (if (dired-get-file-for-visit)
                   (let ((file (dired-get-file-for-visit)))
                     (if (file-directory-p file)
                         (dired-find-file)))))

             (defun dired-duplicate-file ()
               "Duplicate files in one action"
               (interactive)
               (let* ((file (dired-get-file-for-visit))
                      (timestamp (string-replace "." "" (number-to-string (float-time))))
                      (copy (concat (file-name-sans-extension file) "." timestamp)))
                 (copy-file file copy)
                 (dired-add-file copy)))

             (defun dired-toggle-editable ()
               "Move to the end of line before toggling"
               (interactive)
               (end-of-line)
               (dired-toggle-read-only))

             (defun vim-evil-dired () ; Vim directory integration
               (define-key dired-mode-map "i" 'dired-toggle-editable)
               (define-key dired-mode-map "p" 'dired-duplicate-file)
               (define-key dired-mode-map "h" 'dired-up-directory)
               (define-key dired-mode-map "j" 'dired-next-line)
               (define-key dired-mode-map "k" 'dired-previous-line)
               (define-key dired-mode-map "l" 'dired-find-directory)))
