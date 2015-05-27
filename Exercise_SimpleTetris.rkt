;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise_SimpleTetris) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(require 2htdp/universe)
(require 2htdp/image)

; possible data definitions
; falling tetris block
;   pos from topleft corner
; landed blocks
;   list of blocks, pos from topleft corner

; iterations
;   block will fall and land on the ground
;   block will stack on top of each other

(define-struct block [x y])
(define-struct game [block lolanded])
(define BG-WIDTH 100)
(define BG-HEIGHT 155)
(define BG (empty-scene BG-WIDTH BG-HEIGHT))
(define BLOCK-START-X (+ (/ BG-WIDTH 2) 5))
(define PIXEL-LENGTH 10)
(define BLOCK (rectangle PIXEL-LENGTH PIXEL-LENGTH "solid" "green"))

(define (render g)
  (place-image BLOCK
               (block-x (game-block g))
               (block-y (game-block g))
               (render-lolanded (game-lolanded g))))

(define (render-lolanded lolanded)
  (cond
    [(empty? lolanded) BG]
    [else (place-image BLOCK
                       (block-x (first lolanded))
                       (block-y (first lolanded))
                       (render-lolanded (rest lolanded)))]))
(define (move g)
  (make-game (if (landed? (game-block g) (game-lolanded g))
                 (make-block BLOCK-START-X 0)
                 (make-block (block-x (game-block g))
                             (+ (block-y (game-block g)) PIXEL-LENGTH)))
             (if (landed? (game-block g) (game-lolanded g))
                 (cond
                   [(erase? (game-block g) (game-lolanded g))
                    (erase-row (block-y (game-block g)) (game-lolanded g))]
                   [else
                    (cons (game-block g) (game-lolanded g))])
                 (game-lolanded g))))

(define (erase-row y lolanded)
  (cond
    [(empty? lolanded) empty]
    [(eq? y (block-y (first lolanded))) (erase-row y (rest lolanded))]
    [else (cons (first lolanded) (erase-row y (rest lolanded)))]))

(define ROW-LENGTH (/ BG-WIDTH PIXEL-LENGTH))
(define (erase? block lolanded)
  (if (>= (+ (erase/length? block lolanded) 1) ROW-LENGTH) #t #f))

(define (erase/length? block lolanded)
  (cond
    [(empty? lolanded) 0]
    [(eq? (block-y block) (block-y (first lolanded)))
     (+ 1 (erase/length? block (rest lolanded)))]
    [else
     (erase/length? block (rest lolanded))]))

(define (landed? block lolanded)
  (cond
    [(collide? block lolanded) #t]
    [(>= (block-y block) (- BG-HEIGHT (/ PIXEL-LENGTH 2))) #t]
    [else #f]))

(define (collide? block lolanded)
  (cond
    [(empty? lolanded) #f]
    [(and (= (block-x block) (block-x (first lolanded)))
          (>= (+ (block-y block) PIXEL-LENGTH) (block-y (first lolanded)))) #t]
    [else (collide? block (rest lolanded))]))

(define (collide-top g)
  (if (collide-top-lolanded? (game-lolanded g)) #t #f))

(define (collide-top-lolanded? lolanded)
  (cond
    [(empty? lolanded) #f]
    [(<= (block-y (first lolanded)) 0) #t]
    [else (collide-top-lolanded? (rest lolanded))]))

(define (horizontal-move g a-key)
  (make-game
   (make-block
    (cond
      [(key=? a-key "left") (- (block-x (game-block g)) PIXEL-LENGTH)]
      [(key=? a-key "right") (+ (block-x (game-block g)) PIXEL-LENGTH)]
      [else (block-x (game-block g))])
    (block-y (game-block g)))
   (game-lolanded g)))

(define (main g)
  (big-bang g
            [to-draw render]
            [on-tick move 0.1]
            [on-key horizontal-move]
            [stop-when collide-top]))

(define this-game (make-game (make-block BLOCK-START-X 0) empty))
(main this-game)