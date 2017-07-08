(in-package :cl-user)
(defpackage hitchhiker.test
  (:nicknames :hi)
  (:use :cl)
  (:import-from :cl-json
				:decode-json-from-string)
  (:export :get-json
		   :parse))

(in-package :hitchhiker.test)

(defun get-json ()
  (cl-json:decode-json-from-string 
   (dex:get "https://api.vk.com/method/wall.get?access_token=c4ed34a1c4ed34a1c4ed34a163c4b01400cc4edc4ed34a19db0992278cf5dd002a04f03&domain=poputchik.karaidel&count=20")))

(defun parse (ans)
  (loop for request in ans do
	   (loop for post in (get-posts request) do
			(format t "ПОСТ ~a" (by-key :text post)))))

(defun get-posts (response)
  (cddr response))

(defun by-key (key list)
  (let ((item (car list)))
	(cond ((null list) nil)
		  ((atom item) (by-key key (cdr list)))
		  ((not (eql (car item) key)) (by-key key (cdr list)))
		  (t (cdr item)))))
		   

(with-open-file (out "~/temp.lisp" :direction :output
					 :if-exists :supersede
					 :external-format '(:utf-8 :eol-style :crlf))  
  (format out "~a" (get-json)))
