;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname space-invaders-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

;; Space Invaders
;; A shooting game with the goal to shoot as many spaceships as possible with a horizontally moving tank.
;; The player has to shoot the spaceships before they land on the ground, otherwise the game is lost.


;; ======================================================================================================
;; Constants:

(define WIDTH  300)
(define HEIGHT 500)

(define INVADER-X-SPEED 1.5)  ;speeds (not velocities) in pixels per tick
(define INVADER-Y-SPEED 1.5)
(define TANK-SPEED 2)
(define MISSILE-SPEED 10)

(define HIT-RANGE 10)

(define INVADE-RATE 100)

(define BACKGROUND (empty-scene WIDTH HEIGHT))

(define INVADER
  (overlay/xy (ellipse 10 15 "outline" "blue")              ;cockpit cover
              -5 6
              (ellipse 20 10 "solid"   "blue")))            ;saucer

(define TANK
  (overlay/xy (overlay (ellipse 28 8 "solid" "black")       ;tread center
                       (ellipse 30 10 "solid" "green"))     ;tread outline
              5 -14
              (above (rectangle 5 10 "solid" "black")       ;gun
                     (rectangle 20 10 "solid" "black"))))   ;main body

(define TANK-HEIGHT/2 (/ (image-height TANK) 2))

(define MISSILE (ellipse 5 15 "solid" "red"))


;; ===================================================================================================
;; Data Definitions:

(define-struct game (invaders missiles tank))
;; Game is (make-game  (listof Invader) (listof Missile) Tank)
;; interp. the current state of a space invaders game
;; containing info about the current invaders, missiles and the tank

;; Game constants defined below Missile data definition

#;
(define (fn-for-game g)
  (... (fn-for-loinvader (game-invaders g))
       (fn-for-lom (game-missiles g))
       (fn-for-tank (game-tank g))))


(define-struct tank (x dir))
;; Tank is (make-tank Number Integer[-1, 1])
;; interp. the tank location is x, HEIGHT - TANK-HEIGHT/2 in screen coordinates
;; - the tank moves TANK-SPEED pixels per clock tick
;; - it moves left if direction is -1 and right if dir is 1

(define T0 (make-tank (/ WIDTH 2) 1))   ;center going right
(define T1 (make-tank 50 1))            ;going right
(define T2 (make-tank 50 -1))           ;going left

#;
(define (fn-for-tank t)
  (... (tank-x t) (tank-dir t)))


(define-struct invader (x y dx))
;; Invader is (make-invader Number Number Number)
;; interp. the invader is at (x, y) in screen coordinates
;;         the invader along x by dx pixels per clock tick

(define I1 (make-invader 150 100 12))             ;not landed, moving right
(define I2 (make-invader 150 HEIGHT -10))         ;exactly landed, moving left
(define I3 (make-invader 150 (+ HEIGHT 10) 10))   ;> landed, moving right


#;
(define (fn-for-invader invader)
  (... (invader-x invader) (invader-y invader) (invader-dx invader)))


(define-struct missile (x y))
;; Missile is (make-missile Number Number)
;; interp. the missile's location is are x y-coordinates in screen pixels

(define M1 (make-missile 150 300))                               ;not hit U1
(define M2 (make-missile (invader-x I1) (+ (invader-y I1) 10)))  ;exactly hit U1
(define M3 (make-missile (invader-x I1) (+ (invader-y I1)  5)))  ;> hit U1


#;
(define (fn-for-missile m)
  (... (missile-x m) (missile-y m)))


;; examples for Game
(define G0 (make-game empty empty T0))
(define G1 (make-game empty empty T1))
(define G2 (make-game (list I1) (list M1) T1))
(define G3 (make-game (list I1 I2) (list M1 M2) T1))


;; ListOfMissile is one of
;; - empty
;; - (cons missile ListOfMissile)
;; interp. an arbitrary sized list of missiles

(define LOM1 empty)
(define LOM2 (cons (make-missile 150 300) empty))
(define LOM3 (cons (make-missile 150 300) (cons (make-missile 50 100) empty)))


#;
(define (fn-for-lom lom)
  (cond [(empty? lom) (...)]
        [else
         (... (fn-for-missile (first lom))
              (fn-for-lom (rest lom)))]))

;; Template rules used:
;; - one of: 2 cases
;; - atomic distinct: empty
;; - compound: (cons missile ListOfMissile) 2 fields
;; - reference: (first lom) 
;; - self-reference: (rest lom)  


;; ListOfInvader is one of
;; - empty
;; - (cons invader ListOfInvader)
;; interp. an arbitrary sized list of invaders

