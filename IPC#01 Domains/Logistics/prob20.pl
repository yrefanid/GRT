packages( [p16,p15,p14,p13,p12
,p11,p10,p9,p8,p7,p6
,p5,p4,p3,p2,p1] ) .
cities( [c15,c14
,c13,c12,c11,c10,c9,c8,c7,c6,c5,c4
,c3,c2,c1] ) .
airports( [c15_12,c14_12,c13_12,c12_12,c11_12,c10_12
,c9_12,c8_12,c7_12,c6_12,c5_12,c4_12,c3_12
,c2_12,c1_12] ) .
locations( [c15_11,c15_10
,c15_9,c15_8,c15_7,c15_6,c15_5,c15_4,c15_3
,c15_2,c15_1,c14_11,c14_10,c14_9,c14_8
,c14_7,c14_6,c14_5,c14_4,c14_3,c14_2,c14_1
,c13_11,c13_10,c13_9,c13_8,c13_7,c13_6
,c13_5,c13_4,c13_3,c13_2,c13_1,c12_11
,c12_10,c12_9,c12_8,c12_7,c12_6,c12_5,c12_4
,c12_3,c12_2,c12_1,c11_11,c11_10,c11_9
,c11_8,c11_7,c11_6,c11_5,c11_4,c11_3,c11_2
,c11_1,c10_11,c10_10,c10_9,c10_8,c10_7
,c10_6,c10_5,c10_4,c10_3,c10_2,c10_1,c9_11
,c9_10,c9_9,c9_8,c9_7,c9_6,c9_5,c9_4
,c9_3,c9_2,c9_1,c8_11,c8_10,c8_9,c8_8
,c8_7,c8_6,c8_5,c8_4,c8_3,c8_2,c8_1
,c7_11,c7_10,c7_9,c7_8,c7_7,c7_6,c7_5
,c7_4,c7_3,c7_2,c7_1,c6_11,c6_10,c6_9
,c6_8,c6_7,c6_6,c6_5,c6_4,c6_3,c6_2
,c6_1,c5_11,c5_10,c5_9,c5_8,c5_7,c5_6
,c5_5,c5_4,c5_3,c5_2,c5_1,c4_11,c4_10
,c4_9,c4_8,c4_7,c4_6,c4_5,c4_4,c4_3
,c4_2,c4_1,c3_11,c3_10,c3_9,c3_8,c3_7
,c3_6,c3_5,c3_4,c3_3,c3_2,c3_1,c2_11
,c2_10,c2_9,c2_8,c2_7,c2_6,c2_5,c2_4
,c2_3,c2_2,c2_1,c1_11,c1_10,c1_9,c1_8
,c1_7,c1_6,c1_5,c1_4,c1_3,c1_2,c1_1
,c15_12,c14_12,c13_12,c12_12,c11_12,c10_12
,c9_12,c8_12,c7_12,c6_12,c5_12,c4_12,c3_12
,c2_12,c1_12 ] ) .
trucks( [tr19,tr18,tr17,tr16,tr15
,tr14,tr13,tr12,tr11,tr10,tr9,tr8,tr7
,tr6,tr5,tr4,tr3,tr2,tr1 ] ) .
airplanes( [pl15,pl14
,pl13,pl12,pl11,pl10,pl9,pl8,pl7,pl6
,pl5,pl4,pl3,pl2,pl1 ] ) .



def( at( Package , Location ) ) :- packages( D1 ) , locations( D2 ) , member( Package , D1 ) , member( Location , D2 ) .  
def( at( Airplane , Airport ) ) :- airplanes( D1 ) , airports( D2 ) , member( Airplane , D1 ) , member( Airport , D2 ) .  
def( out( Package ) ) :- packages( D1 ) , member( Package , D1 ) .
def( in( Package , Truck ) ) :- packages( D1 ) , trucks( D2 ) , member( Package , D1 ) , member( Truck , D2 ) .
def( in( Package , Airplane ) ) :- packages( D1 ) , airplanes( D2 ) , member( Package , D1 ) , member( Airplane , D2 ) .
def( at( Truck , Location ) ) :- trucks( D1 ) , locations( D2 ) , member( Truck , D1 ) , member( Location , D2 ), truck_city(Truck, City), const(loc_at(Location, City)) .


