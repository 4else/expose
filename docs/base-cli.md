<a name=top><br>
<!-- tricks from https://simpleicons.org/  https://studio.tailorbrands.com -->
<p align=center>
<a href="/README.md#top">home</a> • 
<a href="asdas">about</a> • 
<a href="asdas">egs</a> • 
<a href="asdas">issues</a> • 
<a href="asdas">chat</a>  
</p><p align=center>
<a href="/README.md#top"><img src="/etc/img/expose.png" width=250></a><br>
<img src="https://img.shields.io/badge/purpose-se,ai-informational?style=flat&logo=hyper&logoColor=white&color=blueviolet">
<img src="https://img.shields.io/badge/language-lisp-informational?style=flat&logo=lua&logoColor=white&color=orange">
<a href="https://github.com/4duo/duo/actions"><img src="https://github.com/4duo/duo/workflows/tests/badge.svg"></a><br>
<img src="https://img.shields.io/badge/platform-osx,linux-informational?style=flat&logo=linux&logoColor=white&color=blue">
<a href="https://zenodo.org/badge/latestdoi/454593195"><img src="https://zenodo.org/badge/454593195.svg" alt="DOI"></a><br>
<a href="/LICENSE.md#top">&copy;2022</a> Tim Menzies
</p>




# (base-cli)


(defstruct (cli (:constructor %make-cli)) key flag help value)

(defun make-cli (key flag help value)
  (let ((out  (%make-cli :key key :flag flag :help help :value value))

```lisp
    (now  (member flag (args) :test #'equal)))
(if now
  (setf (cli-value out) (cond ((equal now t)   nil)
                              ((equal now nil)   t)
                              (t (item (second now))))))
(cons key out)))

```


(defun args ()
  #+clisp (cdddr (cddr (coerce (EXT:ARGV) 'list)))
  #+sbcl  (cdr sb-ext:*posix-argv*))

(defmethod print-object ((c cli) s)
  (with-slots (flag help value) c

```lisp
(format s "  ~5a  ~a " flag help)
(if (member value '(t nil)) (terpri) (format s "= ~a~%" value))))

```


;-------------------------------------
(defstruct our help options)

(defmethod print-object ((o our) s)
  (format s "~a~%~%OPTIONS:~%" (our-help o))
  (dolist (x (our-options o)) (print s x)))

(defvar *config* (make-our))

(defmacro $ (x) `(cdr (assoc ',x (our-options *config*))))


