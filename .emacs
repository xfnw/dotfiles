
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(global-set-key (kbd "C-x M-r") 'rename-buffer)
;(global-set-key (kbd "C-x M-u") 'redo)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mail-host-address "ttm.sh")
 '(send-mail-function (quote sendmail-send-it))
 '(smtpmail-local-domain (quote "ttm.sh"))
 '(user-mail-address "xfnw@ttm.sh")
 '(custom-enabled-themes (quote (tsdh-dark)))
 '(initial-buffer-choice "~/.esplash")
)


(server-start)
(add-to-list 'auto-mode-alist '("/mutt" . mail-mode))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )