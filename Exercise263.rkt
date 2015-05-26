;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise263) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(define (atom? sexp)
  (or
   (number? sexp)
   (string? sexp)
   (symbol? sexp)))

; S-expr Symbol Atom -> S-expr
; replaces all occurrences of OLD in SEXP with NEW

(check-expect (substitute 'world 'hello 0) 'world)
(check-expect (substitute '(world hello) 'hello 'bey) '(world bey))
(check-expect (substitute '(((world) bey) bey) 'bey '42) '(((world) 42) 42))

(define (substitute sexp old new)
  (cond
    [(atom? sexp) (if (eq? sexp old) new sexp)]
    [else (map
           (lambda (s)
             (substitute s old new)) sexp)]))