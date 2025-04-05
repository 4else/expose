; If an item comes from strings, make sure we coerce it properly.
; ```lisp
(defconstant +nothing+ :?)

(defmethod item ((x number )) x)
(defmethod item ((x string))
  "Return a number or a trimmed string."
  (let ((y (string-trim '(#\Space #\Newline #\Tab) x))) 
    (if (equal y "?") 
      +nothing+
      (let ((z (ignore-errors (read-from-string y)))) 
        (if (numberp z) z y))))) 
; ```
; For lists of things, store it in a resizable list.
(defun make-items (&optional (size 0)) 
  (make-array size :fill-pointer 0 :adjustable t))

(defmethod add ((v vector) x) (vector-push-extend x v) v)
(defmethod at  ((v vector) i) (elt v i))

(defmacro doitemsi ((i item items &optional out) &body body)
  `(dotimes (,i (length ,items) ,out)
     (let ((,item (elt ,items ,i))) ,@body)))

(defmacro doitems ((item items &optional out) &body body)
  (let ((i (gensym))) b
    `(dotimes (,i (length ,items) ,out)
       (declare (ignore ,i))
       (let ((,item (elt ,items ,i))) ,@body))))

(defun mapitem (fn items)
  (let ((out (make-items (length items))))
    (doitemsi (i one items out)
      (setf (elt out i) (funcall fn one)))))

(defun mapitems (fn items1 items2)
  (let ((out (make-items (length items1))))
    (doitemsi (i one items1 out)
      (setf (elt out i) (funcall fn one (elt items2 i))))))

(defun str2items (s &optional (sep #\,))
  (labels ((fun (s &optional (n 0) &aux (pos (position sep s :start n)))
                (if pos
                  (cons (item (subseq s n pos)) (fun s (1+ pos)))
                  (list (item (subseq s n))))))
    (coerce (fun s) 'vector)))

(defun csv (file &optional (fn #'print))
  (with-open-file (s file)
    (loop (funcall fn (str2items (or (read-line s nil) (return-from csv)))))))


