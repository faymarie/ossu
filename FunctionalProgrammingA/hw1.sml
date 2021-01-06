fun is_older (date1: int*int*int, date2: int*int*int) =
    if (#1 date1) = (#1 date2)
    then (
        if (#2 date1) = (#2 date2)
        then ((#3 date1) < (#3 date2))
        else (#2 date1 < #2 date2))
    else (#1 date1) < (#1 date2)

fun number_in_month (lod: (int*int*int) list, month: int) =
    let fun counter (lod: (int*int*int) list, count: int) =
        if null lod
        then count
        else (
            if (#2 (hd lod)) = month
            then counter (tl lod, count + 1)
            else counter (tl lod, count)
        )
    in counter (lod, 0) end

fun number_in_months (lod: (int*int*int) list, lom: int list) =
    let fun counter (lom: int list, count: int) =
        if null lom
        then count
        else counter ((tl lom), count + number_in_month (lod, (hd lom)))
    in counter (lom, 0) end

fun dates_in_month (lod: (int*int*int) list, month: int) =
    if null lod
    then []
    else (
        if (#2 (hd lod)) = month
        then (hd lod)::dates_in_month((tl lod), month)
        else dates_in_month((tl lod), month)
    )

fun dates_in_months (lod: (int*int*int) list, lom: int list) =
    if null lom
    then []
    else dates_in_month (lod, (hd lom)) @ dates_in_months (lod, (tl lom))

fun get_nth (los: string list, n: int) =
    if n <= 1
    then (hd los)
    else get_nth (tl los, n-1)

fun date_to_string (date: int*int*int) = 
    let val months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    in get_nth(months, (#2 date)) ^ " " ^ Int.toString((#3 date)) ^ ", " ^ Int.toString((#1 date)) end

fun number_before_reaching_sum (sum: int, lon: int list) =
    let fun sum_up (lon: int list, total: int) =
        if null lon orelse null (tl lon) orelse ((total + (hd lon)) >= sum)
        then 0
        else 1 + sum_up ((tl lon), (hd lon) + total)
    in sum_up (lon, 0) end

fun what_month (day: int) = 
    let val months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    in number_before_reaching_sum(day, months) + 1 end

fun month_range (day1: int, day2: int) =
    if day1 > day2
    then []
    else what_month(day1)::month_range(day1+1,day2)

fun oldest (dates: (int*int*int) list) =
    if null dates
    then NONE
    else ( 
        let fun get_oldest (dates: (int*int*int) list, date: int*int*int) =
            if null dates
            then SOME (date)
            else (
                if is_older(date, (hd dates)) = true
                then get_oldest((tl dates), date)
                else get_oldest((tl dates), (hd dates))
            )
        in get_oldest(tl dates, (hd dates)) end
    )

(* 12. Challenge Problem *)
fun drop_members (lom: int list, month: int) = 
    if null lom
    then []
    else (
        if (hd lom) = month
        then drop_members(tl lom, month)
        else (hd lom)::drop_members(tl lom, month)
    )

fun drop_duplicates (lom: int list) = 
    if null lom
    then []
    else (
        let val new_lom = drop_members ((tl lom), (hd lom))
        in (hd lom)::drop_duplicates(new_lom) end
    )

fun number_in_months_challenge (lod: (int*int*int) list, lom: int list) =
    let fun counter (lom: int list, count: int) =
        if null lom
        then count
        else counter ((tl lom), count + number_in_month (lod, (hd lom)))
    in
        counter (drop_duplicates(lom), 0)
    end

(* 13. Challenge Problem *)
fun get_nth_num (loi: int list, n: int) = 
    if null loi orelse n < 0
    then NONE
    else (
        if n = 0
        then SOME (hd loi)
        else get_nth_num (tl loi, n - 1)
    ) 

fun is_leap_year(year: int) =
    ((year mod 4 = 0) andalso (year mod 100 <> 0)) orelse (year mod 400 = 0)  

fun is_valid_day_of_month(date: int*int*int) =
    let fun get_months(year: int) =
        if is_leap_year(year) = true
        then [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        else [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    in
        let val months = get_months((#1 date))
        in
            if isSome(get_nth_num(months, (#2 date)-1))
            then ((#3 date) > 0 andalso valOf(get_nth_num(months, (#2 date)-1)) >= (#3 date))
            else false
        end
    end

fun reasonable_date (date: int*int*int) =
    ((#1 date) > 0) andalso ((#2 date) > 0) andalso ((#2 date) < 13) andalso is_valid_day_of_month(date)
