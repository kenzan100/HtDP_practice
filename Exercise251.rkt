;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise251) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(define-struct no-parent [])
(define-struct child [father mother name year eye-color])

; a FamilyTree
; either
; (make-no-parent)
; (make-f-tree (make-no-parent) (make-no-parent) name year eye-color)

; count-persons
; consumes a family tree returns child structure count in the tree

(check-expect (count-person (make-no-parent)) 0)
(check-expect (count-person (make-child (make-no-parent) (make-no-parent) "Ai" 1984 "blue")) 1)

(define (count-person a-f-tree)
  (cond
    [(no-parent? a-f-tree) 0]
    [else
     (+ 1 (+ (count-person (child-father a-f-tree))
             (count-person (child-mother a-f-tree))))]))