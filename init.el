; Keine Menüs oder Tools anzeigen, dafür aber eine Uhr
(menu-bar-mode 0)
(tool-bar-mode 0)
(display-time-mode 1)

;; Splash Screen nicht anzeigen
(setq inhibit-startup-message t)

;; Rechtschreibung in allen Texten wie org- oder txt-Dateien
(add-hook 'text-mode-hook 'flyspell-mode)

;; Rechtschreibung von Kommentare und Strings in allen Programmen
;; prüfen
(add-hook 'prog-mode-hook 'flyspell-prog-mode)

;; Tabs nur mit Leerzeichen
(setq-default indent-tabs-mode nil)

;; Kolorierte Shell
(require 'ansi-color)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(add-to-list 'comint-output-filter-functions 'ansi-color-process-output)

;; Server starten
(require 'server)
(unless (server-running-p)
  (server-start))

;; Melpa Packages
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)

(if (not (package-installed-p 'use-package))
    (progn
      (package-refresh-contents)
      (package-install 'use-package)))
(require 'use-package)

(use-package markdown-mode
  :ensure markdown-mode)
(use-package abyss-theme
  :ensure abyss-theme)
(use-package semantic
  :ensure semantic)
(use-package auto-complete
  :ensure auto-complete
  :bind ("<C-tab>" . auto-complete))
(ac-config-default)
