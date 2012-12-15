;; (l) dancar
(global-set-key (kbd "C-c k") 'kill-buffer-and-window)
(global-set-key (kbd "C-c C-p") 'f3)
(global-set-key (kbd "<f8>") 'f3-switch-project)
(global-set-key (kbd "M-<SPC>") `speedbar-get-focus)
(global-set-key (kbd "C-x C-r") `ido-recentf-open)
(global-set-key (kbd "M-n") `move-text-down)
(global-set-key (kbd "M-p") `move-text-up)
(global-set-key (kbd "s-<return>") `kmacro-end-and-call-macro)
(global-set-key (kbd "C-S-M-<delete>") `erase-buffer)
(global-set-key (kbd "C-S-M-<kp-delete>") `erase-buffer)
(global-set-key (kbd "C-<kp-delete>") `delete-region)
(global-set-key (kbd "C-|") `bookmark-jump)
(global-set-key (kbd "C-c C-g") `magit-status)
(global-set-key (kbd "C-#") `shell)
(global-set-key (kbd "M-S-<f3>") `highlight-symbol-prev)
(global-set-key (kbd "M-<f3>") `highlight-symbol-next)
(global-set-key (kbd "C-<f3>") `highlight-symbol-at-point)
(global-set-key (kbd "<home>") `move-beginning-of-line)
(global-set-key (kbd "<end>") `move-end-of-line)
(global-set-key (kbd "s-s") `save-buffer)
(global-set-key (kbd "S-s") `save-buffer)
(global-set-key (kbd "C-\\") `ido-switch-buffer)
(global-set-key (kbd "C-<return>") `go-line)
(global-set-key (kbd "M-k") (lambda () (interactive) (back-to-indentation) (kill-line)))
(global-set-key (kbd "C-S-k") `kill-whole-line)
(global-set-key (kbd "<f6>") `toggle-truncate-lines)
(global-set-key (kbd "M-]") (lambda () (interactive) (scroll-up-line 2)))
(global-set-key (kbd "M-[") (lambda () (interactive) (scroll-down-line 2)))
(global-set-key (kbd "C-M-[") (lambda () (interactive) (scroll-down-line 6)))
(global-set-key (kbd "C-M-]") (lambda () (interactive) (scroll-up-line 6)))
(global-set-key (kbd "C-M-f") (lambda () (interactive) (forward-char) (search-forward " ") (backward-char)))
(global-set-key (kbd "C-M-b") (lambda () (interactive) (backward-char) (search-backward " ") (backward-char)))
(global-set-key (kbd "M-`") `pop-to-mark-command)
(global-set-key (kbd "M-q") 'highlight-symbol-next)
(global-set-key (kbd "C-z") nil)
(global-set-key (kbd "C-S-<SPC>") 'set-rectangular-region-anchor)
(global-set-key (kbd "C-?") 'undo-tree-redo)
(global-set-key  (kbd "C-<tab>") `other-window)
(global-set-key (kbd "s-<up>") 'windmove-up)
(global-set-key (kbd "s-<down>") 'windmove-down)
(global-set-key (kbd "s-<right>") 'windmove-right)
(global-set-key (kbd "s-<left>") 'windmove-left)

(global-set-key  (kbd "C-M-p") (lambda () (interactive) (previous-line 4)))
(global-set-key  (kbd "C-M-n") (lambda () (interactive) (next-line 4)))
(global-set-key  (kbd "C-M-S-p") (lambda () (interactive) (previous-line 10)))
(global-set-key  (kbd "C-M-S-n") (lambda () (interactive) (next-line 10)))


;; ruby-mode keys override:
(defvar my-ruby-mode-keys-minor-mode-map (make-keymap) "my-ruby-mode-keys-minor-mode keymap.")
(define-key my-ruby-mode-keys-minor-mode-map (kbd "<RET>") 'newline-and-indent)

(define-minor-mode my-ruby-mode-keys-minor-mode
  "A minor mode so fix ruby-mode keys"
  nil " my-ruby-mode-keys" 'my-ruby-mode-keys-minor-mode-map)
(add-hook 'ruby-mode-hook 'my-ruby-mode-keys-minor-mode)
(add-hook 'ruby-mode-hook 'my-super-mode-keys-minor-mode) ;;TODO: recheck
;; /

;; emacs-lisp-mode keys override:
(defvar my-emacs-lisp-mode-keys-minor-mode-map (make-keymap) "my-emacs-lisp-mode-keys-minor-mode keymap.")
(define-key my-emacs-lisp-mode-keys-minor-mode-map (kbd "<RET>") 'newline-and-indent)

(define-minor-mode my-emacs-lisp-mode-keys-minor-mode
  "A minor mode so fix emacs-lisp-mode keys"
  nil " my-emacs-lisp-mode-keys" 'my-emacs-lisp-mode-keys-minor-mode-map)
(add-hook 'emacs-lisp-mode-hook 'my-emacs-lisp-mode-keys-minor-mode)
;; /



;; org-mode keys-override:
(defvar my-org-mode-keys-minor-mode-map (make-keymap) "my-org-mode-keys-minor-mode keymap.")

(define-key my-org-mode-keys-minor-mode-map (kbd "C-<tab>") `other-window)
(define-key my-org-mode-keys-minor-mode-map (kbd "C-c C-p") 'f3)

(define-minor-mode my-org-mode-keys-minor-mode
  "A minor mode so fix org-mode keys"
  nil " my-org-mode-keys" 'my-org-mode-keys-minor-mode-map)
(add-hook 'org-mode-hook 'my-org-mode-keys-minor-mode)
;; /


;;; super keys
(defvar my-super-mode-keys-minor-mode-map (make-keymap) "my-super-mode-keys-minor-mode keymap.")

(define-key my-super-mode-keys-minor-mode-map (kbd "C-M-p") (lambda () (interactive) (previous-line 4)))
(define-key my-super-mode-keys-minor-mode-map (kbd "C-M-n") (lambda () (interactive) (next-line 4)))
(define-key my-super-mode-keys-minor-mode-map (kbd "C-M-S-p") (lambda () (interactive) (previous-line 10)))
(define-key my-super-mode-keys-minor-mode-map (kbd "C-M-S-n") (lambda () (interactive) (next-line 10)))

(define-minor-mode my-super-mode-keys-minor-mode
  "A minor mode so fix super-mode keys"
  nil " Dan(-:" 'my-super-mode-keys-minor-mode-map)
(my-super-mode-keys-minor-mode 1)
(defadvice load (after give-my-super-mode-keybindings-priority)
  "Try to ensure that my keybindings always have priority."
  (if (not (eq (car (car minor-mode-map-alist)) 'my-super-mode-keys-minor-mode))
      (let ((mykeys (assq 'my-super-mode-keys-minor-mode minor-mode-map-alist)))
        (assq-delete-all 'my-super-mode-keys-minor-mode minor-mode-map-alist)
        (add-to-list 'minor-mode-map-alist mykeys))))
(ad-activate 'load)
;; /

;; scss-mode keys-override:
(defvar my-scss-mode-keys-minor-mode-map (make-keymap) "my-scss-mode-keys-minor-mode keymap.")

(define-key my-scss-mode-keys-minor-mode-map (kbd "<RET>") `newline-and-indent)

(define-minor-mode my-scss-mode-keys-minor-mode
  "A minor mode so fix scss-mode keys"
  nil " my-scss-mode-keys" 'my-scss-mode-keys-minor-mode-map)
(add-hook 'scss-mode-hook 'my-scss-mode-keys-minor-mode)
;; /

;; Set newline
(defun set-newline-and-indent ()
  (interactive)
  (local-set-key (kbd "RET") 'newline-and-indent))
;;/

(provide 'dancar-keys)
