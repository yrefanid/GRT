packages( [p29,p28,p27,p26,p25
,p24,p23,p22,p21,p20,p19
,p18,p17,p16,p15,p14,p13
,p12,p11,p10,p9,p8,p7
,p6,p5,p4,p3,p2,p1] ) .
cities( [c11,c10,c9,c8,c7,c6,c5,c4,c3,c2,c1] ) .
airports( [c11_2,c10_2,c9_2,c8_2,c7_2,c6_2,c5_2
,c4_2,c3_2,c2_2,c1_2] ) .
locations( [c11_1,c10_1,c9_1,c8_1
,c7_1,c6_1,c5_1,c4_1,c3_1,c2_1,c1_1
,c11_2,c10_2,c9_2,c8_2,c7_2,c6_2,c5_2
,c4_2,c3_2,c2_2,c1_2 ] ) .
trucks( [tr47,tr46,tr45,tr44,tr43,tr42,tr41
,tr40,tr39,tr38,tr37,tr36,tr35,tr34
,tr33,tr32,tr31,tr30,tr29,tr28,tr27
,tr26,tr25,tr24,tr23,tr22,tr21,tr20
,tr19,tr18,tr17,tr16,tr15,tr14,tr13
,tr12,tr11,tr10,tr9,tr8,tr7,tr6,tr5
,tr4,tr3,tr2,tr1] ) .
airplanes( [pl8,pl7,pl6,pl5,pl4
,pl3,pl2,pl1] ) .



def( at( Package , Location ) ) :- packages( D1 ) , locations( D2 ) , member( Package , D1 ) , member( Location , D2 ) .  
def( at( Airplane , Airport ) ) :- airplanes( D1 ) , airports( D2 ) , member( Airplane , D1 ) , member( Airport , D2 ) .  
def( out( Package ) ) :- packages( D1 ) , member( Package , D1 ) .
def( in( Package , Truck ) ) :- packages( D1 ) , trucks( D2 ) , member( Package , D1 ) , member( Truck , D2 ) .
def( in( Package , Airplane ) ) :- packages( D1 ) , airplanes( D2 ) , member( Package , D1 ) , member( Airplane , D2 ) .
def( at( Truck , Location ) ) :- trucks( D1 ) , locations( D2 ) , member( Truck , D1 ) , member( Location , D2 ), truck_city(Truck, City), const(loc_at(Location, City)) .


const( loc_at( c1_1, c1) ) .
const( loc_at( c1_2, c1) ) .
const( loc_at( c2_1, c2) ) .
const( loc_at( c2_2, c2) ) .
const( loc_at( c3_1, c3) ) .
const( loc_at( c3_2, c3) ) .
const( loc_at( c4_1, c4) ) .
const( loc_at( c4_2, c4) ) .
const( loc_at( c5_1, c5) ) .
const( loc_at( c5_2, c5) ) .
const( loc_at( c6_1, c6) ) .
const( loc_at( c6_2, c6) ) .
const( loc_at( c7_1, c7) ) .
const( loc_at( c7_2, c7) ) .
const( loc_at( c8_1, c8) ) .
const( loc_at( c8_2, c8) ) .
const( loc_at( c9_1, c9) ) .
const( loc_at( c9_2, c9) ) .
const( loc_at( c10_1, c10) ) .
const( loc_at( c10_2, c10) ) .
const( loc_at( c11_1, c11) ) .
const( loc_at( c11_2, c11) ) .


truck_city(tr47,c11).
truck_city(tr46,c10).
truck_city(tr45,c9).
truck_city(tr44,c8).
truck_city(tr43,c7).
truck_city(tr42,c6).
truck_city(tr41,c5).
truck_city(tr40,c4).
truck_city(tr39,c3).
truck_city(tr38,c2).
truck_city(tr37,c1).
truck_city(tr36,c1).
truck_city(tr35,c4).
truck_city(tr34,c7).
truck_city(tr33,c7).
truck_city(tr32,c10).
truck_city(tr31,c3).
truck_city(tr30,c6).
truck_city(tr29,c6).
truck_city(tr28,c10).
truck_city(tr27,c10).
truck_city(tr26,c8).
truck_city(tr25,c10).
truck_city(tr24,c6).
truck_city(tr23,c5).
truck_city(tr22,c9).
truck_city(tr21,c4).
truck_city(tr20,c2).
truck_city(tr19,c8).
truck_city(tr18,c4).
truck_city(tr17,c3).
truck_city(tr16,c2).
truck_city(tr15,c2).
truck_city(tr14,c6).
truck_city(tr13,c10).
truck_city(tr12,c10).
truck_city(tr11,c7).
truck_city(tr10,c2).
truck_city(tr9,c3).
truck_city(tr8,c1).
truck_city(tr7,c3).
truck_city(tr6,c8).
truck_city(tr5,c7).
truck_city(tr4,c8).
truck_city(tr3,c1).
truck_city(tr2,c1).
truck_city(tr1,c2).





