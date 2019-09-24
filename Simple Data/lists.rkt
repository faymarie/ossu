;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lists) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

empty                                  ; to represent empty lists

(cons "Flames" empty)                  ;a list of 1 element -> everything after Flames is "empty"
(cons "Leafs" (cons "Flames" empty))   ;a list of 2 elements 

(cons (string-append "C" "anucks") empty)
;; expressions that produce lists can be formed out of non-value expressions
;; BUT: list values are formed out of values only, no other expressions!

(cons 10 (cons 9 (cons 10 empty)))     ;a list of 3 numbers
(cons (square 10 "solid" "blue")       ; a list of 2 images
      (cons (triangle 20 "solid" "green")
            empty))

(define L1 (cons "Flames" empty))
(define L2(cons 10 (cons 9 (cons 10 empty))))
(define L3 (cons (square 10 "solid" "blue")       ; a list of 2 images
      (cons (triangle 20 "solid" "green")
            empty)))

; produce first item of a list
(first L1)
(first L2)
(first L3)

; produce the list after the first element
(rest L1)
(rest L2)
(rest L3)

; get second element -> call rest and then first
(first (rest L2))

; get 3rd element -> call rest and then first
(first(rest (rest L2)))

; check if list is emty
(empty? empty)
(empty? L1)