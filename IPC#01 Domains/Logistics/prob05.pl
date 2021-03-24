packages( [ p1 , p2 , p3 , p4] ) .
cities( [ c1, c2, c3, c4, c5, c6, c7, c8, c9] ) .
airports( [ c1_2, c2_2, c3_2, c4_2, c5_2, c6_2, c7_2, c8_2, c9_2] ) .
locations( [ c1_1, c1_2, c2_1, c2_2, c3_1, c3_2, c4_1, c4_2, c5_1, c5_2, c6_1, c6_2, c7_1, c7_2, 
	c8_1, c8_2, c9_1, c9_2 ] ) .
trucks( [ tr1 , tr2 , tr3, tr4, tr5, tr6, tr7, tr8, tr9, tr10, tr11 ] ) .
airplanes( [ pl1 ] ) .
 
def( at( Package , Location ) ) :- ps( D1 ) , locations( D2 ) , member( Package , D1 ) , member( Location , D2 ) .  
def( at( Airplane , Airport ) ) :- airplanes( D1 ) , airports( D2 ) , member( Airplane , D1 ) , member( Airport , D2 ) .  
def( out( Package ) ) :- ps( D1 ) , member( Package , D1 ) .
def( in( Package , Truck ) ) :- ps( D1 ) , trucks( D2 ) , member( Package , D1 ) , member( Truck , D2 ) .
def( in( Package , Airplane ) ) :- ps( D1 ) , airplanes( D2 ) , member( Package , D1 ) , member( Airplane , D2 ) .
def( at( Truck , Location ) ) :- trucks( D1 ) , locations( D2 ) , member( Truck , D1 ) , member( Location , D2 ), truck_c(Truck, City), const(loc_at(Location, City)) .

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
 
truck_c(tr1, c3).
truck_c(tr2, c8).
truck_c(tr3, c1).
truck_c(tr4, c2).
truck_c(tr5, c3).
truck_c(tr6, c4).
truck_c(tr7, c5).
truck_c(tr8, c6).
truck_c(tr9, c7).
truck_c(tr10, c8).
truck_c(tr11, c9).


initial([at pl1, c8_2), at(tr11,c9_1), at(tr10, c8_1), at(tr9, c7_1),at(tr8,c6_1), at(tr7,c5_1), at(tr6,c4_1),
	at(tr5,c3_1), at(tr4,c2_1), at(tr3,c1_1), at(tr2,c8_1), at(tr1,c3_2),
	at(p4,c8_1), at(p3,c9_1),at(p2,c8_2),at(p1,c6_2),
	out(p4), out(p3), out(p2), out(p1)]):-!.

goal([at(p4,c2_2), at(p3,c7_2), at(p2,c3_1), at(p1,c9_2), out(p4), out(p3), out(p2), out(p1)]):-!.


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

