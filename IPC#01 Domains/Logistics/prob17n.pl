packages( [p15,p14,p13,p12,p11,p10,p9,p8,p7,p6,p5,p4,p3,p2,p1] ) .
cities( [c4,c3,c2,c1] ) .
airports( [c4_3,c3_3,c2_3,
c1_3] ) .
locations( [c4_2,c4_1,c3_2,c3_1,
c2_2,c2_1,c1_2,c1_1,c4_3,c3_3,c2_3,
c1_3 ] ) .
trucks( [tr45,
tr44,tr43,tr42,tr41,tr40,tr39,tr38,
tr37,tr36,tr35,tr34,tr33,tr32,tr31,
tr30,tr29,tr28,tr27,tr26,tr25,tr24,
tr23,tr22,tr21,tr20,tr19,tr18,tr17,
tr16,tr15,tr14,tr13,tr12,tr11,tr10,tr9,
tr8,tr7,tr6,tr5,tr4,tr3,tr2,tr1 ] ) .
airplanes( [pl5,pl4,pl3,pl2,pl1 ] ) .


def( at( Package , Location ) ) :- packages( D1 ) , locations( D2 ) , member( Package , D1 ) , member( Location , D2 ) .  
def( at( Airplane , Airport ) ) :- airplanes( D1 ) , airports( D2 ) , member( Airplane , D1 ) , member( Airport , D2 ) .  
def( out( Package ) ) :- packages( D1 ) , member( Package , D1 ) .
def( in( Package , Truck ) ) :- packages( D1 ) , trucks( D2 ) , member( Package , D1 ) , member( Truck , D2 ) .
def( in( Package , Airplane ) ) :- packages( D1 ) , airplanes( D2 ) , member( Package , D1 ) , member( Airplane , D2 ) .
def( at( Truck , Location ) ) :- trucks( D1 ) , locations( D2 ) , member( Truck , D1 ) , member( Location , D2 ), truck_city(Truck, City), const(loc_at(Location, City)) .


const(loc_at(c4_2, c4)).
const(loc_at(c4_1, c4)).
const(loc_at(c3_2, c3)).
const(loc_at(c3_1, c3)).
const(loc_at(c2_2, c2)).
const(loc_at(c2_1, c2)).
const(loc_at(c1_2, c1)).
const(loc_at(c1_1, c1)).
const(loc_at(c4_3, c4)).
const(loc_at(c3_3, c3)).
const(loc_at(c2_3, c2)).
const(loc_at(c1_3, c1)).


truck_city(tr45,c4).
truck_city(tr44,c3).
truck_city(tr43,c2).
truck_city(tr42,c1).
truck_city(tr41,c1).
truck_city(tr40,c3).
truck_city(tr39,c2).
truck_city(tr38,c2).
truck_city(tr37,c4).
truck_city(tr36,c3).
truck_city(tr35,c1).
truck_city(tr34,c3).
truck_city(tr33,c3).
truck_city(tr32,c2).
truck_city(tr31,c3).
truck_city(tr30,c3).
truck_city(tr29,c2).
truck_city(tr28,c1).
truck_city(tr27,c4).
truck_city(tr26,c3).
truck_city(tr25,c4).
truck_city(tr24,c2).
truck_city(tr23,c4).
truck_city(tr22,c1).
truck_city(tr21,c3).
truck_city(tr20,c4).
truck_city(tr19,c3).
truck_city(tr18,c1).
truck_city(tr17,c4).
truck_city(tr16,c3).
truck_city(tr15,c3).
truck_city(tr14,c4).
truck_city(tr13,c2).
truck_city(tr12,c2).
truck_city(tr11,c1).
truck_city(tr10,c1).
truck_city(tr9,c1).
truck_city(tr8,c1).
truck_city(tr7,c1).
truck_city(tr6,c2).
truck_city(tr5,c3).
truck_city(tr4,c4).
truck_city(tr3,c1).
truck_city(tr2,c1).
truck_city(tr1,c4).


