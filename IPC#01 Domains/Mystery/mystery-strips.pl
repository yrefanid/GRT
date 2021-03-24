operator(overcome(C,V,N,S1,S2),
	[craves(C,N), craves(V,N),harmony(V,S2)],
	[craves(C,N), harmony(V,S2)],
	[fears(C,V), harmony(V,S1)]):-
		pain(C),
		pleasure(V),
		food(N),
		planet(S1),planet(S2),
		orbits(S1, S2).


operator(feast(V,N1,N2 ,L1,L2),
	[craves(V,N1),locale(N1,L2)],
	[craves(V,N1), locale(N1,L2) ],
	[craves(V,N2), locale(N1,L1), cond(craves(v(pain), N1), [craves(v(cargo), N2)] )  ]) :-
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


