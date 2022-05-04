;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                        ;             keybindings             ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "C-z") 'undo-tree-undo)
(global-set-key (kbd "M-z") 'undo-tree-redo)

(global-set-key (kbd "C-x C-z") 'comment-or-uncomment-region)

(global-set-key (kbd "C-x y") 'find-file-at-point)

(after! org-mode
  (define-key org-mode-map (kbd "C-M-g") 'org-mark-ring-goto)
  (define-key org-mode-map (kbd "C-c n e") 'org-noter))

;(define-key org-mode-map (kbd "C-n") 'next-line)
(global-set-key (kbd "M-l") 'other-window)
(global-set-key (kbd "C-M-l") 'previous-window-any-frame)

;;(define-key python-mode-map (kbd "C-M-l") 'previous-window-any-frame)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                        ;               org-mode              ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq
 org-agenda-files (list
                   (concat org-directory "goals/")))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                        ;               org-roam              ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq org-roam-directory (file-truename "~/org/Notes"))
(setq org-roam-dailies-directory (file-truename "~/org/daily/"))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                        ;               org-ref               ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package! org-ref)


(setq bibtex-completion-bibliography '("~/org/references/dna.bib"
                                       "~/org/references/references.bib"
                                       "~/org/references/unread_references.bib"
                                       "~/org/references/photonics.bib"
                                       "~/org/references/machine_learning.bib"
                                       "~/org/references/nanoparticles.bib"
                                       "~/org/references/self-assembly.bib"
                                       "~/org/references/chemistry.bib"
                                       "~/org/references/quantum-dots.bib")
      bibtex-completion-library-path '("~/org/articles/")
      bibtex-completion-notes-path "~/org/Notes/Lit/"
      bibtex-completion-notes-template-multiple-files "* ${author-or-editor}, ${title}, ${journal}, (${year}) :${=type=}: \n\nSee [[cite:&${=key=}]]\n"
      bibtex-completion-additional-search-fields '(keywords)
      bibtex-completion-display-formats
      '((article       . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} ${journal:40}")
        (inbook        . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} Chapter ${chapter:32}")
        (incollection  . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} ${booktitle:40}")
        (inproceedings . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} ${booktitle:40}")
        (t             . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*}"))
      bibtex-completion-pdf-open-function
      (lambda (fpath)
        (call-process "open" nil 0 nil fpath)))


(setq bibtex-autokey-year-length 7
	bibtex-autokey-name-year-separator "_"
	bibtex-autokey-year-title-separator "_"
	bibtex-autokey-titleword-separator "_"
	bibtex-autokey-titlewords 200
	bibtex-autokey-titlewords-stretch 200
	bibtex-autokey-titleword-length 200
	org-ref-bibtex-hydra-key-binding (kbd "H-b"))

(define-key bibtex-mode-map (kbd "H-b") 'org-ref-bibtex-hydra/body)


(setq org-ref-insert-link-function 'org-ref-insert-link-hydra/body
      org-ref-insert-cite-function 'org-ref-cite-insert-ivy
      org-ref-insert-label-function 'org-ref-insert-label-link
      org-ref-insert-ref-function 'org-ref-insert-ref-link
      org-ref-cite-onclick-function (lambda (_) (org-ref-citation-hydra/body)))

(define-key org-mode-map (kbd "C-c ]") 'org-ref-insert-link)

(after! org-ref
  (setq bibtex-dialect "BibTeX"))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                        ;           org-roam-bibtex           ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (use-package! org-roam-bibtex
;;   :after org-roam
;;   :config
;;   (require 'org-ref)) ; optional: if Org Ref is not loaded anywhere else, load it here


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                        ;             org-download            ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(after! org-download
  (setq org-download-method 'directory
        org-download-image-dir "~/org/images/"
        org-download-screenshot-method "gnome-screenshot -a -f %s"))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                        ;                org-fc               ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package! org-fc
  :custom (org-fc-directories '("~/org/Notes/Lit/" "~/org/Notes/Evergreen/"))
  :config
  (require 'org-fc-hydra)
  (setq org-fc-review-history-file "~/org/org-fc-reviews.tsv"))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                        ;             Latex Setup             ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;(setq org-latex-packages-alist nil)
(add-to-list 'org-latex-packages-alist '("" "physics" t))
;(add-to-list 'org-latex-packages-alist '("" "graphicx" t))
(add-to-list 'org-latex-packages-alist '("" "mhchem" t))
(add-to-list 'org-latex-packages-alist '("" "siunitx" t))
(add-to-list 'org-latex-packages-alist '("" "/home/user/.doom.d/latex_images/rcurs" t))
;org-latex-packages-alist
;; \def\rcurs{{\mbox{$\resizebox{.16in}{.08in}{\includegraphics{ScriptR}}$}}}
;; \def\brcurs{{\mbox{$\resizebox{.16in}{.08in}{\includegraphics{BoldR}}$}}}
;; \def\hrcurs{{\mbox{$\hat \brcurs$}}}
org-preview-latex-process-alist



(after! org-pomodoro
  (setq org-pomodoro-length 45))


(after! sly
  (setq sly-lisp-implementations
      '((sbcl ("sbcl" "--dynamic-space-size" "81920")))))



(after! elfeed-org
  ;
  ;
  ;(setq elfeed-db-directory "~/.elfeed")
  (setq rmh-elfeed-org-files (list "~/org/rss.org")))
; elfeed-feeds

;; (defun my-display-current-entry-feed ()
;;   (interactive)
;;   (let ((entry (elfeed-search-selected t)))
;;     (when entry
;;       (let ((feed (elfeed-entry-feed entry)))
;;         (message "%s" (elfeed-feed-url feed))))))

;; (defun my-unsubscribe-current-feed ()
;;   (interactive)
;;   (let ((entry (elfeed-search-selected t)))
;;     (when entry
;;       (let* ((feed (elfeed-entry-feed entry))
;;              (url (elfeed-feed-url feed)))
;;         (setf elfeed-feeds
;;               (cl-remove url elfeed-feeds
;;                          :test #'equal
;;                          :key (lambda (e) (if (listp e) (car e) e)))))
;;       (customize-save-variable 'elfeed-feeds elfeed-feeds))))


;(elfeed-db-gc)


(setq org-cite-global-bibliography '("~/org/references/dna.bib"
                                       "~/org/references/references.bib"
                                       "~/org/references/unread_references.bib"
                                       "~/org/references/photonics.bib"
                                       "~/org/references/machine_learning.bib"
                                       "~/org/references/nanoparticles.bib"
                                       "~/org/references/self-assembly.bib"
                                       "~/org/references/chemistry.bib"
                                       "~/org/references/quantum-dots.bib"))

;(define-key ivy-mode-map (kbd "C-M j") 'ivy-immediate-done)
