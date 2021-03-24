packages( [ p1 , p2 , p3 , p4 , p5 , p6 , p7, p8, p9] ) .
cities( [ c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14] ) .
airports( [ c1_3, c2_3, c3_3, c4_3, c5_3, c6_3, c7_3, c8_3, c9_3, c10_3, c11_3, c12_3, c13_3, c14_3] ) .
locations( [ c1_1, c1_2, c1_3, c2_1, c2_2, c2_3, c3_1, c3_2, c3_3, c4_1, c4_2, c4_3, c5_1, c5_2, c5_3, c6_1, c6_2 , c6_3,c7_1, c7_2, c7_3, 
	c8_1, c8_2, c8_3, c9_1, c9_2, c9_3, c10_1, c10_2, c10_3, c11_1, c11_2, c11_3, c12_1, c12_2, c12_3, c13_1, c13_2 , c13_3,c14_1, c14_2, c14_3 ] ) .
trucks( [ tr1 , tr2 , tr3, tr4, tr5, tr6, tr7, tr8, tr9, tr10, tr11, tr12, tr13, tr14 ] ) .
airplanes( [ pl1, pl2, pl3, pl4 ] ) .
 
def( at( Package , Location ) ) :- packages( D1 ) , locations( D2 ) , member( Package , D1 ) , member( Location , D2 ) .  
def( at( Airplane , Airport ) ) :- airplanes( D1 ) , airports( D2 ) , member( Airplane , D1 ) , member( Airport , D2 ) .  
def( out( Package ) ) :- packages( D1 ) , member( Package , D1 ) .
def( in( Package , Truck ) ) :- packages( D1 ) , trucks( D2 ) , member( Package , D1 ) , member( Truck , D2 ) .
def( in( Package , Airplane ) ) :- packages( D1 ) , airplanes( D2 ) , member( Package , D1 ) , member( Airplane , D2 ) .
def( at( Truck , Location ) ) :- trucks( D1 ) , locations( D2 ) , member( Truck , D1 ) , member( Location , D2 ), truck_city(Truck, City), const(loc_at(Location, City)) .


const( loc_at( c1_1, c1) ) .
const( loc_at( c1_2, c1) ) .
const( loc_at( c1_3, c1) ) .
const( loc_at( c2_1, c2) ) .
const( loc_at( c2_2, c2) ) .
const( loc_at( c2_3, c2) ) .
const( loc_at( c3_1, c3) ) .
const( loc_at( c3_2, c3) ) .
const( loc_at( c3_3, c3) ) .
const( loc_at( c4_1, c4) ) .
const( loc_at( c4_2, c4) ) .
const( loc_at( c4_3, c4) ) .
const( loc_at( c5_1, c5) ) .
const( loc_at( c5_2, c5) ) .
const( loc_at( c5_3, c5) ) .
const( loc_at( c6_1, c6) ) .
const( loc_at( c6_2, c6) ) .
const( loc_at( c6_3, c6) ) .
const( loc_at( c7_1, c7) ) .
const( loc_at( c7_2, c7) ) .
const( loc_at( c7_3, c7) ) .
const( loc_at( c8_1, c8) ) .
const( loc_at( c8_2, c8) ) .
const( loc_at( c8_3, c8) ) .
const( loc_at( c9_1, c9) ) .
const( loc_at( c9_2, c9) ) .
const( loc_at( c9_3, c9) ) .
const( loc_at( c10_1, c10) ) .
const( loc_at( c10_2, c10) ) .
const( loc_at( c10_3, c10) ) .
const( loc_at( c11_1, c11) ) .
const( loc_at( c11_2, c11) ) .
const( loc_at( c11_3, c11) ) .
const( loc_at( c12_1, c12) ) .
const( loc_at( c12_2, c12) ) .
const( loc_at( c12_3, c12) ) .
const( loc_at( c13_1, c13) ) .
const( loc_at( c13_2, c13) ) .
const( loc_at( c13_3, c13) ) .
const( loc_at( c14_1, c14) ) .
const( loc_at( c14_2, c14) ) .
const( loc_at( c14_3, c14) ) .

 
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
truck_city(tr12, c12).
truck_city(tr13, c13).
truck_city(tr14, c14).

initial( [ at( pl4 , c10_3 ) , at( pl3 , c1_3 ) ,at( pl2 , c11_3 ) , at( pl1 , c11_3 ) ,
	 at( tr14 , c14_1 ) , at( tr13 , c13_1 ) , at( tr12 , c12_1 ),at( tr11 , c11_1 ) , at( tr10 , c10_1 ) , 
	at( tr9 , c9_2 ),at( tr8 , c8_2 ),at( tr7 , c7_1 ),at( tr6 , c6_2 ),
	at( tr5 , c5_1 ) , at( tr4 , c4_2 ),at( tr3 , c3_2 ) , at( tr2 , c2_1 ) , at( tr1 , c1_1 ),
	at(p9, c4_2), at( p8 , c9_1 ) , at( p7 , c1_2 ) , at( p6 , c9_1 ) , at( p5 , c12_2 ) ,
	at( p4 , c8_1 ) , at( p3 , c12_3 ) , at( p2 , c12_2 ) , at( p1 , c8_3) ,
	out(p1), out(p2), out(p3), out(p4), out(p5), out(p6), out(p7), out(p8), out(p9)] ) :- ! .


goal( [ at( p9 , c11_2 ) , at( p8 , c5_3 ) , at( p7 , c10_3 ) , at( p6 , c9_3 ) , at( p5 , c10_1 ) , 
	at( p4 , c13_1 ) , at( p3 , c1_3 ) ,
	out(p3), out(p4), out(p5), out(p6), out(p7), out(p8), out(p9)] ):-! .

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
	member(Object, [p1, p2]), 
	locations(Locations), 
	member(Location, Locations).

not_determined(out(Object)):-
	member(Object, [p1, p2]).

not_determined(in(Object, Truck)):-
	member(Object, [p1, p2]),
	trucks(Trucks),
	member(Truck, Trucks).

not_determined(in(Object, Airplane)):-
	member(Object, [p1, p2]),
	airplanes(Airplanes),
	member(Airplane, Airplanes).






