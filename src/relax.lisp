; vim: ts=2 sw=2 et:
(defpackage :relax (:use :cl))
(in-package :relax)
(defstruct our 
  (help 
"sbcl --script lib.lisp [OPTIONS
(c) 2022, Tim Menzies, MIT license

Lets have some fun.")
  (options 
    '((b    "-b" "asda" 23)
      (p    "-p" "asda" 2)
      (help "-h" "asda" nil)
      (license "-l" "asda" nil)
      (file "-f" "asda" "asdas")
      (seed "-s" "random number seed" 10019)
      (todo "-t" "start up action" "")
      (q    "-q" "asda" 1000)))
  (copyright "
Copyright (c) 2022 Tim Menzies
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS 'AS IS'
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
AUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."))

(defmethod print-object ((o our) s)
  (format s "~a~%~%OPTIONS:~%" (our-help o))
  (dolist (x (our-options o))
    (format s "  ~5a  ~30a = ~a~%" (second x) (third x) (fourth x))))

(defvar *config* (make-our))

(load "rest")
(load "rely")

(setf *config* (cli (make-our)))
(if ($ help) (print *config*))
(if ($ license) (princ (our-copyright *config*)))
