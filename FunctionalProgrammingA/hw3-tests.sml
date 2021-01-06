(* Homework3 Simple Test*)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)

use "hw3.sml";

(* val test10 = only_capitals ["A","B","C"] = ["A","B","C"]
val test11 = only_capitals ["abc","aBc","Cool"] = ["Cool"]
val test12 = only_capitals [] = [] *)

(* val test20 = longest_string1 ["A","bc","C"] = "bc"
val test21 = longest_string1 ["A","bc","Cd"] = "bc"
val test22 = longest_string1 ["","","C"] = "C"
val test23 = longest_string1 ["","",""] = "" *)

(* val test30 = longest_string2 ["A","bc","C"] = "bc"
val test31 = longest_string2 ["A","bc","Cd"] = "Cd"
val test32 = longest_string2 ["A","","C"] = "C"
val test33 = longest_string2 ["","",""] = "" *)

(* val test40a = longest_string3 ["A","bc","C"] = "bc"
val test41a = longest_string3 ["A","bc","Cd"] = "bc"
val test42a = longest_string3 ["","","C"] = "C"
val test43a = longest_string3 ["","",""] = "" *)

(* val test40b = longest_string4 ["A","B","C"] = "C"
val test41b = longest_string4 ["A","bc","Cd"] = "Cd"
val test42b = longest_string4 ["A","","C"] = "C"
val test43b = longest_string4 ["","",""] = ""
val test44b = longest_string4 ["A","bc","C"] = "bc" *)

(* val test50 = longest_capitalized ["A","bc","C"] = "A"
val test51 = longest_capitalized ["a","bc","C"] = "C"
val test52 = longest_capitalized ["A","bc","Ca", "DB"] = "Ca"
val test53 = longest_capitalized [] = "" *)

(* val test60 = rev_string "abc" = "cba"
val test61 = rev_string "b" = "b"
val test62 = rev_string "" = "" *)

(* val test70 = first_answer (fn x => if x > 3 then SOME x else NONE) [1,2,3,4,5] = 4 *)

(* val test80 = all_answers (fn x => if x = 1 then SOME [x] else NONE) [2,3,4,5,6,7] = NONE
val test81 = all_answers (fn x => if x = 1 then SOME [x] else NONE) [] = SOME []
val test82 = all_answers (fn x => if x = 1 then SOME [x] else NONE) [2,3,1,4,5,6,7] = NONE
val test83 = all_answers (fn x => if x = 1 then SOME [x] else NONE) [1] = SOME [1]
val test84 = all_answers (fn x => if x = 1 then SOME ["a", "b"] else NONE) [1, 1] = SOME ["a", "b", "a", "b"] *)


(* val test90a = count_wildcards Wildcard = 1
val test91a = count_wildcards (Variable("a")) = 0
val test92a = count_wildcards(TupleP [ConstP 1]) = 0
val test93a = count_wildcards(TupleP [ConstP 1, Wildcard, UnitP, Wildcard, ConstP 2]) = 2
val test94a = count_wildcards(TupleP [ConstP 1, Wildcard, ConstructorP ("abc", TupleP [Wildcard, Wildcard])]) = 3 *)

(* val test90b = count_wild_and_variable_lengths (Variable("a")) = 1
val test91b = count_wild_and_variable_lengths (Variable("aaaa")) = 4
val test92b = count_wild_and_variable_lengths Wildcard = 1
val test93b = count_wild_and_variable_lengths (TupleP [ConstP 1]) = 0
val test94b = count_wild_and_variable_lengths (TupleP [ConstP 1, Wildcard, UnitP, Wildcard, ConstP 2]) = 2
val test95b = count_wild_and_variable_lengths (TupleP [ConstP 1, Wildcard, UnitP, Wildcard, Variable("aaaa")]) = 6
val test96b = count_wild_and_variable_lengths (TupleP [ConstP 1, Wildcard, UnitP, Wildcard, Variable("aaaa"), ConstructorP ("abc", TupleP [Wildcard, Wildcard, Variable("abc")])]) = 11 *)

(* val test90c = count_some_var ("x", Variable("x")) = 1
val test91c = count_some_var ("x", Variable("xxx")) = 0
val test92c = count_some_var ("x", Wildcard) = 0
val test93c = count_some_var ("x", TupleP [ConstP 1]) = 0
val test94c = count_some_var ("x", TupleP [ConstP 1, Variable("x")]) = 1
val test95c = count_some_var ("abc", TupleP [ConstP 1, Variable("abc"), Variable("abc")]) = 2
val test96c = count_some_var ("abc", TupleP [ConstP 1, Variable("abc"), Variable("abc"), ConstructorP ("abc", TupleP [Wildcard, UnitP, Variable("abc")])]) = 3 *)

