;;; -*- lexical-binding: t -*-

(require 'package)

(add-to-list 'package-archives
	     (cons "melpa" "https://melpa.org/packages/"))

(add-to-list 'load-path (concat user-emacs-directory
				(convert-standard-filename "lisp/")))

(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f"
    "#f6f3e8"])
 '(auth-source-save-behavior nil)
 '(auto-save-file-name-transforms `((".*" ,(concat user-emacs-directory "backups/&") t)))
 '(backup-directory-alist `(("." \, (concat user-emacs-directory "backups"))))
 '(browse-at-remote-prefer-symbolic nil)
 '(browse-url-browser-function 'eww-browse-url)
 '(c-default-style '((java-mode . "java") (awk-mode . "awk") (other . "bsd")))
 '(circe-default-part-message "ABSOLUTELY PROPRIETARY!")
 '(circe-default-quit-message "mmmmmmmm lunchtime")
 '(circe-format-self-say "<{nick}> {body}")
 '(circe-format-server-netmerge
   "*** Netjoin: {split}, split {ago} ago (Use /WL to see who's still missing)")
 '(circe-format-server-quit "*** Quit: {nick} ({userhost}) quit ({reason})")
 '(circe-format-server-quit-channel "*** Quit: {nick} ({userhost}) quit ({reason})")
 '(circe-format-server-topic "*** Topic change by {nick} ({userhost}): {topic-diff}")
 '(circe-server-max-reconnect-attempts 1)
 '(circe-server-send-unknown-command-p t)
 '(circe-use-cycle-completion t)
 '(company-idle-delay nil)
 '(company-selection-wrap-around t)
 '(company-show-quick-access t)
 '(custom-enabled-themes '(gruvbox-dark-hard))
 '(custom-safe-themes
   '("8363207a952efb78e917230f5a4d3326b2916c63237c1f61d7e5fe07def8d378"
     "d445c7b530713eac282ecdeea07a8fa59692c83045bf84dd112dd738c7bcad1d"
     "d80952c58cf1b06d936b1392c38230b74ae1a2a6729594770762dc0779ac66b7"
     default))
 '(dired-auto-revert-buffer 'dired-directory-changed-p)
 '(dired-listing-switches "-alt")
 '(display-line-numbers 'relative)
 '(eldoc-echo-area-use-multiline-p nil)
 '(elpher-gemini-max-fill-width 75)
 '(evil-undo-system 'undo-redo)
 '(evil-want-C-i-jump nil)
 '(evil-want-C-u-delete t)
 '(evil-want-C-u-scroll t)
 '(evil-want-minibuffer t)
 '(geiser-debug-jump-to-debug nil)
 '(indent-tabs-mode nil)
 '(initial-scratch-message ";; Meow! Welcome to the scratching post!\12\12")
 '(lui-fill-column 105)
 '(lui-logging-directory (concat user-emacs-directory "irclogs"))
 '(lui-logging-flush-delay 2)
 '(menu-bar-mode nil)
 '(nxml-auto-insert-xml-declaration-flag t)
 '(nxml-slash-auto-complete-flag t)
 '(org-agenda-files '("." "~/org"))
 '(org-agenda-start-on-weekday 0)
 '(org-agenda-todo-ignore-deadlines 'far)
 '(org-agenda-todo-ignore-scheduled 'future)
 '(org-agenda-todo-ignore-timestamp 'future)
 '(org-babel-load-languages '((emacs-lisp . t) (shell . t) (nix . t)))
 '(org-capture-templates
   '(("e" "Entry" entry (file "") "* %?\12%i\12%u\12%a" :empty-lines 1)
     ("t" "Task" entry (file+olp "" "Tasks")
      "* TODO %?\12%i\12%u\12%a" :empty-lines 1)))
 '(org-default-notes-file "~/org/notes.org")
 '(org-export-backends '(ascii html icalendar latex md rfc texinfo typst))
 '(org-footnote-define-inline t)
 '(org-latex-default-packages-alist
   '(("AUTO" "inputenc" t ("pdflatex")) ("T1" "fontenc" t ("pdflatex"))
     ("" "graphicx" t nil) ("" "longtable" nil nil)
     ("" "wrapfig" nil nil) ("" "rotating" nil nil)
     ("normalem" "ulem" t nil) ("" "amsmath" t nil)
     ("" "amssymb" t nil) ("" "capt-of" nil nil)
     ("pdfa" "hyperref" nil nil)))
 '(org-latex-image-default-width "\\linewidth")
 '(org-modules '(ol-bibtex ol-docview ol-doi ol-eww ol-info ol-irc ol-w3m))
 '(org-src-preserve-indentation t)
 '(org-startup-folded 'content)
 '(org-structure-template-alist
   '(("a" . "export ascii") ("c" . "center") ("C" . "comment")
     ("e" . "example") ("E" . "export") ("h" . "export html")
     ("l" . "export latex") ("t" . "export typst") ("q" . "quote")
     ("s" . "src") ("v" . "verse") ("f" . "fixme") ("d" . "chat")))
 '(org-support-shift-select t)
 '(org-todo-keywords '((type "TODO" "DELAYED" "RERUN" "|" "DONE")))
 '(org-todo-repeat-to-state "TODO")
 '(org-use-sub-superscripts '{})
 '(package-selected-packages
   '(browse-at-remote circe company elpher emacs-everywhere evil geiser
                      geiser-guile gruvbox-theme magit nix-mode
                      nyan-mode ob-nix osm ox-rfc ox-typst paredit
                      rust-mode separedit slime smog))
 '(ses-after-entry-functions '(next-line))
 '(shr-fill-text nil)
 '(tab-always-indent nil)
 '(tool-bar-mode nil)
 '(use-short-answers t)
 '(whitespace-display-mappings
   '((space-mark 32 [183] [46]) (space-mark 160 [164] [95])
     (tab-mark 9 [187 9] [92 9]))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:height 111 :width normal :foundry "JB" :family "JetBrainsMono Nerd Font"))))
 '(line-number ((t (:background unspecified :foreground "#7c6f64"))))
 '(line-number-current-line ((t (:background unspecified :foreground "#fe8019")))))

