packages( [p11,p10,p9,p8,p7
,p6,p5,p4,p3,p2,p1] ) .
cities( [c9,c8,c7,c6,c5,c4,c3,c2,c1] ) .
airports( [c9_12,c8_12,c7_12,c6_12
,c5_12,c4_12,c3_12,c2_12,c1_12] ) .
locations( [c9_11,c9_10,c9_9,c9_8,c9_7
,c9_6,c9_5,c9_4,c9_3,c9_2,c9_1,c8_11
,c8_10,c8_9,c8_8,c8_7,c8_6,c8_5,c8_4
,c8_3,c8_2,c8_1,c7_11,c7_10,c7_9,c7_8
,c7_7,c7_6,c7_5,c7_4,c7_3,c7_2,c7_1
,c6_11,c6_10,c6_9,c6_8,c6_7,c6_6,c6_5
,c6_4,c6_3,c6_2,c6_1,c5_11,c5_10,c5_9
,c5_8,c5_7,c5_6,c5_5,c5_4,c5_3,c5_2
,c5_1,c4_11,c4_10,c4_9,c4_8,c4_7,c4_6
,c4_5,c4_4,c4_3,c4_2,c4_1,c3_11,c3_10
,c3_9,c3_8,c3_7,c3_6,c3_5,c3_4,c3_3
,c3_2,c3_1,c2_11,c2_10,c2_9,c2_8,c2_7
,c2_6,c2_5,c2_4,c2_3,c2_2,c2_1,c1_11
,c1_10,c1_9,c1_8,c1_7,c1_6,c1_5,c1_4
,c1_3,c1_2,c1_1,c9_12,c8_12,c7_12,c6_12
,c5_12,c4_12,c3_12,c2_12,c1_12 ] ) .
trucks( [tr54
,tr53,tr52,tr51,tr50,tr49,tr48,tr47
,tr46,tr45,tr44,tr43,tr42,tr41,tr40
,tr39,tr38,tr37,tr36,tr35,tr34,tr33
,tr32,tr31,tr30,tr29,tr28,tr27,tr26
,tr25,tr24,tr23,tr22,tr21,tr20,tr19
,tr18,tr17,tr16,tr15,tr14,tr13,tr12
,tr11,tr10,tr9,tr8,tr7,tr6,tr5,tr4
,tr3,tr2,tr1 ] ) .
airplanes( [pl8,pl7,pl6,pl5,pl4,pl3,pl2,pl1 ] ) .


def( at( Package , Location ) ) :- packages( D1 ) , locations( D2 ) , member( Package , D1 ) , member( Location , D2 ) .  
def( at( Airplane , Airport ) ) :- airplanes( D1 ) , airports( D2 ) , member( Airplane , D1 ) , member( Airport , D2 ) .  
def( out( Package ) ) :- packages( D1 ) , member( Package , D1 ) .
def( in( Package , Truck ) ) :- packages( D1 ) , trucks( D2 ) , member( Package , D1 ) , member( Truck , D2 ) .
def( in( Package , Airplane ) ) :- packages( D1 ) , airplanes( D2 ) , member( Package , D1 ) , member( Airplane , D2 ) .
def( at( Truck , Location ) ) :- trucks( D1 ) , locations( D2 ) , member( Truck , D1 ) , member( Location , D2 ), truck_city(Truck, City), const(loc_at(Location, City)) .



