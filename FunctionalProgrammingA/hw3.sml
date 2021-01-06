(* Coursera Programming Languages, Homework 3 *)

exception NoAnswer

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps (*i is the accumulator, this results in the sum of el*) 
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end

(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

(**** you can put all your code here ****)

val only_capitals = List.filter (fn word => Char.isUpper(String.sub(word, 0)))

val longest_string1 = 
	List.foldl (fn (str1, str2) => 
					if String.size(str1) > String.size(str2) then str1 else str2) 
				""

val longest_string2 = 
	List.foldl (fn (str1, str2) => 
					if String.size(str1) >= String.size(str2) then str1 else str2) 
				""

fun longest_string_helper pred =
	List.foldl (fn (str1, str2) =>
		if pred (String.size(str1), String.size(str2)) then str1 else str2)
	""

val longest_string3 = longest_string_helper (fn (str1, str2) => str1 > str2)

val longest_string4 = longest_string_helper (fn (str1, str2) => str1 >= str2)

val longest_capitalized = longest_string3 o only_capitals

val rev_string = String.implode o List.rev o String.explode

fun first_answer f a_list =
	case a_list of
	[] => raise NoAnswer
	| h::rest => case f (h) of
					SOME v => v
					| NONE => first_answer f rest

fun all_answers f a_list =
	let fun helper(a_list, acc) =
		case a_list of
			[] => SOME acc
			| h::rest => case f (h) of
							NONE => NONE
							| SOME lst => helper(rest, lst @ acc)  
	in helper(a_list, []) end

val count_wildcards = g (fn _ => 1) (fn _ => 0)

val count_wild_and_variable_lengths = g (fn _ => 1) String.size

fun count_some_var (a_str, p) = g (fn _ => 0) (fn x => if x = a_str then 1 else 0) p

fun check_pat p = 
	let 
		fun get_strings p =
			case p of
				Variable x => [x]
				| TupleP ps => List.foldl (fn (p, acc) => get_strings p @ acc) [] ps
				| ConstructorP(_,p) => get_strings p
				| _ => []
		fun not_repeated los =
			 case los of
			 	[] => true
				| h::rest => (not (List.exists (fn el => el = h) rest))
								andalso not_repeated rest
	in not_repeated(get_strings p) end

fun match (v, p) =
	case (v, p) of
		(_, Wildcard) => SOME []
		| (v, Variable s) => SOME [(s, v)]
		| (Unit, UnitP) => SOME []
		| (Const num1, ConstP num2) => if num1 = num2 
										then SOME [] 
										else NONE
		| (Tuple vs, TupleP ps) => if length vs = length ps 
									then all_answers match (ListPair.zip(vs, ps)) 
									else NONE
		| (Constructor (s1, v1), ConstructorP (s2, p1)) => if s1 = s2 
															then match (v1, p1) 
															else NONE
		| _ => NONE

fun first_match v lop =
	SOME(first_answer (fn p => match(v, p)) lop) 
		handle NoAnswer => NONE
