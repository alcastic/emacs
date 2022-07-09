;;; Go
(use-package go-mode
  :ensure t
  :hook ((go-mode . lsp-deferred)
	 (go-mode . company-mode))
  :bind (:map go-mode-map
	      ("<f6>"  . gofmt)
	      ("C-c 6" . gofmt))
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

(global-set-key (kbd "<f5>") #'recompile)

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file t)

(setq auto-save-file-name-transforms
      '((".*" "~/.emacs.d/auto-save-list/" t))
      backup-directory-alist
      '(("." . "~/.emacs.d/backups")))

(set-face-attribute 'region nil :background "deep sky blue")
(set-face-attribute 'default nil :height 140)

(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(put 'narrow-to-region 'disabled nil)
