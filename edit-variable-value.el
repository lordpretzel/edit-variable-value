;;; edit-variable-value.el --- DESCRIPTION -*- lexical-binding: t -*-

;; Author: Boris Glavic <lordpretzel@gmail.com>
;; Maintainer: Boris Glavic <lordpretzel@gmail.com>
;; Version: 0.1
;; Package-Requires: ((counsel "0.13.1"))
;; Homepage: https://github.com/lordpretzel/edit-variable-value
;; Keywords:


;; This file is not part of GNU Emacs

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; For a full copy of the GNU General Public License
;; see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:

;; ********************************************************************************
;; IMPORTS
(require 'counsel)

;; ********************************************************************************
;; CUSTOM

;; ********************************************************************************
;; FUNCTIONS

;; helper functions
(defun edit-variable-value/edit-variable-value-commit ()
  "Finish editing a variable's value and evaluate the buffer to update the variable's update."
  (interactive)
  (eval-buffer)
  (kill-buffer)
  )

(defun edit-variable-value/edit-variable-value-abort ()
  "Finish editing a variable's value and abort (do not update the variable)."
  (interactive)
  (kill-buffer)
  )

;; minor mode for editing variable values (set's up standard key bindings)
(define-minor-mode edit-variable-value-edit-variable-mode
  "Minor mode for setting up keys when viewing a mu4e email in xwidgets."
  ;; The initial value - Set to 1 to enable by default
  :init-value nil
  ;; The indicator for the mode line.
  :lighter "Edit Var"
  ;; The minor mode keymap
  :keymap `(
            (,(kbd "C-c C-c") . edit-variable-value/edit-variable-value-commit)
            (,(kbd "C-c C-k") . edit-variable-value/edit-variable-value-abort)
            )
  ;; Make mode global rather than buffer local
  :global nil
  )

;; function for editing the value of a symbol (variable) in a scratch buffer
;;;###autoload
(defun edit-variable-value/edit-variable-value (symbol-or-name)
  "Take the current value of variable `SYMBOL-OR-NAME' (a symbol or a string that is the name of the variable) and create a buffer for editing a `setq' expression for this variable.  The purpose is to edit the current value of the variable as a elisp datastructure."
  (let* ((symname (if (stringp symbol-or-name)
                      symbol-or-name
                    (symbol-name symbol-or-name)
                    ))
         (sym (if (stringp symbol-or-name)
                  (intern symbol-or-name)
                symbol-or-name
                ))
         (bufname (concat "*Edit Variable: " symname "*"))
         (buf (get-buffer-create bufname))
         (val (symbol-value sym))
         (valstr (cond
                  ;; return primitive types literally
                  ((or (stringp val) (integerp val) (floatp val)) val)
                  ;; otherwise we have to quote
                  (t (concat "'" (pp-to-string val)))
                  ))
         )
    (switch-to-buffer buf)
    (with-current-buffer buf
      (delete-region (point-min) (point-max))
      (insert (format ";; Use this buffer to edit the variable %s.\n;; Press C-c C-k to close the buffer without applying your edits.\n;; Press C-c C-c to evaluate the buffer before closing it.\n\n" symname))
      (insert (format "(setq %s\n\t%s\n\t)" symname valstr))
      (emacs-lisp-mode)
      (edit-variable-value-edit-variable-mode 1)
      )
    )
  )

;; setup as an option in `counsel-describe-variable'
(ivy-add-actions
   'counsel-describe-variable
   '(("e" edit-variable-value/edit-variable-value "edit variable's value as elisp code")))

(provide 'edit-variable-value)
;;; edit-variable-value.el ends here