(define LOI1 empty)
(define LOI2 (cons (make-invader 20 10 10) empty))
(define LOI3 (cons (make-invader 20 10 10) (cons (make-invader 150 100 -10) empty)))


#;
(define (fn-for-loi loi)
  (cond [(empty? loi) (...)]
        [else
         (... (fn-for-invader (first loi))
              (fn-for-loi (rest loi)))]))


;; Template rules used:
;; - one of: 2 cases
;; - atomic distinct: empty
;; - compound: (cons invader ListOfInvader) 2 fields
;; - reference: (first loi) 
;; - self-reference: (rest loi)  

;; ====================================================================================
;; Functions:
  
;; Game -> Game
;; start space invaders with (main G0)
;; no tests for main function
(define (main f)
  (big-bang f                     ; Game
    (on-tick   next-game)         ; Game -> Game
    (to-draw   render-game)       ; Game -> Image
    (stop-when game-over go-img)  ; Game -> Boolean
    (on-key    handle-key)))      ; Game KeyEvent -> Game

;; Game -> Game
;; produce the next state of the game
;; - advance invaders, missiles and tank
;; - remove all collisions
;; - randomly add invaders to the game 
;; no test due to randomly generated invaders

;(define (next-game g) G0) ; stub

(define (next-game g)
  (randomize-invasion              ; randomly add invaders to the game
   (move-items                     ; advances invaders, missiles and tank
    (destroy-collision g))))       ; destroys all collisions of invaders and missiles  

;; Game -> Game
;; produce the next state of the game
;; - advance all missiles in the list by MISSILE-SPEED
;; - move tank by TANK-SPEED on the x axis, given the direction
;; - create a new invader on every INVADER-RATE - tick
(check-expect (move-items (make-game empty empty (make-tank (/ WIDTH 2) 1)))            ; tank only at initial state, going right  
              (make-game  empty empty (make-tank (+ (/ WIDTH 2) TANK-SPEED) 1)))
(check-expect (move-items (make-game empty empty (make-tank (/ WIDTH 2) -1)))           ; tank only at initial state, going left 
              (make-game  empty empty (make-tank (- (/ WIDTH 2) TANK-SPEED) -1)))
(check-expect (move-items (make-game empty                                              ; missiles and tank
                                     (cons (make-missile 80 (- HEIGHT TANK-HEIGHT/2))
                                           (cons (make-missile (/ WIDTH 2) (- HEIGHT TANK-HEIGHT/2))
                                                 (cons (make-missile 20 100) empty)))
                                     (make-tank (/ WIDTH 2) -1)))
              (make-game empty
                         (cons (make-missile 80 (- (- HEIGHT TANK-HEIGHT/2) MISSILE-SPEED))
                               (cons (make-missile (/ WIDTH 2) (- (- HEIGHT TANK-HEIGHT/2) MISSILE-SPEED))
                                     (cons (make-missile 20 (- 100 MISSILE-SPEED)) empty)))
                         (make-tank (- (/ WIDTH 2) TANK-SPEED) -1)))
(check-expect (move-items (make-game (cons (make-invader 50 70 1) empty)                ; invader, missiles and tank
                                     (cons (make-missile 80 (- HEIGHT TANK-HEIGHT/2))
                                           (cons (make-missile (/ WIDTH 2) (- HEIGHT TANK-HEIGHT/2))
                                                 (cons (make-missile 20 100) empty)))
                                     (make-tank (/ WIDTH 2) -1)))
              (make-game (cons (make-invader (+ 50 INVADER-X-SPEED) (+ 70 INVADER-Y-SPEED) 1) empty)
                         (cons (make-missile 80 (- (- HEIGHT TANK-HEIGHT/2) MISSILE-SPEED))
                               (cons (make-missile (/ WIDTH 2) (- (- HEIGHT TANK-HEIGHT/2) MISSILE-SPEED))
                                     (cons (make-missile 20 (- 100 MISSILE-SPEED)) empty)))
                         (make-tank (- (/ WIDTH 2) TANK-SPEED) -1)))

;(define (move-items g) G0) ;stub

;<took template from Game>
(define (move-items g)
  (make-game                                   
   (next-invader  (game-invaders g))                               ; advance invaders
   (next-missiles (game-missiles g))                               ; advance missiles
   (next-tank (game-tank g))))                                     ; advance tank


;; Game -> Game
;; if missile hit invader, remove invader and missile from game
(check-expect (destroy-collision (make-game empty empty T0))       ; no invaders nor missiles
              (make-game empty empty T0))
