;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise180_rearranging_words) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Word is
; (cons 1String Word)

; List-of-Words is
; (cons Word List-of-Word)

; arrangements
; permutation of a Word

;(check-expect (arrangements (cons "a" (cons "e" empty))) (list (list "a" "e") (list "e" "a")))
;(define (arrangements word)
;  (cond
;    [(empty? word) ...]
;    [else (... (first word) ... (arrangements (rest w) ...))]))

; insert-everywhere
; insertes at every possible index of a given word

; insert-at
; insert a char at given index of a list
(check-expect (insert-at "a" 1 (list "b" "c")) (list "b" "a" "c"))
(define (insert-at char index a-word)
  (cond
    [(zero? index) (cons char a-word)]
    [else (cons (first a-word) (insert-at char (- index 1) (rest a-word)))]))

(check-expect (insert-everywhere "a" (list "b") 0) (list (list "a" "b") (list "b" "a")))
(check-expect (insert-everywhere "a" (list "b" "c") 0)
              (list (list "a" "b" "c") (list "b" "a" "c") (list "b" "c" "a")))
(define (insert-everywhere char w index)
  (cond
    [(= (length w) (- index 1)) empty]
    [else (cons (insert-at char index w)
                (insert-everywhere char w (+ index 1)))]))

(check-expect (insert-everywhere/in-all-words "a" (list (list "e" "r") (list "r" "e")))
              (list (list "a" "e" "r") (list "e" "a" "r") (list "e" "r" "a")
                    (list "a" "r" "e") (list "r" "a" "e") (list "r" "e" "a")))
(define (insert-everywhere/in-all-words char lofw)
  (cond
    [(empty? lofw) empty]
    [else (append (insert-everywhere char (first lofw) 0)
                  (insert-everywhere/in-all-words char (rest lofw)))]))

(check-expect (arrangements (list "a" "b"))
              (list (list "a" "b") (list "b" "a")))
(define (arrangements w)
  (cond
    [(empty? w) (list empty)]
    [else (insert-everywhere/in-all-words (first w) (arrangements (rest w)))]))

(check-expect (arrange-main "ho")
              (list "ho" "oh"))
(define (arrange-main str)
  (implode-everywhere (arrangements (explode str))))

(check-expect (implode-everywhere (list(list "h" "o")(list "o" "h")))
              (list "ho" "oh"))
(define (implode-everywhere lofw)
  (cond
    [(empty? lofw) empty]
    [else (cons (implode (first lofw)) (implode-everywhere (rest lofw)))]))