initial([at(pl8,c9_2),at(pl7,c4_2),at(pl6,c1_2),at(pl5,c2_2),at(pl4,c4_2),at(pl3,c11_2),at(pl2,c2_2),at(pl1,c6_2),
at(tr47,c11_1),at(tr46,c10_1),at(tr45,c9_1),at(tr44,c8_1),at(tr43,c7_1),at(tr42,c6_1),at(tr41,c5_1),
at(tr40,c4_1),at(tr39,c3_1),at(tr38,c2_1),at(tr37,c1_1),at(tr36,c1_1),at(tr35,c4_1),at(tr34,c7_1),
at(tr33,c7_1),at(tr32,c10_2),at(tr31,c3_2),at(tr30,c6_2),at(tr29,c6_2),at(tr28,c10_1),at(tr27,c10_1),at(tr26,c8_1),at(tr25,c10_1),at(tr24,c6_1),at(tr23,c5_2),at(tr22,c9_2),at(tr21,c4_2),
at(tr20,c2_2),at(tr19,c8_1),at(tr18,c4_2),at(tr17,c3_1),at(tr16,c2_1),at(tr15,c2_2),at(tr14,c6_2),at(tr13,c10_2),
at(tr12,c10_2),at(tr11,c7_2),at(tr10,c2_1),at(tr9,c3_2),at(tr8,c1_2),at(tr7,c3_1),at(tr6,c8_2),at(tr5,c7_1),
at(tr4,c8_2),at(tr3,c1_2),at(tr2,c1_1),at(tr1,c2_1),
at(p29,c10_1),at(p28,c4_2),at(p27,c10_2),at(p26,c6_1),at(p25,c6_2),at(p24,c8_2),at(p23,c1_1),at(p22,c9_1),at(p21,c9_2),
at(p20,c6_2),at(p19,c9_1),at(p18,c2_2),at(p17,c4_2),at(p16,c2_2),at(p15,c1_2),at(p14,c9_1),at(p13,c7_1),
at(p12,c9_2),at(p11,c6_2),at(p10,c8_2),at(p9,c1_2),at(p8,c8_1),at(p7,c8_2),at(p6,c1_2),at(p5,c2_2),at(p4,c10_2),at(p3,c11_1),
at(p2,c11_1),at(p1,c11_2),
out(p1), out(p2), out(p3), out(p4), out(p5), out(p6), out(p7), out(p8), out(p9), out(p10), 
out(p11), out(p12), out(p13), out(p14), out(p15), out(p16), out(p17), out(p18), out(p19), out(p20),
out(p21), out(p22), out(p23), out(p24), out(p25), out(p26), out(p27), out(p28), out(p29)]):-!.


goal([at(p29,c5_2),at(p28,c11_2),at(p27,c10_1),at(p26,c9_1),at(p25,c4_1),at(p24,c8_2),
at(p23,c10_2),at(p22,c1_2),at(p21,c1_1),at(p20,c4_1),at(p19,c6_1),at(p18,c9_1)
,at(p17,c4_1),at(p16,c11_1),at(p15,c2_2),at(p14,c8_2),at(p13,c10_2),
at(p12,c11_2),at(p11,c2_2), 
out(p11), out(p12), out(p13), out(p14), out(p15), out(p16), out(p17), out(p18), out(p19), out(p20),
out(p21), out(p22), out(p23), out(p24), out(p25), out(p26), out(p27), out(p28), out(p29)]):-!.

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
	member(Object, [p1, p2, p3, p4, p5, p6, p7, p8, p9, p10]), 
	locations(Locations), 
	member(Location, Locations).

not_determined(out(Object)):-
	member(Object, [p1, p2, p3, p4, p5, p6, p7, p8, p9, p10]). 


not_determined(in(Object, Truck)):-
	member(Object, [p1, p2, p3, p4, p5, p6, p7, p8, p9, p10]), 
	trucks(Trucks),
	member(Truck, Trucks).

not_determined(in(Object, Airplane)):-
	member(Object, [p1, p2, p3, p4, p5, p6, p7, p8, p9, p10]), 
	airplanes(Airplanes),
	member(Airplane, Airplanes).






