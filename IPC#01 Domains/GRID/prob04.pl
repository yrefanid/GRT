places([n0_0,n0_1,n0_2,n0_3,n0_4,n0_5,
n0_6,n0_7,n1_0,n1_1,n1_2,n1_3,n1_4,
n1_5,n1_6,n1_7,n2_0,n2_1,n2_2,n2_3,
n2_4,n2_5,n2_6,n2_7,n3_0,n3_1,n3_2,
n3_3,n3_4,n3_5,n3_6,n3_7,n4_0,n4_1,
n4_2,n4_3,n4_4,n4_5,n4_6,n4_7,n5_0,
n5_1,n5_2,n5_3,n5_4,n5_5,n5_6,n5_7,
n6_0,n6_1,n6_2,n6_3,n6_4,n6_5,n6_6,
n6_7,n7_0,n7_1,n7_2,n7_3,n7_4,n7_5,
n7_6,n7_7]).
shapes([tr,dm,sq,cir]).
keys_([k0,k1,k2,k3,k4,k5,k6,k7,k8,k9,k10,k11]).

def(arm_empty).
def(holding(Key)):-keys_(Keys), member(Key, Keys).
def(locked(Pos ) ) :-places(Places), member(Pos, Places).
def(open(Pos )) :-places(Places), member(Pos, Places).
def(at(Key, Pos)):-keys_(Keys), places(Places), member(Key, Keys), member(Pos, Places).
def(at_robot(Pos)):-places(Places), member(Pos, Places).


lock_shape(n7_2,sq).
lock_shape(n7_3,sq).
lock_shape(n6_3,sq).
lock_shape(n5_3,sq).
lock_shape(n5_2,sq).
lock_shape(n5_1,sq).
lock_shape(n6_1,sq).
lock_shape(n7_1,sq).

key_shape(k0,cir).
key_shape(k1,dm).
key_shape(k2,tr).
key_shape(k3,sq).
key_shape(k4,dm).
key_shape(k5,dm).
key_shape(k6,sq).
key_shape(k7,tr).
key_shape(k8,sq).
key_shape(k9,sq).
key_shape(k10,sq).
key_shape(k11,sq).




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
conn(n0_5,n0_6).
conn(n0_5,n0_4).
conn(n0_6,n1_6).
conn(n0_6,n0_7).
conn(n0_6,n0_5).
conn(n0_7,n1_7).
conn(n0_7,n0_6).
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
conn(n1_5,n1_6).
conn(n1_5,n1_4).
conn(n1_6,n2_6).
conn(n1_6,n0_6).
conn(n1_6,n1_7).
conn(n1_6,n1_5).
conn(n1_7,n2_7).
conn(n1_7,n0_7).
conn(n1_7,n1_6).
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
conn(n2_5,n2_6).
conn(n2_5,n2_4).
conn(n2_6,n3_6).
conn(n2_6,n1_6).
conn(n2_6,n2_7).
conn(n2_6,n2_5).
conn(n2_7,n3_7).
conn(n2_7,n1_7).
conn(n2_7,n2_6).
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
conn(n3_5,n3_6).
conn(n3_5,n3_4).
conn(n3_6,n4_6).
conn(n3_6,n2_6).
conn(n3_6,n3_7).
conn(n3_6,n3_5).
conn(n3_7,n4_7).
conn(n3_7,n2_7).
conn(n3_7,n3_6).
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
conn(n4_5,n4_6).
conn(n4_5,n4_4).
conn(n4_6,n5_6).
conn(n4_6,n3_6).
conn(n4_6,n4_7).
conn(n4_6,n4_5).
conn(n4_7,n5_7).
conn(n4_7,n3_7).
conn(n4_7,n4_6).
conn(n5_0,n6_0).
conn(n5_0,n4_0).
conn(n5_0,n5_1).
conn(n5_1,n6_1).
conn(n5_1,n4_1).
conn(n5_1,n5_2).
conn(n5_1,n5_0).
conn(n5_2,n6_2).
conn(n5_2,n4_2).
conn(n5_2,n5_3).
conn(n5_2,n5_1).
conn(n5_3,n6_3).
conn(n5_3,n4_3).
conn(n5_3,n5_4).
conn(n5_3,n5_2).
conn(n5_4,n6_4).
conn(n5_4,n4_4).
conn(n5_4,n5_5).
conn(n5_4,n5_3).
conn(n5_5,n6_5).
conn(n5_5,n4_5).
conn(n5_5,n5_6).
conn(n5_5,n5_4).
conn(n5_6,n6_6).
conn(n5_6,n4_6).
conn(n5_6,n5_7).
conn(n5_6,n5_5).
conn(n5_7,n6_7).
conn(n5_7,n4_7).
conn(n5_7,n5_6).
conn(n6_0,n7_0).
conn(n6_0,n5_0).
conn(n6_0,n6_1).
conn(n6_1,n7_1).
conn(n6_1,n5_1).
conn(n6_1,n6_2).
conn(n6_1,n6_0).
conn(n6_2,n7_2).
conn(n6_2,n5_2).
conn(n6_2,n6_3).
conn(n6_2,n6_1).
conn(n6_3,n7_3).
conn(n6_3,n5_3).
conn(n6_3,n6_4).
conn(n6_3,n6_2).
conn(n6_4,n7_4).
conn(n6_4,n5_4).
conn(n6_4,n6_5).
conn(n6_4,n6_3).
conn(n6_5,n7_5).
conn(n6_5,n5_5).
conn(n6_5,n6_6).
conn(n6_5,n6_4).
conn(n6_6,n7_6).
conn(n6_6,n5_6).
conn(n6_6,n6_7).
conn(n6_6,n6_5).
conn(n6_7,n7_7).
conn(n6_7,n5_7).
conn(n6_7,n6_6).
conn(n7_0,n6_0).
conn(n7_0,n7_1).
conn(n7_1,n6_1).
conn(n7_1,n7_2).
conn(n7_1,n7_0).
conn(n7_2,n6_2).
conn(n7_2,n7_3).
conn(n7_2,n7_1).
conn(n7_3,n6_3).
conn(n7_3,n7_4).
conn(n7_3,n7_2).
conn(n7_4,n6_4).
conn(n7_4,n7_5).
conn(n7_4,n7_3).
conn(n7_5,n6_5).
conn(n7_5,n7_6).
conn(n7_5,n7_4).
conn(n7_6,n6_6).
conn(n7_6,n7_7).
conn(n7_6,n7_5).
conn(n7_7,n6_7).
conn(n7_7,n7_6).





