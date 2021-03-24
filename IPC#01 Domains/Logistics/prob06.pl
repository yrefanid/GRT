packages( [ p1 , p2 , p3 , p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16 ] ) .
cities( [ c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c17, c18 ] ) .
airports( [ c1_4, c2_4, c3_4, c4_4, c5_4, c6_4, c7_4, c8_4, c9_4, c10_4, c11_4, c12_4, c13_4, c14_4, c15_4, c16_4, c17_4, c18_4] ) .
locations( [ c1_1, c1_2, c1_3, c1_4, c2_1, c2_2, c2_3, c2_4, c3_1, c3_2, c3_3, c3_4, c4_1, c4_2, c4_3, c4_4, 
	c5_1, c5_2, c5_3, c5_4, c6_1, c6_2 , c6_3, c6_4, c7_1, c7_2, c7_3, c7_4, 
	c8_1, c8_2, c8_3, c8_4, c9_1, c9_2, c9_3, c9_4, c10_1, c10_2, c10_3, c10_4, c11_1, c11_2, c11_3, c11_4, 
	c12_1, c12_2, c12_3, c12_4, c13_1, c13_2 , c13_3, c13_4, c14_1, c14_2 , c14_3, c14_4, c15_1, c15_2 , c15_3, c15_4,
	c16_1, c16_2 , c16_3, c16_4, c17_1, c17_2 , c17_3, c17_4, c18_1, c18_2 , c18_3, c18_4 ] ) .
trucks( [ tr1 , tr2 , tr3, tr4, tr5, tr6, tr7, tr8, tr9, tr10, tr11, tr12, tr13, tr14, tr15, tr16, tr17, tr18, tr19, tr20, tr21, tr22, tr23, tr24, tr25, tr26 ] ) .
airplanes( [ pl1, pl2 ] ) .
 
def( at( Package , Location ) ) :- packages( D1 ) , locations( D2 ) , member( Package , D1 ) , member( Location , D2 ) .  
def( at( Airplane , Airport ) ) :- airplanes( D1 ) , airports( D2 ) , member( Airplane , D1 ) , member( Airport , D2 ) .  
def( out( Package ) ) :- packages( D1 ) , member( Package , D1 ) .
def( in( Package , Truck ) ) :- packages( D1 ) , trucks( D2 ) , member( Package , D1 ) , member( Truck , D2 ) .
def( in( Package , Airplane ) ) :- packages( D1 ) , airplanes( D2 ) , member( Package , D1 ) , member( Airplane , D2 ) .
def( at( Truck , Location ) ) :- trucks( D1 ) , locations( D2 ) , member( Truck , D1 ) , member( Location , D2 ), truck_city(Truck, City), const(loc_at(Location, City)) .



const( loc_at( c1_1, c1) ) .
const( loc_at( c1_2, c1) ) .
const( loc_at( c1_3, c1) ) .
const( loc_at( c1_4, c1) ) .
const( loc_at( c2_1, c2) ) .
const( loc_at( c2_2, c2) ) .
const( loc_at( c2_3, c2) ) .
const( loc_at( c2_4, c2) ) .
const( loc_at( c3_1, c3) ) .
const( loc_at( c3_2, c3) ) .
const( loc_at( c3_3, c3) ) .
const( loc_at( c3_4, c3) ) .
const( loc_at( c4_1, c4) ) .
const( loc_at( c4_2, c4) ) .
const( loc_at( c4_3, c4) ) .
const( loc_at( c4_4, c4) ) .
const( loc_at( c5_1, c5) ) .
const( loc_at( c5_2, c5) ) .
const( loc_at( c5_3, c5) ) .
const( loc_at( c5_4, c5) ) .
const( loc_at( c6_1, c6) ) .
const( loc_at( c6_2, c6) ) .
const( loc_at( c6_3, c6) ) .
const( loc_at( c6_4, c6) ) .
const( loc_at( c7_1, c7) ) .
const( loc_at( c7_2, c7) ) .
const( loc_at( c7_3, c7) ) .
const( loc_at( c7_4, c7) ) .
const( loc_at( c8_1, c8) ) .
const( loc_at( c8_2, c8) ) .
const( loc_at( c8_3, c8) ) .
const( loc_at( c8_4, c8) ) .
const( loc_at( c9_1, c9) ) .
const( loc_at( c9_2, c9) ) .
const( loc_at( c9_3, c9) ).
const( loc_at( c9_4, c9) ) .
const( loc_at( c10_1, c10) ) .
const( loc_at( c10_2, c10) ) .
const( loc_at( c10_3, c10) ) .
const( loc_at( c10_4, c10) ) .
const( loc_at( c11_1, c11) ) .
const( loc_at( c11_2, c11) ) .
const( loc_at( c11_3, c11) ) .
const( loc_at( c11_4, c11) ) .
const( loc_at( c12_1, c12) ) .
const( loc_at( c12_2, c12) ) .
const( loc_at( c12_3, c12) ) .
const( loc_at( c12_4, c12) ) .
const( loc_at( c13_1, c13) ) .
const( loc_at( c13_2, c13) ) .
const( loc_at( c13_3, c13) ) .
const( loc_at( c13_4, c13) ) .
const( loc_at( c14_1, c13) ) .
const( loc_at( c14_2, c13) ) .
const( loc_at( c14_3, c13) ) .
const( loc_at( c14_4, c13) ) .
const( loc_at( c15_1, c13) ) .
const( loc_at( c15_2, c13) ) .
const( loc_at( c15_3, c13) ) .
const( loc_at( c15_4, c13) ) .
const( loc_at( c16_1, c13) ) .
const( loc_at( c16_2, c13) ) .
const( loc_at( c16_3, c13) ) .
const( loc_at( c16_4, c13) ) .
const( loc_at( c17_1, c13) ) .
const( loc_at( c17_2, c13) ) .
const( loc_at( c17_3, c13) ) .
const( loc_at( c17_4, c13) ) .
const( loc_at( c18_1, c13) ) .
const( loc_at( c18_2, c13) ) .
const( loc_at( c18_3, c13) ) .
const( loc_at( c18_4, c13) ) .
 

