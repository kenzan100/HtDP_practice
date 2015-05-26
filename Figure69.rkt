;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Figure69) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(define (atom? s)
  (or
    (number? s)
    (string? s)
    (symbol? s)))

; S-expr -> BSL-expr
; creates a representation of a BSL expression for s (if possible)

(define WRONG "wrong kind of S-expression")
(define-struct add [left right])
(define-struct mul [left right])

(define (parse s)
  (local (; S-expr -> BSL-expr
          (define (parse s)
            (cond
              [(atom? s) (parse-atom s)]
              [else (parse-sl s)]))
          
          ; SL -> BSL-expr
          (define (parse-sl s)
            (local ((define L (length s)))
              (cond
                [(< L 3)
                 (error WRONG)]
                [(and (= L 3) (symbol? (first s)))
                 (cond
                   [(symbol=? (first s) '+)
                    (make-add (parse (second s)) (parse (third s)))]
                   [(symbol=? (first s) '*)
                    (make-mul (parse (second s)) (parse (third s)))]
                   [else (error WRONG)])]
                [else
                 (error WRONG)])))
          
          ; Atom -> BSL-expr
          (define (parse-atom s)
            (cond
              [(number? s) s]
              [(string? s) (error "strings not allowed")]
              [(symbol? s) (error "symbols not allowed")])))
    (parse s)))