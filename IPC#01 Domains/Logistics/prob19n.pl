packages( [p19,p18,p17,p16,p15,
p14,p13,p12,p11,p10,p9,
p8,p7,p6,p5,p4,p3,p2,
p1] ) .
cities( [c8,c7,c6,c5,c4,c3,c2,c1] ) .
airports( [c8_8,c7_8,c6_8,c5_8,c4_8,c3_8,
c2_8,c1_8] ) .
locations( [c8_7,c8_6,c8_5,c8_4,c8_3,c8_2,
c8_1,c7_7,c7_6,c7_5,c7_4,c7_3,c7_2,
c7_1,c6_7,c6_6,c6_5,c6_4,c6_3,c6_2,
c6_1,c5_7,c5_6,c5_5,c5_4,c5_3,c5_2,
c5_1,c4_7,c4_6,c4_5,c4_4,c4_3,c4_2,
c4_1,c3_7,c3_6,c3_5,c3_4,c3_3,c3_2,
c3_1,c2_7,c2_6,c2_5,c2_4,c2_3,c2_2,
c2_1,c1_7,c1_6,c1_5,c1_4,c1_3,c1_2,
c1_1,c8_8,c7_8,c6_8,c5_8,c4_8,c3_8,
c2_8,c1_8] ) .
trucks( [tr30,
tr29,tr28,tr27,tr26,tr25,tr24,tr23,
tr22,tr21,tr20,tr19,tr18,tr17,tr16,
tr15,tr14,tr13,tr12,tr11,tr10,tr9,tr8,
tr7,tr6,tr5,tr4,tr3,tr2,tr1 ] ) .
airplanes( [pl11,
pl10,pl9,pl8,pl7,pl6,pl5,pl4,pl3,pl2,
pl1] ) .


def( at( Package , Location ) ) :- packages( D1 ) , locations( D2 ) , member( Package , D1 ) , member( Location , D2 ) .  
def( at( Airplane , Airport ) ) :- airplanes( D1 ) , airports( D2 ) , member( Airplane , D1 ) , member( Airport , D2 ) .  
def( out( Package ) ) :- packages( D1 ) , member( Package , D1 ) .
def( in( Package , Truck ) ) :- packages( D1 ) , trucks( D2 ) , member( Package , D1 ) , member( Truck , D2 ) .
def( in( Package , Airplane ) ) :- packages( D1 ) , airplanes( D2 ) , member( Package , D1 ) , member( Airplane , D2 ) .
def( at( Truck , Location ) ) :- trucks( D1 ) , locations( D2 ) , member( Truck , D1 ) , member( Location , D2 ), truck_city(Truck, City), const(loc_at(Location, City)) .

const(loc_at(c8_7, c8)).
const(loc_at(c8_6, c8)).
const(loc_at(c8_5, c8)).
const(loc_at(c8_4, c8)).
const(loc_at(c8_3, c8)).
const(loc_at(c8_2, c8)).

const(loc_at(c8_1, c8)).
const(loc_at(c7_7, c7)).
const(loc_at(c7_6, c7)).
const(loc_at(c7_5, c7)).
const(loc_at(c7_4, c7)).
const(loc_at(c7_3, c7)).
const(loc_at(c7_2, c7)).

const(loc_at(c7_1, c7)).
const(loc_at(c6_7, c6)).
const(loc_at(c6_6, c6)).
const(loc_at(c6_5, c6)).
const(loc_at(c6_4, c6)).
const(loc_at(c6_3, c6)).
const(loc_at(c6_2, c6)).

const(loc_at(c6_1, c6)).
const(loc_at(c5_7, c5)).
const(loc_at(c5_6, c5)).
const(loc_at(c5_5, c5)).
const(loc_at(c5_4, c5)).
const(loc_at(c5_3, c5)).
const(loc_at(c5_2, c5)).

const(loc_at(c5_1, c5)).
const(loc_at(c4_7, c4)).
const(loc_at(c4_6, c4)).
const(loc_at(c4_5, c4)).
const(loc_at(c4_4, c4)).
const(loc_at(c4_3, c4)).
const(loc_at(c4_2, c4)).

const(loc_at(c4_1, c4)).
const(loc_at(c3_7, c3)).
const(loc_at(c3_6, c3)).
const(loc_at(c3_5, c3)).
const(loc_at(c3_4, c3)).
const(loc_at(c3_3, c3)).
const(loc_at(c3_2, c3)).

const(loc_at(c3_1, c3)).
const(loc_at(c2_7, c2)).
const(loc_at(c2_6, c2)).
const(loc_at(c2_5, c2)).
const(loc_at(c2_4, c2)).
const(loc_at(c2_3, c2)).
const(loc_at(c2_2, c2)).

const(loc_at(c2_1, c2)).
const(loc_at(c1_7, c1)).
const(loc_at(c1_6, c1)).
const(loc_at(c1_5, c1)).
const(loc_at(c1_4, c1)).
const(loc_at(c1_3, c1)).
const(loc_at(c1_2, c1)).

const(loc_at(c1_1, c1)).
const(loc_at(c8_8, c8)).
const(loc_at(c7_8, c7)).
const(loc_at(c6_8, c6)).
const(loc_at(c5_8, c5)).
const(loc_at(c4_8, c4)).
const(loc_at(c3_8, c3)).

const(loc_at(c2_8, c2)).
const(loc_at(c1_8, c1)).


truck_city(tr30,c8).
truck_city(tr29,c7).
truck_city(tr28,c6).
truck_city(tr27,c5).
truck_city(tr26,c4).
truck_city(tr25,c3).
truck_city(tr24,c2).
truck_city(tr23,c1).
truck_city(tr22,c2).
truck_city(tr21,c3).
truck_city(tr20,c4).
truck_city(tr19,c6).
truck_city(tr18,c7).
truck_city(tr17,c6).
truck_city(tr16,c7).
truck_city(tr15,c1).
truck_city(tr14,c8).
truck_city(tr13,c1).
truck_city(tr12,c5).
truck_city(tr11,c2).
truck_city(tr10,c1).
truck_city(tr9,c2).
truck_city(tr8,c8).
truck_city(tr7,c4).
truck_city(tr6,c3).
truck_city(tr5,c3).
truck_city(tr4,c2).
truck_city(tr3,c3).
truck_city(tr2,c1).
truck_city(tr1,c5).



initial([at(pl11,c3_8),at(pl10,c7_8),at(pl9,c3_8),at(pl8,c4_8),at(pl7,c2_8),at(pl6,c1_8),at(pl5,c1_8),at(pl4,c2_8),at(pl3,c3_8),at(pl2,c2_8),at(pl1,c7_8),at(tr30,c8_5),at(tr29,c7_3),at(tr28,c6_2),at(tr27,c5_6),at(tr26,c4_3),at(tr25,c3_5),at(tr24,c2_1),at(tr23,c1_7),at(tr22,c2_4),at(tr21,c3_8),at(tr20,c4_7),at(tr19,c6_7),at(tr18,c7_6),at(tr17,c6_6),at(tr16,c7_3),at(tr15,c1_8),at(tr14,c8_8),at(tr13,c1_8),at(tr12,c5_7),at(tr11,c2_6),at(tr10,c1_5),at(tr9,c2_7),at(tr8,c8_5),at(tr7,c4_1),at(tr6,c3_5),at(tr5,c3_8),at(tr4,c2_1),at(tr3,c3_1),at(tr2,c1_8),at(tr1,c5_6),at(p19,c7_7),at(p18,c4_5),at(p17,c3_6),at(p16,c1_5),at(p15,c8_2),at(p14,c8_3),at(p13,c6_8),at(p12,c8_1),at(p11,c2_6),at(p10,c6_5),at(p9,c7_2),at(p8,c6_1),at(p7,c4_8),at(p6,c6_3),at(p5,c4_3),at(p4,c1_5),at(p3,c2_2),at(p2,c4_5),at(p1,c7_3),
out(p19),out(p18),out(p17),out(p16),out(p15),out(p14),out(p13),out(p12),out(p11),out(p10),out(p9),out(p8),out(p7),out(p6),out(p5),out(p4),out(p3),out(p2),out(p1)]):-!.


goal([at(p19,c6_1),at(p18,c2_2),at(p17,c1_8),at(p16,c2_5),at(p15,c3_6),at(p14,c7_6),at(p13,c8_2),
at(p12,c7_4),at(p11,c8_5),at(p10,c1_7),at(p9,c1_7),at(p8,c6_4),at(p7,c4_5),at(p6,c2_7),at(p5,c3_8),
at(p4,c7_5),at(p3,c2_1),at(p2,c7_4),at(p1,c5_2),
out(p19),out(p18),out(p17),out(p16),out(p15),out(p14),out(p13),out(p12),out(p11),out(p10),out(p9),out(p8),out(p7),out(p6),out(p5),out(p4),out(p3),out(p2),out(p1)]):-!.

goal1( List ):-findall(X, ndt(X), List).

ndt(at(pl11,c6_8)).
ndt(at(pl10,c2_8)).
ndt(at(pl9,c1_8)).
ndt(at(pl8,c2_8)).
ndt(at(pl7,c3_8)).
ndt(at(pl6,c7_8)).
ndt(at(pl5,c8_8)).
ndt(at(pl4,c6_8)).
ndt(at(pl3,c4_8)).
ndt(at(pl2,c3_8)).
ndt(at(pl1,c5_8)).

ndt(at(tr30,c8_2)).
ndt(at(tr29,c7_6)).
ndt(at(tr28,c6_2)).
ndt(at(tr27,c5_6)).
ndt(at(tr26,c4_5)).
ndt(at(tr25,c3_6)).
ndt(at(tr24,c2_5)).
ndt(at(tr23,c1_7)).
ndt(at(tr22,c2_7)).
ndt(at(tr21,c3_8)).
ndt(at(tr20,c4_7)).
ndt(at(tr19,c6_4)).
ndt(at(tr18,c7_5)).
ndt(at(tr17,c6_1)).
ndt(at(tr16,c7_4)).
ndt(at(tr15,c1_8)).
ndt(at(tr14,c8_5)).
ndt(at(tr13,c1_8)).
ndt(at(tr12,c5_7)).
ndt(at(tr11,c2_5)).
ndt(at(tr10,c1_5)).
ndt(at(tr9,c2_1)).
ndt(at(tr8,c8_5)).
ndt(at(tr7,c4_1)).
ndt(at(tr6,c3_6)).
ndt(at(tr5,c3_8)).
ndt(at(tr4,c2_2)).
ndt(at(tr3,c3_1)).
ndt(at(tr2,c1_8)).
ndt(at(tr1,c5_2)).
