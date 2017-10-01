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

print("....(Q5)....");
delete_course_enroll ("comp10", C [], E[]);
delete_course_enroll ("comp10", C [("comp10", "p01")], E []);
delete_course_enroll ("comp10", C [("comp10", "p01")], E [(1701,
["comp10"])]);
delete_course_enroll ("comp10", C [("comp10", "p01"), ("comp12",
"p02")], E [(1701, ["comp10", "comp11"]), (1702, ["comp13", "comp10"]),
(1703, [])]);
