#|
 This file is part of Warbler Weekly Planner
 (c) 2015 Janne Pakarinen
 Author: Janne Pakarinen <gingeralesy@gmail.com>
 |#

(in-package #:org.gingeralesy.warbler)
(named-readtables:in-readtable :qtools)

;; Qt widgets here

(defvar *window*)

(define-widget main-window (QMainWindow)
  ())

(define-initializer (main-window init-window-system 100)
  (unless (boundp '*window*)
    (error "Tried to create main window without the proper context!"))
  (when *window*
    (error "A main window instance is already active!"))
  (setf *window* main-window))

(define-initializer (main-window setup)
  (setf (q+:window-title main-window)
        (format NIL "Warbler v~a" (asdf:component-version
                                   (asdf:find-system :warbler))))
  (q+:resize main-window 500 500))

(define-subwidget (main-window name) (q+:make-qlineedit main-window)
  (setf (q+:placeholder-text name) "This is a placeholder widget."))

(define-subwidget (main-window layout) (q+:make-qhboxlayout main-window)
  (q+:add-widget layout name))

;; Main

(defun main ()
  "Starts up the Warbler program"
  (qt:make-qapplication)
  (format t " ** Warbler launching.~%")
  (let* ((*window*)
         (window (make-instance 'main-window)))
    (q+:show window)
    (format t " ** Warbler finished with ~a.~%"
            (q+:exec *qapplication*))
    (finalize window)
    (trivial-garbage:gc :full T)
    NIL))
