
(defun timeit (fun &aux (tick internal-time-units-per-second))
  (let ((b4 (get-internal-real-time)))
      (funcall fun)
      (float (/ (- (get-internal-real-time) b4) tick))))

(defun lists(l n) (nth n l))

(defun arrays (l n) (aref l n))

(defun listn (n &aux lst)
  (dotimes (i n lst) (push i lst)))

(defun arrayn (n &aux(a  (make-array 0 :fill-pointer 0 :adjustable t)))
  (dotimes (i n a) (vector-push-extend i a)))

(defun list-vs-array ()
    (let ((r (expt 10 3)))
      (dolist (c '(10 20 40 75 150 300 600 1250 2500 5000))
        (let* ((arr (arrayn c))
               (lst (listn  c))
               (ltime  (timeit #'(lambda ()  (dotimes (_ r) (lists lst (1- c))))))
               (atime  (timeit #'(lambda ()  (dotimes (_ r) (arrays arr (1- c)))))))
          (format t "~4a :lst ~,10f :arr ~,10f :ratio ~5,3f~%" c 
                  (/ ltime r) (/ atime r ) (/ ltime atime ))))))

;(list-vs-array)

;;;;;
;(defmacro ? (s x &rest xs) 
 ; "Nested access to slots."
  ;(if (null xs) `(slot-value ,s ',x) `(? (slot-value ,s ',x) ,@xs)))
;(multiple-value-bind 
;(asas (asasd) asass)

;(labels ((asdasas  (asdas) 
;(lets ((a b)
(defun %let+ (body xs)
  (labels ((fun (x) (and (listp x) (> (length x) 2)))
           (mvb (x) (and (listp x) (listp (car x)))))
    (if (null xs)
      body
      (let ((x (pop xs)))
        (cond ((fun x) `(labels ((,(pop x) ,(pop x) ,@x))       ,(%let+ body xs)))
              ((mvb x) `(multiple-value-bind ,(pop x) ,(pop x) ,@(%let+ body xs)))
              (t       `(let (,x)                         ,(%let+ body xs))))))))

(defmacro let+ (spec &rest body) (%let+ body spec))


(print (macroexpand-1  `(let+ ((a 1)  
              zz
              ((x y) (ff aa))
              (mm 23)
              (fun (args1 args1) (body1 1) (body2) (print 23)))
             (print 1) (print 2))))

(print (macroexpand-1 `(let+ (z
         (y 1)
         (z 2)
         (fn1 (x y) (+ x y))
         ((a b) (fn2 x (fn1 y z))))
      (format t "a ~a b ~a x ~a y ~a z ~a~%" a b x y z))))

(defun fn2 (x y ) (values x (+ x y)))

(defun test-let+(&optional (x 1))
  (let+ (z
         (y 1)
         (z 2)
         (fn1 (x y) (+ x y))
         ((a b) (fn2 x (fn1 y z))))
      (format t "~&a ~a b ~a x ~a y ~a z ~a~%" a b x y z)))


    (test-let+)


(require 'relativity) 
(import '(relativity:speed-of-light 
          relativity:ignore-small-errors))