const(loc_at(c15_11, c15)).
const(loc_at(c15_10, c15)).
const(loc_at(c15_9, c15)).
const(loc_at(c15_8, c15)).
const(loc_at(c15_7, c15)).
const(loc_at(c15_6, c15)).
const(loc_at(c15_5, c15)).
const(loc_at(c15_4, c15)).
const(loc_at(c15_3, c15)).
const(loc_at(c15_2, c15)).
const(loc_at(c15_1, c15)).
const(loc_at(c14_11, c14)).
const(loc_at(c14_10, c14)).
const(loc_at(c14_9, c14)).
const(loc_at(c14_8, c14)).
const(loc_at(c14_7, c14)).
const(loc_at(c14_6, c14)).
const(loc_at(c14_5, c14)).
const(loc_at(c14_4, c14)).
const(loc_at(c14_3, c14)).
const(loc_at(c14_2, c14)).
const(loc_at(c14_1, c14)).
const(loc_at(c13_11, c13)).
const(loc_at(c13_10, c13)).
const(loc_at(c13_9, c13)).
const(loc_at(c13_8, c13)).
const(loc_at(c13_7, c13)).
const(loc_at(c13_6, c13)).
const(loc_at(c13_5, c13)).
const(loc_at(c13_4, c13)).
const(loc_at(c13_3, c13)).
const(loc_at(c13_2, c13)).
const(loc_at(c13_1, c13)).
const(loc_at(c12_11, c12)).
const(loc_at(c12_10, c12)).
const(loc_at(c12_9, c12)).
const(loc_at(c12_8, c12)).
const(loc_at(c12_7, c12)).
const(loc_at(c12_6, c12)).
const(loc_at(c12_5, c12)).
const(loc_at(c12_4, c12)).
const(loc_at(c12_3, c12)).
const(loc_at(c12_2, c12)).
const(loc_at(c12_1, c12)).
const(loc_at(c11_11, c11)).
const(loc_at(c11_10, c11)).
const(loc_at(c11_9, c11)).
const(loc_at(c11_8, c11)).
const(loc_at(c11_7, c11)).
const(loc_at(c11_6, c11)).
const(loc_at(c11_5, c11)).
const(loc_at(c11_4, c11)).
const(loc_at(c11_3, c11)).
const(loc_at(c11_2, c11)).
const(loc_at(c11_1, c11)).
const(loc_at(c10_11, c10)).
const(loc_at(c10_10, c10)).
const(loc_at(c10_9, c10)).
const(loc_at(c10_8, c10)).
const(loc_at(c10_7, c10)).
const(loc_at(c10_6, c10)).
const(loc_at(c10_5, c10)).
const(loc_at(c10_4, c10)).
const(loc_at(c10_3, c10)).
const(loc_at(c10_2, c10)).
const(loc_at(c10_1, c10)).
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
const(loc_at(c15_12, c15)).
const(loc_at(c14_12, c14)).
const(loc_at(c13_12, c13)).
const(loc_at(c12_12, c12)).
const(loc_at(c11_12, c11)).
const(loc_at(c10_12, c10)).
const(loc_at(c9_12, c9)).
const(loc_at(c8_12, c8)).
const(loc_at(c7_12, c7)).
const(loc_at(c6_12, c6)).
const(loc_at(c5_12, c5)).
const(loc_at(c4_12, c4)).
const(loc_at(c3_12, c3)).
const(loc_at(c2_12, c2)).
const(loc_at(c1_12, c1)).


truck_city(tr19,c15).
truck_city(tr18,c14).
truck_city(tr17,c13).
truck_city(tr16,c120).
truck_city(tr15,c11).
truck_city(tr14,c101).
truck_city(tr13,c9).
truck_city(tr12,c8).
truck_city(tr11,c7).
truck_city(tr10,c6).
truck_city(tr9,c51).
truck_city(tr8,c4).
truck_city(tr7,c3).
truck_city(tr6,c21).
truck_city(tr5,c11).
truck_city(tr4,c4).
truck_city(tr3,c2).
truck_city(tr2,c10).
truck_city(tr1,c6).



initial([at(pl15,c5_12),at(pl14,c6_12),at(pl13,c4_12),at(pl12,c7_12),at(pl11,c10_12),at(pl10,c3_12),at(pl9,c9_12),
at(pl8,c9_12),at(pl7,c14_12),at(pl6,c8_12),at(pl5,c7_12),at(pl4,c11_12),at(pl3,c11_12),at(pl2,c14_12),at(pl1,c13_12),
at(tr19,c15_6),at(tr18,c14_5),at(tr17,c13_6),at(tr16,c12_10),at(tr15,c11_5),at(tr14,c10_11),at(tr13,c9_3),
at(tr12,c8_7),at(tr11,c7_4),at(tr10,c6_9),at(tr9,c5_11),at(tr8,c4_9),at(tr7,c3_8),at(tr6,c2_11),at(tr5,c1_11),
at(tr4,c4_9),at(tr3,c2_9),at(tr2,c10_5),at(tr1,c6_6),
at(p16,c1_12),at(p15,c3_10),at(p14,c9_8),at(p13,c5_2),
at(p12,c15_5),at(p11,c13_3),at(p10,c2_3),at(p9,c10_1),at(p8,c4_9),at(p7,c3_4),at(p6,c9_2),
at(p5,c8_1),at(p4,c7_5),
at(p3,c12_5),at(p2,c9_7),at(p1,c12_11),
out(p16),out(p15),out(p14),out(p13),out(p12),out(p11),out(p10),out(p9),out(p8),out(p7),out(p6),out(p5),out(p4),out(p3),out(p2),out(p1)]):-!.

goal([at(p16,c9_10),at(p15,c5_12),at(p14,c10_4),at(p13,c3_4),at(p12,c10_10),at(p11,c7_4),
at(p10,c8_5),at(p9,c4_2),at(p8,c15_6),at(p7,c4_9),at(p6,c5_10),at(p5,c8_10),at(p4,c3_11),
at(p3,c3_7),at(p2,c9_12),at(p1,c10_10),
out(p16),out(p15),out(p14),out(p13),out(p12),out(p11),out(p10),out(p9),out(p8),out(p7),out(p6),out(p5),out(p4),out(p3),out(p2),out(p1)]):-!.


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