(* val test100 = check_pat (Variable("x")) = true
val test101 = check_pat Wildcard = true
val test102 = check_pat (TupleP [ConstP 1]) = true
val test103 = check_pat (TupleP [ConstP 1, Wildcard, ConstP 1, Variable("abc"), UnitP]) = true 
val test104 = check_pat (TupleP [ConstP 1, Variable("a"), Wildcard, Variable("abc")]) = true 
val test105 = check_pat (TupleP [ConstP 1, Variable("abc"), Wildcard, Variable("abc")]) = false 
val test106 = check_pat (TupleP [ConstP 1, Variable("abc"), Wildcard, ConstructorP ("abc", TupleP [Wildcard, UnitP, Variable("a")])]) = true
val test107 = check_pat (TupleP [ConstP 1, Variable("abc"), Wildcard, ConstructorP ("abc", TupleP [Wildcard, UnitP, Variable("abc")])]) = false
val test108 = check_pat (TupleP [ConstP 1, Wildcard, ConstructorP ("abc", TupleP [Wildcard, Variable("a"), UnitP, Variable("abc")])]) = true
val test109 = check_pat (TupleP [ConstP 1, Wildcard, ConstructorP ("abc", TupleP [Wildcard, Variable("abc"), UnitP, Variable("abc")])]) = false
val test1100 = check_pat (TupleP [Variable("c"), Variable("abc"), Variable("cba"), Variable("abc")]) = false *)

(* val test110 = match (Const(1), UnitP) = NONE
val test1101 = match (Const(1), Wildcard) = SOME []
val test1102 = match (Unit, Wildcard) = SOME []
val test1103 = match (Tuple [Unit, Const 3], Wildcard) = SOME []
val test1104 = match (Constructor ("abc", Const 1), Wildcard) = SOME []
val test1105 = match (Unit, Variable "abc") = SOME [("abc", Unit)]
val test1106 = match (Constructor ("abc", Const 1), Variable "abc") = SOME [("abc", Constructor ("abc", Const 1))]
val test1107 = match (Tuple [Unit, Constructor ("abc", Const 1), Const 6], Variable "abc") = SOME [("abc", Tuple [Unit, Constructor ("abc", Const 1), Const 6])]
val test1108 = match (Unit, UnitP) = SOME []
val test1109 = match (Const 17, ConstP 17) = SOME []
val test11010 = match (Const 10, ConstP 17) = NONE
val test11011 = match (Tuple [Unit, Const 45, Constructor ("abc", Const 12), Const 6, Unit], TupleP [UnitP, Variable("xyz"), ConstructorP ("abc", ConstP 12), ConstP 6, Variable("abc")]) = SOME [("abc",Unit),("xyz",Const 45)]
val test11012 = match (Tuple [Unit, Const 45, Constructor ("abc", Const 12), Const 6, Unit], TupleP [UnitP, Variable("xyz"), ConstructorP ("abc", ConstP 12), ConstP 6]) = NONE
val test11013 = match (Tuple [Unit, Const 45, Constructor ("abc", Const 12), Const 6, Unit], TupleP [UnitP, UnitP, ConstructorP ("abc", ConstP 12), ConstP 6, Variable("abc")]) = NONE
val test11014 = match (Constructor ("abc", Const 12), ConstructorP ("abc", ConstP 12)) = SOME []
val test11015 = match (Constructor ("abc", Const 12), ConstructorP ("abc", Wildcard)) = SOME []
val test11016 = match (Constructor ("abc", Const 12), ConstructorP ("a", Wildcard)) = NONE
val test11017 = match (Constructor ("abc", Const 12), ConstructorP ("abc", Variable("xyz"))) = SOME [("xyz", Const 12)]
val test11018 = match (Unit, TupleP [UnitP, ConstP 3]) = NONE *)

(* val test120 = first_match Unit [UnitP] = SOME []
val test121 = first_match Unit [ConstP 10] = NONE
val test122 = first_match (Const 10) [ConstP 1, ConstP 2, ConstP 10] = SOME []
val test123 = first_match (Const 10) [ConstP 1, ConstP 2, Variable "abc"] = SOME [("abc", Const 10)] *)
