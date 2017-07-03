(in-package :cl-user)
(defpackage hitchhiker-test-asd
  (:use :cl :asdf))
(in-package :hitchhiker-test-asd)

(defsystem hitchhiker-test
  :author "vasil1987"
  :license ""
  :depends-on (:hitchhiker
               :prove)
  :components ((:module "t"
                :components
                ((:file "hitchhiker"))))
  :perform (load-op :after (op c) (asdf:clear-system c)))
