(in-package :cl-user)
(defpackage hitchhiker-asd
  (:use :cl :asdf))
(in-package :hitchhiker-asd)

(defsystem hitchhiker
  :version "0.1"
  :author "vasil1987"
  :license ""
  :depends-on (:clack
               :lack
               :caveman2
               :envy
               :cl-ppcre
               :uiop

               ;; for @route annotation
               :cl-syntax-annot

               ;; HTML Template
               :djula

               ;; for DB
               :datafly
               :sxql

			   :dexador
			   :cl-json)
  :components ((:module "src"
                :components
                ((:file "main" :depends-on ("config" "view" "db"))
                 (:file "web" :depends-on ("view"))
                 (:file "view" :depends-on ("config"))
                 (:file "db" :depends-on ("config"))
				 (:file "test" :depends-on ("config"))
                 (:file "config"))))
  :description ""
  :in-order-to ((test-op (load-op hitchhiker-test))))
