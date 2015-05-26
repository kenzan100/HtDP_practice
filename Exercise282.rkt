;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise282) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; BSL-expression is either:
; - Number,
; - Symbol,
; - (make-add BSL-expression BSL-expression)
; - (make-mul BSL-expression BSL-expression)
(define-struct add [left right])
(define-struct mul [left right])


(check-expect (eval-expression (make-add 1 1)) 2)
(check-expect (eval-expression (make-mul 3 3)) 9)
(check-expect (eval-expression (make-add (make-mul 1 1) 10)) 11)

(define (eval-expression BSLe)
  (cond
    [(number? BSLe) BSLe]
    [(add? BSLe) (+ (eval-expression (add-left BSLe))
                    (eval-expression (add-right BSLe)))]
    [(mul? BSLe) (* (eval-expression (mul-left BSLe))
                    (eval-expression (mul-right BSLe)))]))
