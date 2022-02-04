; vim: ts=2 et sw=2 et:
(defstruct our
  (help "
sbcl --script lib.lisp [OPTIONS
(c) 2022, Tim Menzies, MIT license

Lets have some fun.")
  (format "  :~5a  ~30a  = ~a")
  (options 
    `((:b "asda" 23)
      (:p "asda" 2)
      (:k "asda" 41)
      (:file "asda" "asdas")
      (:q "asda" 1000))))

(defvar *config* (make-our))

;;;; ---------------------------------------------------------------------------
(defmacro aif (test yes &optional no) 
  `(let ((it ,test)) (if it ,yes ,no)))

(defmacro whale (expr &body body) 
  `(do ((a ,expr ,expr)) ((not a)) ,@body))

(defmacro $ (x &optional (our *config*)) 
  `(third (assoc ,x (our-options ,our))))

(defmacro ? (s x &rest xs) 
  (if (null xs) `(slot-value ,s ',x) `(? (slot-value ,s ',x) ,@xs)))

(defmacro with-csv ((lst file &optional out) &body body)
  `(progn (csv ,file #'(lambda (,lst) ,@body)) ,out))

;;;; ---------------------------------------------------------------------------
(defun args () 
  #+clisp (coerce (EXT:ARGV) 'list) 
  #+sbcl  (cdr sb-ext:*posix-argv*))

(defun trim (x) 
  (string-trim '(#\Space #\Newline #\Tab) x))

(defun reads (x &optional stringp)
  (let ((x (trim x)))
    (cond (stringp x)
          ((equal "?" x) #\?)
          (t (or (ignore-errors (read-from-string x)) x)))))

(defun subseqs (s &optional (sep #\,) (n 0))
  (aif (position sep s :start n)
    (cons (subseq s n it) (subseqs s sep (1+ it)))
    (list (subseq s n))))

(defun csv (file &optional (fn #'print))
  (with-open-file (str file)
    (loop (funcall fn 
       (mapcar #'(lambda (x) (reads x t)) 
         (subseqs (or (read-line str nil) (return-from csv))))))))

;;;; ---------------------------------------------------------------------------
(defmacro flag (x) `(first ,x))
(defmacro val  (x) `(third ,x))

(defun cli (our &optional (lst (args)))
  (dolist (x (our-options our) our)
      (setf (val x)
            (aif (position (flag x) lst)
              (cond ((equal  (val x) t) nil)
                    ((equal (val x) nil) t)
                    (t  (reads (nth (1+ it) lst))))
              (val x)))))

;;;; ---------------------------------------------------------------------------
(defun make () (load "lib"))

;;;; ---------------------------------------------------------------------------
(defun _while(&aux (x '(1 2 3)))
  (whale (pop x) (print a)))


(defun _csv() 
  (let (head)
    (with-csv (line "../data/auto93.csv") 
      (if head
        (format t "~s~%" (mapcar #'reads line))
        (setf head line)))))

(print (cli (make-our)))
