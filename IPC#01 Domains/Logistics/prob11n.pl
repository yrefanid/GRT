packages( [ p1 , p2 , p3 , p4, p5, p6, p7, p8] ) .
cities( [ c1, c2, c3] ) .
airports( [ c1_3, c2_3, c3_3] ) .
locations( [ c1_1, c1_2, c1_3, c2_1, c2_2, c2_3, c3_1, c3_2, c3_3 ] ) .
trucks( [ tr1 , tr2 , tr3, tr4, tr5, tr6, tr7, tr8, tr9, tr10, tr11,
	 tr12, tr13, tr14, tr15, tr16, tr17, tr18, tr19,  tr20, tr21, tr22] ) .
airplanes( [ pl1, pl2, pl3, pl4, pl5, pl6 ] ) .
 
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

truck_city(tr1, c2).
truck_city(tr2, c1).
truck_city(tr3, c2).
truck_city(tr4, c3).
truck_city(tr5, c2).
truck_city(tr6, c2).
truck_city(tr7, c2).
truck_city(tr8, c3).
truck_city(tr9, c2).
truck_city(tr10, c3).
truck_city(tr11, c3).
truck_city(tr12, c2).
truck_city(tr13, c1).
truck_city(tr14, c2).
truck_city(tr15, c2).
truck_city(tr16, c2).
truck_city(tr17, c2).
truck_city(tr18, c1).
truck_city(tr19, c2).
truck_city(tr20, c1).
truck_city(tr21, c2).
truck_city(tr22, c3).


initial([at(pl6,c2_3), at(pl5,c1_3), at(pl4,c3_3), at(pl3, c2_3), at(pl2, c2_3), at(pl1,c1_3), at(tr22, c3_2), at(tr21,c2_1),
	 at(tr20,c1_2),  at(tr19,c2_3), at(tr18,c1_2), at(tr17,c2_2), at(tr16,c2_1), at(tr15,c2_3), at(tr14,c2_2),
	 at(tr13,c1_2),at(tr12,c2_2), at(tr11,c3_3), at(tr10,c3_1), at(tr9,c2_3), at(tr8,c3_3), at(tr7,c2_3),
	at(tr6,c2_3), at(tr5,c2_3), at(tr4,c3_2),at(tr3,c2_2), at(tr2,c1_1), at(tr1,c2_3), at(p8,c1_2), at(p7,c2_1),
	at(p6,c3_2),at(p5,c1_3),at(p4,c3_3),at(p3,c2_2), at(p2,c3_2), at(p1,c1_3),
	out(p1), out(p2), out(p3), out(p4), out(p5), out(p6), out(p7), out(p8)]):-!.

goal([at(p8, c3_3), at(p7,c3_3), at(p6, c3_2), at(p5, c1_3), at(p4, c3_3), at(p3, c1_2), at(p2, c2_3), at(p1, c1_1),
	out(p1), out(p2), out(p3), out(p4), out(p5), out(p6), out(p7), out(p8)]):-!.	

goal1( List ):-findall(X, ndt(X), List).

ndt(at(pl6,c2_3)).
 ndt(at(pl5,c1_3)).
 ndt(at(pl4,c3_3)).
 ndt(at(pl3, c2_3)).
 ndt(at(pl2, c2_3)).
 ndt(at(pl1,c1_3)).
 

ndt(at(tr22, c3_2)).
 ndt(at(tr21,c2_1)).
 ndt(at(tr20,c1_2)).
  ndt(at(tr19,c2_3)).
 ndt(at(tr18,c1_2)).
 ndt(at(tr17,c2_2)).
 ndt(at(tr16,c2_1)).
 ndt(at(tr15,c2_3)).
 ndt(at(tr14,c2_2)).
  ndt(at(tr13,c1_2)).
ndt(at(tr12,c2_2)).
 ndt(at(tr11,c3_3)).
 ndt(at(tr10,c3_1)).
 ndt(at(tr9,c2_3)).
 ndt(at(tr8,c3_3)).
 ndt(at(tr7,c2_3)).
 ndt(at(tr6,c2_3)).
 ndt(at(tr5,c2_3)).
 ndt(at(tr4,c3_2)).
ndt(at(tr3,c2_2)).
 ndt(at(tr2,c1_1)).
 ndt(at(tr1,c2_3)).


