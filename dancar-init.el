(package-initialize)
(add-to-list 'load-path "~/.emacs.d")
(require 'dancar-customize)
(require 'dancar-functions)
(require 'dancar-keys)
(require 'dancar-plugins)

(yas-global-mode)
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-hook 'after-change-major-mode-hook 'highlight-symbol-mode)
(when window-system (server-start))
;;font per os:
(cond
 ((equal system-type 'darwin)
  (set-face-attribute 'default nil :family "Monaco" :height 130 :weight 'normal))
 ((equal system-type 'gnu/linux)
  (set-face-attribute 'default nil :family "Ubuntu Mono" :height 130 :weight 'normal)))

(add-hook 'ediff-prepare-buffer-hook (lambda () (toggle-truncate-lines 0)))
(put 'erase-buffer 'disabled nil)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'shell-mode-hook (lambda () (insert "source ~/.profile") (comint-send-input)))
;; prevent exit prompt
(defadvice save-buffers-kill-emacs (around no-query-kill-emacs activate)
        "Prevent annoying \"Active processes exist\" query when you quit Emacs."
        (flet ((process-list ())) ad-do-it))


(if (> (list-length plugin-error-list) 0) (error "Plugin Errors %s" plugin-error-list))
