#lang racket
(define calc-distance
  (lambda (x y)
    (sqrt
       (+ (* x x) (* y y)))))
(define cube-surface
  (lambda (length)
    (* length length)))
(define cube-volume
  (lambda (length)
    (* (cube-surface length) length)))

(define string-first
  (lambda (str)
    (substring str 0 1)))
(define string-last
  (lambda (str)
    (substring str (- (string-length str ) 1))))

(define bool-imply
  (lambda (b1 b2)
    (or (eq? b1 false)
        (eq? b2 true))))

(require 2htdp/image)
(define image-area
  (lambda (image)
    (* (image-width image)
       (image-height image))))
(define image-classify
  (lambda (image)
    (define (image-wh-ratio)
      (/ (image-width image) (image-height image)))
    (if (= 1 (image-wh-ratio)) "square"
        (if (> 1 (image-wh-ratio)) "wide" "tall"))))

#|Exercise20~22 already answered in previously exercise answers.|#