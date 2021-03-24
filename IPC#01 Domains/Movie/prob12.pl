problem_name('movie12.txt').

chips([c1,c2,c3,c4,c5,c6,c8,c9,c10,c11,c12,c13,c14,c15,c16]).
dip([d1,d2,d3,d4,d5,d6,d8,d9,d10,d11,d12,d13,d14,d15,d16]).
pop([p1,p2,p3,p4,p5,p6,p8,p9,p10,p11,p12,p13,p14,p15,p16]).
cheese([z1,z2,z3,z4,z5,z6,z8,z9,z10,z11,z12,z13,z14,z15,z16]).
crackers([k1,k2,k3,k4,k5,k6,k8,k9,k10,k11,k12,k13,k14,k15,k16]).
 
def(chips(X)):-chips(Domain), member(X, Domain).
def(dip(X)):-dip(Domain), member(X, Domain).
def(pop(X)):-pop(Domain), member(X, Domain).
def(cheese(X)):-cheese(Domain), member(X, Domain).
def(crackers(X)):-crackers(Domain), member(X, Domain).
def(counter_at_other_than_two_hours).
def(movie_rewound).
def(not_movie_rewound).
def(counter_at_zero).
def(have_chips).
def(have_dip).
def(have_pop).
def(have_cheese).
def(have_crackers).
def(dont_have_chips).
def(dont_have_dip).
def(dont_have_pop).
def(dont_have_cheese).
def(dont_have_crackers).


initial([counter_at_other_than_two_hours,	dont_have_chips, dont_have_dip,dont_have_pop,dont_have_cheese, dont_have_crackers, not_movie_rewound]):-!.

goal([movie_rewound, counter_at_zero, have_chips, have_dip,have_pop,have_cheese,have_crackers]):-!.
goal1([]):-!.

