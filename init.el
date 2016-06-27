;; -*- ispell-local-dictionary: "en_US" -*-
;; Do not show splash screen.
(setq inhibit-startup-message t)

;; Spell check and out fill in text modes.
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'text-mode-hook 'auto-fill-mode)

;; Special spell check mode for programs.
(add-hook 'prog-mode-hook 'flyspell-prog-mode)

;; Spaces instead of tabs, as tabs are always interpreted differently.
(setq-default indent-tabs-mode nil)

;; Colors in shells. If someone knows how to handle all the other
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

;; Setup of individual graphical frames. No toolbar and no
;; scrollbars. But a nice theme.
(defun init-frame (&optional frame)
  (if window-system
      (progn
        (tool-bar-mode 0)
        (scroll-bar-mode 0)
        (load-theme 'anti-zenburn t))))
(add-hook 'after-make-frame-functions 'init-frame)
(add-hook 'after-init-hook 'init-frame)

;; And no menu-bar. Not even in text mode.
(menu-bar-mode 0)

;; But a clock and a file size indication.
(setq display-time-24hr-format t)
(display-time-mode 1)
(size-indication-mode 1)

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
