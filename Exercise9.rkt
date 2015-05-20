#lang racket
(define b1 true)
(define b2 false)
(define b1_false_b2_true?
  (lambda (b1 b2)
    (or (eq? b1 false)
        (eq? b2 true))))