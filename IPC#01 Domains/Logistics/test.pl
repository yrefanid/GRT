test:-
	goal(L1),
	goal1(L2),
	append(L1, L2, L),
	test1(L).

test1([]):-!.
test1([H|L]):-
	def(H),
	!,
	test1(L).

test1([H|_L]):-
	write(H),write(' is not defined!'), nl.
