places([n0_0,n0_1,n0_2,n0_3,n0_4,n0_5,n1_0,n1_1,n1_2,n1_3,n1_4,n1_5,
n2_0,n2_1,n2_2,n2_3,n2_4,n2_5,n3_0,n3_1,
n3_2,n3_3,n3_4,n3_5,n4_0,n4_1,n4_2,n4_3,n4_4,n4_5,n5_0,n5_1,n5_2,n5_3,n5_4,n5_5]).

shapes([tr,dm,sq,cir]).
keys_([k0,k1,k2,k3,k4,k5,k6,k7,k8,k9]).

def(arm_empty).
def(holding(Key)):-keys_(Keys), member(Key, Keys).
def(locked(Pos ) ) :-places(Places), member(Pos, Places).
def(open(Pos )) :-places(Places), member(Pos, Places).
def(at(Key, Pos)):-keys_(Keys), places(Places), member(Key, Keys), member(Pos, Places).
def(at_robot(Pos)):-places(Places), member(Pos, Places).


lock_shape(n4_2,tr).
lock_shape(n5_2,tr).
lock_shape(n5_3,tr).
lock_shape(n4_3,tr).
lock_shape(n4_4,tr).
lock_shape(n3_4,tr).
lock_shape(n3_3,tr).
lock_shape(n3_2,tr).


key_shape(k0,dm).
key_shape(k1,cir).
key_shape(k2,sq).
key_shape(k3,tr).
key_shape(k4,tr).
key_shape(k5,dm).
key_shape(k6,sq).
key_shape(k7,dm).
key_shape(k8,sq).
key_shape(k9,dm).










conn(n0_0,n1_0).
conn(n0_0,n0_1).
conn(n0_1,n1_1).
conn(n0_1,n0_2).
conn(n0_1,n0_0).
conn(n0_2,n1_2).
conn(n0_2,n0_3).
conn(n0_2,n0_1).
conn(n0_3,n1_3).
conn(n0_3,n0_4).
conn(n0_3,n0_2).
conn(n0_4,n1_4).
conn(n0_4,n0_5).
conn(n0_4,n0_3).
conn(n0_5,n1_5).
conn(n0_5,n0_4).
conn(n1_0,n2_0).
conn(n1_0,n0_0).
conn(n1_0,n1_1).
conn(n1_1,n2_1).
conn(n1_1,n0_1).
conn(n1_1,n1_2).
conn(n1_1,n1_0).
conn(n1_2,n2_2).
conn(n1_2,n0_2).
conn(n1_2,n1_3).
conn(n1_2,n1_1).
conn(n1_3,n2_3).
conn(n1_3,n0_3).
conn(n1_3,n1_4).
conn(n1_3,n1_2).
conn(n1_4,n2_4).
conn(n1_4,n0_4).
conn(n1_4,n1_5).
conn(n1_4,n1_3).
conn(n1_5,n2_5).
conn(n1_5,n0_5).
conn(n1_5,n1_4).
conn(n2_0,n3_0).
conn(n2_0,n1_0).
conn(n2_0,n2_1).
conn(n2_1,n3_1).
conn(n2_1,n1_1).
conn(n2_1,n2_2).
conn(n2_1,n2_0).
conn(n2_2,n3_2).
conn(n2_2,n1_2).
conn(n2_2,n2_3).
conn(n2_2,n2_1).
conn(n2_3,n3_3).
conn(n2_3,n1_3).
conn(n2_3,n2_4).
conn(n2_3,n2_2).
conn(n2_4,n3_4).
conn(n2_4,n1_4).
conn(n2_4,n2_5).
conn(n2_4,n2_3).
conn(n2_5,n3_5).
conn(n2_5,n1_5).
conn(n2_5,n2_4).
conn(n3_0,n4_0).
conn(n3_0,n2_0).
conn(n3_0,n3_1).
conn(n3_1,n4_1).
conn(n3_1,n2_1).
conn(n3_1,n3_2).
conn(n3_1,n3_0).
conn(n3_2,n4_2).
conn(n3_2,n2_2).
conn(n3_2,n3_3).
conn(n3_2,n3_1).
conn(n3_3,n4_3).
conn(n3_3,n2_3).
conn(n3_3,n3_4).
conn(n3_3,n3_2).
conn(n3_4,n4_4).
conn(n3_4,n2_4).
conn(n3_4,n3_5).
conn(n3_4,n3_3).
conn(n3_5,n4_5).
conn(n3_5,n2_5).
conn(n3_5,n3_4).
conn(n4_0,n5_0).
conn(n4_0,n3_0).
conn(n4_0,n4_1).
conn(n4_1,n5_1).
conn(n4_1,n3_1).
conn(n4_1,n4_2).
conn(n4_1,n4_0).
conn(n4_2,n5_2).
conn(n4_2,n3_2).
conn(n4_2,n4_3).
conn(n4_2,n4_1).
conn(n4_3,n5_3).
conn(n4_3,n3_3).
conn(n4_3,n4_4).
conn(n4_3,n4_2).
conn(n4_4,n5_4).
conn(n4_4,n3_4).
conn(n4_4,n4_5).
conn(n4_4,n4_3).
conn(n4_5,n5_5).
conn(n4_5,n3_5).
conn(n4_5,n4_4).
conn(n5_0,n4_0).
conn(n5_0,n5_1).
conn(n5_1,n4_1).
conn(n5_1,n5_2).
conn(n5_1,n5_0).
conn(n5_2,n4_2).
conn(n5_2,n5_3).
conn(n5_2,n5_1).
conn(n5_3,n4_3).
conn(n5_3,n5_4).
conn(n5_3,n5_2).
conn(n5_4,n4_4).
conn(n5_4,n5_5).
conn(n5_4,n5_3).
conn(n5_5,n4_5).
conn(n5_5,n5_4).


initial([arm_empty, 
locked(n4_2),locked(n5_2),locked(n5_3),
locked(n4_3),locked(n4_4),locked(n3_4),locked(n3_3),locked(n3_2),
open(n0_0),open(n0_1),open(n0_2),open(n0_3),open(n0_4),open(n0_5),open(n1_0),open(n1_1),open(n1_2),
open(n1_3),open(n1_4),open(n1_5),open(n2_0),open(n2_1),open(n2_2),open(n2_3),open(n2_4),open(n2_5),
open(n3_0),open(n3_1),open(n3_5),open(n4_0),open(n4_1),open(n4_5),open(n5_0),open(n5_1),open(n5_4),open(n5_5),
at(k0,n0_0), at(k1,n1_3),at(k2,n0_1),at(k3,n1_5),at(k4,n5_5),at(k5,n4_2),
at(k6,n0_3),at(k7,n5_1),at(k8,n4_3),at(k9,n5_5),
at_robot(n5_5)]):-!.

goal([at(k8,n3_2), at(k5,n4_2), at(k0,n4_1)]):-!.

goal1( List ):-findall(X, not_determined(X), List).

not_determined(arm_empty).

not_determined(holding(Key)):-
	keys_(Keys),
	member(Key, Keys),
	not(member(Key,[k0, k5, k8])).

not_determined(at(Key, Pos)):-
	keys_(Keys),
	places(Places),
	member(Key, Keys),
	not(member(Key,[k0, k5, k8])),
	member(Pos, Places).

not_determined(at_robot( Pos)):-
	places(Places),
	member(Pos, Places).

not_determined(open(Pos)):-
	places(Places),
	member(Pos, Places).

def( locked(Pos ) ) :-
member(Pos, [n4_2,n5_2,n5_3,n4_3,n4_4,n3_4,n3_3,n3_2]).


