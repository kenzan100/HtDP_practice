#lang racket
(require 2htdp/image)
; Number String Image -> Image
; adds s to img, y pixels from top, 10 pixels to the left
; given: 
; 5 for y, 
; "hello" for s, and
; (empty-scene 100 100) for img
; expected: 
; (place-image (text "hello" 10 "red") 10 5 (empty-scene 100 100))
(define (add-image y s img)
  (place-image (text s 10 "red") 10 y img))

; string-first
; String -> String
; extracts the first char from a non-empty string.
; given:
;  'hoge' for a non-empty string
; expected:
;  'h'
(define (string-first str)
  (substring str 0 1))

; string-last
; String -> String
; extracts the last char from a non-empty string.
; given:
;  'hoge' for a non-empty string
; expected:
;  'e'
(define (string-last str)
  (substring str (- (string-length str) 1)))

; image-area
; Image -> Number
; counts the number of pixcels in a given image.
; given:
;  (rectangle 10 100 "solid" "black")
; expected:
;  1000
(define (image-area image)
  (* (image-width image) (image-height image)))

; string-rest
; String -> String
; produces a string like the given one with the first char removed.
; given:
;  "hoge"
; expected:
;  "oge"
(define (string-rest str)
  (substring str 1))

; string-remove-last
; String -> String
; produces a string like the given one with the last char removed.
; given:
;  "hoge"
; expecte:
;  "hog"
(define (string-remove-last str)
  (substring str 0 (- (string-length str) 1)))