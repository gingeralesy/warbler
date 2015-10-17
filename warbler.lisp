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

(define-initializer (dock-container setup)
  (setf (q+:widget dock-container) widget)
  (setf (q+:window-title dock-container) title)
  (setf (q+:features dock-container) (q+:qdockwidget.dock-widget-movable)))

(define-widget main-window (QMainWindow)
  ())

(define-initializer (main-window set-main 100)
  (setf *window* main-window)
  (setf (q+:window-title main-window)
        (format NIL "Warbler v~a" (asdf:component-version
                                   (asdf:find-system :warbler))))
  (q+:resize main-window 800 600))

(define-subwidget (main-window central-area) (make-instance 'central-area))

(define-subwidget (main-window dockable)
                  (make-instance 'dock-container
                                 :widget central-area
                                 :title "Week")
  (q+:add-dock-widget main-window (q+:qt.bottom-dock-widget-area) dockable))

(define-menu (main-window File)
  (:item ("Quit" (ctrl q))
         (q+:close main-window)))

;; Main

(defun main ()
  "Starts up the Warbler program"
  (let ((*window*))
    (with-main-window (w 'main-window))))
