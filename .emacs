
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
 '(backup-directory-alist `(("." \, (concat user-emacs-directory "backups"))))
 '(custom-enabled-themes '(gruvbox-dark-hard))
 '(custom-safe-themes
   '("6b5c518d1c250a8ce17463b7e435e9e20faa84f3f7defba8b579d4f5925f60c1" "f27c3fcfb19bf38892bc6e72d0046af7a1ded81f54435f9d4d09b3bff9c52fc1" default))
 '(evil-want-C-u-scroll t)
 '(initial-scratch-message
   ";; This buffer is for text that is not saved, and for Lisp evaluation.

")
 '(menu-bar-mode nil)
 '(org-agenda-files '("."))
 '(package-selected-packages '(elpher evil gruvbox-theme))
 '(tool-bar-mode nil))

(require 'evil)
(evil-set-initial-state 'term-mode 'emacs)
(evil-mode 1)

(server-start)
(add-to-list 'auto-mode-alist '("/mutt" . mail-mode))

(setenv "EDITOR" "emacsclient")

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:height 120 :width normal :foundry "JB" :family "JetBrainsMono Nerd Font")))))

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

(add-hook 'org-mode-hook 'turn-on-auto-fill)
