;; -*- ispell-local-dictionary: "en_us" -*-
;; do not show splash screen.
(setq inhibit-startup-message t)

;; spaces instead of tabs, as tabs are always interpreted differently.
(setq-default indent-tabs-mode nil)

;; colors in shells. if someone knows how to handle all the other
;; fancy control characters, please let me know.
(require 'ansi-color)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(add-to-list 'comint-output-filter-functions
             'ansi-color-process-output)

;; Start emacs server.
(require 'server)
(unless (server-running-p)
  (server-start))

;; MELPA packages:
;;  - package configuration
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)

;;  - load and install new
(defun package-check-and-install (package-name)
  "Install a package only if the package is not already installed"
  (interactive)
  (if (not (package-installed-p package-name))
    (progn
      (package-refresh-contents)
      (package-install package-name))))
(package-check-and-install 'use-package)
(require 'use-package)

;;  - do load the package
(package-check-and-install 'abyss-theme)
(package-check-and-install 'zenburn-theme)
(package-check-and-install 'anti-zenburn-theme)
(package-check-and-install 'dracula-theme)
(package-check-and-install 'hl-anything)
(package-check-and-install 'highlight-symbol)

(use-package markdown-mode
  :ensure markdown-mode)
(use-package semantic
  :ensure semantic)
(use-package magit
  :ensure magit
  :bind ("C-x g" . magit-status))
(use-package auto-complete
  :ensure auto-complete
  :bind ("<C-tab>" . auto-complete))
(ac-config-default)

;; Spell check and out fill in text modes.
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'text-mode-hook 'auto-fill-mode)
; (add-hook 'text-mode-hook 'hl-line-mode)

;; Special spell check mode for programs.
(add-hook 'prog-mode-hook 'flyspell-prog-mode)
; (add-hook 'prog-mode-hook 'hl-line-mode)
(add-hook 'prog-mode-hook 'hl-paren-mode)
(add-hook 'prog-mode-hook 'highlight-symbol-mode)

;; Load some local packages
(defun add-to-load-path-eventually (path &optional append symbol)
  (if (file-exists-p path)
      (progn
        (add-to-list 'load-path path append)
        (if (and symbol (symbolp symbol))
            (require symbol)))))

(let ((add-this-to-load-path
       '("~/Workspace/org-mode/lisp" nil org
         "~/Workspace/org-mode/contrib/lisp" t nil
         "~/Workspace/org-reveal" nil ox-reveal)))
  (while
      (progn
        (add-to-load-path-eventually (pop add-this-to-load-path)
                                     (pop add-this-to-load-path)
                                     (pop add-this-to-load-path))
        add-this-to-load-path)))

;; Path to reveal.js to use by ox-reveal
(let ((reveal-js-path (concat (getenv "HOME") "/Workspace/reveal.js")))
  (if (file-exists-p reveal-js-path)
      (setq org-reveal-root (concat "file://" reveal-js-path))))


;; Setup of individual graphical frames. No toolbar and no
;; scrollbars. But a nice theme.
(defun init-frame (&optional frame)
  (if window-system
      (progn
        (tool-bar-mode 0)
        (scroll-bar-mode 0)
        (load-theme 'leuven t))))
(add-hook 'after-make-frame-functions 'init-frame)
(add-hook 'after-init-hook 'init-frame)
(set-default-font "Inconsolata")

;; And no menu-bar. Not even in text mode.
(menu-bar-mode 0)

;; But a clock and a file size indication.
(setq display-time-24hr-format t)
(display-time-mode 1)
(size-indication-mode 1)

;; use aspell
(setq ispell-program-name "aspell"
      ispell-dictionary   "de_DE")

;; Mac key bindings and spell checker
(if (string-equal system-type "darwin")
    (progn
      (setq ns-command-modifier 'meta
            ns-right-command-modifier 'control
            ns-option-modifier nil
            exec-path (append exec-path '("/usr/local/bin"))
            ispell-dictionary "de_DE")))

;; Local settings, like passwords, usernames and that like can go in
;; ~/.emacs.d/init.el:
;;
;;    (setq user-full-name "Dein Name")
;;    (setq user-mail-address "info@example.com")
;;    (setq send-mail-function 'sendmail-send-it)
;;
(setq init-site-file "~/.emacs.d/site.el")
(if (file-exists-p init-site-file)
    (load-file init-site-file))
