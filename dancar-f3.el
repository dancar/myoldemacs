;;; f3
;;; TODO:
;; - extract to repo
;; - f8 with argument will ask for folder
(require 'cl)

(setq f3-projects-dir "~/dev")
(setq f3-find-command "find")
(setq f3-extension-whitelist '(js rb json yml yaml html erb rake lua txt el coffee css scss sql sh))
(setq f3-blacklist-regexp "\\.git|1\\.9\\.")

(defun f3-filter (list)
  (let*
      ((after-whitelist
        (delete-if-not
         (lambda (file)
           (string-match
            (concat
             "\\(\/[a-zA-Z_]+\\)$"  ;; no extension at all
             "\\|\\(" ;;  (or1)
             "\\.\\("     ;; whitelisted extension
             (apply 'concat
                    (mapcar
                     (lambda (extension) (concat (symbol-name extension) "\\|"))
                     f3-extension-whitelist)
                    )
             "$^\\)$"
             "\\)" ;;end (or1)
             )
            file))
         list))
       (after-blacklist
        (delete-if
         (lambda (file)
           (string-match f3-blacklist-regexp file))
            after-whitelist)))
    after-blacklist))

(defun f3-switch-project ()
  "Switch current project dir from a subdir of the projects-dir"
  (interactive)
  (let* ((projects-hash
          (mapcar
           (lambda (fulldir)
             (cons (file-name-nondirectory fulldir) fulldir))
           (find-to-list f3-projects-dir "-type d -maxdepth 1")))
         (project-names
          (mapcar 'car projects-hash))
         (user-selection
          (ido-completing-read "Switch project:" project-names))
         (selection-pair
          (assoc user-selection projects-hash))
         (selected-project (cdr selection-pair)))
    (f3-load-project selected-project)))

(defun f3-load-project (dir)
  (interactive "DProject directory")
  (setq f3-current-project-dir dir)
  (setq f3-current-project-name (file-name-nondirectory dir))
  (setq f3-current-project-list
        (f3-filter
         (find-to-list dir)))
  (message (format "Loaded %d files from project \"%s\"" (length f3-current-project-list) f3-current-project-name)))

(defun f3-current-project ()
  (interactive)
  (if (boundp 'f3-current-project-list)
      (ido-fild-file-from-list f3-current-project-list f3-current-project-dir)
    (message "No project selected")))


(defalias 'f3 'f3-current-project)

(defun ido-fild-file-from-list (list &optional opt_prefix)
  (let* ((prefix
         (or opt_prefix ""))
        (truncated-list
         (mapcar (lambda (full)
                   (substring full (length prefix)))
                 list))

        (selection (ido-completing-read "Open:" truncated-list))
        (file (concat prefix selection)))
    (find-file file)))

(defun find-to-list (dir &optional params)
  (split-string
   (with-temp-buffer
     (shell-command
      (concat f3-find-command " " dir " " params) t)
     (buffer-string))
   "\n"
   t))

(provide 'dancar-f3)
