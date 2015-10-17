#|
 This file is part of Warbler Weekly Planner
 (c) 2015 Janne Pakarinen
 Author: Janne Pakarinen <gingeralesy@gmail.com>
 |#

(in-package #:org.gingeralesy.warbler)
(named-readtables:in-readtable :qtools)

;; Qt widgets here

(defvar *window*)

(define-widget central-area (QWidget)
  ())

(define-widget dock-container (QDockWidget)
  ((widget :initarg :widget :reader widget)
   (title :initarg :title :reader title))
  (:default-initargs
    :widget (error "WIDGET required.")
    :title ""))

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
  (q+:resize main-window 800 600))

(define-subwidget (main-window central-area) (make-instance 'central-area))

(define-subwidget (main-window layout-container) (q+:make-qwidget)
  (let ((layout (q+:make-qhboxlayout layout-container)))
    (setf (q+:margin layout) 0)
    (setf (q+:spacing layout) 0)
    (q+:add-widget layout central-area))
  (setf (q+:central-widget main-window) layout-container))

(define-menu (main-window File)
  (:item ("Quit" (ctrl q))
         (q+:close main-window)))

;; Main

(defun main ()
  "Starts up the Warbler program"
  #+:sbcl (sb-ext:disable-debugger)
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
