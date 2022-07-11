;; === Install packages - Start ===========================================================
; list the packages you want
(setq package-list '(modus-themes))

; list the repositories containing them
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")))

; activate all the packages (in particular autoloads)
(package-initialize)

; fetch the list of packages available 
(or (file-exists-p package-user-dir) (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))
;; --- Install packages - End -------------------------------------------------------------


;; === Config general emacs variables - Start =============================================
; Move customization variables to a separate file and load it
(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)

(setq
 visible-bell t ; Visible signal (instead of sound) for non allow operations.
 use-dialog-box nil) ; Don't pop up UI dialogs when prompting.
;; --- Config general emacs variables - End -----------------------------------------------


;; === Config. Minor Modes - Start ========================================================
;(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode 1)
(hl-line-mode 1)
(blink-cursor-mode 1)
(recentf-mode 1)
;; --- Config. Minor Modes - End ----------------------------------------------------------


;; === Config. Emacs Theme - Start ========================================================
(setq modus-themes-mode-line '(accented borderless))
(load-theme 'modus-vivendi t)
;; --- Config. Emacs Theme - End ----------------------------------------------------------
