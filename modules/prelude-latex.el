;;; prelude-latex.el --- Emacs Prelude: Sane setup for LaTeX writers.
;;
;; Copyright © 2011-2017 Bozhidar Batsov
;;
;; Author: Bozhidar Batsov <bozhidar@batsov.com>
;; URL: https://github.com/bbatsov/prelude
;; Version: 1.0.0
;; Keywords: convenience

;; This file is not part of GNU Emacs.

;;; Commentary:

;; Nice defaults for the premium LaTeX editing mode auctex.

;;; License:

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 3
;; of the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Code:

(prelude-require-packages '(auctex cdlatex))
(require 'smartparens-latex)
;; for case
(require 'cl)

(eval-after-load "company"
  '(progn
     (prelude-require-packages '(company-auctex))
     (company-auctex-init)))

(defcustom prelude-latex-fast-math-entry 'LaTeX-math-mode
  "Method used for fast math symbol entry in LaTeX."
  :link '(function-link :tag "AUCTeX Math Mode" LaTeX-math-mode)
  :link '(emacs-commentary-link :tag "CDLaTeX" "cdlatex.el")
  :group 'prelude
  :type '(choice (const :tag "None" nil)
                 (const :tag "AUCTeX Math Mode" LaTeX-math-mode)
                 (const :tag "CDLaTeX" cdlatex)))

;; AUCTeX configuration
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-close-quote "")
(setq TeX-open-quote "")

(setq-default TeX-master nil)

;; use pdflatex
(setq TeX-PDF-mode t)

;; sensible defaults for OS X, other OSes should be covered out-of-the-box
(when (eq system-type 'darwin)
  (setq TeX-view-program-selection
        '((output-dvi "DVI Viewer")
          (output-pdf "PDF Viewer")
          (output-html "HTML Viewer")))

  (setq TeX-view-program-list
        '(("DVI Viewer" "open %o")
          ("PDF Viewer" "okular --unique %o#src:%n%b")
          ("HTML Viewer" "open %o"))))
