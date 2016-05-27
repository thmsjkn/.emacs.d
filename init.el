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
(setq-default indent-tabs-mode nil)))

;; Server starten
(require 'server)
(unless (server-running-p)
  (server-start))
