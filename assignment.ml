
datatype course = C of (string * string) list;
datatype enroll = E of (int * string list) list;

fun AppendUnique ([],L2,f) = L2
|   AppendUnique (L1h::L1t , L2,f) = 
        let
            fun Exist_ (el,[]) = false
            |   Exist_ (el, h::t) = if(f el h) then true else Exist_ (el, t);
        in
            if(Exist_ (L1h , L2)) then AppendUnique (L1t , L2, f) else AppendUnique (L1t , L2 @ [L1h],f)
        end;

fun CourseMatch (a:(string * string)) (b:(string * string)) = #1a= #1b;
fun StrMatch (a:string) (b:string) = a=b;

fun insert_course ([],c:course) = c
|   insert_course(h::t,C([])) = C(h::t)
|   insert_course(l,C(L)) = C(AppendUnique (l,L,CourseMatch));

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


insert_course ([], C [("comp10", "p01")]);
insert_course ([("comp12", "p02")], C []);
insert_course ([("comp10", "p02")], C [("comp10", "p01")]);
insert_course ([("comp13", "p01"), ("comp12", "p02")], C [("comp10","p01")]);
print(".............");
 insert_enroll ((1702, []), E [(1701, ["comp10", "comp11"])]);
 insert_enroll ((1701, ["comp10", "comp11"]), E []);
 insert_enroll ((1701, ["comp11", "comp10"]), E [(1701, ["comp10",
"comp12"])]);
insert_enroll ((1702, ["comp10"]), E [(1701, ["comp10", "comp11"])]);