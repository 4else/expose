; vim: ts=2 et sw=2 et:
(defstruct our 
  (help 
"sbcl --script lib.lisp [OPTIONS
(c) 2022, Tim Menzies, MIT license

Lets have some fun.")
  (options 
    '((b    "-b" "asda" 23)
      (p    "-p" "asda" 2)
      (help "-help" "asda" nil)
      (file "-f" "asda" "asdas")
      (q    "-q" "asda" 1000))))

(defvar *config* (make-our))

(defmethod print-object ((o our) s)
  (format s "~a~%~%OPTIONS:~%" (our-help o))
  (dolist (x (our-options o))
    (format s "  ~5a  ~30a = ~a~%" (second x) (third x) (fourth x))))

;;;; macros --------------------------------------------------------------------
(defmacro aif (test yes &optional no) 
  "Anaphoric if (using `it` as the variable)."
  `(let ((it ,test)) (if it ,yes ,no)))

(defmacro whale (expr &body body) 
  "Anaphoric while (using `a` as the variable)."
  `(do ((a ,expr ,expr)) ((not a)) ,@body))

(defmacro $ (x &optional (our *config*)) 
  "Access a variable name."
  `(fourth (assoc ',x (our-options ,our))))

(defmacro ? (s x &rest xs) 
  "Nested access to slots."
  (if (null xs) `(slot-value ,s ',x) `(? (slot-value ,s ',x) ,@xs)))

(defmacro with-csv ((lst file &optional out) &body body)
  "File row iterator."
  `(progn (csv ,file #'(lambda (,lst) ,@body)) ,out))

;;;; strings -------------------------------------------------------------------
(defun trim (x) 
  "Remove whitespace front and back."
  (string-trim '(#\Space #\Newline #\Tab) x))

(defun reads (x)
  "Prune strings, maybe coercing to a number."
  (if x (let ((x (trim x)))
          (if (equal "?" x)
            #\?
            (or (ignore-errors (read-from-string x)) x)))))

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

(defun num?(x)
  (let ((y (ignore-errors (read-from-string x))))
    (cond ((null y) x)
          ((numberp y) y)
          (t x))))

(defun cli (&optional (our (make-our)) (lst (args)))
  "Maybe update `our` with data from command line."
  (labels 
    ((cli1 (flag x) (aif (member flag lst :test #'equalp)
                          (cond ((equal x t)   nil) ; flip booleans
                                ((equal x nil) t)   ; flp booleans
                                (t (or (num? (second it)) x)))
                          x)))
    (dolist (x (our-options our) our)
      (setf (fourth x) (cli1 (second x) (fourth x))))))

(do-all-symbols(s *package*)
  (if (equal 0 (search "_" (string s) :test #'char=)) (print s)))

;;;; ---------------------------------------------------------------------------
(defun make () (load "lib"))

(defun _while(&aux (x '(1 2 3)))
  (whale (pop x) (print a)))

(defun _csv() 
  (let (head)
    (with-csv (line "../data/auto93.csv") 
      (if head
        (format t "~s~%" (mapcar #'reads line))
        (setf head line)))))

(setf *config* (cli (make-our)))
(if ($ help) (print *config*))
