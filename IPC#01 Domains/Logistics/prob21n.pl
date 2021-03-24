problem_name('log21.txt').

packages( [p11,p10,p9,p8,p7,
p6,p5,p4,p3,p2,p1] ) .
cities( [c14,c13,c12,c11,c10,c9,c8,c7,c6,c5,c4,c3,c2,c1] ) .
airports( [c14_9,c13_9,c12_9,c11_9,
c10_9,c9_9,c8_9,c7_9,c6_9,c5_9,c4_9,
c3_9,c2_9,c1_9] ) .
locations( [c14_8,c14_7,c14_6,c14_5,
c14_4,c14_3,c14_2,c14_1,c13_8,c13_7,c13_6,
c13_5,c13_4,c13_3,c13_2,c13_1,c12_8,c12_7,
c12_6,c12_5,c12_4,c12_3,c12_2,c12_1,c11_8,
c11_7,c11_6,c11_5,c11_4,c11_3,c11_2,c11_1,
c10_8,c10_7,c10_6,c10_5,c10_4,c10_3,c10_2,
c10_1,c9_8,c9_7,c9_6,c9_5,c9_4,c9_3,
c9_2,c9_1,c8_8,c8_7,c8_6,c8_5,c8_4,
c8_3,c8_2,c8_1,c7_8,c7_7,c7_6,c7_5,
c7_4,c7_3,c7_2,c7_1,c6_8,c6_7,c6_6,
c6_5,c6_4,c6_3,c6_2,c6_1,c5_8,c5_7,
c5_6,c5_5,c5_4,c5_3,c5_2,c5_1,c4_8,
c4_7,c4_6,c4_5,c4_4,c4_3,c4_2,c4_1,
c3_8,c3_7,c3_6,c3_5,c3_4,c3_3,c3_2,
c3_1,c2_8,c2_7,c2_6,c2_5,c2_4,c2_3,
c2_2,c2_1,c1_8,c1_7,c1_6,c1_5,c1_4,
c1_3,c1_2,c1_1,c14_9,c13_9,c12_9,c11_9,
c10_9,c9_9,c8_9,c7_9,c6_9,c5_9,c4_9,
c3_9,c2_9,c1_9 ] ) .
trucks( [tr40,tr39,tr38,tr37,tr36,
tr35,tr34,tr33,tr32,tr31,tr30,tr29,
tr28,tr27,tr26,tr25,tr24,tr23,tr22,
tr21,tr20,tr19,tr18,tr17,tr16,tr15,
tr14,tr13,tr12,tr11,tr10,tr9,tr8,tr7,
tr6,tr5,tr4,tr3,tr2,tr1 ] ) .
airplanes( [pl13,pl12,
pl11,pl10,pl9,pl8,pl7,pl6,pl5,pl4,
pl3,pl2,pl1 ] ) .

def( at( Package , Location ) ) :- packages( D1 ) , locations( D2 ) , member( Package , D1 ) , member( Location , D2 ) .  
def( at( Airplane , Airport ) ) :- airplanes( D1 ) , airports( D2 ) , member( Airplane , D1 ) , member( Airport , D2 ) .  
def( out( Package ) ) :- packages( D1 ) , member( Package , D1 ) .
def( in( Package , Truck ) ) :- packages( D1 ) , trucks( D2 ) , member( Package , D1 ) , member( Truck , D2 ) .
def( in( Package , Airplane ) ) :- packages( D1 ) , airplanes( D2 ) , member( Package , D1 ) , member( Airplane , D2 ) .
def( at( Truck , Location ) ) :- trucks( D1 ) , locations( D2 ) , member( Truck , D1 ) , member( Location , D2 ), truck_city(Truck, City), const(loc_at(Location, City)) .


