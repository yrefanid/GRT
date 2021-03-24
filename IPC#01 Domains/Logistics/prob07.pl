
packages( [ p1 , p2 , p3 , p4, p5, p6, p7, p8, p9, p10] ) .
cities( [ c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11] ) .
airports( [ c1_2, c2_2, c3_2, c4_2, c5_2, c6_2, c7_2, c8_2, c9_2, c10_2, c11_2] ) .
locations( [ c1_1, c1_2, c2_1, c2_2, c3_1, c3_2, c4_1, c4_2, c5_1, c5_2, c6_1, c6_2, c7_1, c7_2, 
	c8_1, c8_2, c9_1, c9_2, c10_1, c10_2, c11_1, c11_2 ] ) .
trucks( [ tr1 , tr2 , tr3, tr4, tr5, tr6, tr7, tr8, tr9, tr10, tr11 ] ) .
airplanes( [ pl1, pl2, pl3, pl4, pl5, pl6 ] ) .

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



truck_city(tr1, c1).
truck_city(tr2, c2).
truck_city(tr3, c3).
truck_city(tr4, c4).
truck_city(tr5, c5).
truck_city(tr6, c6).
truck_city(tr7, c7).
truck_city(tr8, c8).
truck_city(tr9, c9).
truck_city(tr10, c10).
truck_city(tr11, c11).

initial([at(pl6,c2_2), at(pl5,c5_2), at(pl4,c6_2),at(pl3,c9_2), at(pl2,c8_2), at(pl1,c1_2), at(tr11,c11_1), at(tr10,c10_1),
 at(tr9,c9_1), at(tr8,c8_1), at(tr7,c7_1),  at(tr6,c6_1), at(tr5,c5_1), at(tr4,c4_1), at(tr3,c3_1), at(tr2,c2_1), at(tr1,c1_1), 
at(p10,c6_2), at(p9,c5_2), at(p8,c10_2), at(p7,c6_2), at(p6,c1_2), at(p5,c4_1), at(p4,c4_2), at(p3,c1_2), at(p2,c10_2), at(p1,c8_1),
out(p10), out(p9), out(p8), out(p7), out(p6), out(p5), out(p4), out(p3), out(p2), out(p1)]):-!.

goal([at(p10,c9_1),at(p9,c9_2),at(p8,c1_2),at(p7,c5_1),at(p6,c10_2),at(p5,c7_1),
out(p10), out(p9), out(p8), out(p7), out(p6), out(p5)]):-!.


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
	member(Object, [p1, p2, p3, p4]), 
	locations(Locations), 
	member(Location, Locations).

not_determined(out(Object)):-
	member(Object, [p1, p2, p3, p4]).

not_determined(in(Object, Truck)):-
	member(Object, [p1, p2, p3, p4]), 
	trucks(Trucks),
	member(Truck, Trucks).

not_determined(in(Object, Airplane)):-
	member(Object, [p1, p2, p3, p4]), 
	airplanes(Airplanes),
	member(Airplane, Airplanes).