(check-expect (destroy-collision                                   ; no invaders but missiles
               (make-game empty                         
                          (cons (make-missile 80 (- HEIGHT TANK-HEIGHT/2))
                                (cons (make-missile (/ WIDTH 2) (- HEIGHT TANK-HEIGHT/2))
                                      empty))
                          T0))
              (make-game empty
                         (cons (make-missile 80 (- HEIGHT TANK-HEIGHT/2))
                               (cons (make-missile (/ WIDTH 2) (- HEIGHT TANK-HEIGHT/2))
                                     empty))
                         T0))
(check-expect (destroy-collision
               (make-game (cons (make-invader 40 120 1)             ; no missiles but invaders
                                (cons (make-invader 120 150 -1) empty))                        
                          empty
                          T0))
              (make-game (cons (make-invader 40 120 1)     
                               (cons (make-invader 120 150 -1) empty))
                         empty
                         T0))
(check-expect (destroy-collision
               (make-game (cons (make-invader 40 120 1)              ; missiles and invaders, no hit
                                (cons (make-invader 120 150 -1) empty))                        
                          (cons (make-missile 80 (- HEIGHT TANK-HEIGHT/2))
                                (cons (make-missile (/ WIDTH 2) (- HEIGHT TANK-HEIGHT/2))
                                      empty))
                          T0))
              (make-game (cons (make-invader 40 120 1)     
                               (cons (make-invader 120 150 -1) empty))
                         (cons (make-missile 80 (- HEIGHT TANK-HEIGHT/2))
                               (cons (make-missile (/ WIDTH 2) (- HEIGHT TANK-HEIGHT/2))
                                     empty))
                         T0))
(check-expect (destroy-collision                                      ; missile hit invader exactly
               (make-game (cons (make-invader 40 120 1)         
                                (cons (make-invader 120 150 -1) empty))                        
                          (cons (make-missile 120 (+ 150 HIT-RANGE))
                                (cons (make-missile (/ WIDTH 2) (- HEIGHT TANK-HEIGHT/2))
                                      empty))
                          T0))
              (make-game (cons (make-invader 40 120 1) empty)
                         (cons (make-missile (/ WIDTH 2) (- HEIGHT TANK-HEIGHT/2)) empty)
                         T0))
(check-expect (destroy-collision                                       ; missile hit invader barely
               (make-game (cons (make-invader 40 120 1)             
                                (cons (make-invader 120 150 -1) empty))                        
                          (cons (make-missile 120 (+ 150 6))
                                (cons (make-missile (/ WIDTH 2) (- HEIGHT TANK-HEIGHT/2)) empty))
                          T0))
              (make-game (cons (make-invader 40 120 1) empty)
                         (cons (make-missile (/ WIDTH 2) (- HEIGHT TANK-HEIGHT/2)) empty)
                         T0))
(check-expect (destroy-collision
               (make-game (cons (make-invader 40 120 1)                ; missile has passed invader, no hit
                                (cons (make-invader 120 150 -1) empty))                        
                          (cons (make-missile 120 (- 150 15))
                                (cons (make-missile (/ WIDTH 2) (- HEIGHT TANK-HEIGHT/2)) empty))
                          T0))
              (make-game (cons (make-invader 40 120 1)     
                               (cons (make-invader 120 150 -1) empty))
                         (cons (make-missile 120 (- 150 15))
                               (cons (make-missile (/ WIDTH 2) (- HEIGHT TANK-HEIGHT/2)) empty))
                         T0))
              
;(define (destroy-collision g) G0) ;stub

;<took template from Game>
(define (destroy-collision g)
  (make-game 
   (remove-invaders (game-invaders g) (game-missiles g))
   (remove-missiles (game-invaders g) (game-missiles g))
   (game-tank g)))

;; ListOfInvader ListOfMissile -> ListOfInvader
;; remove all invaders from the list where a missile from the list has coordinates within the shooting range 
(check-expect (remove-invaders empty empty) empty)
(check-expect (remove-invaders empty (cons (make-missile 50 40) empty)) empty)    ; only missiles
(check-expect (remove-invaders (cons (make-invader 60 80 -1) empty)               ; no hit
                               (cons (make-missile 50 40) empty))
              (cons (make-invader 60 80 -1) empty))
(check-expect (remove-invaders (cons (make-invader 60 80 -1)                      ; one hit
                                     (cons (make-invader 50 50 -1) empty))               
                               (cons (make-missile 50 60) empty))
              (cons (make-invader 60 80 -1) empty))
