

# sandbox.lisp


(defun timeit (fun &aux (tick internal-time-units-per-second))
  (let ((b4 (get-internal-real-time)))

```lisp
  (funcall fun)
  (float (/ (- (get-internal-real-time) b4) tick))))

```


(defun lists(l n) (nth n l))

(defun arrays (l n) (aref l n))

(defun listn (n &aux lst)
  (dotimes (i n lst) (push i lst)))

(defun arrayn (n &aux(a  (make-array 0 :fill-pointer 0 :adjustable t)))
  (dotimes (i n a) (vector-push-extend i a)))

(defun list-vs-array ()

```lisp
(let ((r (expt 10 3)))
  (dolist (c '(10 20 40 75 150 300 600 1250 2500 5000))
    (let* ((arr (arrayn c))
           (lst (listn  c))
           (ltime  (timeit #'(lambda ()  (dotimes (_ r) (lists lst (1- c))))))
           (atime  (timeit #'(lambda ()  (dotimes (_ r) (arrays arr (1- c)))))))
      (format t "~4a :lst ~,10f :arr ~,10f :ratio ~5,3f~%" c 
              (/ ltime r) (/ atime r ) (/ ltime atime ))))))

```


(list-vs-array)
