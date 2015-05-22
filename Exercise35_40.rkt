;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise35_40) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(require 2htdp/image)
(require 2htdp/universe)

; "Physical" constants
(define WIDTH-OF-WORLD 400)
(define WHEEL-RADIUS 10)
(define WHEEL-DISTANCE (* WHEEL-RADIUS 5))
(define CAR-LENGTH (* WHEEL-DISTANCE 2))

; "Graphical" constants
(define WHEEL (circle WHEEL-RADIUS "solid" "black"))
(define SPACE (rectangle 20 WHEEL-RADIUS "solid" "white"))
(define BOTH-WHEELS (beside WHEEL SPACE WHEEL))
(define CAR-BASE (rectangle CAR-LENGTH 20 "solid" "red"))
(define CAR-TOP (rectangle (/ (image-width CAR-BASE) 2) 20 "solid" "red"))
(define CAR (above CAR-TOP CAR-BASE BOTH-WHEELS)) 
(define BACKGROUND (empty-scene WIDTH-OF-WORLD 200))
(define Y-CAR 100)

(define tree
  (underlay/xy (circle 10 'solid 'green)
               9 15
               (rectangle 2 20 'solid 'brown)))

; as as AnimationState
; AnimationState is a Number(representation)
; its interpretation is the number of clock ticks since the animation started

; ws as WorldState
; WorldState is a Number
; interpretation is the "number of pixels between the left border and
; the x-coordinate of the car's rightmost edge.
(define (render ws)
  (place-image CAR ws Y-CAR (place-image tree 110 70 BACKGROUND)))

(define (adjust-ws ws)
  (* 3 (- ws (/ (image-width CAR) 2))))

(check-expect (tock 10) 13)
(check-expect (tock 0) 3)
(define (tock ws)
  (+ ws 3))

(define TIME-PASSES 100)
(check-expect (end? 1) false)
(define (end? ws)
  (> ws WIDTH-OF-WORLD))

(check-expect (hyper 21 10 20 "enter") 21)
(check-expect (hyper 42 10 20 "button-down") 10)
(define (hyper x-position-of-car x-mouse y-mouse mouse-event)
  (cond
    [(string=? "button-down" mouse-event) x-mouse]
    [else x-position-of-car]))

(define (main ws)
  (big-bang ws
            [on-tick tock]
            [on-mouse hyper]
            [to-draw render]
            [stop-when end?]))