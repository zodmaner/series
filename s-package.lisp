;;;;-*- Mode: lisp; Package: SERIES -*-

;;;; The package initialization stuff is done here now, instead of in s-code.lisp.  This is based a comment by Bruno Haible who said
;;;;
;;;; "The difference with Harlequin LW might be due to the way symbols
;;;; are represented in .fas files. ANSI CL describes two approaches,
;;;; CLISP has taken one of them, other CLs the other one. The
;;;; important point is that the packages setup when you compile a
;;;; file must be identical to the packages setup when you load the
;;;; file....  What will help, 100%, is to have a file which issues
;;;; all the necessary `defpackage' forms, and make sure this file is
;;;; loaded before anything else and before any `compile-file'.

;;;; $Id: s-package.lisp,v 1.1 1999/07/02 19:52:32 toy Exp $
;;;;
;;;; $Log: s-package.lisp,v $
;;;; Revision 1.1  1999/07/02 19:52:32  toy
;;;; Initial revision
;;;;

;;; Add a feature to say if we are a Lisp that can hack ansi-cl style
;;; stuff, as far as series goes anyway.  This implies:
;;;	ansi style packages (DEFPACKAGE, CL not LISP as main package)
;;;
;;; if you don't have this you need to make the LISP package have CL
;;; as a nickname somehow, in any case.
;;;
#+gcl
(eval-when (compile load eval)
  (unless (find-package "CL")
    (rename-package "LISP" "COMMON-LISP" '("LISP" "CL"))))

;;; Note this is really too early, but we need it here
#+(or draft-ansi-cl draft-ansi-cl-2 ansi-cl allegro CMU Genera Harlequin-Common-Lisp CLISP)
(cl:eval-when (load eval compile)
  (cl:pushnew ':SERIES-ANSI cl:*features*))

(provide "SERIES")

#+(or Series-ANSI)
(defpackage "SERIES"
    (:use "CL")
  (:export 
   ;;(2) readmacros (#M and #Z)

   ;;(5) declarations and types (note dual meaning of series)
   "OPTIMIZABLE-SERIES-FUNCTION"  "OFF-LINE-PORT"  ;series
   "SERIES-ELEMENT-TYPE"  "PROPAGATE-ALTERABILITY"

   ;;(10) special functions
   "ALTER" "TO-ALTER" "ENCAPSULATED" "TERMINATE-PRODUCING"
   "NEXT-IN" "NEXT-OUT" "GENERATOR" "GATHERER" "RESULT-OF" "GATHERING"

   ;;(55) main line functions
   "MAKE-SERIES" "SERIES" "SCAN" "SCAN-MULTIPLE" "SCAN-RANGE"
   "SCAN-SUBLISTS" "SCAN-FN" "SCAN-FN-INCLUSIVE" "SCAN-LISTS-OF-LISTS"
   "SCAN-LISTS-OF-LISTS-FRINGE" "SCAN-FILE" "SCAN-STREAM" "SCAN-HASH" "SCAN-ALIST"
   "SCAN-PLIST" "SCAN-SYMBOLS" "COLLECT-FN" "COLLECT" "COLLECT-APPEND"
   "COLLECT-NCONC" "COLLECT-FILE" "COLLECT-ALIST" "COLLECT-PLIST"
   "COLLECT-HASH" "COLLECT-LENGTH" "COLLECT-SUM" "COLLECT-MAX"
   "COLLECT-MIN" "COLLECT-LAST" "COLLECT-FIRST" "COLLECT-NTH"
   "COLLECT-AND" "COLLECT-OR" "PREVIOUS" "MAP-FN" "ITERATE" "MAPPING"
   "COLLECTING-FN" "COTRUNCATE" "LATCH" "UNTIL" "UNTIL-IF" "POSITIONS"
   "CHOOSE" "CHOOSE-IF" "SPREAD" "EXPAND" "MASK" "SUBSERIES" "MINGLE"
   "CATENATE" "SPLIT" "SPLIT-IF" "PRODUCING" "CHUNK"

   ;;(5) variables
    "*SERIES-EXPRESSION-CACHE*"
    "*LAST-SERIES-LOOP*"
    "*LAST-SERIES-ERROR*"
    "*SUPPRESS-SERIES-WARNINGS*"
    )
  (:shadow
   "LET" "LET*" "MULTIPLE-VALUE-BIND" "FUNCALL" "DEFUN" #+cmu "COLLECT" #+cmu "ITERATE")
  #+Harlequin-Common-Lisp
  (:import-from "LISPWORKS" "COMPILER-LET")
  #+Genera
  (:import-from "LISP" "COMPILER-LET")
  #+Allegro
  (:import-from "CLTL1" "COMPILER-LET")
  #+CLISP
  (:import-from "LISP" "COMPILER-LET")
)

#+(or Series-ANSI)
(in-package "SERIES")

#-(or Series-ANSI)
(progn
  (in-package "SERIES" :use '("LISP"))
  (shadow '(let let* multiple-value-bind funcall defun)))