const(loc_at(c9_11, c9)).
const(loc_at(c9_10, c9)).
const(loc_at(c9_9, c9)).
const(loc_at(c9_8, c9)).
const(loc_at(c9_7, c9)).
const(loc_at(c9_6, c9)).
const(loc_at(c9_5, c9)).
const(loc_at(c9_4, c9)).
const(loc_at(c9_3, c9)).
const(loc_at(c9_2, c9)).
const(loc_at(c9_1, c9)).
const(loc_at(c8_11, c8)).
const(loc_at(c8_10, c8)).
const(loc_at(c8_9, c8)).
const(loc_at(c8_8, c8)).
const(loc_at(c8_7, c8)).
const(loc_at(c8_6, c8)).
const(loc_at(c8_5, c8)).
const(loc_at(c8_4, c8)).
const(loc_at(c8_3, c8)).
const(loc_at(c8_2, c8)).
const(loc_at(c8_1, c8)).
const(loc_at(c7_11, c7)).
const(loc_at(c7_10, c7)).
const(loc_at(c7_9, c7)).
const(loc_at(c7_8, c7)).
const(loc_at(c7_7, c7)).
const(loc_at(c7_6, c7)).
const(loc_at(c7_5, c7)).
const(loc_at(c7_4, c7)).
const(loc_at(c7_3, c7)).
const(loc_at(c7_2, c7)).
const(loc_at(c7_1, c7)).
const(loc_at(c6_11, c6)).
const(loc_at(c6_10, c6)).
const(loc_at(c6_9, c6)).
const(loc_at(c6_8, c6)).
const(loc_at(c6_7, c6)).
const(loc_at(c6_6, c6)).
const(loc_at(c6_5, c6)).
const(loc_at(c6_4, c6)).
const(loc_at(c6_3, c6)).
const(loc_at(c6_2, c6)).
const(loc_at(c6_1, c6)).
const(loc_at(c5_11, c5)).
const(loc_at(c5_10, c5)).
const(loc_at(c5_9, c5)).
const(loc_at(c5_8, c5)).
const(loc_at(c5_7, c5)).
const(loc_at(c5_6, c5)).
const(loc_at(c5_5, c5)).
const(loc_at(c5_4, c5)).
const(loc_at(c5_3, c5)).
const(loc_at(c5_2, c5)).
const(loc_at(c5_1, c5)).
const(loc_at(c4_11, c4)).
const(loc_at(c4_10, c4)).
const(loc_at(c4_9, c4)).
const(loc_at(c4_8, c4)).
const(loc_at(c4_7, c4)).
const(loc_at(c4_6, c4)).
const(loc_at(c4_5, c4)).
const(loc_at(c4_4, c4)).
const(loc_at(c4_3, c4)).
const(loc_at(c4_2, c4)).
const(loc_at(c4_1, c4)).
const(loc_at(c3_11, c3)).
const(loc_at(c3_10, c3)).
const(loc_at(c3_9, c3)).
const(loc_at(c3_8, c3)).
const(loc_at(c3_7, c3)).
const(loc_at(c3_6, c3)).
const(loc_at(c3_5, c3)).
const(loc_at(c3_4, c3)).
const(loc_at(c3_3, c3)).
const(loc_at(c3_2, c3)).
const(loc_at(c3_1, c3)).
const(loc_at(c2_11, c2)).
const(loc_at(c2_10, c2)).
const(loc_at(c2_9, c2)).
const(loc_at(c2_8, c2)).
const(loc_at(c2_7, c2)).
const(loc_at(c2_6, c2)).
const(loc_at(c2_5, c2)).
const(loc_at(c2_4, c2)).
const(loc_at(c2_3, c2)).
const(loc_at(c2_2, c2)).
const(loc_at(c2_1, c2)).
const(loc_at(c1_11, c1)).
const(loc_at(c1_10, c1)).
const(loc_at(c1_9, c1)).
const(loc_at(c1_8, c1)).
const(loc_at(c1_7, c1)).
const(loc_at(c1_6, c1)).
const(loc_at(c1_5, c1)).
const(loc_at(c1_4, c1)).
const(loc_at(c1_3, c1)).
const(loc_at(c1_2, c1)).
const(loc_at(c1_1, c1)).
const(loc_at(c9_12, c9)).
const(loc_at(c8_12, c8)).
const(loc_at(c7_12, c7)).
const(loc_at(c6_12, c6)).
const(loc_at(c5_12, c5)).
const(loc_at(c4_12, c4)).
const(loc_at(c3_12, c3)).
const(loc_at(c2_12, c2)).
const(loc_at(c1_12, c1)).

