; vim: ts=2 et sw=2 et:
(defun make () (load "lib"))
(defun options() "
lisp lib.lisp [OPTIONS]

OPTIONS
  :ass  asdasas   = 23
  :help asdasassd = true
  :b    asaasdas  = 100")


(defmacro aif (test yes &optional no) 
  `(let ((it ,test)) (if it ,yes ,no)))

(defmacro whale (expr &body body) 
  `(do ((a ,expr ,expr)) ((not a)) ,@body))


(defmacro ? (p x &rest xs) 
  (if (null xs) `(slot-value ,p ,x) `(? (slot-value ,p ,x) ,@xs)))

(defun args () 
  #+clisp (coerce (EXT:ARGV) 'list) 
  #+sbcl  (cdr sb-ext:*posix-argv*))

(defun trim (x) 
  (string-trim '(#\Space #\Newline #\Tab) x))

(defun subseqs (s &optional (sep #\,) (n 0))
  (aif (position sep s :start n)
    (cons (subseq s n it) (subseqs s sep (1+ it)))
    (list (subseq s n))))

(defun cell(x)
  (if (equal "?" x) 
    #\? 
    (let ((y (read-from-string x)))
      (if (numberp y) y x))))

(defun csv (file &optional (fn #'print))
  (with-open-file (str file)
    (loop (funcall fn 
       (mapcar #'trim 
         (subseqs (or (read-line str nil) (return-from csv))))))))

(defmacro with-csv ((lst file &optional out) &body body)
  `(progn (csv ,file #'(lambda (,lst) ,@body)) ,out))

;;;; ------------------------------------------------
(defmacro $ (x) `(opt-value (cdr (assoc *config* ,x))))

(defstruct (option (:print-function (lambda(x s _) (format s "1"))
                    :constructor %make-option)) 
  key value help)

(defun make-option (key help value) 
  (labels ((cli (key value &optional (com (copy-tree (args)))) 
                (aif (pop com)
                  (if (eql key (ignore-errors (read-from-string it)))
                    (cond ((equal value "true") nil)
                          ((equal value "false") t)
                          (t (ignore-errors (read-from-string (pop com)))))
                    (cli key value com)))))
    (cons key (%make-option :key key :help help :value (or (cli key value) value)))))

(defun config ()
  (list 
    (make-option :b "asda" 23)
    (make-option :p "asda" 2)
    (make-option :k "asda" 41)
    (make-option :file "asda" "asdas")
    (make-option :q "asda" 1000)))

(defun _while(&aux (x '(1 2 3)))
  (whale (pop x) (print a)))

(defun _args() (cli :aa "sad"))

(defun _csv() 
  (let (head)
    (with-csv (line "../data/auto93.csv") 
      (if head
        (format t "~s~%" (mapcar #'cell line))
        (setf head line)))))

(print (config))
