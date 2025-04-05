; vim: ts=2 sw=2 et:
;   ___ ___          __          ___       _ __         ___         ____  
; /' __` __`\      /'__`\       /'___\    /\`'__\      / __`\      /',__\ 
; /\ \/\ \/\ \    /\ \L\.\_    /\ \__/    \ \ \/      /\ \L\ \    /\__, `\
; \ \_\ \_\ \_\   \ \__/.\_\   \ \____\    \ \_\      \ \____/    \/\____/
;  \/_/\/_/\/_/    \/__/\/_/    \/____/     \/_/       \/___/      \/___/ 
                                                                        
(defmacro aif (test yes &optional no) 
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
                  (car (setf ,a (cons (cons ,x 0) ,a))))) ,inc))

(defmacro dofun (name params  doc  &body body)
  "Define a test case, add it to `*tests*."
  `(progn (pushnew  ',name *tests*) 
          (defun ,name ,params ,doc (progn (format t "~a~%~%" ',name) ,@body))))

(defmacro any (sequence)
  "Return any item in `sequence` (to support `setf`, do this is in a macro)."
   `(elt ,sequence (randi (length ,sequence))))

(defun %let (body xs)
  "Allow `let` to define functions and do multiple-value-binds."
  (labels ((lab (x) (and (listp x) (> (length x) 2)))
           (mvb (x) (and (listp x) (listp (car x)))))
    (if (null xs)
        body
        (let ((x (pop xs)))
          (cond 
            ((lab x) `(labels ((,(pop x) ,(pop x) ,@x))       ,(%let body xs)))
            ((mvb x) `(multiple-value-bind ,(pop x) ,(pop x) ,@(%let body xs)))
            (t       `(let (,x)                          ,(%let body xs))))))))

(defmacro let+ (spec &rest body) (%let body spec))
