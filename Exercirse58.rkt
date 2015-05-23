;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercirse58) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(require 2htdp/image)
(require 2htdp/universe)

; A DoorState is one of:
; - "locked"
; - "closed"
; - "open"

(check-expect (door-closer "locked") "locked")
(check-expect (door-closer "closed") "closed")
(check-expect (door-closer "open") "closed")

(define (door-closer ds)
  (cond
    [(string=? "locked" ds) "locked"]
    [(string=? "closed" ds) "closed"]
    [(string=? "open" ds) "closed"]))

(check-expect (door-actions "locked" "u") "closed")
(check-expect (door-actions "closed" "l") "locked")
(define (door-actions s k)
  (cond
    [(and (string=? "locked" s) (string=? "u" k)) "closed"]
    [(and (string=? "closed" s) (string=? "l" k)) "locked"]
    [(and (string=? "closed" s) (string=? " " k)) "open"]
    [else s]))
 
; DoorState -> Image
; renders the current state of the door as a large red text 
 
(check-expect (door-render "closed")
              (text "closed" 40 "red"))
 
(define (door-render s)
  (text s 40 "red"))

(define (door-sim initial-state)
  (big-bang initial-state
            (on-tick door-closer 1)
            (on-key door-actions)
            (to-draw door-render)))
(door-sim "locked")