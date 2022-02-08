<a name=top><br>
<!-- tricks from https://simpleicons.org/  https://studio.tailorbrands.com -->
<p align=center>
<a href="/README.md#top">home</a> • 
<a href="asdas">about</a> • 
<a href="asdas">egs</a> • 
<a href="asdas">issues</a> • 
<a href="asdas">chat</a>  
</p><p align=center>
<a href="/README.md#top"><img src="/etc/img/slice.png" width=350></a><br>
<img src="https://img.shields.io/badge/purpose-se,ai-informational?style=flat&logo=hyper&logoColor=white&color=blueviolet">
<img src="https://img.shields.io/badge/language-lua-informational?style=flat&logo=lua&logoColor=white&color=orange">
<a href="https://github.com/4duo/duo/actions"><img src="https://github.com/4duo/duo/workflows/tests/badge.svg"></a><br>
<img src="https://img.shields.io/badge/platform-osx,linux-informational?style=flat&logo=linux&logoColor=white&color=blue">
<a href="https://zenodo.org/badge/latestdoi/452530453"><img src="https://zenodo.org/badge/452530453.svg"></a><br>
<a href="/LICENSE.md#top">&copy;2022</a> Tim Menzies
</p>




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
