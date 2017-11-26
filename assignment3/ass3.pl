enroll(1701, [c01, c10]).
enroll(1602, [c21]).
enroll(1711, [c01, c21, c10]).
enroll(1501, []).
teach(p01, [c01, c21]).
teach(p02, [c23]).
teach(p03, [c10]).
teach(p04, []).

debug([X|Y]):-print(X),put(44),debug(Y),!.
debug(_):-put(10),!.

member(X,[H|_]):-X=H.
member(X,[_|L]):-member(X,L).

%student enrolled certain course
el(Stu,C):-enroll(Stu,CL),member(C,CL).

%professor tech certain course
tc(Prof,C):-teach(Prof,TL),member(C,TL).

append([],L, L).
append([X | X1], Y, [X | L]) :- append(X1, Y, L).

subtract(_,[],[]).
subtract(A,[H|T],[H|C]):-A\=H,subtract(A,T,C),!.
subtract(A,[H|T],C):-A=H,subtract(A,T,C),!.

helperq1([],[]):-!.
helperq1([C|CL],[P|PL]):-teach(P,TL),member(C,TL),helperq1(CL,PL),!.
prof_ids(S,PL):-enroll(S,CL),helperq1(CL,PL).

helperq2([],_,[]):-!.
helperq2(_,[],[]):-!.
helperq2(CA,CB,[C|CL]):-member(C,CA),member(C,CB),subtract(C,CA,LA),subtract(C,CB,LB),helperq2(LA,LB,CL),!.
helperq2(_,_,[]):-!.
common_enroll(SA,SB,L):-enroll(SA,CA),enroll(SB,CB),SA\=SB,helperq2(CA,CB,L).
common_enroll(_,_,_):-fail.

union([],L, L).
union([X | X1], Y, L) :- member(X,Y), union(X1, Y, L),!.
union([X | X1], Y, [X | L]) :- union(X1, Y, L),!.

all_students_helper(F,[S|SL]):-enroll(S,_),\+member(S,F),all_students_helper([S|F],SL),!.
all_students_helper(_,[]).
all_students(SL):-all_students_helper([],SL).

intersect([X|_],Y):-member(X,Y),!.
intersect([_|XL],Y):-intersect(XL,Y).

helperq3(TL,[S|ASL],[S|SL]):-enroll(S,CL),intersect(TL,CL),helperq3(TL,ASL,SL),!.
helperq3(TL,[_|ASL],SL):-helperq3(TL,ASL,SL),!.
helperq3(_,[],[]).
student_list(P,SL):- teach(P,TL),all_students(ASL),helperq3(TL,ASL,SL).

all_prof_helper(F,[S|SL]):-teach(S,_),\+member(S,F),all_prof_helper([S|F],SL).
all_prof_helper(_,[]).
all_prof(SL):-all_prof_helper([],SL).

reduce([],[]).
reduce([X|I],O):-member(X,I),reduce(I,O),!.
reduce([X|I],[X|O]):-reduce(I,O),!.

helperq4([],[]).
helperq4([P|PL],L):-teach(P,CL),helperq4(PL,LL),union(CL,LL,L).
course_list(L):-all_prof(PL),helperq4(PL,L),!.