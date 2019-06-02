;;; private/custom/init.el -*- lexical-binding: t; -*-

;; -- font ---------------------------------------------------------------------
(setq doom-font (font-spec :family "Roboto Mono for Powerline" :size 16))


;; -- Theme --------------------------------------------------------------------
(setq doom-themes-enable-bold t
      doom-themes-enable-italic t)

(load-theme 'tsdh-light t)


;; -- indenting ----------------------------------------------------------------
(setq-default
 ;; js2-mode
 js2-basic-offset 2
 js2-strict-trailing-comma-warning nil
 ;; web-mode
 css-indent-offset 2
 js-indent-level 2
 js-chain-indent nil
 web-mode-markup-indent-offset 2
 web-mode-css-indent-offset 2
 web-mode-code-indent-offset 2
 web-mode-attr-indent-offset 2
 ;; general
 tab-width 2
 indent-tabs-mode nil
 c-basic-offset 2
 c-default-style "k&r")


;; -- rjsx-mode ----------------------------------------------------------------
(add-to-list 'auto-mode-alist '("\\.js\\'" . rjsx-mode))


;; -- delete trailing whitespace on save ---------------------------------------
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(setq-default truncate-lines nil)


;; -- cider config -------------------------------------------------------------
(setq cider-cljs-lein-repl
      "(do (require 'figwheel-sidecar.repl-api)
         (figwheel-sidecar.repl-api/start-figwheel!)
         (figwheel-sidecar.repl-api/cljs-repl))")
(setq cider-lein-parameters "repl :headless :host localhost")


;; -- theme tweaks -------------------------------------------------------------
(custom-set-faces '(highlight ((t (:foreground nil :underline nil)))))
