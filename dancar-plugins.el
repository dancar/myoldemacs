(add-to-list 'load-path "~/.emacs.d/plugins/")

;; Preload:
;; ================
;; add all subdirs of plugins to load path:
(mapcar (lambda (dir) (add-to-list 'load-path dir)) (directory-files "~/.emacs.d/plugins/" 1 "^[-_a-zA-Z0-9]+$"))
;; dependencies:
(add-to-list 'load-path "~/.emacs.d/plugins/js2-refactor/util/vendor")
(add-to-list 'load-path "~/.emacs.d/plugins/auto-complete/lib/popup")

;; Plugins:
;; ================
(setq plugin-error-list (list))
(defun load-plugin (plugin)
  "Safely requires the plugin - if an error occures, gracefuly add it to plugin-error-list"
  (let ((plugin-name (symbol-name plugin)))
    (condition-case
        exception
        (progn
          (message (format "Loading plugin \"%s\"..." plugin-name))
          (require plugin)
          (message (format "Plugin \"%s\" loaded successfully." plugin-name)))
      ('error
       (progn
         (add-to-list 'plugin-error-list plugin))
         (message (format "Error loading plugin \"%s\"." plugin-name))
      ))))
(load-plugin 'ido-f3)
(load-plugin 'scss-mode)
(load-plugin 'json-mode)
(load-plugin 'git-emacs)
(load-plugin 'magit)
(load-plugin 'newcomment)
(load-plugin 'highlight-symbol)
(load-plugin 'lua-mode)
(load-plugin 'maxframe)
(load-plugin 'ido)
(load-plugin 'recentf)
(load-plugin 'color-theme)
(load-plugin 'expand-region)
(load-plugin 'dired-details)
(load-plugin 'dired-details-plus)
(load-plugin 'inline-string-rectangle)
(load-plugin 'mark-more-like-this)
(load-plugin 'js2-mode)
(load-plugin 'js2-refactor)
(load-plugin 'mic-paren)
(load-plugin 'multiple-cursors)
(load-plugin 'yaml-mode)
(load-plugin 'yasnippet)
(load-plugin 'move-lines)
(load-plugin 'exec-path-from-shell)

;; Disabled:
;; ================
;; (require 'gpicker)
;; (require 'sr-speedbar)
;; (require 'helm-config)
;; (require 'tail)
;; (require 'auto-complete)

;; Configurations:
;; ================

;; lua-mode
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

;; Display ido results vertically, rather than horizontally
(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
(defun ido-disable-line-truncation () (set (make-local-variable 'truncate-lines) nil))
(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)

;; sass-mode
;; (add-to-list 'load-path "~/.emacs.d/plugins/sass-mode")
;; (autoload 'sass-mode "js2-mode" nil t)
;; (add-to-list 'auto-mode-alist '("\\.scss$" . sass-mode))
;; (require 'sass-mode)

;;;max-frame
(add-hook 'window-setup-hook 'maximize-frame t)
;; (setq mf-max-width 1600)  ;; Pixel width of main monitor

;;; ido-mode
(setq ido-everywhere 1)
(ido-mode 1)

;;; display tooltips in the echo:
(tooltip-mode -1)
(setq tooltip-use-echo-area t)

;;; recent-f
(recentf-mode t)
;; get rid of `find-file-read-only' and replace it with something more useful.
(defun ido-recentf-open ()
  "Use `ido-completing-read' to \\[find-file] a recent file"
  (interactive)
  (if (find-file (ido-completing-read "Find recent file: " recentf-list))
      (message "Opening file...")
    (message "Aborting")))

;;;color theme:
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-hober)))

;;Expand-region
(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C-+") 'er/contract-region)

;; dired-details and plus
(dired-details-install)

;;mark-multiple
(global-set-key (kbd "C-x r t") 'inline-string-rectangle)
(global-set-key (kbd "C-<") 'mark-previous-like-this)
(global-set-key (kbd "C->") 'mark-next-like-this)

;;; vi-like % paren matching
(defun goto-match-paren (arg)
  "Go to the matching parenthesis if on parenthesis, otherwise insert %.
vi style of % jumping to matching brace."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))
(global-set-key (kbd "C-%") 'goto-match-paren)

;;js2
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;;js2-refactor
;; Usage
;; All refactorings start with C-c C-m and then a two-letter mnemonic shortcut.

;; eo is expand-object: Converts a one line object literal to multiline.
;; co is contract-object: Converts a multiline object literal to one line.
;; wi is wrap-buffer-in-iife: Wraps the entire buffer in an immediately invoked function expression
;; ig is inject-global-in-iife: Creates a shortcut for a marked global by injecting it in the wrapping immediately invoked function expression
;; ag is add-to-globals-annotation: Creates a /*global */ annotation if it is missing, and adds the var at point to it.
;; ev is extract-var: Takes a marked expression and replaces it with a var.
;; iv is inline-var: Replaces all instances of a variable with its initial value.
;; rv is rename-var: Renames the variable on point and all occurrences in its lexical scope.
;; vt is var-to-this: Changes local var a to be this.a instead.
;; ao is arguments-to-object: Replaces arguments to a function call with an object literal of named arguments. Requires yasnippets.
;; 3i is ternary-to-if: Converts ternary operator to if-statement.
;; sv is split-var-declaration: Splits a var with multiple vars declared, into several var statements.
;; uw is unwrap: Replaces the parent statement with the selected region.
;; There are also some minor conveniences bundled:

;; C-S-down and C-S-up moves the current line up or down. If the line is an element in an object or array literal, it makes sure that the commas are still correctly placed.

;; change magit diff colors
(eval-after-load 'magit
  '(progn
     (set-face-foreground 'magit-diff-add "green3")
     (set-face-foreground 'magit-diff-del "red3")
     (when (not window-system)
       (set-face-background 'magit-item-highlight "black"))))

;;mic-parent
(paren-activate)

;;; gpicker
;(global-set-key (kbd "C-x f") `gpicker-find-file)

;;; multiple cursors
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

;;; full path in title
(setq frame-title-format
      (list
       (format "%s %%S: %%j " (system-name))
       '(buffer-file-name "%f" (dired-directory dired-directory "%b"))))

;;exec-path
(exec-path-from-shell-initialize)
(mapcar 'exec-path-from-shell-copy-env '())
;; yasnippet
(yas-global-mode 1)

;; yaml-mode
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))


;;join-region
(defun join-region (beg end)
  "Apply join-line over region."
  (interactive "r")
  (if mark-active
          (let ((beg (region-beginning))
                        (end (copy-marker (region-end))))
                (goto-char beg)
                (while (< (point) end)
                  (join-line 1)))))
(provide 'dancar-plugins)
