#|
 This file is part of Warbler Weekly Planner
 (c) 2015 Janne Pakarinen
 Author: Janne Pakarinen <gingeralesy@gmail.com>
 |#

(in-package #:org.gingeralesy.warbler)
(named-readtables:in-readtable :qtools)

;; Main

(defun main ()
  "Starts up the Warbler program"
  (with-main-window (window (make-instance 'main-window))))

(define-widget main-window (QWidget)
  ())