const(loc_at(c14_8, c14)).
const(loc_at(c14_7, c14)).
const(loc_at(c14_6, c14)).
const(loc_at(c14_5, c14)).
const(loc_at(c14_4, c14)).
const(loc_at(c14_3, c14)).
const(loc_at(c14_2, c14)).
const(loc_at(c14_1, c14)).
const(loc_at(c13_8, c13)).
const(loc_at(c13_7, c13)).
const(loc_at(c13_6, c13)).
const(loc_at(c13_5, c13)).
const(loc_at(c13_4, c13)).
const(loc_at(c13_3, c13)).
const(loc_at(c13_2, c13)).
const(loc_at(c13_1, c13)).
const(loc_at(c12_8, c12)).
const(loc_at(c12_7, c12)).
const(loc_at(c12_6, c12)).
const(loc_at(c12_5, c12)).
const(loc_at(c12_4, c12)).
const(loc_at(c12_3, c12)).
const(loc_at(c12_2, c12)).
const(loc_at(c12_1, c12)).
const(loc_at(c11_8, c11)).
const(loc_at(c11_7, c11)).
const(loc_at(c11_6, c11)).
const(loc_at(c11_5, c11)).
const(loc_at(c11_4, c11)).
const(loc_at(c11_3, c11)).
const(loc_at(c11_2, c11)).
const(loc_at(c11_1, c11)).
const(loc_at(c10_8, c10)).
const(loc_at(c10_7, c10)).
const(loc_at(c10_6, c10)).
const(loc_at(c10_5, c10)).
const(loc_at(c10_4, c10)).
const(loc_at(c10_3, c10)).
const(loc_at(c10_2, c10)).
const(loc_at(c10_1, c10)).
const(loc_at(c9_8, c9)).
const(loc_at(c9_7, c9)).
const(loc_at(c9_6, c9)).
const(loc_at(c9_5, c9)).
const(loc_at(c9_4, c9)).
const(loc_at(c9_3, c9)).
const(loc_at(c9_2, c9)).
const(loc_at(c9_1, c9)).
const(loc_at(c8_8, c8)).
const(loc_at(c8_7, c8)).
const(loc_at(c8_6, c8)).
const(loc_at(c8_5, c8)).
const(loc_at(c8_4, c8)).
const(loc_at(c8_3, c8)).
const(loc_at(c8_2, c8)).
const(loc_at(c8_1, c8)).
const(loc_at(c7_8, c7)).
const(loc_at(c7_7, c7)).
const(loc_at(c7_6, c7)).
const(loc_at(c7_5, c7)).
const(loc_at(c7_4, c7)).
const(loc_at(c7_3, c7)).
const(loc_at(c7_2, c7)).
const(loc_at(c7_1, c7)).
const(loc_at(c6_8, c6)).
const(loc_at(c6_7, c6)).
const(loc_at(c6_6, c6)).
const(loc_at(c6_5, c6)).
const(loc_at(c6_4, c6)).
const(loc_at(c6_3, c6)).
const(loc_at(c6_2, c6)).
const(loc_at(c6_1, c6)).
const(loc_at(c5_8, c5)).
const(loc_at(c5_7, c5)).
const(loc_at(c5_6, c5)).
const(loc_at(c5_5, c5)).
const(loc_at(c5_4, c5)).
const(loc_at(c5_3, c5)).
const(loc_at(c5_2, c5)).
const(loc_at(c5_1, c5)).
const(loc_at(c4_8, c4)).
const(loc_at(c4_7, c4)).
const(loc_at(c4_6, c4)).
const(loc_at(c4_5, c4)).
const(loc_at(c4_4, c4)).
const(loc_at(c4_3, c4)).
const(loc_at(c4_2, c4)).
const(loc_at(c4_1, c4)).
const(loc_at(c3_8, c3)).
const(loc_at(c3_7, c3)).
const(loc_at(c3_6, c3)).
const(loc_at(c3_5, c3)).
const(loc_at(c3_4, c3)).
const(loc_at(c3_3, c3)).
const(loc_at(c3_2, c3)).
const(loc_at(c3_1, c3)).
const(loc_at(c2_8, c2)).
const(loc_at(c2_7, c2)).
const(loc_at(c2_6, c2)).
const(loc_at(c2_5, c2)).
const(loc_at(c2_4, c2)).
const(loc_at(c2_3, c2)).
const(loc_at(c2_2, c2)).
const(loc_at(c2_1, c2)).
const(loc_at(c1_8, c1)).
const(loc_at(c1_7, c1)).
const(loc_at(c1_6, c1)).
const(loc_at(c1_5, c1)).
const(loc_at(c1_4, c1)).
const(loc_at(c1_3, c1)).
const(loc_at(c1_2, c1)).
const(loc_at(c1_1, c1)).
const(loc_at(c14_9, c14)).
const(loc_at(c13_9, c13)).
const(loc_at(c12_9, c12)).
const(loc_at(c11_9, c11)).
const(loc_at(c10_9, c10)).
const(loc_at(c9_9, c9)).
const(loc_at(c8_9, c8)).
const(loc_at(c7_9, c7)).
const(loc_at(c6_9, c6)).
const(loc_at(c5_9, c5)).
const(loc_at(c4_9, c4)).
const(loc_at(c3_9, c3)).
const(loc_at(c2_9, c2)).
const(loc_at(c1_9, c1)).


truck_city(tr40,c14).
truck_city(tr39,c13).
truck_city(tr38,c12).
truck_city(tr37,c11).
truck_city(tr36,c10).
truck_city(tr35,c9).
truck_city(tr34,c8).
truck_city(tr33,c7).
truck_city(tr32,c6).
truck_city(tr31,c5).
truck_city(tr30,c4).
truck_city(tr29,c3).
truck_city(tr28,c2).
truck_city(tr27,c1).
truck_city(tr26,c4).
truck_city(tr25,c9).
truck_city(tr24,c9).
truck_city(tr23,c4).
truck_city(tr22,c3).
truck_city(tr21,c7).
truck_city(tr20,c2).
truck_city(tr19,c13).
truck_city(tr18,c5).
truck_city(tr17,c4).
truck_city(tr16,c7).
truck_city(tr15,c7).
truck_city(tr14,c4).
truck_city(tr13,c2).
truck_city(tr12,c2).
truck_city(tr11,c6).
truck_city(tr10,c8).
truck_city(tr9,c3).
truck_city(tr8,c11).
truck_city(tr7,c8).
truck_city(tr6,c4).
truck_city(tr5,c1).
truck_city(tr4,c1).
truck_city(tr3,c2).
truck_city(tr2,c2).
truck_city(tr1,c12).