(check-expect (remove-invaders (cons (make-invader 60 80 -1)                      ; two hits
                                     (cons (make-invader 50 50 -1) empty))               
                               (cons (make-missile 50 60)
                                     (cons (make-missile 60 86) empty)))
              empty)


;(define (remove-invaders loi lom) LOI1) ;stub

;<took template from ListOfInvaders, added compound parameter lom>
(define (remove-invaders loi lom)
  (cond [(empty? loi) empty]
        [(empty? lom) loi]
        [(hit-invader? (first loi) lom)
         (remove-invaders (rest loi) lom)]
        [else
         (cons (make-invader
                (invader-x (first loi))
                (invader-y (first loi))
                (invader-dx (first loi)))
               (remove-invaders (rest loi) lom))])) 

;; ListOfInvader ListOfMissile -> ListOfMissile
;; remove all missiles from the list where an invader
;; from the list has coordinates within the shooting range 
(check-expect (remove-missiles empty empty) empty)
(check-expect (remove-missiles empty (cons (make-missile 50 40) empty))           ; only missiles
              (cons (make-missile 50 40) empty))   
(check-expect (remove-missiles (cons (make-invader 60 80 -1) empty)               ; no hit
                               (cons (make-missile 50 40) empty))
              (cons (make-missile 50 40) empty))
(check-expect (remove-missiles (cons (make-invader 60 80 -1)                      ; one hit
                                     (cons (make-invader 50 50 -1) empty))               
                               (cons (make-missile 50 60) empty))
              empty)
(check-expect (remove-missiles (cons (make-invader 60 80 -1)                      ; two hits
                                     (cons (make-invader 50 50 -1) empty))               
                               (cons (make-missile 50 60)
                                     (cons (make-missile 60 86) empty)))
              empty)


;(define (remove-missiles loi lom) LOM1) ;stub

;<took template from ListOfMissile, added compound parameter loi>
(define (remove-missiles loi lom)
  (cond [(empty? lom) empty]
        [(empty? loi) lom]
        [(hit-missile? (first lom) loi)
         (remove-missiles loi (rest lom))]
        [else
         (cons (make-missile
                (missile-x (first lom))
                (missile-y (first lom)))
               (remove-missiles loi (rest lom)))])) 


;; Invader ListOfMissile -> Boolean
;; produce true if an invader is within HIT-RANGE of any missile within ListOfMissile, else false
(check-expect (hit-invader? (make-invader 50 70 1)
                            (cons (make-missile 39 81)
                                  (cons (make-missile 61 59) empty)))
              false)
(check-expect (hit-invader? (make-invader 50 70 1)
                            (cons (make-missile 60 70)
                                  (cons (make-missile 53 80) empty)))
              true)
(check-expect (hit-invader? (make-invader 80 70 1)
                            (cons (make-missile 75 75)
                                  (cons (make-missile 50 76) empty)))
              true)
(check-expect (hit-invader? (make-invader 50 70 1)
                            (cons (make-missile 70 90)
                                  (cons (make-missile 52 66) empty)))
              true)

; (define (hit-invader? inv lom) false) ;stub

;<took template from ListOfMissile, added atomic parameter inv>
(define (hit-invader? inv lom)
  (cond [(empty? lom) false]
        [else
         (if (and (<= (abs (- (missile-x (first lom)) (invader-x inv))) HIT-RANGE)
                  (<= (abs (- (missile-y (first lom)) (invader-y inv))) HIT-RANGE))
             true
             (hit-invader? inv (rest lom)))]))


;; Missile ListOfInvader -> Boolean
;; produce true if an missile is within HIT-RANGE of any invader within ListOfInvader, else false
(check-expect (hit-missile? (make-missile 50 70)
                            (cons (make-invader 39 81 1)
                                  (cons (make-invader 61 59 -1) empty)))
              false)
(check-expect (hit-missile? (make-missile 50 70)
                            (cons (make-invader 60 70 1)
                                  (cons (make-invader 50 60 -1) empty)))
              true)
(check-expect (hit-missile? (make-missile 50 70)
                            (cons (make-invader 60 70 1)
                                  (cons (make-invader 20 120 -1) empty)))
              true)
(check-expect (hit-missile? (make-missile 50 70)
                            (cons (make-invader 10 100 -1)
                                  (cons (make-invader 50 65 -1) empty)))
              true)

; (define (hit-missile? m lol) false) ;stub

