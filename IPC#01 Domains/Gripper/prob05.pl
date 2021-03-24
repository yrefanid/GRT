problem_name('gripper05.txt').

rooms([rooma,roomb]).
balls([ball12,ball11,ball10,ball9,ball8,ball7,ball6
,ball5,ball4,ball3,ball2,ball1]).
grippers([left,right]).

def(at_robby(Room)):-rooms(Rooms), member(Room, Rooms).
def(at(Ball, Room)):-rooms(Rooms), balls(Balls),member(Ball,Balls), member(Room, Rooms).
def(free(Gripper)):-grippers(Grippers), member(Gripper, Grippers).
def(carry(Ball, Gripper)):-balls(Balls), member(Ball, Balls),grippers(Grippers), member(Gripper, Grippers).

initial([at_robby(rooma),free(left),free(right),at(ball12,rooma),at(ball11,rooma),at(ball10,rooma),at(ball9,rooma),at(ball8,rooma),at(ball7,rooma),at(ball6,rooma),at(ball5,rooma),at(ball4,rooma),at(ball3,rooma),at(ball2,rooma),at(ball1,rooma)]):-!.
goal([at(ball12,roomb),at(ball11,roomb),at(ball10,roomb),at(ball9,roomb),at(ball8,roomb),at(ball7,roomb),at(ball6,roomb),at(ball5,roomb),at(ball4,roomb),at(ball3,roomb),at(ball2,roomb),at(ball1,roomb)]):-!.

goal1(List):-findall(X, ndt(X), List).
ndt(at_robby(roomb)).
ndt(free(left)).
ndt(free(right)).