initial([at(pl5,c1_3),at(pl4,c4_3),at(pl3,c4_3),at(pl2,c3_3),at(pl1,c4_3),
at(tr45,c4_2),at(tr44,c3_2),at(tr43,c2_2),at(tr42,c1_1),at(tr41,c1_3),at(tr40,c3_2),at(tr39,c2_1),at(tr38,c2_3),
at(tr37,c4_2),at(tr36,c3_2),at(tr35,c1_1),at(tr34,c3_3),at(tr33,c3_3),at(tr32,c2_1),at(tr31,c3_1),
at(tr30,c3_2),at(tr29,c2_2),at(tr28,c1_3),at(tr27,c4_1),at(tr26,c3_2),at(tr25,c4_3),at(tr24,c2_1),
at(tr23,c4_1),at(tr22,c1_1),at(tr21,c3_2),at(tr20,c4_3),at(tr19,c3_3),at(tr18,c1_2),at(tr17,c4_2),
at(tr16,c3_1),at(tr15,c3_2),at(tr14,c4_3),at(tr13,c2_2),at(tr12,c2_1),at(tr11,c1_1),at(tr10,c1_2),
at(tr9,c1_2),at(tr8,c1_1),at(tr7,c1_2),at(tr6,c2_2),at(tr5,c3_1),at(tr4,c4_1),at(tr3,c1_3),at(tr2,c1_3),at(tr1,c4_2),
at(p15,c1_2),at(p14,c3_1),at(p13,c1_1),at(p12,c1_1),at(p11,c3_3),at(p10,c4_2),at(p9,c3_2),at(p8,c4_2),at(p7,c4_3),at(p6,c3_2),at(p5,c2_2),at(p4,c2_3),at(p3,c1_3),at(p2,c4_2),at(p1,c2_1),
out(p15),out(p14),out(p13),out(p12),out(p11),out(p10),out(p9),out(p8),out(p7),out(p6),out(p5),out(p4),out(p3),out(p2),out(p1)
]):-!.

goal([at(p15,c4_2),at(p14,c4_2),at(p13,c4_3),at(p12,c2_2),at(p11,c2_1),at(p10,c4_2),at(p9,c4_2),at(p8,c4_2),out(p15),out(p14),out(p13),out(p12),out(p11),out(p10),out(p9),out(p8)]):-!.

goal1( List ):-findall(X, ndt(X), List).


ndt(at(pl5,c2_3)).
ndt(at(pl4,c4_3)).
ndt(at(pl3,c4_3)).
ndt(at(pl2,c2_3)).
ndt(at(pl1,c4_3)).
ndt(at(tr45,c4_2)).
ndt(at(tr44,c3_2)).
ndt(at(tr43,c2_2)).
ndt(at(tr42,c1_1)).
ndt(at(tr41,c1_3)).
ndt(at(tr40,c3_2)).
ndt(at(tr39,c2_1)).
ndt(at(tr38,c2_3)).
ndt(at(tr37,c4_2)).
ndt(at(tr36,c3_2)).
ndt(at(tr35,c1_1)).
ndt(at(tr34,c3_3)).
ndt(at(tr33,c3_3)).
ndt(at(tr32,c2_1)).
ndt(at(tr31,c3_1)).
ndt(at(tr30,c3_2)).
ndt(at(tr29,c2_2)).
ndt(at(tr28,c1_3)).
ndt(at(tr27,c4_1)).
ndt(at(tr26,c3_2)).
ndt(at(tr25,c4_3)).
ndt(at(tr24,c2_1)).
ndt(at(tr23,c4_1)).
ndt(at(tr22,c1_1)).
ndt(at(tr21,c3_2)).
ndt(at(tr20,c4_3)).
ndt(at(tr19,c3_3)).
ndt(at(tr18,c1_2)).
ndt(at(tr17,c4_2)).
ndt(at(tr16,c3_1)).
ndt(at(tr15,c3_2)).
ndt(at(tr14,c4_3)).
ndt(at(tr13,c2_2)).
ndt(at(tr12,c2_1)).
ndt(at(tr11,c1_1)).
ndt(at(tr10,c1_2)).
ndt(at(tr9,c1_2)).
ndt(at(tr8,c1_1)).
ndt(at(tr7,c1_2)).
ndt(at(tr6,c2_2)).
ndt(at(tr5,c3_1)).
ndt(at(tr4,c4_1)).
ndt(at(tr3,c1_3)).
ndt(at(tr2,c1_3)).
ndt(at(tr1,c4_2)).

ndt(at(p7,c4_3)).
ndt(at(p6,c3_2)).
ndt(at(p5,c2_2)).
ndt(at(p4,c2_3)).
ndt(at(p3,c1_3)).
ndt(at(p2,c4_2)).
ndt(at(p1,c2_1)).
 ndt(out(p7)).
ndt(out(p6)).
ndt(out(p5)).
ndt(out(p4)).
ndt(out(p3)).
ndt(out(p2)).
ndt(out(p1)).