;<took template from ListOfInvader, added atomic parameter m>
(define (hit-missile? m loi)
  (cond [(empty? loi) false]
        [else
         (if (and (<= (abs (- (invader-x (first loi)) (missile-x m))) HIT-RANGE)
                  (<= (abs (- (invader-y (first loi)) (missile-y m))) HIT-RANGE))
             true
             (hit-missile? m (rest loi)))]))


;; Tank -> Tank
;; produce the next tank of the game
;; if dir of tank is 1, add tank-speed to the x-coordinate
;; if dir of tank is -1, subtract tank-speed from the x-coordinate
;; if tank reaches the boundaries left and right of the screen,
;; make it appear on the opposite end of the x-axis keeping the direction

(check-expect (next-tank (make-tank (/ WIDTH 2) 1))         ; only tank at initial state, going right  
              (make-tank (+ (/ WIDTH 2) (* TANK-SPEED 1)) 1))
(check-expect (next-tank (make-tank (/ WIDTH 2) -1))        ; only tank at initial state, going left 
              (make-tank (+ (/ WIDTH 2) (* TANK-SPEED -1)) -1))

(check-expect (next-tank (make-tank WIDTH 1))                       ; right edge, right direction
              (make-tank (modulo (+ WIDTH (* TANK-SPEED 1)) WIDTH) 1))
(check-expect (next-tank (make-tank 0 -1))                            ; left edge, left direction
              (make-tank (modulo (+ 0 (* TANK-SPEED -1)) WIDTH) -1))

;(define (next-tank t) T0) ; stub

;<took template from Tank>
(define (next-tank t)
  (make-tank (modulo (+ (tank-x t) (* TANK-SPEED (tank-dir t))) WIDTH)
             (tank-dir t)))

;; ListOfMissile -> ListOfMissile
;; move the missile upward on y-axis by MISSILE-SPEED
;; remove missile from list if it reached the upper boundary
(check-expect (next-missiles empty) empty)
(check-expect (next-missiles (cons (make-missile 50 50) empty))
              (cons (make-missile 50 (- 50 MISSILE-SPEED)) empty))
(check-expect (next-missiles (cons (make-missile 20 80)
                                   (cons (make-missile 50 50) empty)))
              (cons (make-missile 20 (- 80 MISSILE-SPEED))
                    (cons (make-missile 50 (- 50 MISSILE-SPEED)) empty)))
(check-expect (next-missiles (cons (make-missile 30 0)                   ; missile reaches upper end of screen
                                   (cons (make-missile 50 50) empty)))   
              (cons (make-missile 50 (- 50 MISSILE-SPEED)) empty))
                             

;(define (next-missiles lom) LOM1) ;stub

;<took template from ListOfMissile>
(define (next-missiles lom)
  (cond [(empty? lom) empty]
        [(<= (missile-y (first lom)) 0)
         (next-missiles (rest lom))]
        [else
         (cons (make-missile (missile-x (first lom)) (- (missile-y (first lom)) MISSILE-SPEED))
               (next-missiles (rest lom)))]))

;; ListOfInvader -> ListOfInvader
;; move all invaders by INVADER-X-SPEED on the x-axis
;; - if dx is positive, add INVADER-X-SPEED to x-value
;; - if dx is negative, subtract x-value by INVADER-X-SPEED
;; - if left or right boundary was reached, additionally invert dx 
;; - move all invaders by INVADER-Y-SPEED upwards on the y-axis
(check-expect (next-invader empty) empty)
(check-expect (next-invader (cons (make-invader 20 50 -1) empty))                 ; left direction
              (cons (make-invader (+ 20 -1.5) (+ 50 INVADER-Y-SPEED) -1) empty))
(check-expect (next-invader (cons (make-invader 20 50 1) empty))                  ; right direction
              (cons (make-invader (+ 20 1.5) (+ 50 INVADER-Y-SPEED) 1) empty))
(check-expect (next-invader (cons (make-invader WIDTH 50 1) empty))               ; right boundary
              (cons (make-invader (+ WIDTH -1.5) (+ 50 INVADER-Y-SPEED) -1) empty))
(check-expect (next-invader (cons (make-invader 0 50 -1) empty))                  ; left boundary
              (cons (make-invader (+ 0 1.5) (+ 50 INVADER-Y-SPEED) 1) empty))
(check-expect (next-invader (cons (make-invader 20 50 -1)                         ; multiple invaders
                                  (cons (make-invader 40 70 1) empty)))                
              (cons (make-invader (+ 20 -1.5) (+ 50 INVADER-Y-SPEED) -1)
                    (cons (make-invader (+ 40 1.5) (+ 70 INVADER-Y-SPEED) 1) empty)))

;(define (next-invader loi) empty) ;stub

