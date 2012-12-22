(defun comment-line-toggle ()
  "Toggle current line or region's commenting
  (c) dancar"
  (interactive)
  (comment-normalize-vars)
  (if (and mark-active transient-mark-mode)
      (comment-or-uncomment-region (region-beginning) (region-end))
    (comment-or-uncomment-region (line-beginning-position) (line-end-position))))
(global-set-key (kbd "M-;") 'comment-line-toggle)


(defun go-line ()
  (interactive)
  (search-backward " ")
  (newline-and-indent)
  (previous-line)
  (end-of-line)
  (newline-and-indent))

(defun server-tail()
  (interactive)
  (shell "server")
  (insert "tail -f ~/dev/tma/log/development.log")
  (comint-send-input))

(defun console()
  (interactive)
  (shell "console")
  (insert "rails c")
  (comint-send-input)
  (other-buffer))

(defun seed()
  (interactive)
  (shell-action "rake db:seed"))

(defun compass()
  (interactive)
  (shell-action "tma_compass"))

(global-set-key (kbd "<f10>") 'seed)
(global-set-key (kbd "<f11>") `compass)

(defun same-issue ()
  "Copies issue number to commit message (c) dancar"
  (interactive)
  (beginning-of-buffer)
  (next-line)
  (end-of-line)
  (search-backward "(")
  (copy-to-register `x (point) (line-end-position))
  (magit-log-edit)
  (insert " ")
  (insert-register `x)
  (beginning-of-buffer)
  )

;; shell-action-init:
((lambda ()
  (setq shell-actions-buffer "shell-actions")
  (shell shell-actions-buffer)
  (switch-to-buffer nil)
  ))


(defun shell-action (action)
  (shell-action-base action 1))

(defun shell-action-base (action wait)
  (interactive)
  (split-window-below)
  (other-window 1)
  (switch-to-buffer shell-actions-buffer)
  (insert action)
  (comint-send-input)
  (if wait
      (let ((cursor-in-echo-area 1))
        (read-event "Press any key to continue")))
  (delete-window))

(defun shell-action-bg (action)
  (shell-action-base action nil))

(defun tail (file)
  (interactive "fFile name:")
  (shell (concat (file-name-nondirectory file) "-tail"))
  (insert (concat "tail -f " file))
  (comint-send-input))

(provide 'dancar-functions)
