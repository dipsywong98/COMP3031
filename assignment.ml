datatype course = C of (string * string) list;
datatype enroll = E of (int * string list) list;

fun insert_course ([],c:course) = c
|   insert_course(h::t,C([])) = C(h::t)
|   insert_course(h::t,C(L)) = 
        let 
            fun Exist (c,C([])) = false
            |   Exist (c:(string * string),C(h::t)) = 
                    if( #1c= #1h) then true 
                    else Exist(c,C(t));
        in
            if(Exist(h,C(L))) 
            then insert_course(t,C(L)) 
            else insert_course(t,C(L@[h])) 
        end;

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
                        then (#1x, #2x @ #2s) 
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