initial([arm_empty, locked(n7_2),locked(n7_3),locked(n6_3),locked(n5_3),locked(n5_2),locked(n5_1),
locked(n6_1),locked(n7_1),
open(n0_0),open(n0_1),open(n0_2),open(n0_3),open(n0_4),open(n0_5),open(n0_6),
open(n0_7),open(n1_0),open(n1_1),open(n1_2),open(n1_3),open(n1_4),open(n1_5),
open(n1_6),open(n1_7),open(n2_0),open(n2_1),open(n2_2),open(n2_3),open(n2_4),
open(n2_5),open(n2_6),open(n2_7),open(n3_0),open(n3_1),open(n3_2),open(n3_3),
open(n3_4),open(n3_5),open(n3_6),open(n3_7),open(n4_0),open(n4_1),open(n4_2),
open(n4_3),open(n4_4),open(n4_5),open(n4_6),open(n4_7),open(n5_0),open(n5_4),
open(n5_5),open(n5_6),open(n5_7),open(n6_0),open(n6_2),open(n6_4),open(n6_5),
open(n6_6),open(n6_7),open(n7_0),open(n7_4),open(n7_5),open(n7_6),open(n7_7),
at(k0,n1_6),at(k1,n2_3),at(k2,n2_2),at(k3,n0_3),at(k4,n5_1),at(k5,n5_2),
at(k6,n7_2),at(k7,n3_6),at(k8,n0_6),at(k9,n1_1),at(k10,n3_2),at(k11,n5_0),
at_robot(n4_4)]):-!.



goal([at(k0,n1_1), at(k4,n6_4), at(k3,n3_0)]):-!.

goal1( List ):-findall(X, not_determined(X), List).

not_determined(arm_empty).

not_determined(holding(Key)):-
	keys_(Keys),
	member(Key, Keys),
	not(member(Key,[k0, k3, k4])).

not_determined(at(Key, Pos)):-
	keys_(Keys),
	places(Places),
	member(Key, Keys),
	not(member(Key,[k0, k3, k4])),
	member(Pos, Places).

not_determined(at_robot( Pos)):-
	places(Places),
	member(Pos, Places).

not_determined(open(Pos)):-
	places(Places),
	member(Pos, Places).

def( locked(Pos ) ) :-
member(Pos, [n7_2,n7_3,n6_3,n5_3,n5_2,n5_1,n6_1,n7_1]).







