;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Figure12) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(require 2htdp/image)
(require 2htdp/universe)

(define MT (empty-scene 100 30))
(define font-size 10)

(check-expect (remember "hello" " ") "hello ")
(check-expect (remember "hello " "w") "hello w")

(check-expect (show "hel")
              (overlay (text "hel" font-size "red") MT))

(define (show all-key)
  (overlay (text all-key font-size "red") MT))

(define (main s)
  (big-bang s
            [on-key remember]
            [to-draw show]))
(main "hoge")
