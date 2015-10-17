#|
 This file is part of Warbler Weekly Planner
 (c) 2015 Janne Pakarinen
 Author: Janne Pakarinen <gingeralesy@gmail.com>
 |#

(in-package #:cl-user)
(asdf:defsystem "warbler"
  :name "Warbler"
  :version "0.0.0"
  :license "GNU General Public License v3.0"
  :author "Janne Pakarinen <gingeralesy@gmail.com>"
  :maintainer "Janne Pakarinen <gingeralesy@gmail.com>"
  :description "Weekly planner for projects and events."
  :homepage "https://github.com/gingeralesy/warbler"
  :serial T
  :components ((:file "packages")
               (:file "warbler"))
  :defsystem-depends-on (:qtools)
  :depends-on (:qtools
               :qtcore
               :qtgui
               :q+)) ;; TODO: remove q+ at some point

