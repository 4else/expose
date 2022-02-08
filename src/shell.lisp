;-------------------------------------
(defstruct (cli (:constructor %make-cli)) key flag help value)

(defun make-cli (key flag help value)
  (let ((out  (%make-cli :key key :flag flag :help help :value value))
        (now  (member flag (args) :test #'equal)))
    (if now
      (setf (cli-value out) (cond ((equal now t)   nil)
                                  ((equal now nil)   t)
                                  (t (item (second now))))))
    (cons key out)))

(defun args ()
  #+clisp (cdddr (cddr (coerce (EXT:ARGV) 'list)))
  #+sbcl  (cdr sb-ext:*posix-argv*))

(defmethod print-object ((c cli) s)
  (with-slots (flag help value) c
    (format s "  ~5a  ~a " flag help)
    (if (member value '(t nil)) (terpri) (format s "= ~a~%" value))))

;-------------------------------------
(defstruct our help options)
    (help
      "sbcl --noinform --script expose.lisp [OPTIONS]
(c) 2022, Tim Menzies, MIT license

Lets have some fun.")
    (options (list 
      (make-cli 'enough  "-e" "enough items for a sample" 512)
      (make-cli 'far     "-F" "far away                 " .9)
      (make-cli 'file    "-f" "read data from file      " "../data/auto93.csv")
      (make-cli 'help    "-h" "show help                " nil)
      (make-cli 'license "-l" "show license             " nil)
      (make-cli 'p       "-p" "euclidean coefficient    " 2)
      (make-cli 'seed    "-s" "random number seed       " 10019)
      (make-cli 'todo    "-t" "start up action          " ""))))

(defmethod print-object ((o our) s)
  (format s "~a~%~%OPTIONS:~%" (our-help o))
  (dolist (x (our-options o)) (print s x)))

(defvar *config* (make-our))

(defmacro $ (x) `(cdr (assoc ',x (our-options *config*))))


