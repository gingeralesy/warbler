#|
 This file is part of Warbler Weekly Planner
 (c) 2015 Janne Pakarinen
 Author: Janne Pakarinen <gingeralesy@gmail.com>
 |#

(in-package #:cl-user)
(defpackage #:warbler
  (:documentation "UI for doing weekly planning.")
  (:use #:cl+qt)
  (:nicknames #:org.gingeralesy.warbler)
  (:export #:main))