truck_city(tr1, c14).
truck_city(tr2, c4).
truck_city(tr3, c10).
truck_city(tr4, c8).
truck_city(tr5, c14).
truck_city(tr6, c1).
truck_city(tr7, c3).
truck_city(tr8, c14).
truck_city(tr9, c1).
truck_city(tr10, c2).
truck_city(tr11, c3).
truck_city(tr12, c4).
truck_city(tr13, c5).
truck_city(tr14, c6).
truck_city(tr15, c7).
truck_city(tr16, c8).
truck_city(tr17, c9).
truck_city(tr18, c10).
truck_city(tr19, c11).
truck_city(tr20, c12).
truck_city(tr21, c13).
truck_city(tr22, c14).
truck_city(tr23, c15).
truck_city(tr24, c16).
truck_city(tr25, c17).
truck_city(tr26, c18).

initial([at(pl2,c10_4),at(pl1,c18_4),at(tr26,c18_2),at(tr25,c17_1),at(tr24,c16_1),at(tr23,c15_2),at(tr22,c14_2),at(tr21,c13_1),
	at(tr20,c12_3),at(tr19,c11_1),at(tr18,c10_1),at(tr17,c9_1),at(tr16,c8_2),at(tr15,c7_1),at(tr14,c6_1),at(tr13,c5_1),
	at(tr12,c4_2),at(tr11,c3_2),at(tr10,c2_2),at(tr9,c1_2),at(tr8,c14_1),at(tr7,c3_4),at(tr6,c1_1),at(tr5,c14_1),at(tr4,c8_1),
	at(tr3,c10_3),at(tr2,c4_3),at(tr1,c14_3),at(p16,c16_2),at(p15,c14_3),at(p14,c14_1),at(p13,c14_4),at(p12,c6_1),
	at(p11,c3_1),at(p10,c9_4),at(p9,c17_3),at(p8,c15_2),at(p7,c8_4),at(p6,c6_1),at(p5,c10_3),at(p4,c15_2),at(p3,c16_3),
	at(p2,c11_2),at(p1,c7_3),
	out(p1), out(p2), out(p3), out(p4), out(p5), out(p6), out(p7),
	out(p8), out(p9), out(p10), out(p11), out(p12), out(p13), out(p14),out(p15), out(p16)]):-!.

goal([at(p16, c14_3), at(p15, c14_2),at(p14, c8_4),at(p13, c4_3), at(p12, c13_4),at(p11, c12_2),
	at(p10, c16_2),at(p9, c17_4),at(p8, c8_1),at(p7, c8_2),
	out(p7), out(p8), out(p9), out(p10), out(p11), out(p12), out(p13), out(p14),out(p15), out(p16)]):-!.


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
	member(Object, [p1, p2, p3, p4, p5, p6]), 
	locations(Locations), 
	member(Location, Locations).

not_determined(out(Object)):-
	member(Object, [p1, p2]).

not_determined(in(Object, Truck)):-
	member(Object, [p1, p2, p3, p4, p5, p6]), 
	trucks(Trucks),
	member(Truck, Trucks).

not_determined(in(Object, Airplane)):-
	member(Object, [p1, p2, p3, p4, p5, p6]), 
	airplanes(Airplanes),
	member(Airplane, Airplanes).








