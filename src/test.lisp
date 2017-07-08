(in-package :cl-user)
(defpackage hitchhiker.test
  (:nicknames :hi)
  (:use :cl)
  (:import-from :cl-json
				:decode-json-from-string)
  (:export :get-json
		   :parse
		   :get-records))

(in-package :hitchhiker.test)

(defparameter +access-token+ "c4ed34a1c4ed34a1c4ed34a163c4b01400cc4edc4ed34a19db0992278cf5dd002a04f03")

(defun make-api-uri (method &rest parameters)
  (let ((uri (quri:make-uri :scheme "https"
							:host "api.vk.com"
							:path (concatenate 'string "/method/" method)))
		(params (list (cons "access_token" +access-token+))))
	(loop for key in parameters by #'cddr
	   for value in (cdr parameters) by #'cddr do
		 (push (cons (string-downcase key) value) params))
	(setf (quri:uri-query-params uri) params)
	uri))
  

(defun get-json (uri)
  (cl-json:decode-json-from-string 
   (dex:get uri)))

(defun get-json ()
  (cl-json:decode-json-from-string 
   (dex:get "https://api.vk.com/method/wall.get?access_token=c4ed34a1c4ed34a1c4ed34a163c4b01400cc4edc4ed34a19db0992278cf5dd002a04f03&domain=poputchik.karaidel&count=20")))

(defun parse (ans)
  (let ((posts nil))
	(loop for request in ans do
		 (loop for post in (get-posts request) do
			  (push (make-post-message
					 :text (by-key :text post)
					 :date (by-key :date post))
					posts)))
	posts))
			

(defun get-posts (response)
  (cddr response))

(defun by-key (key list)
  "поиск значения по ключу"
  (let ((item (car list)))
	(cond ((null list) nil)
		  ((atom item) (by-key key (cdr list)))
		  ((not (eql (car item) key)) (by-key key (cdr list)))
		  (t (cdr item)))))


(defstruct post-message
  date
  phones
  direction
  text)

(defun get-records ()
	(parse (get-json (make-api-uri "wall.get" :count 20 :domain "poputchik.karaidel"))))
