;; Config. Frame Layout.
;(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode 1)
(hl-line-mode 1)
(blink-cursor-mode 1)


;; Config. Emacs Theme.
(setq modus-themes-mode-line '(accented borderless))
(load-theme 'modus-vivendi t)


;; Don't show the splash screen.
(setq ;inhibit-startup-message t
 visible-bell t ; Visible signal (instead of sound) for non allow operations.
 use-dialog-box nil) ; Don't pop up UI dialogs when prompting.