;<took template from ListOfInvaders>
(define (next-invader loi)
  (cond [(empty? loi) empty]
        [(>= (invader-x (first loi)) WIDTH)
         (cons (make-invader (- (invader-x (first loi)) INVADER-X-SPEED)
                             (+ (invader-y (first loi)) INVADER-Y-SPEED)
                             (* (invader-dx (first loi)) -1)) 
               (next-invader (rest loi)))]
        [(<=(invader-x (first loi)) 0)
         (cons (make-invader (+ (invader-x (first loi)) INVADER-X-SPEED)
                             (+ (invader-y (first loi)) INVADER-Y-SPEED)
                             (* (invader-dx (first loi)) -1)) 
               (next-invader (rest loi)))]
        [(< (invader-dx (first loi)) 0)
         (cons (make-invader (- (invader-x (first loi)) INVADER-X-SPEED)
                             (+ (invader-y (first loi)) INVADER-Y-SPEED)
                             (invader-dx (first loi))) 
               (next-invader (rest loi)))]
        [else
         (cons (make-invader (+ (invader-x (first loi)) INVADER-X-SPEED)
                             (+ (invader-y (first loi)) INVADER-Y-SPEED)
                             (invader-dx (first loi))) 
               (next-invader (rest loi)))]))


;; Game -> Game
;; randomly create an additional invader (using INVADE-RATE) to the game

;<took template from Game> 
(define (randomize-invasion g)
  (if (> (random 105) INVADE-RATE)
      (make-game 
       (invade (game-invaders g))
       (game-missiles g)
       (game-tank g))
      g))
  
;; ListOfInvader -> ListOfInvader
;; produce a ListOfInvader with an additional invader
;; - a random value of x within an interval of [0, WIDTH)
;; - a random value of y within the upper 20% of the screen
;; - a positive or negative direction of dx 
(check-random (invade empty)
              (cons (make-invader (random WIDTH)
                            (random (* HEIGHT 0.2))
                            (random-dir (random 2))) empty))
(check-random (invade (cons (make-invader 50 70 1) empty))
              (cons (make-invader (random WIDTH)
                                  (random (* HEIGHT 0.2))
                                  (random-dir (random 2)))
                    (cons (make-invader 50 70 1) empty)))

;(define (invade loi) empty) ;stub 

(define (invade loi) 
  (cons (make-invader (random WIDTH)
                      (random (* HEIGHT 0.2))
                      (random-dir (random 2))) loi))

;; Natural[1,2] -> Integer
;; produce 1 or -1 depending on the randomized input value
(check-expect (random-dir 0) 1)         ;even
(check-expect (random-dir 1) -1)        ;odd

;(define (random-dir num) 1) ;stub

(define (random-dir num)
  (if (odd? num)
      -1
      1))


;; Game -> Image
;; produce the image representing the state of the game
(check-expect (render-game (make-game empty empty (make-tank (/ WIDTH 2) 1)))
              (place-image TANK (/ WIDTH 2) (- HEIGHT TANK-HEIGHT/2) BACKGROUND))             ;only tank at initial state
(check-expect (render-game (make-game empty empty (make-tank 0 1)))
              (place-image TANK 0 (- HEIGHT TANK-HEIGHT/2) BACKGROUND))                       ; tank left boundary
(check-expect (render-game (make-game empty empty (make-tank (- WIDTH TANK-SPEED) 1)))
              (place-image TANK (- WIDTH TANK-SPEED) (- HEIGHT TANK-HEIGHT/2) BACKGROUND))    ; tank right boundary
(check-expect (render-game (make-game empty                                                   ; multiple missiles and tank
                                      (cons (make-missile 80 (- HEIGHT TANK-HEIGHT/2))
                                            (cons (make-missile (/ WIDTH 2) (- HEIGHT TANK-HEIGHT/2))
                                                  (cons (make-missile 20 100) empty)))
                                      (make-tank (/ WIDTH 2) 1)))
              (place-image MISSILE  80 (- HEIGHT TANK-HEIGHT/2)
                           (place-image MISSILE (/ WIDTH 2) (- HEIGHT TANK-HEIGHT/2)
                                        (place-image MISSILE 20 100
                                                     (place-image TANK (/ WIDTH 2) (- HEIGHT TANK-HEIGHT/2)
                                                                  BACKGROUND)))))
