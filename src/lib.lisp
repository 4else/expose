; vim: ts=2 et sw=2 et:
(defun options() "
lisp lib.lisp [OPTIONS]

OPTIONS
  :ass  asdasas   = 23
  :help asdasassd = true
  :b    asaasdas  = 100")

(defmacro aif (test yes &optional no) 
  `(let ((it ,test)) (if it ,yes ,no)))

(defun args () 
  #+clisp (EXT:ARGV) #+sbcl (cdr sb-ext:*posix-argv*))

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

(labels ((csv (file &optional (fn #'print))
              (with-open-file (str file)
                (loop (funcall fn 
                   (mapcar #'trim 
                     (subseqs (or (read-line str nil) (return-from csv)))))))))
  (defmacro with-csv ((lst file &optional out) &body body)
    `(progn (csv ,file #'(lambda (,lst) ,@body)) ,out)))

(defun cli (lst)
  (let ((tmp (copy-tree (args))))
    (whale (pop tmp)
      (setf a (read-from-string a))
      (if (getf lst a) (setf (getf lst a) (read-from-string (car tmp))))))
  lst)

(dolist (one (subseqs (options) #\Newline)) 
  (if  (> (length one) 3) 
    (if (equal "  :" (subseq one 0 3))
       (let* ((words (subseqs one #\Space))
              (flag  (cell (third words)))
              (value (cell (car (last words)))))
             (print `(flag ,flag value ,value))))))

(let (head)
  (with-csv (line "../data/auto93.csv") 
    (if head
        (format t "~s~%" (mapcar #'cell line))
        (setf head line))))
