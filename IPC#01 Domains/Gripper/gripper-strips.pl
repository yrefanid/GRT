operator(move(From, To),
	[at_robby(From)],
	[at_robby(From)],
	[at_robby(To)]):-
		rooms(Rooms), member(From, Rooms), member(To, Rooms).


operator(pick(Obj,Room,Gripper),
	[at(Obj,Room),at_robby(Room),free(Gripper)],
	[at(Obj,Room),free(Gripper)],
	[carry(Obj,Gripper)]):-
		rooms(Rooms),member(Room, Rooms),
		balls(Balls), member(Obj, Balls),
		grippers(Grippers), member(Gripper, Grippers).

	
operator(drop(Obj,Room,Gripper),
	[carry(Obj,Gripper),at_robby(Room)],
	[carry(Obj,Gripper)],
	[at(Obj,Room), free(Gripper)]):-
		rooms(Rooms),member(Room, Rooms),
		balls(Balls), member(Obj, Balls),
		grippers(Grippers), member(Gripper, Grippers).
