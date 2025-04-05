<a name=top><br>
<!-- tricks from https://simpleicons.org/  https://studio.tailorbrands.com -->
<p align=center>
<a href="/README.md#top">home</a> • 
<a href="/docs/about.md#top">about</a> • 
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




# (shall)


 asdasad 


```lisp
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
            (format t "~&~a [~a] ~a~%"    "PASS" one doc)))))))  

```


# asdasddsa

asdas
saasasads

asaassaas 

```lisp

(defun make () (load "lib"))

(deftest _while(&aux (x '(1 2 3)))
  (whale (pop x) (print a)))

(deftest _csv() 
  (let (head)
    (with-csv (line "../data/auto93.csv") 
      (if head
        (format t "~s~%" (mapcar #'reads line))
        (setf head line)))))


```


