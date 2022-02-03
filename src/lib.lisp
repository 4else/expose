; vim: ts=2 et sw=2 et:
;;;; ---------------------------------------------------------------------------
(defmacro aif (test yes &optional no) 
  `(let ((it ,test)) (if it ,yes ,no)))

(defmacro whale (expr &body body) 
  `(do ((a ,expr ,expr)) ((not a)) ,@body))

(defmacro $ (x) 
  `(opt-value (cdr (assoc *config* ,x))))

(defmacro ? (s x &rest xs) 
  (if (null xs) `(slot-value ,s ',x) `(? (slot-value ,s ',x) ,@xs)))

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

(defun opt (key help value) 
  (labels ((cli (&optional (com (copy-tree (args))))
                (aif (pop com)
                  (if (eql key (reads it))
                    (cond ((equal value "true") nil)
                          ((equal value "false") t)
                          (t (and com (reads (pop com)))))
                    (cli com)))))
    (cons key (%make-option :key key :help help :value (or (cli) value)))))

(defun %show-option (x str depth)
  (declare (ignore depth))
  (format str "  :~5a  ~30a  = ~a" (string-downcase (? x key)) (? x help) (? x value)))

(defstruct (option (:print-function %show-option)
                   (:constructor %make-option)) key value help)

(defun help ()
  "sbcl --script lib.lisp [OPTIONS
(c) 2022, Tim Menzies, MIT licence

Lets have some fun.

OPTIONS:"
  (list (opt :b "asda" 23)
        (opt :p "asda" 2)
        (opt :k "asda" 41)
        (opt :file "asda" "asdas")
        (opt :q "asda" 1000)))

;;;; ---------------------------------------------------------------------------
(defun make () (load "lib"))

(defun subseqs (s &optional (sep #\,) (n 0))
  (aif (position sep s :start n)
    (cons (subseq s n it) (subseqs s sep (1+ it)))
    (list (subseq s n))))

(defun csv (file &optional (fn #'print))
  (with-open-file (str file)
    (loop (funcall fn 
       (mapcar #'(lambda (x) (reads x t)) 
         (subseqs (or (read-line str nil) (return-from csv))))))))

(defmacro with-csv ((lst file &optional out) &body body)
  `(progn (csv ,file #'(lambda (,lst) ,@body)) ,out))

;;;; ---------------------------------------------------------------------------
(defun _while(&aux (x '(1 2 3)))
  (whale (pop x) (print a)))


(defun _csv() 
  (let (head)
    (with-csv (line "../data/auto93.csv") 
      (if head
        (format t "~s~%" (mapcar #'reads line))
        (setf head line)))))

(mapc #'print (mapcar #'cdr (help)))