(setq TeX-view-program-selection
      '((output-pdf "Okular")))


(defun prelude-latex-mode-defaults ()
  "Default Prelude hook for `LaTeX-mode'."
  (turn-on-auto-fill)
  (abbrev-mode +1)
  (smartparens-mode +1)
  (visual-line-mode)
  (turn-on-reftex)
  (case prelude-latex-fast-math-entry
    (LaTeX-math-mode (LaTeX-math-mode 1))
    (cdlatex (turn-on-cdlatex))))

(setq prelude-latex-mode-hook 'prelude-latex-mode-defaults)

(add-hook 'LaTeX-mode-hook (lambda ()
                             (run-hooks 'prelude-latex-mode-hook)))

;; syctex
(setq TeX-source-correlate-method 'synctex)
(setq TeX-source-correlate-mode t)
(setq TeX-source-correlate-start-server t)

(setq reftex-plug-into-auctex t)
(setq LaTeX-eqnarray-label "eq:"
      LaTeX-amsmath-label "eq:"
      LaTeX-equation-label "eq:"
      LaTeX-align-label "eq:"
      LaTeX-figure-label "fig:"
      LaTeX-table-label "tab:"
      LaTeX-section-label "sec:"
      LaTeX-subsection-label "sec:"
      LaTeX-myChapter-label "chap:"
      LaTeX-chapter-label "chap:"
      TeX-newline-function 'reindent-then-newline-and-indent
      LaTeX-section-hook
      '(LaTeX-section-heading
	LaTeX-section-title
	LaTeX-section-toc
	LaTeX-section-section
	LaTeX-section-label))
(setq reftex-default-bibliography '("/home/ayonga/Dropbox/Paper/bibliography/zotero.bib"))

(setq bibtex-completion-bibliography '("/home/ayonga/Dropbox/Paper/bibliography/zotero.bib"))
(setq helm-bibtex-bibliography '("/home/ayonga/Dropbox/Paper/bibliography/zotero.bib"))
;(add-hook 'TeX-mode-hook
;          (lambda() (define-key TeX-mode-map "\C-ch" 'helm-bibtex)) )
(setq bibtex-completion-library-path '("/home/ayonga/Papers/bibliography/pdf/"))
(setq bibtex-completion-pdf-field "File")
(setq bibtex-completion-pdf-open-function
      (lambda (fpath)
        (call-process "evince" nil 0 nil fpath)))

(setq reftex-label-alist '(AMSTeX))
(setq reftex-label-alist '((nil ?f nil "~\\figref{%s}" nil nil)))
(setq reftex-label-alist '((nil ?t nil "~\\tabref{%s}" nil nil)))
(setq reftex-label-alist '((nil ?s nil "~\\secref{%s}" nil nil)))
(setq reftex-label-alist '((nil ?e nil "~\\eqref{%s}" nil nil)))




;;(add-to-list 'LaTeX-label-alist '("theorem" . "thm:"))
(add-to-list 'reftex-label-alist
	       '("theorem" ?h "thm:" "~\\thmref{%s}"
		 nil ("Theorem" "thm") nil))
(add-to-list 'reftex-label-alist
	       '("lemma" ?l "lem:" "~\\lemref{%s}"
		 nil ("Lemma" "lem") nil))
(add-to-list 'reftex-label-alist
	       '("definition" ?d "defn:" "~\\defnref{%s}"
		 nil ("Definition" "defn") nil))
(add-to-list 'reftex-label-alist
	       '("corollary" ?c "cor:" "~\\corref{%s}"
		 nil ("Corollary" "cor") nil))
(add-to-list 'reftex-label-alist
	       '("example" ?x "ex:" "~\\exref{%s}"
		 nil ("Example" "ex") nil))
(add-to-list 'reftex-label-alist
	       '("proposition" ?p "prop:" "~\\propref{%s}"
		 nil ("Proposition" "prop") nil))
;;
;; set XeTeX mode in TeX/LaTeX
(add-hook 'LaTeX-mode-hook 
          (lambda()
             (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
             (setq TeX-command-default "LaTeX")
             (setq TeX-save-query nil)
             (setq TeX-show-compilation nil)))
(eval-after-load "tex"
  '(add-to-list 'TeX-command-list 
                '("Glossary" "makeindex -s %s.ist -o %s.gls %s.glo"
                  (lambda (name command file)
                    (TeX-run-compile name command file)
                    (TeX-process-set-variable file 'TeX-command-next TeX-command-default))
                  nil t :help "Create Glossary")))
;; Change this to the place where you store all the electronic versions.
;;(defvar bibtex-papers-directory "/home/ayonga/Papers/bibliography/pdf/")


;; Translates a BibTeX key into the base filename of the corresponding
;; file. Change to suit your conventions.
;; Mine is:
;; - author1-author2-author3.conferenceYYYY for the key
;; - author1-author2-author3_conferenceYYYY.{ps,pdf} for the file
;; (defun bibtex-key->base-filename (key)
;;   (concat bibtex-papers-directory
;;           (replace-regexp-in-string "\\." "_" key)))

;; ;; Finds the BibTeX key the point is on.
;; ;; You might want to change the regexp if you use other strange characters in the keys.
;; (defun bibtex-key-at-point ()
;;   (let ((chars-in-key "A-Z-a-z0-9_:-\\."))
;;     (save-excursion
;;       (buffer-substring-no-properties
;;        (progn (skip-chars-backward chars-in-key) (point))
;;        (progn (skip-chars-forward chars-in-key) (point))))))

;; ;; Opens the appropriate viewer on the electronic version of the paper referenced at point.
;; ;; Again, customize to suit your preferences.
;; (defun browse-paper-at-point ()
;;   (interactive)
;;   (let ((base (bibtex-key->base-filename (bibtex-key-at-point))))
;;     (cond
;;      ((file-exists-p (concat base ".pdf"))
;;       (shell-command (concat "evince " base ".pdf &")))
;;      ((file-exists-p (concat base ".ps"))
;;       (shell-command (concat "gv " base ".ps &")))
;;      (t (message (concat "No electronic version available: " base ".{pdf,ps}"))))))

;; (global-set-key [S-f6] 'browse-paper-at-point)

;;Automatically insert non-breaking space before citation
(setq reftex-format-cite-function
      '(lambda (key fmt)
         (let ((cite (replace-regexp-in-string "%l" key fmt)))
           (if (or (= ?~ (string-to-char fmt))
                   (member (preceding-char) '(?\ ?\t ?\n ?~)))
               cite
             (concat "~" cite)))))

;; local configuration for TeX modes
(defun my-latex-mode-setup ()
  (setq-local company-backends
              (append '((company-math-symbols-latex company-latex-commands))
                      company-backends)))

(add-hook 'LaTex-mode-hook 'my-latex-mode-setup)

(provide 'prelude-latex)

;;; prelude-latex.el ends here
