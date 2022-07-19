;;; init.el  --- initialization file for Emacs
;;; Commentary:
;; Emacs Startup File --- initialization for Emacs

;;; Code:
;; --- configure user-package - start =====================================================
(require 'package) ; activate packages
(package-initialize) ; activate all the packages (in particular autoloads)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/"))
(add-to-list 'package-archives '("elpa" . "https://elpa.gnu.org/packages/"))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
;; --- configure user-package - end -------------------------------------------------------


;; === general emacs configuration - start ================================================
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode 1)
(hl-line-mode 1)
(blink-cursor-mode 1)
(recentf-mode 1)

; move customization variables to a separate file and load it
(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)

(setq visible-bell t
      use-dialog-box nil)
;; --- general emacs configuration - end --------------------------------------------------


;; === emacs util packages - start ========================================================
; minibuffer comand bind comletition
(use-package which-key
  :ensure t
  :config
  (which-key-mode))

; counsel flexible tools for minibuffer completion in Emacs. Its includes:
; - ivy: generic completion mechanism for Emacs.
; - counsel: a collection of ivy-enhanced versions of common Emacs commands.
; - swiper: ivy-enhanced alternative to Isearch.
(use-package counsel
  :ensure t
  :config
  (ivy-mode 1)
  (bind-key "C-c C-r" 'ivy-resume))
(global-set-key (kbd "C-s") 'swiper-isearch)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "M-y") 'counsel-yank-pop)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "<f2> j") 'counsel-set-variable)
(global-set-key (kbd "C-x b") 'ivy-switch-buffer)
(global-set-key (kbd "C-c v") 'ivy-push-view)
(global-set-key (kbd "C-c V") 'ivy-pop-view)

; text completition framework
(use-package company
  :ensure t
  :hook ((emacs-lisp-mode . (lambda ()
			      (setq-local company-backends '(company-elisp))))
	 (emacs-lisp-mode . company-mode))
  :config
  (company-tng-configure-default)
  (setq company-idle-delay 0.1
	company-minimum-prefix-length 1))

; syntax checking
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

; client for language server protocol. lsp-mode provides integration for company and flycheck
(use-package lsp-mode
  :ensure t
  :bind(:map lsp-mode-map
	     ("C-c d" . lsp-describe-thing-at-point)
	     ("C-c a" . lsp-executepcode-action)
	     ("C-c l" . lsp-command-map))
  :config
  (lsp-enable-which-key-integration t))
;; --- emacs util packages - start --------------------------------------------------------


;;; === LSP => Go =========================================================================
(use-package go-mode
  :ensure t
  :hook ((go-mode . lsp-deferred)
	 (go-mode . company-mode))
  :bind (:map go-mode-map
	      ("<f6>"  . gofmt))
  :config
  (require 'lsp-go)
  ;; https://github.com/golang/tools/blob/master/gopls/doc/analyzers.md
  (setq lsp-go-analyses
	'((fieldalignment . t)
	  (nilness        . t)
	  (unusedwrite    . t)
	  (unusedparams   . t)))
  ;; GOPATH/bin
  (add-to-list 'exec-path "~/go/bin")
  (setq gofmt-command "goimports"))
;; --- LSP => Go -------------------------------------------------------------------------


;; === configure emacs aparience - start ==================================================
; all-the-icons requires to execute "M-x all-the-icons-install-fonts" after first installation
(use-package all-the-icons
  :ensure t)

(use-package neotree
  :ensure t)
(global-set-key [f8] 'neotree-toggle)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

(use-package doom-themes
  :ensure t
  :config
  ;; global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one t)           ; other great theme: doom-ayu-dark
  (doom-themes-visual-bell-config)   ; enable flashing mode-line on errors
  (doom-themes-org-config))          ; corrects (and improves) org-mode's native fontification.

(provide 'init)
;;; init.el ends here
