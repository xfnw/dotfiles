
(add-to-list 'package-archives
             (cons "nongnu" (format "http%s://elpa.nongnu.org/nongnu/"
                                    (if (gnutls-available-p) "s" ""))))
(add-to-list 'package-archives
	     (cons "melpa" (format "http%s://melpa.org/packages/"
				   (if (gnutls-available-p) "s" ""))))

(add-to-list 'load-path (concat user-emacs-directory
				(convert-standard-filename "lisp/")))

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(global-set-key (kbd "C-x M-r") 'rename-buffer)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c q") 'auto-fill-mode)
(global-set-key (kbd "<f12>") 'buffer-menu)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(auth-source-save-behavior nil)
 '(backup-directory-alist `(("." \, (concat user-emacs-directory "backups"))))
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
 '(circe-server-send-unknown-command-p t)
 '(circe-use-cycle-completion t)
 '(company-minimum-prefix-length 4)
 '(company-quick-access-modifier 'super)
 '(company-selection-wrap-around t)
 '(company-show-quick-access t)
 '(custom-enabled-themes '(gruvbox-dark-hard))
 '(custom-safe-themes
   '("d445c7b530713eac282ecdeea07a8fa59692c83045bf84dd112dd738c7bcad1d" "d80952c58cf1b06d936b1392c38230b74ae1a2a6729594770762dc0779ac66b7" default))
 '(display-line-numbers 'relative)
 '(evil-undo-system 'undo-redo)
 '(evil-want-C-u-scroll t)
 '(eww-search-prefix "https://google.com/search?q=")
 '(global-company-mode t)
 '(initial-scratch-message ";; Meow! Welcome to the scratching post!

")
 '(lui-fill-column 105)
 '(lui-logging-directory (concat user-emacs-directory "irclogs"))
 '(lui-logging-flush-delay 2)
 '(menu-bar-mode nil)
 '(nix-nixfmt-bin "nixpkgs-fmt")
 '(nix-repl-executable-args '("repl" "--file" "<nixpkgs>"))
 '(org-agenda-files '("."))
 '(org-agenda-start-on-weekday 0)
 '(org-default-notes-file "~/org/notes.org")
 '(org-footnote-define-inline t)
 '(org-latex-default-packages-alist
   '(("AUTO" "inputenc" t
      ("pdflatex"))
     ("T1" "fontenc" t
      ("pdflatex"))
     ("" "graphicx" t nil)
     ("" "longtable" nil nil)
     ("" "wrapfig" nil nil)
     ("" "rotating" nil nil)
     ("normalem" "ulem" t nil)
     ("" "amsmath" t nil)
     ("" "amssymb" t nil)
     ("" "capt-of" nil nil)
     ("pdfa" "hyperref" nil nil)))
 '(org-latex-image-default-width "\\linewidth")
 '(org-src-preserve-indentation t)
 '(org-structure-template-alist
   '(("a" . "export ascii")
     ("c" . "center")
     ("C" . "comment")
     ("e" . "example")
     ("E" . "export")
     ("h" . "export html")
     ("l" . "export latex")
     ("q" . "quote")
     ("s" . "src")
     ("v" . "verse")
     ("f" . "fixme")))
 '(org-support-shift-select t)
 '(org-todo-keywords '((sequence "TODO" "DELAYED" "RERUN" "|" "DONE")))
 '(package-selected-packages
   '(ob-nix graphviz-dot-mode nix-mode circe badwolf-theme evil elpher gruvbox-theme sudo-edit company))
 '(sudo-edit-indicator-mode t)
 '(tab-always-indent nil)
 '(tool-bar-mode nil)
 '(use-short-answers t))

(setq split-height-threshold nil)
(setq split-width-threshold 160)

(defvar move-file-default-target "~/Documents/" "move-file's default target")

