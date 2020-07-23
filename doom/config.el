;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Leny Diallo"
      user-mail-address "l.diallo.pro@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "monospace" :size 14))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/code/org/")

(after! org

  (defface bdd/keyword-given
    '((t :foreground "#98DBC6" :weight bold :height 1.2))
    "BDD Given highlight")

  (defface bdd/keyword-when
    '((t :foreground "#E6D72A" :weight bold :height 1.2))
    "BDD When highlight")

  (defface bdd/keyword-then
    '((t :foreground "#F18D9E" :weight bold :height 1.2))
    "BDD Then highlight")

  (defface bdd/keyword-user
    '((t :foreground "#DE7A22" :weight bold :height 1.2))
    "BDD Users highlight")

  (defun bdd/keywords ()
    "Use hi-lock to highlight specific words"
    (setq case-fold-search nil)
    (hi-lock-face-buffer "\\b\\(Ziva\'?s?\\|Mcgee\'?s?\\|Tony\'?s?\\|Gibbs\'?s?\\)\\b" 'bdd/keyword-user)
    (hi-lock-face-buffer "\\b\\(GIVEN\\)\\b" 'bdd/keyword-given)
    (hi-lock-face-buffer "\\b\\(WHEN\\|AND\\)\\b" 'bdd/keyword-when)
    (hi-lock-face-buffer "\\b\\(THEN\\)\\b" 'bdd/keyword-then))

  (add-hook 'org-mode-hook #'bdd/keywords)

  (setq org-tag-alist '(("@work" . ?w) ("@feature" . ?f) ("backend" . ?b) ("frontend" . ?h) ("@routine" . ?r) ("@learning" .  ?l)))
  (setq org-todo-keywords
        '((sequence
           "TODO(t)"  ; A task that needs doing & is ready to do
           "PROJ(p)"  ; A project, which usually contains other tasks
           "STRT(s)"  ; A task that is in progress
           "WAIT(w)"  ; Something external is holding up this task
           "HOLD(h)"  ; This task is paused/on hold because of me
           "|"
           "DONE(d)"  ; Task successfully completed
           "KILL(k)")) ; Task was cancelled, aborted or is no longer applicable
        org-todo-keyword-faces
        '(("STRT" . +org-todo-active)
          ("WAIT" . +org-todo-onhold)
          ("HOLD" . +org-todo-onhold)
          ("PROJ" . +org-todo-project)))
  )

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

;; Require rvm support
(require 'rvm)

(rvm-use-default)

;; Format using rubocop
(require 'rubocopfmt)

;;(add-hook 'ruby-mode-hook #'rubocopfmt-mode)
;;(after! ruby-mode-hook
  ;;(set-formatter! 'rubocopfmt))
