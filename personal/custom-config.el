;; custom UI configuration
(prelude-require-packages
 '(
   apropospriate-theme
   color-theme-modern
   wolfram
   )
 )


;;(global-set-key [?\C-c ?l] 'layout-save-current)
;;(global-set-key [?\C-c ?\C-l ?\C-l] 'layout-restore)
;;(global-set-key [?\C-c ?\C-l ?\C-c] 'layout-delete-current)

(setq wolfram-alpha-app-id 'ULKG8W-V7G55YHRQ8)
;; appearance
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode 1)
(setq-default cursor-type 'bar)

;; marking text
(transient-mark-mode t)
(setq select-enable-clipboard t)

;; disable startup message
(setq inhibit-splash-screen t
      initial-scratch-message nil)

;; disable backup files
(setq make-backup-files nil)

;; indention
(setq tab-width 4)
(setq-default fill-column 80)


(setq echo-keystrokes 0.1
      use-dialog-box nil
      visible-bell t)
(show-paren-mode t)

;; sensible undo
(defalias 'redo 'undo-tree-redo)
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "C-S-z") 'redo)


;; Disable guru-mode (I like using arrows :p)
(setq prelude-guru nil)
;; Disable whitespace-mode
(setq prelude-whitespace nil)

(global-set-key (kbd "C-;") 'comment-or-uncomment-region)
(global-set-key (kbd "C-S-k") 'delete-region)
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "M-%") 'query-replace-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)
(global-set-key (kbd "C-M-%") 'query-replace)

(setq imenu-auto-rescan t)
(global-set-key (kbd "C-x TAB") 'imenu)

(put 'upcase-region 'disabled nil)




;; yasnippet
(prelude-require-package 'yasnippet)
(defvar prelude-personal-snippet-dir (expand-file-name "snippets" prelude-personal-dir)
  "The home of Prelude's core functionality.")
(add-to-list 'yas-snippet-dirs prelude-personal-snippet-dir)
(yas-global-mode t)
(define-key yas-minor-mode-map (kbd "C-<tab>") 'yas-expand)
(setq company-yasnippet nil);; must

(defvar prelude-matlab-dir (expand-file-name "vendor/matlab-emacs-src" prelude-dir)
  "The home of Prelude's core functionality.")
(add-to-list 'load-path prelude-matlab-dir)
(require 'matlab-load)
