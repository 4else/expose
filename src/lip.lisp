; vim: ts=2 et sw=2 et:
(defpackage :lip (:use :cl))
(in-package :lip)

(defun loaded (file)
  (format *error-output* "; loading ~(~a~) ...~%" file)
  (handler-bind ((style-warning #'muffle-warning)) (load file)))
 
(defvar +help+ "
asasd

CONFIG

 -help    asdadasd    = aaasdsa
 -assasa  asdadasd    = 3232342")

(defun config ()
  '((:seed 10013
    :data "../data/aaa.csv")
         :col (:p 2)
         :dom (:samples 100)))

(loaded "lib")

(halt (demos (cli)))