(check-expect (render-game (make-game (cons (make-invader 60 50 1)                            ; invaders & missiles & tank 
                                            (cons (make-invader 20 70 -1) empty))                                          
                                      (cons (make-missile 80 (- HEIGHT TANK-HEIGHT/2))
                                            (cons (make-missile (/ WIDTH 2) (- HEIGHT TANK-HEIGHT/2))
                                                  (cons (make-missile 20 100) empty)))
                                      (make-tank (/ WIDTH 2) 1)))
              (place-image INVADER 60 50
                           (place-image INVADER 20 70
                                        (place-image MISSILE  80 (- HEIGHT TANK-HEIGHT/2)
                                                     (place-image MISSILE (/ WIDTH 2) (- HEIGHT TANK-HEIGHT/2)
                                                                  (place-image MISSILE 20 100
                                                                               (place-image TANK (/ WIDTH 2) (- HEIGHT TANK-HEIGHT/2)
                                                                                            BACKGROUND)))))))

;(define (render-game g) BACKGROUND) ; stub

;<took template from Game>
(define (render-game g)
  (place-invaders (game-invaders g)
                  (place-missiles (game-missiles g)
                                  (place-image TANK
                                               (tank-x (game-tank g)) (- HEIGHT TANK-HEIGHT/2)
                                               BACKGROUND))))

;; ListOfMissile Image -> Image
;; produce images of the missiles within the ListOfMissile at the respective coordinates on the screen
(check-expect (place-missiles empty BACKGROUND) BACKGROUND)                    ; no missiles
(check-expect (place-missiles (cons (make-missile 20 100) empty) BACKGROUND)   ; one missile
              (place-image MISSILE 20 100
                           BACKGROUND))
(check-expect (place-missiles (cons (make-missile 80 (- HEIGHT TANK-HEIGHT/2))
                                    (cons (make-missile (/ WIDTH 2) (- HEIGHT TANK-HEIGHT/2))
                                          (cons (make-missile 20 100) empty))) BACKGROUND)   ; multiple missiles
              (place-image MISSILE 80 (- HEIGHT TANK-HEIGHT/2)
                           (place-image MISSILE (/ WIDTH 2) (- HEIGHT TANK-HEIGHT/2)
                                        (place-image MISSILE 20 100 
                                                     BACKGROUND))))
  
;(define (place-missiles lom img) BACKGROUND) ;stub

;<took template from ListOfMissile, added one atomic parameter img>
(define (place-missiles lom img)
  (cond [(empty? lom) img]
        [else
         (place-image MISSILE (missile-x (first lom)) (missile-y (first lom))
                      (place-missiles (rest lom) img))]))


;; ListOfInvader Image -> Image
;; render images of the invaders within the list
;; and place them on the respective coordinates on the screen
(check-expect (place-invaders empty BACKGROUND) BACKGROUND)
(check-expect (place-invaders (cons (make-invader 170 55 1)
                                    (cons (make-invader 190 100 -1) empty)) BACKGROUND)
              (place-image INVADER 170 55
                           (place-image INVADER 190 100
                                        BACKGROUND)))

;(define (place-invaders loi img) BACKGROUND) ;stub

;<took template from ListOfInvader, added one atomic parameter img>
(define (place-invaders loi img)
  (cond [(empty? loi) img]
        [else
         (place-image INVADER (invader-x (first loi)) (invader-y (first loi))
                      (place-invaders (rest loi) img))]))

  
;; Game -> Boolean
;; produce true to stop the game if the invader has reached the bottom 
;; display Game Over and reset game to initital state, produce false 
(check-expect (game-over G0) false)
(check-expect (game-over (make-game (cons (make-invader 40 50 -1)
                                          (cons (make-invader 60 70 -1) empty))
                                          M1
                                          T0))
              false)
(check-expect (game-over G2) false)
(check-expect (game-over G3) true)  

;(define (game-over g) false) ;stub

(define (game-over g)
  (landed? (game-invaders g)))

;; ListOfInvader -> Boolean
;; produce true if any of the invader has reached the bottom of the screen (x >= HEIGHT of screen)
(check-expect (landed? empty) false)
(check-expect (landed? LOI1) false)                                                            ; not landed 
(check-expect (landed? (cons (make-invader 20 10 10)
                             (cons (make-invader 150 HEIGHT -10) empty))) true)                ; exactly landed
(check-expect (landed? (cons (make-invader 20 10 10)
                             (cons (make-invader 150 (+ HEIGHT 10) -10) empty))) true)         ; below screen

;(define (landed? loi) false) ;stub

;<took template from ListOfInvader>
(define (landed? loi)
  (cond [(empty? loi) false]
        [(>= (invader-y (first loi)) HEIGHT) true]
        [else
         (landed? (rest loi))]))
  
