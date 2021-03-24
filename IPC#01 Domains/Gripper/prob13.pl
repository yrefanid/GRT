problem_name('gripper13.txt').

rooms([rooma,roomb]).
balls([ball28,ball27,ball26,ball25,ball24,ball23,
ball22,ball21,ball20,ball19,ball18,ball17,ball16,ball15,ball14,
ball13,ball12,ball11,ball10,ball9,ball8,ball7,ball6,ball5,ball4,
ball3,ball2,ball1]).
grippers([left,right]).

def(at_robby(Room)):-rooms(Rooms), member(Room, Rooms).
def(at(Ball, Room)):-rooms(Rooms), balls(Balls),member(Ball,Balls), member(Room, Rooms).
def(free(Gripper)):-grippers(Grippers), member(Gripper, Grippers).
def(carry(Ball, Gripper)):-balls(Balls), member(Ball, Balls),grippers(Grippers), member(Gripper, Grippers).

initial([at_robby(rooma),free(left),free(right),at(ball28,rooma),at(ball27,rooma),at(ball26,rooma),at(ball25,rooma),at(ball24,rooma),at(ball23,rooma),at(ball22,rooma),at(ball21,rooma),at(ball20,rooma),at(ball19,rooma),at(ball18,rooma),at(ball17,rooma),at(ball16,rooma),at(ball15,rooma),at(ball14,rooma),at(ball13,rooma),at(ball12,rooma),at(ball11,rooma),at(ball10,rooma),at(ball9,rooma),at(ball8,rooma),at(ball7,rooma),at(ball6,rooma),at(ball5,rooma),at(ball4,rooma),at(ball3,rooma),at(ball2,rooma),at(ball1,rooma)]):-!.

goal([at(ball28,roomb),at(ball27,roomb),at(ball26,roomb),at(ball25,roomb),at(ball24,roomb),at(ball23,roomb),at(ball22,roomb),at(ball21,roomb),at(ball20,roomb),at(ball19,roomb),at(ball18,roomb),at(ball17,roomb),at(ball16,roomb),at(ball15,roomb),at(ball14,roomb),at(ball13,roomb),at(ball12,roomb),at(ball11,roomb),at(ball10,roomb),at(ball9,roomb),at(ball8,roomb),at(ball7,roomb),at(ball6,roomb),at(ball5,roomb),at(ball4,roomb),at(ball3,roomb),at(ball2,roomb),at(ball1,roomb)]):-!.

goal1(List):-findall(X, ndt(X), List).


ndt(at_robby(roomb)).
ndt(free(left)).
ndt(free(right)).
