(in-package :cl-user)
(defpackage hitchhiker.test
  (:nicknames :hi)
  (:use :cl)
  (:import-from :cl-json
				:decode-json-from-string)
  (:export :get-json))

(in-package :hitchhiker.test)

(defun get-json ()
  (cl-json:decode-json-from-string 
  (dex:get "https://api.vk.com/method/wall.get?access_token=c4ed34a1c4ed34a1c4ed34a163c4b01400cc4edc4ed34a19db0992278cf5dd002a04f03&domain=poputchik.karaidel&count=20")))