(package-install-selected-packages)

(setq split-height-threshold nil)
(setq split-width-threshold 160)

(setenv "EDITOR" "emacsclient")

(defvar move-file-default-target "~/Documents/" "move-file's default target")

;; borrowed from https://emacs.stackexchange.com/a/45910/37594
(defun move-file ()
  "Move current to another directory, for which you're prompted.
Directory defaults to the value of `move-file-default-target'."
  (interactive)
  (let ((old  (or (buffer-file-name)  (user-error "Not visiting a file")))
	(dir  (read-directory-name "Move to: " move-file-default-target)))
    (write-file (expand-file-name (file-name-nondirectory old) dir) t)
    (delete-file old)))

(defvar onlytabs-keymap
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "TAB") #'self-insert-command)
    map))

(define-minor-mode onlytabs-mode
  "make the tab key only emit a literal tab"
  :lighter " tab" :keymap onlytabs-keymap
  (setq-local electric-indent-inhibit t)
  (setq-local indent-line-function #'indent-relative)
  (setq-local indent-tabs-mode t))

(use-package emacs
  :bind ("C-x M-r" . rename-buffer))

(use-package compile
  :bind (("C-c c" . compile)
         ("C-x C-a" . recompile)))

(use-package tramp
  :bind (("C-c r" . tramp-revert-buffer-with-sudo)))

(use-package magit
  :bind (("C-c m" . magit)
         ("C-c M" . magit-file-dispatch)))

(use-package browse-at-remote
  :bind (("C-c b" . bar-to-clipboard)))

(use-package simple
  :bind (("C-c q" . auto-fill-mode))
  :hook ((after-init . column-number-mode)
         (org-mode . turn-on-auto-fill)
         (text-mode . turn-on-auto-fill)))

(use-package buff-menu
  :bind (("<f12>" . buffer-menu)))

(use-package evil
  :bind (:map evil-insert-state-map
         ([S-left] . nil)
         ([S-right] . nil)
         :map evil-normal-state-map
         ("M-." . nil)
         ("f" . evil-find-char)
         ("RET" . evil-ret)
         :map evil-motion-state-map
         ("f" . nil)
         ("RET" . nil))
  :hook (after-init . evil-mode)
  :functions evil-fill-justify
  :config
  (evil-set-initial-state 'term-mode 'emacs)
  (evil-set-initial-state 'circe-mode 'emacs)
  (evil-set-initial-state 'ses-mode 'emacs)
  (evil-set-initial-state 'Info-mode 'emacs)

  (evil-define-operator evil-fill-justify (beg end)
    "fill justified text."
    :move-point nil
    :type line
    (save-excursion
      (condition-case nil
          (fill-region beg end "fill")
        (error nil))))
  (define-key evil-normal-state-map "gj" #'evil-fill-justify))

(use-package text-mode
  :mode "\\.gm\\'")

(use-package eww
  :bind (:map eww-mode-map
         ("u" . eww-back-url)
         ("g" . eww)
         ("G" . eww-reload)
         ("C-x w" . eww-copy-page-url)))

(use-package elpher
  :bind (:map elpher-mode-map
         ("C-x w" . elpher-copy-current-url)))

(use-package org
  :bind (("C-c a" . org-agenda)
         ("C-c l" . org-store-link)
         ("C-c t" . org-capture)
         :map org-mode-map
         ("C-c C-1" . org-timestamp-now)
         ("C-M-<return>" . org-meta-return)
         ("C-c M-," . org-insert-structure-template))
  :functions (org-link-gopher-export-link
              org-link-gemini-export-link
              org-link-abbr-export-link
              org-export-deterministic-reference
              org-link-set-parameters
              org-timestamp-inactive
              org-timestamp-now)
  :config
  ;; support gopher and gemini links for org
  ;; https://list.orgmode.org/87k1vsiv7t.fsf@nicolasgoaziou.fr/t/
  (defun org-link-gopher-export-link (link desc format)
    "Create export of gopher links"
    (let ((link (concat "gopher:" link)))
      (cond
       ((eq format 'html)
        (format "<a href=\"%s\">%s</a>" link desc))
       ((eq format 'latex)
        (format "\\href{%s}{%s}" link desc))
       (t
        (format "[%s](%s)" desc link)))))
  (defun org-link-gemini-export-link (link desc format)
    "Create export of gemini links"
    (let ((link (concat "gemini:" link)))
      (cond
       ((eq format 'html)
        (format "<a href=\"%s\">%s</a>" link desc))
       ((eq format 'latex)
        (format "\\href{%s}{%s}" link desc))
       (t
        (format "[%s](%s)" desc link)))))
  ;; my cursed abbreviations
  (defun org-link-abbr-export-link (link desc format)
    "Create export of abbreviations"
    (cond
     ((eq format 'html)
      (format "<abbr title=\"%s\">%s</abbr>" link desc))
     (t
      (format "%s (%s)" desc link))))

  (org-link-set-parameters "gopher" :export #'org-link-gopher-export-link)
  (org-link-set-parameters "gemini" :export #'org-link-gemini-export-link)
  (org-link-set-parameters "abbr" :export #'org-link-abbr-export-link)

  (defun org-export-deterministic-reference (references)
    "make org export's html anchor ids deterministic."
    (let ((new 0))
      (while (rassq new references) (setq new (+ new 1)))
      new))
  (advice-add 'org-export-new-reference :override #'org-export-deterministic-reference)

  (defun org-timestamp-now ()
    "insert an inactive timestamp without prompting"
    (interactive)
    (org-timestamp-inactive '(16))))

(use-package bytecomp
  :commands compile-defun)

(use-package lisp-mode
  :mode ("\\.cl\\'" . lisp-mode)
  :bind (:map lisp-mode-shared-map
         ("C-c C-c" . compile-defun))
  :config
  ;; deferring loading inf-lisp seems to make it ignore
  ;; the value of inferior-lisp-program in custom :(
  (setq inferior-lisp-program "sbcl"))

(use-package eglot
  :commands (eglot
             eglot-code-actions-at-mouse
             eglot-format-buffer
             eglot-rename))

(use-package separedit
  :commands separedit)

(use-package rust-mode
  :bind (:map rust-mode-map
         ; override the rust-mode stuff because it does not work over tramp >:(
         ("C-c C-f" . eglot-format-buffer)
         ("C-c C-r" . eglot-rename)
         ("<mouse-3>" . eglot-code-actions-at-mouse)
         ("C-c '" . separedit)))

(use-package flymake
  :bind (:map flymake-mode-map
         ("C-x `" . flymake-goto-next-error)))

(use-package paredit
  :bind (:map paredit-mode-map
         ("C-<left>" . nil)
         ("C-<right>" . nil)
         ("M-<left>" . paredit-forward-barf-sexp)
         ("M-<right>" . paredit-forward-slurp-sexp)
         ("M-c" . paredit-convolute-sexp))
  :hook ((emacs-lisp-mode . paredit-mode)
         (lisp-mode . paredit-mode)
         (scheme-mode . paredit-mode)))

(use-package company
  :bind (:map company-mode-map
         ("C-<tab>" . company-complete)
         ("<backtab>" . company-complete)
         :map company-active-map
         ("C-l" . company-abort)
         ("C-<up>" . company-abort)
         ("C-<down>" . company-abort)
         ("C-<left>" . company-abort)
         ("C-<right>" . company-abort)
         ("<escape>" . company-abort)
         ("C-j" . company-select-next-or-abort)
         ("C-k" . company-select-previous-or-abort))
  :hook (after-init . global-company-mode)
  :functions turn-off-company
  :config
  (defun turn-off-company ()
    (company-mode -1))
  (add-hook 'term-mode-hook #'turn-off-company)
  (add-hook 'eshell-mode-hook #'turn-off-company)
  (add-hook 'circe-mode-hook #'turn-off-company)
  (add-hook 'org-mode-hook #'turn-off-company))

(use-package autorevert
  :hook (doc-view-mode . auto-revert-mode))

(use-package display-line-numbers
  :functions turn-off-line-numbers
  :config
  (defun turn-off-line-numbers ()
    (display-line-numbers-mode 0))
  (add-hook 'ses-mode-hook #'turn-off-line-numbers))

(use-package circe
  :commands circe
  :after evil
  :functions (lui-kill-to-beginning-of-line
              chanserv-op
              circe-server-process
              irc-send-raw
              circe-command-JOIN
              circe-command-GAWAY)
  :config
  (defalias 'circe-command-AA #'circe-command-GAWAY)
  (defalias 'circe-command-J #'circe-command-JOIN)

  ;; XXX: i do not remember why this needs to be loaded in such an odd way
  ;; can this be put into a separate use-package?
  (load "lui-logging" nil t)
  (enable-lui-logging-globally)

  (let ((cert (expand-file-name (concat user-emacs-directory "irc.pem"))))
    (when (file-exists-p cert)
      (setq-default circe-tls-keylist (list (list cert cert)))))

  (defun chanserv-op ()
    (interactive)
    (irc-send-raw (circe-server-process)
                  (format "CHANSERV :op %s" circe-chat-target)))
  (define-key lui-mode-map (kbd "C-f") #'chanserv-op)
  (define-key lui-mode-map (kbd "C-u") #'lui-kill-to-beginning-of-line)
  (define-key lui-mode-map (kbd "C-w") #'evil-delete-backward-word))

(defun circe-tls ()
  (interactive)
  (circe (read-string "host: ")
         :port (read-number "port: " 6697)
         :use-tls t))

(use-package vulpforth
  :commands vulpforth
  :mode ("\\.vf\\'" . vulpforth-mode))

(use-package redtick
  :hook (after-init . redtick-mode))

(use-package save-place-mode
  :hook (after-init . save-place-mode))

(use-package time
  :hook (after-init . display-time-mode))

(use-package xt-mouse
  :hook (after-init . xterm-mouse-mode))

(use-package htmlfontify
  :commands htmlfontify-buffer
  :config
  (defun hfy-family (family)
    (list (cons "font-family"
                (format "\"%s\", monospace" (string-replace "\"" "\\\\\"" family))))))

(when (not (and (boundp 'server-process) server-process))
  (server-start))
