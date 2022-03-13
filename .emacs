
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(global-set-key (kbd "C-x M-r") 'rename-buffer)
;(global-set-key (kbd "C-x M-u") 'redo)

(add-to-list 'package-archives
             (cons "nongnu" (format "http%s://elpa.nongnu.org/nongnu/"
                                    (if (gnutls-available-p) "s" ""))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(wombat))
 '(evil-want-C-u-scroll t)
 '(initial-scratch-message
   ";; This buffer is for text that is not saved, and for Lisp evaluation.

")
 '(menu-bar-mode nil)
 '(package-selected-packages '(elpher evil))
 '(tool-bar-mode nil))

(require 'evil)
(evil-set-initial-state 'term-mode 'emacs)
(evil-mode 1)

(server-start)
(add-to-list 'auto-mode-alist '("/mutt" . mail-mode))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
