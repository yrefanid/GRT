operator(overcome(C,V,N,S1,S2),
	[craves(C,N), craves(V,N),harmony(V,S2)],
	[craves(C,N), harmony(V,S2)],
	[fears(C,V), harmony(V,S1)]):-
		pain(C),
		pleasure(V),
		food(N),
		planet(S1),planet(S2),
		orbits(S1, S2).

operator(feast(V,N1,N2,L1,L2),
	[craves(V,N1), locale(N1,L2)],
	[craves(V,N1), locale(N1,L2)],
	[craves(V,N2), locale(N1,L1)]):-
		food(N1), food(N2),
		eats(N1, N2),
		pleasure(V),
		attacks(L1, L2).

operator(succumb(C,V,N,S1,S2),
	[fears(C,V),craves(V,N),harmony(V,S1)],
	[fears(C,V),harmony(V,S1)],
	[craves(C,N), harmony(V,S2)]):-
		pain(C),
		pleasure(V),
		food(N),
		orbits(S1,S2).

operator(drink(N1,N2,L11,L12,L13,L21,L22),
	[locale(N1,L11), locale(N2,L21)],
	[locale(N1,L11), locale(N2,L21)],
	[locale(N1,L12), locale(N2,L22)]):-
		food(N1), food(N2),
		attacks(L12,L11), attacks(L13,L12), attacks(L21,L22).
		


/*

operator(overcome(p([C,V]), s([N, S1, S2])),
	[craves(C,N), craves(V,N),harmony(V,S2)],
	[craves(C,N), harmony(V,S2)],
	[fears(C,V), harmony(V,S1)]):-
		pain(C),
		pleasure(V),
		food(N),
		planet(S1),planet(S2),
		orbits(S1, S2).

operator(feast(p([V,N2]), s([N1,L1, L2])),
	[craves(V,N1), locale(N1,L2)],
	[craves(V,N1), locale(N1,L2)],
	[craves(V,N2), locale(N1,L1)]):-
		food(N1), food(N2),
		eats(N1, N2),
		pleasure(V),
		attacks(L1, L2).

operator(succumb(p([C]), s([N, S2, V, S1])),
	[fears(C,V),craves(V,N),harmony(V,S1)],
	[fears(C,V),harmony(V,S1)],
	[craves(C,N), harmony(V,S2)]):-
		pain(C),
		pleasure(V),
		food(N),
		orbits(S1,S2).

operator(drink(p([N1,N2]),s([L11, L21, L13,L12,L13,L22])),
	[locale(N1,L11), locale(N2,L21)],
	[locale(N1,L11), locale(N2,L21)],
	[locale(N1,L12), locale(N2,L22)]):-
		food(N1), food(N2),
		attacks(L12,L11), attacks(L13,L12), attacks(L21,L22).
		

*/


