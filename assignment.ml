(*
name:WONG Yuk Chun
itsc:ycwongal
sid :20419764
*)

datatype course = C of (string * string) list;
datatype enroll = E of (int * string list) list;

(*Helper functions*)
fun reduce f [ ] v = v
|   reduce f (head::tail) v = f (head, reduce f tail v);

fun AppendUnique ([],L2,f) = L2
|   AppendUnique (L1h::L1t , L2,f) = 
        let
            fun Exist_ (el,[]) = false
            |   Exist_ (el, h::t) = if(f el h) then true else Exist_ (el, t);
        in
            if(Exist_ (L1h , L2)) then AppendUnique (L1t , L2, f) else AppendUnique (L1t , L2 @ [L1h],f)
        end;

(*Q1*)
fun CourseMatch (a:(string * string)) (b:(string * string)) = #1a= #1b;

fun insert_course ([],c:course) = c
|   insert_course(h::t,C([])) = C(h::t)
|   insert_course(l,C(L)) = C(AppendUnique (l,L,CourseMatch));

(*Q2*)
fun StrMatch (a:string) (b:string) = a=b;

fun insert_enroll (s:(int * string list),E([])) = E([s])
|   insert_enroll (s,E(L)) = 
        let 
            fun Exist(s:(int * string list),E([])) = false
            |   Exist(s,E(h::t)) = 
                if( #1s= #1h) then true
                else Exist(s,E(t));    
        in 
            if(Exist(s,E(L))) then E(map (
                    fn x=> 
                        if(#1s= #1x) 
                        then (#1x, AppendUnique( #2x , #2s, StrMatch)) 
                        else x
                    ) L
                ) else E(L@[s]) end;

(*Q3*)
fun query_students (course_id,E(L)) =
    let 
        fun Exist__ (course_id, []) = false
        |   Exist__ (course_id, h::t) = if (course_id = h) then true else Exist__ (course_id, t);

        fun push_students (course_id,E([]),[]) = []
        |   push_students (course_id,E([]),students) = students
        |   push_students (course_id,E(h::t),students) = 
                if( Exist__ (course_id, #2 h)) then push_students (course_id,E(t),students @ [#1 h])
                else push_students (course_id,E(t),students);
    in
        push_students(course_id,E(L),[])
    end;

(*Q4*)
fun IntMatch a b = a=b;
fun count_distinct_students (prof, C(c), E(e)) =
    let fun Helper (prof, C([]), E(_), students_list) = students_list
    |   Helper (prof, C(_), E([]), students_list) = students_list 
    |   Helper (prof, C(h::t), E(e), students_list) = 
        if ( #2 h = prof) then Helper (prof, C(t), E(e), AppendUnique(query_students(#1 h, E(e)), students_list, IntMatch))
        else Helper (prof, C(t), E(e), students_list)
    in Helper (prof, C(c), E(e), []) end;


print("....(Q1)....");
insert_course ([], C [("comp10", "p01")]);
insert_course ([("comp12", "p02")], C []);
insert_course ([("comp10", "p02")], C [("comp10", "p01")]);
insert_course ([("comp13", "p01"), ("comp12", "p02")], C [("comp10","p01")]);

print("....(Q2)....");
 insert_enroll ((1702, []), E [(1701, ["comp10", "comp11"])]);
 insert_enroll ((1701, ["comp10", "comp11"]), E []);
 insert_enroll ((1701, ["comp11", "comp10"]), E [(1701, ["comp10",
"comp12"])]);
insert_enroll ((1702, ["comp10"]), E [(1701, ["comp10", "comp11"])]);

print("....(Q3)....");
query_students ("comp10", E []);
query_students ("comp10", E [(1701, ["comp10"])]);
query_students ("comp11", E [(1701, ["comp10"])]);
query_students ("comp10", E [(1701, ["comp10", "comp11"]), (1702,
["comp13", "comp10"]), (1703, [])]);

print("....(Q4)....");
count_distinct_students ("p01", C [], E []);
count_distinct_students ("p01", C [("comp10", "p01")], E []);
count_distinct_students ("p01", C [("comp10", "p01")], E [(1701,
["comp10"]), (1702, ["comp13"])]);
count_distinct_students ("p01", C [("comp10", "p01"), ("comp12",
"p02"), ("comp13", "p01")], E [(1701, ["comp10", "comp11"]), (1702,
["comp13"])]);