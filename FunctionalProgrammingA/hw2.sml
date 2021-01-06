(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

fun all_except_option(a_str, los) =
   case los of 
      [] => NONE
      | h::rest => (case (same_string (h, a_str), all_except_option(a_str, rest)) of
                  (true, NONE) => SOME rest
                  | (false, NONE) => NONE
                  | (true, SOME x) => SOME x
                  | (false, SOME x) => SOME (h::x))

fun get_substitutions1(substitutions, s) =
   case substitutions of
      [] => []
      | los::rest_sub => (case all_except_option(s, los) of
                           NONE => get_substitutions1(rest_sub, s)
                           | SOME subs => subs @ get_substitutions1(rest_sub, s))

fun get_substitutions2(substitutions, s) =
   let fun helper (lolos, acc) = 
      case lolos of
         [] => acc
         | los::rest=> (case all_except_option(s, los) of
                           NONE => helper(rest, acc)
                           | SOME subs => helper(rest, subs @ acc))
   in
      helper (substitutions, [])
   end

fun similar_names(substitutions, {first=x,middle=y,last=z}) =
   let fun create_entries(subs) =
      case subs of
         [] => []
         | h::rest => {first=h,middle=y,last=z}::create_entries(rest)
   in
      case get_substitutions1(substitutions, x) of
         [] => {first=x,middle=y,last=z}::[]
         | h::rest => {first=x,middle=y,last=z}::create_entries(h::rest)
   end

(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

fun card_color (card) =
   case card of
      (Spades,_) => Black
      | (Clubs,_) => Black
      | (Hearts,_) => Red
      | (Diamonds,_) => Red

fun card_value (card) =
   case card of
      (_, Num i) => i
      | (_, Ace) => 11
      | (_, _) => 10

fun remove_card (cs, c, e) =
   case cs of 
      [] => raise e
      | card::rest => if (card = c) 
                     then rest 
                     else card::remove_card(rest, c, e)

fun all_same_color(cs) =
   case cs of
      [] => true
      | _::[] => true
      | card::(next::rest) => ((card_color(card) = card_color(next)) 
                              andalso all_same_color(next::rest))

fun sum_cards (cs) =
   let fun count (cs, sum) =
      case cs of
         [] => sum
         | card::rest => count(rest, sum + card_value(card)) 
   in count(cs, 0) end

fun score (held_cards, goal) =
   let val sum = sum_cards (held_cards)
      val preliminary_score = if sum > goal 
                              then 3 * (sum - goal) 
                              else goal - sum
   in
      if (all_same_color(held_cards))
      then preliminary_score div 2
      else preliminary_score
   end

fun officiate (card_list, move_list, goal) =
   let fun play (held_cards, move_list, card_list) =
      case (move_list, card_list) of
         ([], _) => score (held_cards, goal)
         | ((Discard c)::rest_moves, _) => play (remove_card (held_cards, c, IllegalMove), 
                                          rest_moves, 
                                          card_list)
         | ((Draw)::rest_moves,[]) => score (held_cards, goal)
         | ((Draw)::rest_moves, new::rest_cards) => let val new_held = new::held_cards 
                                                   in if (sum_cards(new_held) > goal)
                                                      then score (new_held, goal)
                                                      else play (new_held, rest_moves, rest_cards)
                                                   end
   in
      play([], move_list, card_list)
   end
