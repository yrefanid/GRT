places([n0_0,n0_1,n0_2,n0_3,n0_4,n1_0,
n1_1,n1_2,n1_3,n1_4,n2_0,n2_1,n2_2,n2_3,n2_4,n3_0,n3_1,n3_2,n3_3,n3_4,n4_0,n4_1,n4_2,n4_3,n4_4]).
keys_([k0,k1,k2,k3,k4,k5,k6,k7,k8]).
shapes([tr,diam,sq,cir]).


def(arm_empty).
def(holding(Key)):-keys_(Keys), member(Key, Keys).
def(locked(Pos ) ) :-places(Places), member(Pos, Places).
def(open(Pos )) :-places(Places), member(Pos, Places).
def(at(Key, Pos)):-keys_(Keys), places(Places), member(Key, Keys), member(Pos, Places).
def(at_robot(Pos)):-places(Places), member(Pos, Places).


lock_shape(n4_3,sq).
lock_shape(n4_4,sq).
lock_shape(n3_4,sq).
lock_shape(n3_3,sq).
lock_shape(n2_3,sq).
lock_shape(n2_2,sq).
lock_shape(n3_2,sq).
lock_shape(n4_2,sq).
 

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
conn(n0_4,n0_3).
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
conn(n1_4,n1_3).
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
conn(n2_4,n2_3).
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
conn(n3_4,n3_3).
conn(n4_0,n3_0).
conn(n4_0,n4_1).
conn(n4_1,n3_1).
conn(n4_1,n4_2).
conn(n4_1,n4_0).
conn(n4_2,n3_2).
conn(n4_2,n4_3).
conn(n4_2,n4_1).
conn(n4_3,n3_3).
conn(n4_3,n4_4).
conn(n4_3,n4_2).
conn(n4_4,n3_4).
conn(n4_4,n4_3).


key_shape(k0,tr).
key_shape(k1,cir).
key_shape(k2,diam).
key_shape(k3,sq).
key_shape(k4,sq).
key_shape(k5,tr).
key_shape(k6,tr).
key_shape(k7,cir).
key_shape(k8,tr).



initial([	arm_empty,
	locked(n4_3),locked(n4_4),locked(n3_4),locked(n3_3),locked(n2_3),locked(n2_2),locked(n3_2),locked(n4_2),
	open(n0_0),open(n0_1),open(n0_2),open(n0_3),open(n0_4),open(n1_0),open(n1_1),
	open(n1_2),open(n1_3),open(n1_4),
	open(n2_0),open(n2_1),open(n2_4),open(n3_0),open(n3_1),open(n4_0),open(n4_1),at(k0,n2_3),
	at(k1,n1_3),at(k2,n0_4),at(k3,n0_2),at(k4,n3_3),at(k5,n4_1),at(k6,n4_4),at(k7,n3_4),at(k8,n2_2),
	at_robot(n2_4)]):-!.


goal([at(k0,n1_1)]):-!.


goal1( List ):-findall(X, not_determined(X), List).

not_determined(arm_empty).

not_determined(holding(Key)):-
	keys_(Keys),
	member(Key, Keys),
	Key\=k0.

not_determined(at(Key, Pos)):-
	keys_(Keys),
	Key\=k0, 
	places(Places),
	member(Key, Keys),
	member(Pos, Places).

not_determined(at_robot( Pos)):-
	places(Places),
	member(Pos, Places).

not_determined(open(Pos)):-
	places(Places),
	member(Pos, Places).

def( locked(Pos ) ) :-
	member(Pos, [n4_3,n4_4,n3_4,n3_3,n2_3,n2_2,n3_2,n4_2]).

