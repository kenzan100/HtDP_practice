#lang racket
(define str "helloworld")
(define i 5)
(define inserting_letter "_")
(define insert_at
  (lambda (str i inserting_l)
    (string-append
       (substring str 0 i)
       inserting_l
       (substring str i))))
(define delete_at
  (lambda (str i)
    (string-append
      (substring str 0 (- i 1))
      (substring str (+ i 1)))))