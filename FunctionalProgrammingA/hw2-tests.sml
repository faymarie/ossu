(* Homework2 Simple Test *)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)

use "hw2.sml";

(* val test10 = all_except_option ("string", ["string"]) = SOME []
val test11 = all_except_option ("test", ["string"]) = NONE
val test12 = all_except_option ("string", ["a", "string"]) = SOME ["a"]
val test13 = all_except_option ("string", ["string", "a"]) = SOME ["a"]
val test14 = all_except_option ("string", ["string", "a", "b"]) = SOME ["a", "b"]
val test15 = all_except_option ("string", ["a", "b", "string"]) = SOME ["a", "b"]
val test16 = all_except_option ("string", ["a", "string", "b"]) = SOME ["a", "b"]
val test17 = all_except_option ("string", []) = NONE
val test18 = all_except_option ("string", ["a", "string", "b", "string"]) *)

(* val test20 = get_substitutions1 ([["foo"],["there"]], "foo") = []
val test21 = get_substitutions1 ([[],[]], "foo") = []
val test22 = get_substitutions1 ([], "foo") = []
val test23 = get_substitutions1 ([["f1", "foo", "f2"], ["foo"]], "foo") = ["f1","f2"]
val test24 = get_substitutions1 ([["f1", "foo", "f2"], ["f3", "foo", "f4"], ["f5", "f6"], []], "foo") = ["f1","f2","f3","f4"] *)


(* val test30 = get_substitutions2 ([["foo"],["there"]], "foo") = []
val test31 = get_substitutions2 ([[],[]], "foo") = []
val test32 = get_substitutions2 ([], "foo") = []
val test33 = get_substitutions2 ([["f1", "foo", "f2"], ["foo"]], "foo") = ["f1","f2"]
val test34 = get_substitutions2 ([["f1", "foo", "f2"], ["f3", "foo", "f4"], ["f5", "f6"], []], "foo") = ["f3","f4","f1","f2"] *)

(* val test40 = similar_names ([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], {first="Fred", middle="W", last="Smith"}) =
	    [{first="Fred", last="Smith", middle="W"}, {first="Fredrick", last="Smith", middle="W"},
	     {first="Freddie", last="Smith", middle="W"}, {first="F", last="Smith", middle="W"}]
val test41 = similar_names ([], {first="Fred", middle="W", last="Smith"}) = [{first="Fred", middle="W", last="Smith"}]
val test42 = similar_names ([["Elizabeth","Betty"]], {first="Fred", middle="W", last="Smith"}) = [{first="Fred", middle="W", last="Smith"}] *)


(* val test50 = card_color (Clubs, Num 2) = Black
val test51 = card_color (Spades, Num 4) = Black
val test52 = card_color (Hearts, Num 9) = Red
val test53 = card_color (Diamonds, Num 7) = Red *)

(* val test60 = card_value (Clubs, Num 2) = 2
val test61 = card_value (Hearts, King) = 10
val test62 = card_value (Hearts, Jack) = 10
val test63 = card_value (Hearts, Queen) = 10
val test64 = card_value (Spades, Ace) = 11 *)

(* val test70 = remove_card ([(Hearts, Ace)], (Hearts, Ace), IllegalMove) = []
val test71 = remove_card ([(Spades, Num 9), (Hearts, Ace), (Diamonds, Jack), (Hearts, Ace)], (Hearts, Ace), IllegalMove) = [(Spades,Num 9),(Diamonds,Jack),(Hearts,Ace)]
val test72  = remove_card([(Diamonds, Ace)], (Hearts, Ace), IllegalMove) *)

(* val test80 = all_same_color [(Hearts, Ace), (Hearts, Ace)] = true
val test81 = all_same_color [(Hearts, Ace), (Diamonds, Ace), (Hearts, Num 7)] = true
val test82 = all_same_color [(Hearts, Ace), (Diamonds, Ace), (Spades, Jack)] = false
val test83 = all_same_color [(Spades, Jack), (Hearts, Ace), (Diamonds, Ace)] = false
val test84 = all_same_color [(Hearts, Ace), (Spades, Jack), (Diamonds, Ace)] = false
val test85 = all_same_color [] = true *)

(* val test90 = sum_cards [(Clubs, Num 2),(Clubs, Num 2)] = 4
val test91 = sum_cards [] = 0
val test92 = sum_cards [(Clubs, Num 2),(Clubs, Ace), (Diamonds, Queen)] = 23 *)

(* val test100 = score ([(Hearts, Num 2),(Clubs, Num 4)],10) = 4
val test101 = score ([(Hearts, Num 7),(Clubs, Queen), (Spades, Num 5)], 24) = 2
val test102 = score ([(Clubs, Num 7),(Clubs, Queen), (Spades, Num 5)], 24) = 1
val test103 = score ([(Hearts, Num 7),(Clubs, Queen), (Spades, Num 5)], 20) = 6
val test104 = score ([(Clubs, Num 7),(Clubs, Queen), (Spades, Num 5)], 20) = 3 *)

val test11 = officiate ([(Hearts, Num 2),(Clubs, Num 4)],[Draw], 15) = 6

val test12 = officiate ([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)],
                        [Draw,Draw,Draw,Draw,Draw],
                        42)
             = 3

val test13 = ((officiate([(Clubs,Jack),(Spades,Num(8))],
                         [Draw,Discard(Hearts,Jack)],
                         42);
               false) 
              handle IllegalMove => true)
