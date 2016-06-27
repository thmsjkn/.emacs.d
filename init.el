;; Splash Screen nicht anzeigen
(setq inhibit-startup-message t)

;; Rechtschreibung und Zeilenumbrüche in allen Texten wie org- oder
;; txt-Dateien
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'text-mode-hook 'auto-fill-mode)

;; Rechtschreibung von Kommentare und Strings in allen Programmen
;; prüfen
(add-hook 'prog-mode-hook 'flyspell-prog-mode)

;; Tabs nur mit Leerzeichen
(setq-default indent-tabs-mode nil)

;; Kolorierte Shell
(require 'ansi-color)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(add-to-list 'comint-output-filter-functions
             'ansi-color-process-output)

;; Server starten
(require 'server)
(unless (server-running-p)
  (server-start))

;; MELPA Packages
;;  - Package einrichten
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)

;;  - Use-package zum Laden der MELPA-Packages einrichten, so dass nur
;;    neues geladen wird.
(defun package-check-and-install (package-name)
  "Install a package only if the package is not already installed"
  (interactive)
  (if (not (package-installed-p package-name))
    (progn
      (package-refresh-contents)
      (package-install package-name))))
(package-check-and-install 'use-package)
(require 'use-package)

;;  - Die eigentlichen Pakete installieren
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
