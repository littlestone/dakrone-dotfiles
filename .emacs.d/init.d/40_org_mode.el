;; org-mode
(when (require 'org-install nil t)
  (define-key global-map (kbd "C-c l") 'org-store-link)
  (setq org-startup-truncated nil)
  (setq org-return-follows-link t)
  (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
  ;; (org-remember-insinuate)
  (setq org-directory user-emacs-directory)
;;  (setq org-startup-folded 'nofold)
  (setq org-use-fast-todo-selection t)
  (setq org-todo-keywords
        '((sequence "TODO(t)" "STARTED(s)" "WAITING(w)" "|" "DONE(x)" "CANCEL(c)")
          (sequence "APPT(a)" "|" "DONE(x)" "CANCEL(c)")))
  (setq org-todo-keyword-faces
        '(("TODO"      . org-warning)
          ("STARTED"   . (:foreground "deep sky blue" :weight bold))
          ("DONE"      . (:foreground "SpringGreen1" :weight bold))
          ("WAITING"   . (:foreground "orange" :weight bold))))

  ;; faces
  ;; (set-face-foreground 'org-block "green")
  ;; (set-face-foreground 'org-tag "green yellow")

  ;; function of org-open-at-point
  ;; (setf (cdr (assoc 'file org-link-frame-setup)) 'find-file))
  )

(eval-after-load "org"
  '(progn
     (define-key org-mode-map (kbd "C-t") 'org-mark-ring-goto)
     (define-key org-mode-map (kbd "C-M-<return>") 'org-insert-todo-heading)
     (define-key org-mode-map (kbd "C-c C-i") 'my/org-insert-pomodoro-template)
     (define-key org-mode-map (kbd "C-M-<tab>") 'show-all)
     (local-unset-key (kbd "M-S-<return>"))

     (smartrep-define-key
         org-mode-map "C-c" '(("f" . 'org-shiftright)
                              ("b" . 'org-shiftleft)))
     (smartrep-define-key
         org-mode-map "C-c" '(("C-n" . (outline-next-visible-heading 1))
                              ("C-p" . (outline-previous-visible-heading 1))))
     (setq org-clock-persist 'history)
     (org-clock-persistence-insinuate)))

(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))

(eval-after-load "org"
  '(progn
     (define-prefix-command 'org-todo-state-map)

     (define-key org-mode-map "\C-cx" 'org-todo-state-map)

     (define-key org-todo-state-map "x"
       #'(lambda nil (interactive) (org-todo "CANCELLED")))
     (define-key org-todo-state-map "d"
       #'(lambda nil (interactive) (org-todo "DONE")))
     (define-key org-todo-state-map "f"
       #'(lambda nil (interactive) (org-todo "DEFERRED")))
     (define-key org-todo-state-map "l"
       #'(lambda nil (interactive) (org-todo "DELEGATED")))
     (define-key org-todo-state-map "s"
       #'(lambda nil (interactive) (org-todo "STARTED")))
     (define-key org-todo-state-map "w"
       #'(lambda nil (interactive) (org-todo "WAITING")))

     ;;     (define-key org-agenda-mode-map "\C-n" 'next-line)
     ;;     (define-key org-agenda-keymap "\C-n" 'next-line)
     ;;     (define-key org-agenda-mode-map "\C-p" 'previous-line)
     ;;     (define-key org-agenda-keymap "\C-p" 'previous-line)
     ))

(add-hook 'org-mode-hook '(lambda ()
                            (define-key org-mode-map [C-tab] 'other-window)
                            (flyspell-mode -1)
                            (define-key org-mode-map [C-S-tab]
                              (lambda ()
                                (interactive)
                                (other-window -1)))))

;; Standard key bindings
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(define-key global-map "\C-cc" 'org-capture)
(setq org-directory (concat "~" (user-login-name) "/org"))
(setq org-agenda-files (list org-directory))
(setq org-completion-use-ido 't)
(setq org-refile-targets `((,(concat "~" (user-login-name)
                                     "/org/todo.org") . (:level . 1))))
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "todo.org" "Unsorted") "* TODO %i%?")
        ("n" "Notes" entry (file+headline "notes.org" "Notes") "** %? ")
        ("j" "Journal" entry (file+datetree "journal.org") "* %i%?")))

;;(add-hook 'remember-mode-hook 'org-remember-apply-template)

;;(define-key global-map [(control meta ?r)] 'remember)

;; (custom-set-variables
;;  '(org-agenda-files (quote ("~/agenda.org" "~/work.org")))
;;  '(org-default-notes-file "~/notes.org")
;;  '(org-agenda-ndays 7)
;;  '(org-deadline-warning-days 14)
;;  '(org-agenda-show-all-dates t)
;;  '(org-agenda-skip-deadline-if-done t)
;;  '(org-agenda-skip-scheduled-if-done t)
;;  '(org-agenda-start-on-weekday nil)
;;  '(org-reverse-note-order t)
;;  '(org-fast-tag-selection-single-key (quote expert))
;;  '(org-agenda-custom-commands
;;    (quote (("d" todo "DELEGATED" nil)
;;            ("c" todo "DONE|DEFERRED|CANCELLED" nil)
;;            ("w" todo "WAITING" nil)
;;            ("W" agenda "" ((org-agenda-ndays 21)))
;;            ("A" agenda ""
;;             ((org-agenda-skip-function
;;               (lambda nil
;;                 (org-agenda-skip-entry-if (quote notregexp) "\\=.*\\[#A\\]")))
;;              (org-agenda-ndays 1)
;;              (org-agenda-overriding-header "Today's Priority #A tasks: ")))
;;            ("u" alltodo ""
;;             ((org-agenda-skip-function
;;               (lambda nil
;;                 (org-agenda-skip-entry-if (quote scheduled) (quote deadline)
;;                                           (quote regexp) "<[^>\n]+>")))
;;              (org-agenda-overriding-header "Unscheduled TODO entries: "))))))
;;  '(org-remember-store-without-prompt t)
;;  '(org-remember-templates
;;    (quote ((116 "* TODO %?\n  %u" "~/agenda.org" "Tasks")
;;            (110 "* %u %?" "~/notes.org" "Notes"))))
;;  '(remember-annotation-functions (quote (org-remember-annotation)))
;;  '(remember-handler-functions (quote (org-remember-handler))))
