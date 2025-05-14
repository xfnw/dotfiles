;;; -*- lexical-binding: t -*-

(require 'comint)

(defgroup vulpforth nil
  "integration for vulpforth"
  :group 'applications
  :prefix "vulpforth-")

(defcustom vulpforth-command "vulpforth"
  "command to run vulpforth"
  :type 'string)

(defcustom vulpforth-buffer "*vulpforth*"
  "buffer name for vulpforth"
  :type 'string)

(defun vulpforth ()
  "start vulpforth"
  (interactive)
  (async-shell-command vulpforth-command vulpforth-buffer))

(defun vulpforth-eval (inp)
  "send text to vulpforth"
  (if (get-buffer vulpforth-buffer)
    (progn
      (comint-send-string vulpforth-buffer (concat inp "\n"))
      (display-buffer vulpforth-buffer '(nil (inhibit-same-window . t))))
    (message "start vulpforth with M-x vulpforth")))

(defun vulpforth-eval-region ()
  "send the selection to vulpforth"
  (interactive)
  (vulpforth-eval
   (if (use-region-p)
     (buffer-substring (region-beginning) (region-end))
     (thing-at-point 'line))))

(defvar vulpforth-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "C-c C-c") #'vulpforth-eval-region)
    map))

;;;###autoload
(define-derived-mode vulpforth-mode fundamental-mode "vulpforth"
  "major mode for editing vulpforth files"
  (setq-local electric-indent-inhibit t)
  (setq-local indent-tabs-mode t))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.vf\\'" . vulpforth-mode))

(provide 'vulpforth)
