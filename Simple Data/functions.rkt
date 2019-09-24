;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname functions) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

; function definition
(define (bulb c)
  (circle 20 "solid" c))

(above (bulb "red")
       (bulb "yellow")
       (bulb "green"))

; compare strings and images
(string=? "foo" "bar")

(define I1 (rectangle 10 20 "solid" "red"))
(define I2 (rectangle 20 10 "solid" "blue"))

(< (image-width I1)
   (image-width I2))

; if else statement

(if (< (image-width I2)
   (image-width I2))
    "tall"
    "wide")

(if (< (image-width I2)
   (image-height I2))
    (image-width I2)
    (image-height I2))

; AND OR NOT
(and (> (image-height I2) (image-height I1))
     (> (image-width I2) (image-width I1)))