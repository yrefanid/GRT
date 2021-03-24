operator(unlck(Curpos, Lockpos, Key, Shape),
 	[at_robot(Curpos), locked(Lockpos), holding(Key)],
	[locked(Lockpos)],
	[open(Lockpos)]):-
		places(Places), member(Curpos, Places),member(Lockpos, Places), 
		keys_(Keys), member(Key, Keys), 
		shapes(Shapes),member(Shape, Shapes), 
		conn(Curpos, Lockpos), 
		key_shape(Key, Shape), 
		lock_shape(Lockpos, Shape).


operator(mv(Curpos, Nextpos),
	[at_robot(Curpos), open(Nextpos)],
	[at_robot(Curpos)],
	[at_robot(Nextpos)]):-
		places(Places), member(Curpos, Places),member(Nextpos, Places), conn(Curpos, Nextpos).



operator(pck(Curpos,Key),
	[at_robot(Curpos),at(Key,Curpos), arm_empty],
	[at(Key, Curpos),arm-empty],
	[holding(Key)]):-
	places(Places), member(Curpos, Places),
		keys_(Keys), member(Key, Keys).


operator(pck_ls(Curpos, Newkey, Oldkey),
	[at_robot(Curpos),holding(Oldkey),at(Newkey,Curpos)],
	[holding(Oldkey), at(Newkey,Curpos)],
	[holding(Newkey),at(Oldkey,Curpos)]):-
		places(Places), member(Curpos, Places),
		keys_(Keys), member(Newkey, Keys), member(Oldkey, Keys).

operator(ptdwn(Curpos,Key),
	[at_robot(Curpos),holding(Key)],
	[holding(Key)],
	[arm_empty, at(Key,Curpos)]):- 
	places(Places), member(Curpos, Places),
		keys_(Keys), member(Key, Keys).


	