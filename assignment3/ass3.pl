enroll(1701, [c01, c10]).
enroll(1602, [c21]).
enroll(1711, [c01, c21, c10]).
enroll(1501, []).
teach(p01, [c01, c21]).
teach(p02, [c23]).
teach(p03, [c10]).
teach(p04, []).

debug([X|Y]):-print(X),print(","),debug(Y).
debug(_):-print("\n"),!.

member(X,[H|_]):-X=H.
member(X,[_|L]):-member(X,L).

%student enrolled certain course
el(Stu,C):-enroll(Stu,CL),member(C,CL).

%professor tech certain course
tc(Prof,C):-teach(Prof,TL),member(C,TL).

append([],L, L).
append([X | X1], Y, [X | L]) :- append(X1, Y, L).

helperq1([],[]):-!.
helperq1([C|CL],[P|PL]):-teach(P,TL),member(C,TL),helperq1(CL,PL),!.
prof_id(S,PL):-enroll(S,CL),helperq1(CL,PL).