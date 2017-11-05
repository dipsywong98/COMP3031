(* name:WONG Yuk Chun , itsc:ycwongal , sid :20419764 *)

Control.Print.printDepth := 100;

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
                        then (#1x, AppendUnique( #2s , #2x, StrMatch)) 
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
fun list_distinct_students (prof, C(c), E(e)) =
    let fun Helper (prof, C([]), E(_), students_list) = students_list
    |   Helper (prof, C(_), E([]), students_list) = students_list 
    |   Helper (prof, C(h::t), E(e), students_list) = 
        if ( #2 h = prof) then Helper (prof, C(t), E(e), AppendUnique(query_students(#1 h, E(e)), students_list, IntMatch))
        else Helper (prof, C(t), E(e), students_list)
    in Helper (prof, C(c), E(e), []) end;

fun count_distinct_students (prof, C(c), E(e)) = length(list_distinct_students (prof, C(c), E(e))) ;

(*Q5*)
(*remove course and enrollment by course id*)
fun delete_course_enroll (course_id, C(c), E(e)) = 
    let fun delete_course (course_id, C([]), C(c_list)) = C(c_list)
        |   delete_course (course_id, C(h::t), C(c_list)) = 
            if (course_id = #1 h) then delete_course (course_id, C(t), C(c_list))
            else delete_course (course_id, C(t), C(c_list@[h]));
        fun delete_enroll (course_id, E([]) , E(e_list)) = E(e_list)
        |   delete_enroll (course_id , E(h::t), E(e_list)) = 
            let fun student_drop (course_id, [], fin_courses) = fin_courses
                |   student_drop (course_id, h::t, fin_courses) = 
                    if(h = course_id) then student_drop (course_id , t, fin_courses)
                    else student_drop (course_id , t, fin_courses@[h]);
                val std = (# 1 h , student_drop (course_id, #2 h, []))
            in

            delete_enroll (course_id, E(t), E(e_list@[std])) end;
    in

    (delete_course(course_id,C(c),C([])) , delete_enroll(course_id,E(e),E([])))

end;