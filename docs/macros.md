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




# (macros)


  ___ ___          __          ___       _ __         ___         ____  
/' __` __`\      /'__`\       /'___\    /\`'__\      / __`\      /',__\ 
/\ \/\ \/\ \    /\ \L\.\_    /\ \__/    \ \ \/      /\ \L\ \    /\__, `\
\ \_\ \_\ \_\   \ \__/.\_\   \ \____\    \ \_\      \ \____/    \/\____/
 \/_/\/_/\/_/    \/__/\/_/    \/____/     \/_/       \/___/      \/___/ 

```lisp
                                                                    
(defmacro aif (test yes &optional no) 
```


  "Anaphoric if (traps result of conditional in `it`)."
  `(let ((it ,test)) (if it ,yes ,no)))

(defmacro whale (expr &body body) 
  "Anaphoric while (traps result of conditional in `a`)."
  `(do ((a ,expr ,expr)) ((not a)) ,@body))

(defmacro ? (s x &rest xs) 
  "Nested access to slots."
  (if (null xs) `(slot-value ,s ',x) `(? (slot-value ,s ',x) ,@xs)))

(defmacro with-csv ((lst file &optional out) &body body)
  "File row iterator."
  `(progn (csv ,file #'(lambda (,lst) ,@body)) ,out))

(defmacro inca (x a &optional (inc  1))
  "Add one to a counter for `x` in `a` (updating `a` as a side-effect)"
  `(incf (cdr (or (assoc ,x ,a :test #'equal)

```lisp
              (car (setf ,a (cons (cons ,x 0) ,a))))) ,inc))

```


(defmacro dofun (name params  doc  &body body)
  "Define a test case, add it to `*tests*."
  `(progn (pushnew  ',name *tests*) 

```lisp
      (defun ,name ,params ,doc (progn (format t "~a~%~%" ',name) ,@body))))

```


(defmacro any (sequence)
  "Return any item in `sequence` (to support `setf`, do this is in a macro)."
   `(elt ,sequence (randi (length ,sequence))))

(defun %let (body xs)
  "Allow `let` to define functions and do multiple-value-binds."
  (labels ((lab (x) (and (listp x) (> (length x) 2)))

```lisp
       (mvb (x) (and (listp x) (listp (car x)))))
(if (null xs)
    body
    (let ((x (pop xs)))
      (cond 
        ((lab x) `(labels ((,(pop x) ,(pop x) ,@x))       ,(%let body xs)))
        ((mvb x) `(multiple-value-bind ,(pop x) ,(pop x) ,@(%let body xs)))
        (t       `(let (,x)                          ,(%let body xs))))))))

```


(defmacro let+ (spec &rest body) (%let body spec))
