packages( [p7,p6,p5,p4,p3,p2 ,p1] ) .
cities( [c11,c10,c9,c8,c7,c6,c5,c4,c3 ,c2,c1] ) .
airports( [c11_3,c10_3,c9_3,c8_3,c7_3,c6_3 ,c5_3,c4_3,c3_3,c2_3,c1_3] ) .
locations( [c11_2,c11_1,c10_2,c10_1,c9_2,c9_1,c8_2 ,c8_1,c7_2,
c7_1,c6_2,c6_1,c5_2,c5_1 ,c4_2,c4_1,c3_2,c3_1,c2_2,c2_1,
c1_2 ,c1_1,c11_3,c10_3,c9_3,c8_3,c7_3,c6_3 ,c5_3,c4_3,c3_3,
c2_3,c1_3] ) .
trucks( [tr52,tr51,tr50,tr49,tr48,tr47 ,tr46,tr45,tr44,tr43,tr42,tr41,
tr40 ,tr39,tr38,tr37,tr36,tr35,tr34,tr33 ,tr32,tr31,tr30,tr29,tr28,tr27,
tr26 ,tr25,tr24,tr23,tr22,tr21,tr20,tr19 ,tr18,tr17,tr16,tr15,tr14,tr13,
tr12 ,tr11,tr10,tr9,tr8,tr7,tr6,tr5,tr4 ,tr3,tr2,tr1] ) .
airplanes( [pl13,pl12,pl11,pl10,pl9 ,pl8,pl7,pl6,pl5,pl4,pl3,pl2,pl1 ] ) .



const(loc_at(c11_2, c11)).
const(loc_at(c11_1, c11)).
const(loc_at(c10_2, c10)).
const(loc_at(c10_1, c10)).
const(loc_at(c9_2, c9)).
const(loc_at(c9_1, c9)).
const(loc_at(c8_2, c8)). 
const(loc_at(c8_1, c8)).
const(loc_at(c7_2, c7)).
const(loc_at(c7_1, c7)).
const(loc_at(c6_2, c6)).
const(loc_at(c6_1, c6)).
const(loc_at(c5_2, c5)).
const(loc_at(c5_1, c5)). 
const(loc_at(c4_2, c4)).
const(loc_at(c4_1, c4)).
const(loc_at(c3_2, c3)).
const(loc_at(c3_1, c3)).
const(loc_at(c2_2, c2)).
const(loc_at(c2_1, c2)).
const(loc_at(c1_2, c1)). 
const(loc_at(c1_1, c1)).
const(loc_at(c11_3, c11)).
const(loc_at(c10_3, c10)).
const(loc_at(c9_3, c9)).
const(loc_at(c8_3, c8)).
const(loc_at(c7_3, c7)).
const(loc_at(c6_3, c6)). 
const(loc_at(c5_3, c5)).
const(loc_at(c4_3, c4)).
const(loc_at(c3_3, c3)).
const(loc_at(c2_3, c2)).
const(loc_at(c1_3, c1)).



truck_city(tr52,c11).
truck_city(tr51,c10).
truck_city(tr50,c9).
truck_city(tr49,c8).
truck_city(tr48,c7).
truck_city(tr47,c6).
truck_city(tr46,c5).
truck_city(tr45,c4).
truck_city(tr44,c3).
truck_city(tr43,c2).
truck_city(tr42,c1).
truck_city(tr41,c7).
truck_city(tr40,c6).
truck_city(tr39,c2).
truck_city(tr38,c3).
truck_city(tr37,c2).
truck_city(tr36,c7).
truck_city(tr35,c8).
truck_city(tr34,c8).
truck_city(tr33,c7).
truck_city(tr32,c6).
truck_city(tr31,c2).
truck_city(tr30,c11).
truck_city(tr29,c1).
truck_city(tr28,c3).
truck_city(tr27,c9).
truck_city(tr26,c7).
truck_city(tr25,c1).
truck_city(tr24,c4).
truck_city(tr23,c9).
truck_city(tr22,c3).
truck_city(tr21,c1).
truck_city(tr20,c7).
truck_city(tr19,c4).
truck_city(tr18,c1).
truck_city(tr17,c4).
truck_city(tr16,c11).
truck_city(tr15,c6).
truck_city(tr14,c5).
truck_city(tr13,c5).
truck_city(tr12,c8).
truck_city(tr11,c8).
truck_city(tr10,c5).
truck_city(tr9,c8).
truck_city(tr8,c1).
truck_city(tr7,c8).
truck_city(tr6,c9).
truck_city(tr5,c10).
truck_city(tr4,c6).
truck_city(tr3,c11).
truck_city(tr2,c5).
truck_city(tr1,c5).



initial([at(pl13,c10_3),at(pl12,c5_3),at(pl11,c11_3),at(pl10,c1_3),at(pl9,c9_3),at(pl8,c7_3),
at(pl7,c1_3),
at(pl6,c8_3),at(pl5,c7_3),at(pl4,c9_3),at(pl3,c1_3),at(pl2,c11_3),at(pl1,c6_3),at(tr52,c11_2),
at(tr51,c10_1),at(tr50,c9_2),at(tr49,c8_1),at(tr48,c7_1),at(tr47,c6_1),at(tr46,c5_2),at(tr45,c4_1),
at(tr44,c3_2),at(tr43,c2_2),at(tr42,c1_2),at(tr41,c7_2),at(tr40,c6_1),at(tr39,c2_3),at(tr38,c3_1),
at(tr37,c2_3),at(tr36,c7_1),at(tr35,c8_2),at(tr34,c8_2),at(tr33,c7_2),at(tr32,c6_3),at(tr31,c2_2),
at(tr30,c11_3),at(tr29,c1_2),at(tr28,c3_1),at(tr27,c9_2),at(tr26,c7_2),at(tr25,c1_3),at(tr24,c4_1),
at(tr23,c9_2),at(tr22,c3_1),at(tr21,c1_1),at(tr20,c7_3),at(tr19,c4_3),at(tr18,c1_1),at(tr17,c4_3),
at(tr16,c11_3),at(tr15,c6_2),at(tr14,c5_3),at(tr13,c5_1),at(tr12,c8_1),at(tr11,c8_1),at(tr10,c5_2),
at(tr9,c8_3),at(tr8,c1_1),at(tr7,c8_2),at(tr6,c9_3),at(tr5,c10_2),at(tr4,c6_3),at(tr3,c11_1),
at(tr2,c5_3),at(tr1,c5_2),at(p7,c4_2),at(p6,c4_1),at(p5,c11_2),at(p4,c2_2),at(p3,c7_2),at(p2,c7_2),at(p1,c7_2), 
out(p7),out(p6),out(p5),out(p4),out(p3),out(p2) ,out(p1)]):-!.



goal([at(p7,c5_1),at(p6,c5_2),at(p5,c2_1),at(p4,c5_3),at(p3,c5_1),at(p2,c5_2),
at(p1,c4_1), 
out(p7),out(p6),out(p5),out(p4),out(p3),out(p2) ,out(p1)]):-!.


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

