;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Figure65+) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; An S-expr (S-expression) is one of:
; - Atom
; - SL

; An SL(S-list) is one of:
; - empty
; - (cons S-expr SL)

; An Atom is one of:
; - Number
; - String
; - Symbol

; atom?
; tells whether given s is a Number/String/Symbol

(check-expect (atom? 1) true)
(check-expect (atom? empty) false)

(define (atom? s)
  (or
   (number? s)
   (string? s)
   (symbol? s)))

(check-expect (count 'world 'hello) 0)
(check-expect (count '(world hello) 'hello) 1)
(check-expect (count '(((world) hello) hello) 'hello) 2)

(define (count sexp sy)
  (cond
    [(atom? sexp) (count-atom sexp sy)]
    [else (count-sl sexp sy)]))

(define (count-sl sl sy)
  (cond
    [(empty? sl) 0]
    [else (+ (count (first sl) sy)
             (count-sl (rest sl) sy))]))

(define (count-atom at sy)
  (cond
    [(number? at) 0]
    [(string? at) 0]
    [(symbol? at) (if (symbol=? at sy) 1 0)]))