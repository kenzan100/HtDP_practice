;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Figure70) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(define WRONG "wrong kind of s-expression")
(define-struct def [name para body])

(define (atom? s)
  (or
   (string? s)
   (number? s)
   (symbol? s)))

; dummy
(define (parse s)
  s)

;{S-expr} -> (tech "BSL-fun-def")
(define (def-parse s)
  (local (; S-expr -> BSL-fun-def
          (define (def-parse s)
            (cond
              [(atom? s) (error WRONG)]
              [else
               (if (and (= (length s) 3) (eq? (first s) 'define))
                   (head-parse (second s) (parse (third s)))
                   (error WRONG))]))
          ; S-expr BSL-expr -> BSL-fun-def
          (define (head-parse s body)
            (cond
              [(atom? s) (error WRONG)]
              [else
               (if (not (= (length s) 2))
                   (error WRONG)
                   (local ((define name (first s))
                           (define para (second s)))
                     (if (and (symbol? name) (symbol? para))
                         (make-def name para body)
                         (error WRONG))))])))
    (def-parse s)))