;; Game -> Image
;; produce the last screen of the game "GAME OVER"

;(define (go-img g) BACKGROUND) ;stub

(define (go-img g)
  (place-image (text "GAME OVER :(" 35 "red") (/ WIDTH 2) (/ HEIGHT 2)
                     (render-game g)))

;; Game KeyEvent -> Game
;; if left-key was hit, move tank to the left
;; if right-key was hit, move tank to the right
;; if space-key was hit, launch a missile
(check-expect (handle-key (make-game empty empty (make-tank (/ WIDTH 2) 1)) "right")  ; right key, right direction
              (make-game empty empty (make-tank (/ WIDTH 2) 1)))
(check-expect (handle-key (make-game empty empty (make-tank (/ WIDTH 2) -1)) "right")  ; right key, left direction
              (make-game empty empty (make-tank (/ WIDTH 2) 1)))
(check-expect (handle-key (make-game empty empty (make-tank (/ WIDTH 2) -1)) "left")  ; left key, left direction
              (make-game empty empty (make-tank (/ WIDTH 2) -1)))
(check-expect (handle-key (make-game empty empty (make-tank (/ WIDTH 2) 1)) "left")  ; left key, left direction
              (make-game empty empty (make-tank (/ WIDTH 2) -1)))
(check-expect (handle-key (make-game empty                                           ; space-key left direction
                                     (cons (make-missile (/ WIDTH 2) (- HEIGHT TANK-HEIGHT/2))
                                           (cons (make-missile 20 100) empty))
                                     (make-tank 30 -1)) " ")  
              (make-game empty
                         (cons (make-missile 30 (- HEIGHT TANK-HEIGHT/2))
                               (cons (make-missile (/ WIDTH 2) (- HEIGHT TANK-HEIGHT/2))
                                     (cons (make-missile 20 100) empty)))
                         (make-tank 30 -1)))

;(define (handle-key s ke) G0) ;stub

; <on-key handler template>
(define (handle-key s ke)
  (cond [(key=? ke "left")
         (make-game (game-invaders s) (game-missiles s) (go-left (game-tank s)))]
        [(key=? ke "right")
         (make-game (game-invaders s) (game-missiles s) (go-right (game-tank s)))]
        [(key=? ke " ")
         (make-game (game-invaders s) (shoot (game-missiles s) (game-tank s)) (game-tank s))]
        [else
         s]))


;; Tank -> Tank
;; if left-key was hit and moving to the right, change direction to left (invert dir)
(check-expect (go-left (make-tank (/ WIDTH 2) -1))  ; left key, left direction
              (make-tank (/ WIDTH 2) -1))
(check-expect (go-left (make-tank (/ WIDTH 2) 1))  ; left key, right direction
              (make-tank (/ WIDTH 2) -1))

;(define (go-left t) T0) ; stub

;<template from tank>
(define (go-left t)
  (if (= (tank-dir t) 1)
      (make-tank (tank-x t) -1)
      t))

;; Tank -> Tank
;; if right-key was hit and moving left, change direction to right
(check-expect (go-right (make-tank (/ WIDTH 2) -1))  ; right key, left direction
              (make-tank (/ WIDTH 2) 1))
(check-expect (go-right (make-tank (/ WIDTH 2) 1))  ; right key, right direction
              (make-tank (/ WIDTH 2) 1))

;(define (go-right t) T0) ; stub

; <template from tank>     
(define (go-right t)
  (if (= (tank-dir t) -1)
      (make-tank (tank-x t) 1)
      t))

;; ListOfMissile Tank -> ListOfMissile
;; insert a new missile at the beginning of the list of missiles
(check-expect (shoot empty (make-tank (/ WIDTH 2) 1))                                   ; first missile
              (cons (make-missile (/ WIDTH 2) (- HEIGHT TANK-HEIGHT/2)) empty))
(check-expect (shoot (cons (make-missile (/ WIDTH 2) (- HEIGHT TANK-HEIGHT/2))
                           (cons (make-missile 20 100) empty))                          ; multiple missiles
                     (make-tank 80 -1))                          
              (cons (make-missile 80 (- HEIGHT TANK-HEIGHT/2))
                    (cons (make-missile (/ WIDTH 2) (- HEIGHT TANK-HEIGHT/2))
                          (cons (make-missile 20 100) empty))))

; (define (shoot lom t) LOM1) ;stub

; <template from ListOfMissile, add one atomic parameter t>
(define (shoot lom t)
  (cons (make-missile (tank-x t) (- HEIGHT TANK-HEIGHT/2)) lom))