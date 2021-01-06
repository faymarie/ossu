(* Homework1 Tests *)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)

use "hw1.sml";

(* val test1 = is_older ((1,2,3),(2,3,4)) = true
val test11 = is_older ((1,2,3),(1,3,4)) = true
val test12 = is_older ((1,2,3),(1,2,4)) = true
val test13 = is_older ((1,2,3),(1,2,3)) = false
val test14 = is_older ((2,2,3),(1,2,3)) = false
val test15 = is_older ((1,3,4),(1,2,3)) = false
val test16 = is_older ((1,2,4),(1,2,3)) = false *)

(* val test20 = number_in_month ([(2012,2,28),(2013,12,1)],2) = 1
val test21 = number_in_month ([(2013,3,1),(2012,2,28),(2013,2,1)],2) = 2
val test22 = number_in_month ([(2013,1,1),(2012,4,28),(2013,7,1)],2) = 0
val test23 = number_in_month ([],2) = 0  *)

(* val test30 = number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = 3
val test31 = number_in_months ([(2012,1,28),(2013,1,1),(2011,1,31),(2011,1,28)],[2,3,4]) = 0
val test32 = number_in_months ([(2012,1,28),(2013,1,1),(2011,3,31),(2011,1,28)],[]) = 0
val test33 = number_in_months ([],[1,2]) = 0
val test34 = number_in_months ([],[]) = 0  *)

(* val test40 = dates_in_month ([(2012,2,28),(2013,12,1)],2) = [(2012,2,28)]
val test41 = dates_in_month ([(2013,5,1),(2012,2,28),(2013,2,1),(2013,9,1)],2) = [(2012,2,28), (2013,2,1)]
val test42 = dates_in_month ([],2) = []
val test43 = dates_in_month ([(2012,12,28),(2013,1,1)],2) = [] *)

(* val test50 = dates_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = [(2012,2,28),(2011,3,31),(2011,4,28)]
val test51 = dates_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[5]) = []
val test52 = dates_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[]) = []
val test53 = dates_in_months ([],[3,4,5]) = []
val test54 = dates_in_months ([],[]) = []  *)

(* val test60 = get_nth (["hi", "there", "how", "are", "you"], 2) = "there"
val test61 = get_nth (["hi", "there", "how", "are", "you"], 1) = "hi" *)

(* val test70 = date_to_string (2013, 6, 1) = "June 1, 2013"
val test71 = date_to_string (2090, 12, 8) = "December 8, 2090" *)

(* val test80 = number_before_reaching_sum (10, [1,2,3,4,5]) = 3
val test81 = number_before_reaching_sum (1, [1,1,2]) = 0
val test82 = number_before_reaching_sum (2, [1,1,2]) = 1
val test83 = number_before_reaching_sum (3, [1,1,2]) = 2
val test84 = number_before_reaching_sum (4, [1,1,2]) = 2
val test85 = number_before_reaching_sum (5, [1,1,2,1]) = 3 *)

(* val test90 = what_month 70 = 3
val test91 = what_month 31 = 1
val test92 = what_month 1 = 1
val test93 = what_month 32 = 2
val test94 = what_month 59 = 2
val test95 = what_month 60 = 3
val test96 = what_month 90 = 3
val test97 = what_month 91 = 4
val test98 = what_month 120 = 4
val test99 = what_month 121 = 5
val test990 = what_month 151 = 5
val test991 = what_month 152 = 6
val test992 = what_month 181 = 6
val test993 = what_month 182 = 7
val test994 = what_month 212 = 7
val test995 = what_month 213 = 8
val test996 = what_month 243 = 8
val test997 = what_month 244 = 9
val test998 = what_month 273 = 9
val test999 = what_month 274 = 10
val test9990 = what_month 304 = 10
val test9991 = what_month 305 = 11
val test9992 = what_month 334 = 11
val test9993 = what_month 335 = 12
val test9994 = what_month 365 = 12 *)

(* val test10 = month_range (31, 34) = [1,2,2,2]
val test101 = month_range (31, 31) = [1]
val test102 = month_range (32, 31) = []
val test103 = month_range (31, 60) = [1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,3] *)

(* val test110 = oldest([(2012,2,28),(2011,3,31),(2011,4,28)]) = SOME (2011,3,31)
val test111 = oldest([(2014,2,28),(2019,3,31),(2011,4,28)]) = SOME (2011,4,28)
val test112 = oldest([(2010,2,28),(2019,3,31),(2011,4,28)]) = SOME (2010,2,28)
val test113 = oldest([]) = NONE *)

(* val test120 = drop_duplicates ([]) = []
val test121 = drop_duplicates ([3]) = [3]
val test122 = drop_duplicates ([3,2,2,3,4,1]) = [3,2,4,1]
val test123 = drop_duplicates ([3,2,3,1,2,3,4,1]) = [3,2,1,4] *)

(* val test124 = number_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,3,4]) = 3
val test125 = number_in_months_challenge ([(2012,1,28),(2013,1,1),(2011,1,31),(2011,1,28)],[2,3,4,5,5]) = 0
val test126 = number_in_months_challenge ([],[1,1,2]) = 0
val test127 = number_in_months_challenge ([],[]) = 0 *)

(* val test130 = get_nth_num([31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31], 0) = SOME 31
val test131 = get_nth_num([31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31], 11) = SOME 31
val test132 = get_nth_num([31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31], 12) = NONE
val test133 = get_nth_num([], 12) = NONE
val test134 = is_valid_day_of_month(2020, 2, 1) = true
val test135 = is_valid_day_of_month(2020, 12, 31) = true
val test136 = is_valid_day_of_month(2020, 11, 31) = false
val test137 = is_valid_day_of_month(1998, 2, 29) = false
val test138 = is_valid_day_of_month(2004, 2, 29) = true
val test139 = is_leap_year(2000) = true
val test140 = is_leap_year(1992) = true
val test141 = is_leap_year(1700) = false
val test142 = is_leap_year(1900) = false
val test143 = reasonable_date(0,1,1) = false
val test144 = reasonable_date(1,0,1) = false
val test145 = reasonable_date(1,1,0) = false
val test146 = reasonable_date(2020,2,1) = true
val test147 = reasonable_date(2020,12,31) = true
val test148 = reasonable_date(2020,11,31) = false
val test149 = reasonable_date(1998,2,29) = false
val test1410 = reasonable_date(2004,2,29) = true *)
