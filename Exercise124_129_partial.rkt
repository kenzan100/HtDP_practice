;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise124_129_partial) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; List-of-strings -> Number
; determines how many strings are on alos

(define (how-many alos)
  (cond
    [(empty? alos) ...]
    [else
     (... (first alos) ... (how-many (rest alos)) ...)]))

; List-of-booleans -> Bool
; determins if all-of-them are true

(define (all-true alob)
  (cond
    [(empty? alob) true]
    [else
     (and (eq? (first alob) true)
          (all-true (rest alob)))]))

; List-of-strings -> String
; consuems a list to append them all to one long string
; juxtapose

; List-of-images PositiveNumber -> Image or Bool
; if found 'not n by n square', return that Image.
; otherwise return false