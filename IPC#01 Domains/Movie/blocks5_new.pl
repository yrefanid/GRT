domain([a,b,c,d,e]):-!.

def(clear(X)) :- domain(Domain), member(X,Domain).
def(on(X,Y)) :- domain(Domain), member(Y, Domain), member( X, [ table | Domain]), X\==Y.

% initial conditions
%initial([on(table,a),on(a,b),on(b,c), clear(c), on(table,d),clear(d)]):-!.
initial( [on(table,a),on(a,b),on(b,e), clear(e), on(table,c),on(c,d),clear(d)]):-!.
	
% goal
goal([on(table,d),on(d,c),on(c,b), on(b,e),on(e,a), clear(a)]):-!.
goal1([]):-!.

operator(	
	mXt(p([X]),s([Y])),    % moves X from Y to table
	[ on(Y,X), clear(X)],  	
	[on(Y,X)],
	[on(table,X),clear(Y)]):-
			domain(Domain),
			member(X,Domain),member(Y, Domain) , X\==Y.


operator(	
	mXY(p([X,Y]),s([Z])),    % moves X from Z to Y 
	[on(Z,X), clear(X), clear(Y)],
	[clear(Y), on(Z,X)],
	[on(Y,X), clear(Z)])	:-
			domain(Domain), 
			member(X,Domain),member(Y, Domain), member(Z, Domain), X\==Y, Y\==Z, Z\==X.

operator(	
	mXY(p([X,Y]),s([])),    % moves X from Z to Y 
	[on(table,X), clear(X), clear(Y)],
	[clear(Y), on(table,X)],
	[on(Y,X)]):-
			domain(Domain),
			member(X,Domain),member(Y, Domain), X\==Y.

