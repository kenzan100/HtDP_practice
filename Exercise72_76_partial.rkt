;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise72_76_partial) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
(define-struct editor [pre post])
; Editor = (make-editor String String)
; interpretation (make-editor s t) means the text in the editor is
; (string-append s t) with the cursor displayed between s and t

(require 2htdp/universe)
(require 2htdp/image)

(define SCENE (empty-scene 200 20))
(define CURSOR (rectangle 1 20 "solid" "red"))

; edit Editor -> Editor
(check-expect (edit (make-editor "Hello " "World") "s")
              (make-editor "Hello s" "World"))

(define (edit editor ke)
  (cond
    [(string=? "left" ke)
     (substring (editor-pre editor) 0 (- (string-length (editor-pre editor)) 1))]
    [(string=? "right" ke)
     (substring (editor-post editor) 1)]
    [else (make-editor (string-append (editor-pre editor) ke) (editor-post editor))]))

(define (render editor)
  (place-image/align
   (beside (text (editor-pre editor) 11 'black)
           CURSOR
           (text (editor-post editor) 11 'black))
   10 10 "left" "center"
   SCENE))

(define (main editor)
  (big-bang editor
            [on-key edit]
            [to-draw render]))

(main (make-editor "H" "F"))