truck_city(tr54,c9).
truck_city(tr53,c8).
truck_city(tr52,c71).
truck_city(tr51,c6).
truck_city(tr50,c5).
truck_city(tr49,c4).
truck_city(tr48,c3).
truck_city(tr47,c2).
truck_city(tr46,c1).
truck_city(tr45,c5).
truck_city(tr44,c7).
truck_city(tr43,c8).
truck_city(tr42,c3).
truck_city(tr41,c6).
truck_city(tr40,c2).
truck_city(tr39,c20).
truck_city(tr38,c22).
truck_city(tr37,c2).
truck_city(tr36,c5).
truck_city(tr35,c1).
truck_city(tr34,c11).
truck_city(tr33,c60).
truck_city(tr32,c1).
truck_city(tr31,c3).
truck_city(tr30,c52).
truck_city(tr29,c2).
truck_city(tr28,c3).
truck_city(tr27,c2).
truck_city(tr26,c3).
truck_city(tr25,c4).
truck_city(tr24,c12).
truck_city(tr23,c1).
truck_city(tr22,c71).
truck_city(tr21,c4).
truck_city(tr20,c8).
truck_city(tr19,c1).
truck_city(tr18,c4).
truck_city(tr17,c40).
truck_city(tr16,c11).
truck_city(tr15,c9).
truck_city(tr14,c3).
truck_city(tr13,c1).
truck_city(tr12,c4).
truck_city(tr11,c8).
truck_city(tr10,c6).
truck_city(tr9,c60).
truck_city(tr8,c1).
truck_city(tr7,c4).
truck_city(tr6,c4).
truck_city(tr5,c4).
truck_city(tr4,c9).
truck_city(tr3,c4).
truck_city(tr2,c1).
truck_city(tr1,c9).


initial([at(pl8,c6_12),at(pl7,c6_12),at(pl6,c9_12),at(pl5,c3_12),at(pl4,c9_12),at(pl3,c2_12),at(pl2,c7_12),at(pl1,c6_12),
at(tr54,c9_4),at(tr53,c8_5),at(tr52,c7_11),at(tr51,c6_1),at(tr50,c5_4),at(tr49,c4_5),at(tr48,c3_2),
at(tr47,c2_8),at(tr46,c1_9),at(tr45,c5_4),at(tr44,c7_6),at(tr43,c8_5),at(tr42,c3_2),at(tr41,c6_8),
at(tr40,c2_3),at(tr39,c2_10),at(tr38,c2_12),at(tr37,c2_5),at(tr36,c5_7),at(tr35,c1_3),at(tr34,c1_11),
at(tr33,c6_10),at(tr32,c1_2),at(tr31,c3_3),at(tr30,c5_12),at(tr29,c2_4),at(tr28,c3_3),at(tr27,c2_3),
at(tr26,c3_3),at(tr25,c4_1),at(tr24,c1_12),at(tr23,c1_1),at(tr22,c7_11),at(tr21,c4_5),at(tr20,c8_6),
at(tr19,c1_4),at(tr18,c4_7),at(tr17,c4_10),at(tr16,c1_11),at(tr15,c9_7),at(tr14,c3_3),at(tr13,c1_4),
at(tr12,c4_8),at(tr11,c8_9),at(tr10,c6_7),at(tr9,c6_10),at(tr8,c1_1),at(tr7,c4_3),at(tr6,c4_5),
at(tr5,c4_5),at(tr4,c9_8),at(tr3,c4_8),at(tr2,c1_5),at(tr1,c9_7),
at(p11,c5_4),at(p10,c2_5),at(p9,c6_5),at(p8,c1_5),at(p7,c3_9),at(p6,c6_9),at(p5,c4_12),at(p4,c7_1),at(p3,c6_6),at(p2,c2_7),at(p1,c8_1),
out(p11),out(p10),out(p9),out(p8),out(p7),out(p6),out(p5),out(p4),out(p3),out(p2),out(p1)]):-!.


goal([at(p11,c8_8),at(p10,c3_2),at(p9,c1_11),at(p8,c3_4),
out(p11),out(p10),out(p9),out(p8)]):-!.


goal1( List ):-findall(X, not_determined(X), List).

not_determined(at(Truck, Location)):-
	trucks(Trucks), 
	locations(Locations), 
	member(Truck, Trucks), 
	member(Location, Locations),
	truck_city(Truck, City),
	const(loc_at(Location, City)).

not_determined(at(Plane, Airport)):-
	airplanes(Planes), 
	airports(Airports), 
	member(Plane, Planes), 
	member(Airport, Airports).

not_determined(at(Object, Location)):-
	member(Object, [p1, p2, p3, p4, p5, p6, p7]), 
	locations(Locations), 
	member(Location, Locations).

not_determined(out(Object)):-
	member(Object, [p1, p2, p3, p4, p5, p6, p7]). 

not_determined(in(Object, Truck)):-
	member(Object, [p1, p2, p3, p4, p5, p6, p7]), 
	trucks(Trucks),
	member(Truck, Trucks).

not_determined(in(Object, Airplane)):-
	member(Object, [p1, p2, p3, p4, p5, p6, p7]), 
	airplanes(Airplanes),
	member(Airplane, Airplanes).








