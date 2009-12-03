;;; lisp-skels.el --- Skeletons for lisp coding

;; Copyright (C) 1999 by Tom Breton
;; Author: Tom Breton <tob@world.std.com>
;; Created: 19 Jan, 1999
;; Version: 0.1
;; Keywords: extensions

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Install:

;; Put this file in your load-path and add...

;; (autoload 'tehom-lisp-skel-keymap "lisp-skels" 
;;   "Lisp skeletons" t 'keymap)
;;
;; (add-hook 'emacs-lisp-mode-hook
;;   ( function
;;     ( lambda ()
;;       (define-key shared-lisp-mode-map "\C-ci"
;;	 tehom-lisp-skel-keymap))))

;;  ... to your .emacs

;;Or to use this in co-operation with expand.el, use... 

;;(defvar tehom-lisp-mode-expand-list nil 
;;  "Expand-list for lisp skeletons.")

;;(autoload 'tehom-lisp-skel-keymap "lisp-skels" 
;;  "Keymap for lisp skeletons" t 'keymap)

;;(add-hook 'emacs-lisp-mode-hook
;;  ( function
;;    ( lambda ()
;;      (require 'lisp-skels)
;;      (define-key shared-lisp-mode-map "\C-ci"
;;	tehom-lisp-skel-keymap)

;;      (expand-add-abbrevs 
;;	lisp-mode-abbrev-table tehom-lisp-mode-expand-list)
;;      (abbrev-mode 1)
;;      )))

;;...instead.

;;; Commentary:

;; This module is pretty simple: It's a bunch of skeletons as per
;; skeleton.el, a list so that expand.el can interoperate with it, and
;; 1 keymap so you can quickly call the skeletons manually.

;; Try these skeletons with a prefix of -1 (Usually bound to M--) and
;; a hylited region:  They'll wrap around it.  It's often useful.

;;; Changelog:

;;1999-09-07  Tom Breton  <tob@world.std.com>

;;	* lisp-skels.el: Changed "let" to "lett", because the former
;;        word just occurs too often in English.

;;1999-06-11  Tom Breton  <tob@world.std.com>

;;	* lisp-skels.el: Changed various whitespace so that "( defthing"
;;      is now "(defthing"

;;1999-06-01  Tom Breton  <tob@world.std.com>

;;	* lisp-skels.el: (tehom-defstruct-skel) New function
;;	(tehom-lisp-mode-expand-list): Added tehom-defstruct-skel
;;	(tehom-lisp-skel-keymap): Added tehom-defstruct-skel

;;
;;1999-01-25  Tom Breton  <tob@world.std.com>

;;	* lisp-skels.el: Fixed installation instructions
;;	Added (require 'skeleton)
;;	(tehom-lisp-mode-expand-list): New variable for inter-operating
;;	with expand.el 
;;	Added autoloads
;;	(tehom-let-skel): Changed.
;;	(tehom-defun-skel): Changed.
;;	(tehom-defsubst-skel): New function
;;	(tehom-defmacro-skel): New function
;;	(tehom-defadvice-skel): New function
;;	(tehom-defconst-skel): New function
;;	(tehom-defvar-skel): New function
;;	(tehom-save-excursion-skel): New function
;;	(tehom-autoload-skel): New function


;;; Code:

(require 'skeleton)

(define-skeleton tehom-let-skel
  "Insert a let in all its glory."

  nil
  \n > "(let* "
  \n > "(" @ ")"
  \n > _
  \n > ")"
  )

(define-skeleton tehom-lambda-skel
  "Insert a quoted lambda."

  nil
  \n > "#'(lambda (" @ ")"
  \n > _
  \n > ")"
  )

(define-skeleton tehom-defun-skel
  "Insert a defun in all its glory."

  nil
  \n > "(defun " _ " (" @ ")"
  \n  "\"" @ "\""
  \n
  \n > "(interactive)"
  \n > "(let*" 
  \n > "(" @ ")"
  \n > @
  \n > "))"
  )

(define-skeleton tehom-defsubst-skel
  "Insert a defsubst skeleton."
  nil
  \n > "(defsubst " _ " (" @ ")"
  \n  "\"" @ "\""
  \n > "(let*" 
  \n > "(" @ ")"
  \n > @
  \n > "))"
)

(define-skeleton tehom-defstruct-skel
  "Insert a defstruct skeleton."
  nil
  \n > "(defstruct " _ 
  \n  "\"" @ "\""
  \n > ")"
)

(define-skeleton tehom-defmacro-skel
  "Insert a macro skeleton."
  nil
  \n > "(defmacro " @ " (" @ ")"
  \n  "\"" @ "\""
  \n
  \n > "`(" 
  \n > _
  \n > "))"
)

(define-skeleton tehom-defadvice-skel
  "Insert a defadvice skeleton."
  nil
  \n > "(defadvice " @ " ( around act )"
  \n  "\"" @ "\""
  \n > _
  \n > ")"
)

(define-skeleton tehom-defconst-skel
  "Insert a defconst skeleton."
  nil
  \n > "(defconst " _ " \"" @ "\" )"
)

(define-skeleton tehom-defvar-skel
  "Insert a defvar skeleton."
  nil
  \n > "(defvar " _ " \"" @ "\" )"
)

(define-skeleton tehom-save-excursion-skel
  "Insert a save-excursion skeleton."
  nil
  \n > "(save-excursion"
  \n > _
  \n > ")"
)

(define-skeleton tehom-autoload-skel
  "Insert an autoload skeleton."
  nil
  \n "(autoload '" @ " \"" @ "\" t t)"
)

(define-skeleton tehom-pp-macroexpand-skel
  "Insert a \(pp \(macroexpand ... \)\) skeleton."
  nil
  \n > "(pp "
  \n > "(macroexpand"
  \n > _
  \n > "))"
  )

;;;###autoload (defvar tehom-lisp-mode-expand-list nil "Expand-list for lisp skeletons.")

(defconst tehom-lisp-mode-expand-list
  '(
     ( "defu" tehom-defun-skel)
     ( "lam"  tehom-lambda-skel)
     ( "defsu" tehom-defsubst-skel)
     ( "defst" tehom-defstruct-skel)
     ( "defm" tehom-defmacro-skel)
     ( "defa" tehom-defadvice-skel)
     ( "defc" tehom-defconst-skel)
     ( "defv" tehom-defvar-skel)
     ( "lett"  tehom-let-skel)
     ( "sav"  tehom-save-excursion-skel)
     ( "aut"  tehom-autoload-skel)
     ( "ppm"  tehom-pp-macroexpand-skel)

     )
  "Lisp skeleton list for expansion.")
 

;;;###autoload (autoload 'tehom-lisp-skel-keymap "lisp-skels" "Keymap for lisp skeletons" t 'keymap)

(defvar tehom-lisp-skel-keymap nil)
(if
  (null tehom-lisp-skel-keymap)
  (progn
    (setq
      tehom-lisp-skel-keymap
      (make-sparse-keymap 
	"Lisp skeletons"))

    (define-key tehom-lisp-skel-keymap "l" 'tehom-let-skel)
    (define-key tehom-lisp-skel-keymap "L" 'tehom-lambda-skel)
    (define-key tehom-lisp-skel-keymap "d" 'tehom-defun-skel)
    (define-key tehom-lisp-skel-keymap "s" 'tehom-defstruct-skel)
    (define-key tehom-lisp-skel-keymap "p" 'tehom-pp-macroexpand-skel)
    
    ))

;;;###autoload (add-hook 'emacs-lisp-mode-hook
;;;###autoload   ( function
;;;###autoload     ( lambda ()
;;;###autoload       (require 'lisp-skels)
;;;###autoload       (define-key shared-lisp-mode-map "\C-ci"
;;;###autoload 	tehom-lisp-skel-keymap)
;;;###autoload       (expand-add-abbrevs 
;;;###autoload 	lisp-mode-abbrev-table tehom-lisp-mode-expand-list)
;;;###autoload       (abbrev-mode 1)
;;;###autoload       )))



(provide 'lisp-skels )

;;; lisp-skels.el ends here