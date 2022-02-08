; vim: et :
#|# asdasdsasa

asdaasaasasasas #|

    (defvar *tests* nil)
    (defvar *fails* 0)
    
    (defmacro deftest (name params  doc  &body body)
      `(progn (pushnew  ',name *tests*) 
              (defun ,name ,params ,doc ,@body)))
    
    (defun demos (&optional what)
      (dolist (one *tests*)
        (let ((doc (documentation one 'function)))
          (when (or (not what) (eql one what))
            (setf *config* (cli (make-our)))
            (multiple-value-bind (_ err)
              (ignore-errors (funcall one))
              (incf *fails* (if err 1 0))
              (if err
                (format t "~&~a [~a] ~a ~a~%" "FAIL" one doc err)
                (format t "~&~a [~a] ~a~%"    "PASS" one doc)))))))  #|

# asdasddsa

asdas
saasasads

asaassaas |#
    
    (defun make () (load "lib"))
    
    (deftest _while(&aux (x '(1 2 3)))
      (whale (pop x) (print a)))
    
    (deftest _csv() 
      (let (head)
        (with-csv (line "../data/auto93.csv") 
          (if head
            (format t "~s~%" (mapcar #'reads line))
            (setf head line)))))
    

