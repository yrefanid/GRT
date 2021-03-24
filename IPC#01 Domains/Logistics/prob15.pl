packages( [p23,p22,p21,p20,p19
,p18,p17,p16,p15,p14,p13
,p12,p11,p10,p9,p8,p7
,p6,p5,p4,p3,p2,p1] ) .
cities( [c3,c2,c1] ) .
airports( [c3_6,c2_6,c1_6] ) .
locations( [c3_5,c3_4,c3_3
,c3_2,c3_1,c2_5,c2_4,c2_3,c2_2,c2_1
,c1_5,c1_4,c1_3,c1_2,c1_1,c3_6,c2_6
,c1_6 ] ) .
trucks( [tr5,tr4,tr3,tr2,tr1] ) .
airplanes( [pl7,pl6
,pl5,pl4,pl3,pl2,pl1] ) .


def( at( Package , Location ) ) :- packages( D1 ) , locations( D2 ) , member( Package , D1 ) , member( Location , D2 ) .  
def( at( Airplane , Airport ) ) :- airplanes( D1 ) , airports( D2 ) , member( Airplane , D1 ) , member( Airport , D2 ) .  
def( out( Package ) ) :- packages( D1 ) , member( Package , D1 ) .
def( in( Package , Truck ) ) :- packages( D1 ) , trucks( D2 ) , member( Package , D1 ) , member( Truck , D2 ) .
def( in( Package , Airplane ) ) :- packages( D1 ) , airplanes( D2 ) , member( Package , D1 ) , member( Airplane , D2 ) .
def( at( Truck , Location ) ) :- trucks( D1 ) , locations( D2 ) , member( Truck , D1 ) , member( Location , D2 ), truck_city(Truck, City), const(loc_at(Location, City)) .


const(loc_at(c3_5, c3)).
const(loc_at(c3_4, c3)).
const(loc_at(c3_3, c3)).
const(loc_at(c3_2, c3)).
const(loc_at(c3_1, c3)).
const(loc_at(c2_5, c2)).
const(loc_at(c2_4, c2)).
const(loc_at(c2_3, c2)).
const(loc_at(c2_2, c2)).
const(loc_at(c2_1, c2)).
onst(loc_at(c1_5, c1)).
const(loc_at(c1_4, c1)).
const(loc_at(c1_3, c1)).
const(loc_at(c1_2, c1)).
const(loc_at(c1_1, c1)).
const(loc_at(c3_6, c3)).
const(loc_at(c2_6, c2)).
const(loc_at(c1_6, c1)).


truck_city(tr5,c3).
truck_city(tr4,c2).
truck_city(tr3,c1).
truck_city(tr2,c1).
truck_city(tr1,c1).


initial([at(pl7,c1_6),at(pl6,c2_6),at(pl5,c1_6),at(pl4,c1_6),at(pl3,c3_6),
at(pl2,c1_6),at(pl1,c2_6),at(tr5,c3_4),at(tr4,c2_3),at(tr3,c1_5),at(tr2,c1_3),
at(tr1,c1_6),at(p23,c1_5),at(p22,c1_5),at(p21,c2_4),at(p20,c2_3),at(p19,c1_2),
at(p18,c3_3),at(p17,c2_3),at(p16,c3_5),at(p15,c2_2),at(p14,c2_1),at(p13,c3_4),
at(p12,c1_6),at(p11,c1_4),at(p10,c3_3),at(p9,c3_3),at(p8,c1_2),at(p7,c1_4),
at(p6,c1_4),at(p5,c3_1),at(p4,c2_1),at(p3,c1_5),at(p2,c3_3),at(p1,c1_2),
out(23),out(22),out(21),out(20),out(19),out(18),out(17),out(16),out(15),
out(14),out(13),out(12),out(11),out(10),out(9),out(8),out(7),out(6),
out(5),out(4),out(3),out(2),out(1)]):-!.




goal([at(p23,c2_3),at(p22,c1_5),at(p21,c1_6),at(p20,c1_1),at(p19,c1_3),at(p18,c1_3),
at(p17,c1_5),at(p16,c1_1),at(p15,c3_3),at(p14,c1_5),at(p13,c2_5),
at(p12,c3_2),at(p11,c2_6),at(p10,c1_6),
out(23),out(22),out(21),out(20),out(19),out(18),out(17),out(16),out(15),
out(14),out(13),out(12),out(11),out(10)]):-!.


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






