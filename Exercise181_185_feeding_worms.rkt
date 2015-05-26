;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise181_185_feeding_worms) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(require 2htdp/universe)
(require 2htdp/image)
; GameEnvironment
; WormHeadPosition is a structure
(define-struct game [wormheadp worm-moving-d worm-tails food-pos])
(define-struct wormheadp [x y])
(define-struct worm-moving-d [vx vy])
(define-struct tail-relp [x y])
(define-struct food-pos [x y])
(define this-game (make-game (make-wormheadp 40 40)
                             (make-worm-moving-d 0 1)
                             (list (make-tail-relp  0  -1)
                                   (make-tail-relp  0  -1)
                                   (make-tail-relp -1   0))
                             (make-food-pos 80 80)))

; WormTails is a List
; (cons (make-worm-segment 1 0) aWormTails)
; either (1 0) (-1 0) (0 -1) (0 1)
; interprets in which direction a tail is at from predecessor

(define (move g)
  (make-game
   (make-wormheadp  
    (+ (wormheadp-x (game-wormheadp g))
       (* (worm-moving-d-vx (game-worm-moving-d g)) DIRECTION-SEGMENT-MULTIPLIER))
    (+ (wormheadp-y (game-wormheadp g))
       (* (worm-moving-d-vy (game-worm-moving-d g)) DIRECTION-SEGMENT-MULTIPLIER)))
   (make-worm-moving-d
    (worm-moving-d-vx (game-worm-moving-d g))
    (worm-moving-d-vy (game-worm-moving-d g)))
   (cons
    (make-tail-relp
     (- 0 (* (worm-moving-d-vx (game-worm-moving-d g)) DIRECTION-SEGMENT-MULTIPLIER))
     (- 0 (* (worm-moving-d-vy (game-worm-moving-d g)) DIRECTION-SEGMENT-MULTIPLIER)))
     (cond
       [(food-eaten? g) (game-worm-tails g)]
       [else (reverse (rest (reverse (game-worm-tails g))))])
    )
   (cond
     [(food-eaten? g) (food-create (game-food-pos g))]
     [else (game-food-pos g)])
   ))

(define (food-create p)
  (food-check-create p (make-food-pos (random BG-AREA-SIDE-LENGTH)
                                      (random BG-AREA-SIDE-LENGTH))))

(define (food-check-create p candidate)
  (if (equal? p candidate) (food-create p) candidate))
                                              

(define (food-eaten? g)
  (and (and (> (+ (food-pos-x (game-food-pos g)) 3) (wormheadp-x (game-wormheadp g)))
            (< (- (food-pos-x (game-food-pos g)) 3) (wormheadp-x (game-wormheadp g))))
       (and (> (+ (food-pos-y (game-food-pos g)) 3) (wormheadp-y (game-wormheadp g)))
            (< (- (food-pos-y (game-food-pos g)) 3) (wormheadp-y (game-wormheadp g))))))

(define BG-AREA-SIDE-LENGTH 100)
(define GB (empty-scene BG-AREA-SIDE-LENGTH
                        BG-AREA-SIDE-LENGTH))
(define WORM-BODY (circle 2 "solid" "red"))
(define DIRECTION-SEGMENT-MULTIPLIER 2)

(define (render-tails headp tails)
  (cond
    [(empty? tails) GB]
    [else
     (place-image
      WORM-BODY
      (+ (wormheadp-x headp) (tail-relp-x (first tails)))
      (+ (wormheadp-y headp) (tail-relp-y (first tails)))
      (render-tails
       (make-wormheadp
        (+ (wormheadp-x headp) (tail-relp-x (first tails)))
        (+ (wormheadp-y headp) (tail-relp-y (first tails))))
       (rest tails)))]))

(define (render g)
  (place-image
   (rectangle 3 3 "solid" "green")
   (food-pos-x (game-food-pos g))
   (food-pos-x (game-food-pos g))
  (place-image
   WORM-BODY
   (wormheadp-x (game-wormheadp g))
   (wormheadp-y (game-wormheadp g))
   (render-tails (game-wormheadp g) (game-worm-tails g)))))

(define (change-direction g a-key)
  (make-game
   (make-wormheadp
    (wormheadp-x (game-wormheadp g))
    (wormheadp-y (game-wormheadp g)))
   (cond
     [(key=? a-key "left")  (make-worm-moving-d -1  0)]
     [(key=? a-key "right") (make-worm-moving-d  1  0)]
     [(key=? a-key "up")    (make-worm-moving-d  0 -1)]
     [(key=? a-key "down")  (make-worm-moving-d  0  1)]
     [else (make-worm-moving-d
            (worm-moving-d-vx (game-worm-moving-d g))
            (worm-moving-d-vy (game-worm-moving-d g)))])
   (game-worm-tails g)
   (make-food-pos (food-pos-x (game-food-pos g))
                  (food-pos-x (game-food-pos g)))
   ))

(define (hit-obstacle g)
  (or (hit-wall g)
      (hit-itself (wormheadp-x (game-wormheadp g))
                  (wormheadp-y (game-wormheadp g))
                  (wormheadp-x (game-wormheadp g))
                  (wormheadp-y (game-wormheadp g))
                  (game-worm-tails g))))
(define (hit-wall g)
  (or (> (wormheadp-x (game-wormheadp g)) BG-AREA-SIDE-LENGTH)
      (> (wormheadp-y (game-wormheadp g)) BG-AREA-SIDE-LENGTH)
      (< (wormheadp-x (game-wormheadp g)) 0)
      (< (wormheadp-y (game-wormheadp g)) 0)))

(define (hit-itself headpx headpy segpx segpy tails)
  (cond
    [(empty? tails) false]
    [(and (equal? headpx (+ segpx (tail-relp-x (first tails))))
          (equal? headpy (+ segpy (tail-relp-y (first tails))))) true]
    [else
     (hit-itself
      headpx headpy
      (+ segpx (tail-relp-x (first tails)))
      (+ segpy (tail-relp-y (first tails)))
      (rest tails))]))

(define (last-scene g)
  (place-image
   (text "Game Over" 14 "olive")
   (/ BG-AREA-SIDE-LENGTH 2)
   (- BG-AREA-SIDE-LENGTH 20)
   (render g)))

(define (main g)
  (big-bang g
            [on-tick move 0.05]
            [on-key change-direction]
            [to-draw render]
            [stop-when hit-obstacle last-scene]))
(main this-game)