initial([at(pl13,c8_9),at(pl12,c4_9),at(pl11,c2_9),at(pl10,c5_9),at(pl9,c2_9),at(pl8,c7_9),at(pl7,c5_9),
at(pl6,c3_9),at(pl5,c11_9),at(pl4,c7_9),at(pl3,c6_9),at(pl2,c11_9),at(pl1,c2_9),
at(tr40,c14_3),at(tr39,c13_7),at(tr38,c12_7),at(tr37,c11_5),at(tr36,c10_1),at(tr35,c9_3),at(tr34,c8_8),
at(tr33,c7_1),at(tr32,c6_3),at(tr31,c5_7),at(tr30,c4_4),at(tr29,c3_1),at(tr28,c2_7),at(tr27,c1_5),at(tr26,c4_6),
at(tr25,c9_1),at(tr24,c9_7),at(tr23,c4_4),at(tr22,c3_3),at(tr21,c7_8),at(tr20,c2_6),at(tr19,c13_3),at(tr18,c5_5),
at(tr17,c4_5),at(tr16,c7_1),at(tr15,c7_8),at(tr14,c4_9),at(tr13,c2_1),at(tr12,c2_8),at(tr11,c6_2),at(tr10,c8_3),
at(tr9,c3_1),at(tr8,c11_7),at(tr7,c8_5),at(tr6,c4_7),at(tr5,c1_3),at(tr4,c1_3),at(tr3,c2_6),at(tr2,c2_9),at(tr1,c12_9),
at(p11,c3_8),at(p10,c3_1),at(p9,c2_5),at(p8,c6_6),at(p7,c9_8),at(p6,c1_6),at(p5,c1_1),at(p4,c8_8),at(p3,c5_8),at(p2,c10_1),at(p1,c12_1),
out(p11),out(p10),out(p9),out(p8),out(p7),out(p6),out(p5),out(p4),out(p3),out(p2),out(p1)]):-!.



goal([at(p11,c9_8),at(p10,c12_9),at(p9,c2_3),at(p8,c10_7),at(p7,c2_2),at(p6,c12_6),at(p5,c14_8),
at(p4,c13_2),at(p3,c2_8),at(p2,c6_2),at(p1,c11_6),
out(p11),out(p10),out(p9),out(p8),out(p7),out(p6),out(p5),out(p4),out(p3),out(p2),out(p1)]):-!.


goal1( List ):-findall(X, ndt(X), List).

ndt(at(pl13,c8_9)).
ndt(at(pl12,c4_9)).
ndt(at(pl11,c2_9)).
ndt(at(pl10,c5_9)).
ndt(at(pl9,c2_9)).
ndt(at(pl8,c7_9)).
ndt(at(pl7,c5_9)).
ndt(at(pl6,c3_9)).
ndt(at(pl5,c11_9)).
ndt(at(pl4,c7_9)).
ndt(at(pl3,c6_9)).
ndt(at(pl2,c11_9)).
ndt(at(pl1,c2_9)).
ndt(at(tr40,c14_8)).
ndt(at(tr39,c13_7)).
ndt(at(tr38,c12_6)).
ndt(at(tr37,c11_6)).
ndt(at(tr36,c10_7)).
ndt(at(tr35,c9_3)).
ndt(at(tr34,c8_8)).
ndt(at(tr33,c7_1)).
ndt(at(tr32,c6_2)).
ndt(at(tr31,c5_7)).
ndt(at(tr30,c4_4)).
ndt(at(tr29,c3_1)).
ndt(at(tr28,c2_2)).
ndt(at(tr27,c1_5)).
ndt(at(tr26,c4_6)).
ndt(at(tr25,c9_8)).
ndt(at(tr24,c9_7)).
ndt(at(tr23,c4_4)).
ndt(at(tr22,c3_3)).
ndt(at(tr21,c7_8)).
ndt(at(tr20,c2_8)).
ndt(at(tr19,c13_2)).
ndt(at(tr18,c5_5)).
ndt(at(tr17,c4_5)).
ndt(at(tr16,c7_1)).
ndt(at(tr15,c7_8)).
ndt(at(tr14,c4_9)).
ndt(at(tr13,c2_1)).
ndt(at(tr12,c2_3)).
ndt(at(tr11,c6_2)).
ndt(at(tr10,c8_3)).
ndt(at(tr9,c3_1)).
ndt(at(tr8,c11_7)).
ndt(at(tr7,c8_5)).
ndt(at(tr6,c4_7)).
ndt(at(tr5,c1_3)).
ndt(at(tr4,c1_3)).
ndt(at(tr3,c2_6)).
ndt(at(tr2,c2_9)).
ndt(at(tr1,c12_9)).

