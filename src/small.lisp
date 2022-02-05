; vim: ts=2 sw=2 et:
(defpackage :small (:use :cl))
(in-package :small)
(defstruct our 
  (help 
"sbcl --script lib.lisp [OPTIONS
(c) 2022, Tim Menzies, MIT license

Lets have some fun.")
  (options 
    '((enough  "-e" "enough items for a sample"  512)
      (file    "-f" "read data from file      "  "../data/auto93.csv")
      (help    "-h" "show help                "  nil)
      (license "-l" "show license             "  nil)
      (p       "-p" "euclidean coefficient    "  2)
      (seed    "-s" "random number seed       "  10019)
      (todo    "-t" "start up action          "  "")))
  (copyright "
Copyright (c) 2022 Tim Menzies
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS 'AS IS'
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
AUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."))

(defvar *config* (make-our))

;;;; macros --------------------------------------------------------------------

;;;; macros --------------------------------------------------------------------
(defmacro aif (test yes &optional no) 
  "Anaphoric if (traps result of conditional in `it`)."
  `(let ((it ,test)) (if it ,yes ,no)))

(defmacro whale (expr &body body) 
  "Anaphoric while (traps result of conditional in `a`)."
  `(do ((a ,expr ,expr)) ((not a)) ,@body))

(defmacro ? (s x &rest xs) 
  "Nested access to slots."
  (if (null xs) `(slot-value ,s ',x) `(? (slot-value ,s ',x) ,@xs)))

(defmacro $ (x &optional (our *config*)) 
  "Access  a config variable name."
  `(fourth (assoc ',x (our-options ,our))))

(defmacro with-csv ((lst file &optional out) &body body)
  "File row iterator."
  `(progn (csv ,file #'(lambda (,lst) ,@body)) ,out))

(defmacro inca (x a &optional (inc  1))
  `(incf (cdr (or (assoc ,x ,a :test #'equal)
                  (car (setf ,a (cons (cons ,x 0) ,a))))) ,inc))

;;;; random  ----------------------------------------------------------
(defun randf (&optional (n 1.0)) 
  (setf ($ seed)  (mod (* 16807.0d0 ($ seed)) 2147483647.0d0))
  (* n (- 1.0d0 (/ ($ seed)                   2147483647.0d0))))

(defun randi (&optional (n 1)) 
  (floor (* n (/ (randf 1000000.0) 1000000))))

;;;; strings -------------------------------------------------------------------
(defun trim (x) 
  "Remove whitespace front and back."
  (string-trim '(#\Space #\Newline #\Tab) x))

(defun num?(x)
  "Return a number, if you can. Else return trimmed string."
  (let ((y (ignore-errors (read-from-string x))))
    (if (numberp y) y (let ((x (trim x)))
                        (if (equal x "?") #\? x)))))

(defun subseqs (s &optional (sep #\,) (n 0))
  "Separate string on `sep`."
  (aif (position sep s :start n)
    (cons (subseq s n it) (subseqs s sep (1+ it)))
    (list (subseq s n))))

;;;; operating system ----------------------------------------------------------
(defun args () 
  "Return list of command line arguments."
  #+clisp (cdddr (cddr (coerce (EXT:ARGV) 'list)))
  #+sbcl  (cdr sb-ext:*posix-argv*))

(defun csv (file &optional (fn #'print))
  "Send to `fn` one list from each line."
  (with-open-file (str file)
    (loop (funcall fn 
         (subseqs (or (read-line str nil) (return-from csv)))))))

(defun cli (&optional (our (make-our)) (lst (args)))
  "Maybe update `our` with data from command line."
  (labels ((cli1 (flag x) (aif (member flag lst :test #'equalp)
                            (cond ((equal x t)   nil) ; flip boolean
                                  ((equal x nil) t)   ; flip boolean
                                  (t             (or (num? (second it)) x)))
                            x)))
    (dolist (x (our-options our) our)
      (setf (fourth x) (cli1 (second x) (fourth x))))))

;;;; our  ----------------------------------------------------------
(defmethod print-object ((o our) s)
  (format s "~a~%~%OPTIONS:~%" (our-help o))
  (dolist (x (our-options o))
    (format s "  ~5a  ~a = ~a~%" (second x) (third x) (fourth x))))

;;;; few  ----------------------------------------------------------------------

(defun add (s x)
  (unless (eq x #\?)
    (incf (? s n))
    (add1 s x))
  x)

(defun adds (s lst)
  (dolist (new lst s) (add s new)))

(defstruct (few (:constructor %make-few)) 
  ok (n 0) (lst (make-array 5 :adjustable t :fill-pointer 0)) (max ($ enough)))

(defun make-few (&key init)
  (adds (%make-few) init))

(defmethod has ((f few))
  (with-slots (ok lst) f
    (unless ok
      (setf lst (sort lst #'<)
      ok t))
    lst))

(defmethod add1 ((f few) x)
  (setf (? f ok) nil)
  (vector-push-extend x (? f lst)))

;;;; num  ----------------------------------------------------------------------
(defstruct (num (:constructor %make-num))
  (n 0) (w 1) (at 0) (txt "") (all (make-few)) 
  (lo most-positive-fixnum) (hi most-negative-fixnum))

(defun make-num (&key init (txt "") (at 0) )
  (adds (%make-num :txt txt :at at :w (if (find #\< txt) -1 1)) init))

(defmethod add1 ((n num) x)
  (with-slots (n lo hi all) n
      (incf n)
      (setf lo (min x lo)
            hi (max x hi))
      (add all x)))

;;;; sym  ---------------------------------------------------------------------=
(defstruct (sym (:constructor %make-sym))
  mode seen (n 0) (at 0) (txt "") (most 0))

(defun make-sym (&key init (txt "") (at 0) )
  (adds (%make-sym :txt txt :at at) init))

(defmethod add1 ((s sym) x)
  (with-slots (n seen most mode) s
    (let ((now (inca x seen)))
      (if (> now most)
        (setf most now
              mode x)))))

;;;; ---------------------------------------------------------------------------
(defvar *tests* nil)
(defvar *fails* 0)

(defmacro deftest (name params  doc  &body body)
  `(progn (pushnew  ',name *tests*) 
          (defun ,name ,params ,doc ,@body)))

(defun demos (&optional what)
  (dolist (one *tests*)
    (let* ((what (string-upcase (string what)))
           (txt  (string-upcase (string one)))
           (doc  (documentation one 'function)))
      (when (or (not what) (search  what txt))
        (setf *config* (cli (make-our)))
        (multiple-value-bind (_ err)
          (ignore-errors (funcall one))
          (incf *fails* (if err 1 0))
          (if err
            (format t "~&~a [~a] ~a ~a~%" "FAIL" one doc err)
            (format t "~&~a [~a] ~a~%"    "PASS" one doc)))))))  

(defun make () (load "lib"))

(deftest whale.(&aux (x '(1 2 3)))
  (whale (pop x) (print a)))

(deftest csv.() 
  (let (head)
    (with-csv (line "../data/auto93.csv") 
      (if head
        (format t "~s~%" (mapcar #'num? line))
        (setf head line)))))

(deftest num.()
  (print (has (? (make-num :init '(1 2 4 #\? 1 1 1 1 1 11 )) all))))

;;;; ---------------------------------------------------------------------------
(setf *config* (cli (make-our)))
(if ($ help) (print *config*))
(if ($ license) (princ (our-copyright *config*)))
(demos ($ todo))
