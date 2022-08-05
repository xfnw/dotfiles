
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(global-set-key (kbd "C-x M-r") 'rename-buffer)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c q") 'auto-fill-mode)

(add-to-list 'package-archives
             (cons "nongnu" (format "http%s://elpa.nongnu.org/nongnu/"
                                    (if (gnutls-available-p) "s" ""))))
(add-to-list 'package-archives
	     (cons "melpa" (format "http%s://melpa.org/packages/"
				   (if (gnutls-available-p) "s" ""))))

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
 '(company-minimum-prefix-length 4)
 '(company-quick-access-modifier 'super)
 '(company-selection-wrap-around t)
 '(company-show-quick-access t)
 '(custom-enabled-themes '(gruvbox-dark-hard))
 '(custom-safe-themes
   '("6b5c518d1c250a8ce17463b7e435e9e20faa84f3f7defba8b579d4f5925f60c1" "f27c3fcfb19bf38892bc6e72d0046af7a1ded81f54435f9d4d09b3bff9c52fc1" default))
 '(evil-want-C-u-scroll t)
 '(eww-search-prefix "https://google.com/search?q=")
 '(global-company-mode t)
 '(initial-scratch-message ";; Meow! Welcome to the scratching post!

")
 '(menu-bar-mode nil)
 '(org-agenda-files '("."))
 '(org-footnote-define-inline t)
 '(org-latex-image-default-width "\\linewidth")
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
 '(org-todo-keywords '((sequence "TODO" "DELAYED" "RERUN" "|" "DONE")))
 '(package-selected-packages '(evil elpher gruvbox-theme sudo-edit company))
 '(sudo-edit-indicator-mode t)
 '(tab-always-indent nil)
 '(tool-bar-mode nil))

(setq split-height-threshold nil)
(setq split-width-threshold 160)

(require 'eww)
(define-key eww-mode-map "u" 'eww-back-url)
(define-key eww-mode-map "g" 'eww)
(define-key eww-mode-map "G" 'eww-reload)

(require 'evil)
(evil-set-initial-state 'term-mode 'emacs)
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

(display-time-mode 1)

(server-start)
(add-to-list 'auto-mode-alist '("/mutt" . mail-mode))

(setenv "EDITOR" "emacsclient")

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:height 105 :width normal :foundry "JB" :family "JetBrainsMono Nerd Font")))))

(require 'zone)
(zone-when-idle 120)

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
  (let ((new 0))
    (while (rassq new references) (setq new (+ new 1)))
    new))
(advice-add #'org-export-new-reference :override #'org-export-deterministic-reference)

(add-hook 'org-mode-hook 'turn-on-auto-fill)
(add-hook 'text-mode-hook 'turn-on-auto-fill)

(defun turn-off-company ()
  (company-mode -1))
(add-hook 'term-mode-hook 'turn-off-company)
(add-hook 'eshell-mode-hook 'turn-off-company)

