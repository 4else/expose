; vim: ts=2 et sw=2 et:
(defmacro aif (test yes &optional no) `(let ((it ,test)) (if it ,yes ,no)))

(defun subseqs (s &optional (sep #\,))
  (aif (position sep s)
       (cons (subseq s 0 it) (subseqs (subseq s (1+ it)) sep))
       (list s)))

(defun trim (s) (string-trim '(#\Space #\Newline #\Tab) s))
