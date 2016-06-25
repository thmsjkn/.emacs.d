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

;; Funktion für Frames auf grafische Terminals
(defun init-frame (&optional frame)
  (if window-system
      (progn
        (tool-bar-mode 0)
        (scroll-bar-mode 0)
        (load-theme 'zenburn t))))

;; Keine Menüs oder Toolbar etc. anzeigen, dafür aber eine Uhr
(menu-bar-mode 0)
(setq display-time-24hr-format t)
(display-time-mode 1)
(size-indication-mode 1)
(add-hook 'after-make-frame-functions 'init-frame)
(add-hook 'after-init-hook 'init-frame)
