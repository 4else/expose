<a name=top><br>
<!-- tricks from https://simpleicons.org/  https://studio.tailorbrands.com -->
<p align=center>
<a href="/README.md#top">home</a> • 
<a href="/docs/about.md">about</a> • 
<a href="https://github.com/4else/expose/issues">issues</a>  
</p><p align=center>
<a href="/README.md#top"><img src="/etc/img/expose.png" width=250></a><br>
<img src="https://img.shields.io/badge/purpose-se,ai-informational?style=flat&logo=hyper&logoColor=white&color=blueviolet">
<img src="https://img.shields.io/badge/language-lisp-informational?style=flat&logo=lua&logoColor=white&color=orange">
<a href="https://github.com/4duo/duo/actions"><img src="https://github.com/4duo/duo/workflows/tests/badge.svg"></a><br>
<img src="https://img.shields.io/badge/platform-osx,linux-informational?style=flat&logo=linux&logoColor=white&color=blue">
<a href="https://zenodo.org/badge/latestdoi/454593195"><img src="https://zenodo.org/badge/454593195.svg" alt="DOI"></a><br>
<a href="/LICENSE.md#top">&copy;2022</a> Tim Menzies
</p>




# (base-items)


```lisp
(defconstant +nothing+ :?)

(defmethod item ((x number )) x)
(defmethod item ((x string))
  "Return a number or a trimmed string."
  (let ((y (string-trim '(#\Space #\Newline #\Tab) x))) 

```lisp
(if (equal y "?") 
  +nothing+
  (let ((z (ignore-errors (read-from-string y)))) 
    (if (numberp z) z y))))) 
```
```


For lists of things, store it in a resizable list.
(defun make-items (&optional (size 0)) 
  (make-array size :fill-pointer 0 :adjustable t))

(defmethod add ((v vector) x) (vector-push-extend x v) v)
(defmethod at  ((v vector) i) (elt v i))

(defmacro doitemsi ((i item items &optional out) &body body)
  `(dotimes (,i (length ,items) ,out)

```lisp
 (let ((,item (elt ,items ,i))) ,@body)))

```


(defmacro doitems ((item items &optional out) &body body)
  (let ((i (gensym))) 

```lisp
`(dotimes (,i (length ,items) ,out)
   (declare (ignore ,i))
   (let ((,item (elt ,items ,i))) ,@body))))

```


(defun mapitem (fn items)
  (let ((out (make-items (length items))))

```lisp
(doitemsi (i one items out)
  (setf (elt out i) (funcall fn one)))))

```


(defun mapitems (fn items1 items2)
  (let ((out (make-items (length items1))))

```lisp
(doitemsi (i one items1 out)
  (setf (elt out i) (funcall fn one (elt items2 i))))))

```


(defun str2items (s &optional (sep #\,))
  (labels ((fun (s &optional (n 0) &aux (pos (position sep s :start n)))

```lisp
            (if pos
              (cons (item (subseq s n pos)) (fun s (1+ pos)))
              (list (item (subseq s n))))))
(coerce (fun s) 'vector)))

```


(defun csv (file &optional (fn #'print))
  (with-open-file (s file)

```lisp
(loop (funcall fn (str2items (or (read-line s nil) (return-from csv)))))))

```



