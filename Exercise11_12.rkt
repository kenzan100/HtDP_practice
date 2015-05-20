#lang racket
(require 2htdp/image)
(define in "hello")
(define (in-image) (rectangle 10 100 "solid" "black"))
(define convert-to-number
  (lambda (whatever)
    (if (string? whatever) (string-length whatever)
        (if (image? whatever) (* (image-width whatever)
                                 (image-height whatever))
            (if (number? whatever) (if (or (eq? whatever 0)
                                           (< whatever 0))
                                       whatever
                                       (- whatever 1)
                                    )
                (if (eq? whatever true) 10
                    (if (eq? whatever false) 20 null)))))))