;; borrowed from https://emacs.stackexchange.com/a/45910/37594
(defun move-file ()
  "Move current to another directory, for which you're prompted.
Directory defaults to the value of 'move-file-default-target'."
  (interactive)
  (let ((old  (or (buffer-file-name)  (user-error "Not visiting a file")))
	(dir  (read-directory-name "Move to: " move-file-default-target)))
    (write-file (expand-file-name (file-name-nondirectory old) dir) t)
    (delete-file old)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:height 105 :width normal :foundry "JB" :family "JetBrainsMono Nerd Font"))))
 '(line-number ((t (:background nil :foreground "#7c6f64"))))
 '(line-number-current-line ((t (:background nil :foreground "#fe8019")))))

(require 'evil)
(define-key evil-insert-state-map [S-left] nil)
(define-key evil-insert-state-map [S-right] nil)
(evil-set-initial-state 'term-mode 'emacs)
(evil-set-initial-state 'circe-mode 'emacs)
(evil-mode 1)

(evil-define-operator evil-fill-justify (beg end)
  "fill justified text."
  :move-point nil
  :type line
  (save-excursion
    (condition-case nil
        (fill-region beg end "fill")
      (error nil))))
(define-key evil-normal-state-map "gj" 'evil-fill-justify)

(require 'elisp-mode)
(define-key lisp-mode-shared-map (kbd "C-c C-c") 'eval-defun)

(display-time-mode 1)

(require 'text-mode)
(add-to-list 'auto-mode-alist '("\\.gm\\'" . text-mode))
(add-to-list 'auto-mode-alist '("/mutt" . mail-mode))

(setenv "EDITOR" "emacsclient")

(require 'eww)
(define-key eww-mode-map "u" 'eww-back-url)
(define-key eww-mode-map "g" 'eww)
(define-key eww-mode-map "G" 'eww-reload)
(define-key eww-mode-map (kbd "C-x w") 'eww-copy-page-url)

(require 'elpher)
(define-key elpher-mode-map (kbd "C-x w") 'elpher-copy-current-url)

(require 'org)
;; support gopher and gemini links for org
;; https://list.orgmode.org/87k1vsiv7t.fsf@nicolasgoaziou.fr/t/
(defun org-link-gopher-export-link (link desc format)
  "Create export version of LINK and DESC to FORMAT."
  (let ((link (concat "gopher:" link)))
    (cond
     ((eq format 'html)
      (format "<a href=\"%s\">%s</a>" link desc))
     ((eq format 'latex)
      (format "\\href{%s}{%s}" link desc))
     (t
      (format "[%s](%s)" desc link)))))
(defun org-link-gemini-export-link (link desc format)
  "Create export version of LINK and DESC to FORMAT."
  (let ((link (concat "gemini:" link)))
    (cond
     ((eq format 'html)
      (format "<a href=\"%s\">%s</a>" link desc))
     ((eq format 'latex)
      (format "\\href{%s}{%s}" link desc))
     (t
      (format "[%s](%s)" desc link)))))
(org-link-set-parameters "gopher" :export #'org-link-gopher-export-link)
(org-link-set-parameters "gemini" :export #'org-link-gemini-export-link)

(defun org-export-deterministic-reference (references)
  "make org export's html anchor ids deterministic."
  (let ((new 0))
    (while (rassq new references) (setq new (+ new 1)))
    new))
(advice-add #'org-export-new-reference :override #'org-export-deterministic-reference)

(define-key org-mode-map (kbd "C-M-<return>") 'org-meta-return)

(add-hook 'org-mode-hook 'turn-on-auto-fill)
(add-hook 'text-mode-hook 'turn-on-auto-fill)

(defun turn-off-company ()
  (company-mode -1))
(add-hook 'term-mode-hook 'turn-off-company)
(add-hook 'eshell-mode-hook 'turn-off-company)
(add-hook 'circe-mode-hook 'turn-off-company)

(add-hook 'doc-view-mode-hook 'auto-revert-mode)

(require 'circe)
(defalias 'circe-command-J 'circe-command-JOIN)

(load "lui-logging" nil t)
(enable-lui-logging-globally)

(require 'redtick)
(redtick-mode 1)

(server-start)
