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

(defmethod print-object ((o our) s)
  (format s "~a~%~%OPTIONS:~%" (our-help o))
  (dolist (x (our-options o)) (print-object  (cdr x) s )))

(defvar *config* (make-our))

(defmacro $ (x) `(cdr (assoc ',x (our-options *config*))))


