packages( [ p1 , p2 , p3 , p4 , p5 , p6 , p7, p8, p9, p10, p11, p12, p13, p14,
	p15, p16, p17] ) .
cities( [ c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14,
	c15, c16, c17, c18, c19, c20, c21, c22, c23] ) .
airports( [ c1_2, c2_2, c3_2, c4_2, c5_2, c6_2, c7_2, c8_2, c9_2, c10_2, c11_2, c12_2, c13_2, c14_2, c15_2, c16_2, c17_2, c18_2, c19_2, c20_2, c21_2, c22_2, c23_2] ) .
locations( [ c1_1, c1_2, c2_1, c2_2, c3_1, c3_2, c4_1, c4_2, c5_1, c5_2, c6_1, c6_2 , c7_1, c7_2, 
	c8_1, c8_2, c9_1, c9_2, c10_1, c10_2, c11_1, c11_2, c12_1, c12_2, c13_1, c13_2 , c14_1, c14_2, 
	c15_1, c15_2, c16_1, c16_2, c17_1, c17_2, c18_1, c18_2, c19_1, c19_2 , c20_1, c20_2, c21_1, c21_2, c22_1, c22_2, c23_1, c23_2 ] ) .
trucks( [ tr1 , tr2 , tr3, tr4, tr5, tr6, tr7, tr8, tr9, tr10, tr11, tr12, tr13, tr14, tr15, tr16, tr17, tr18, tr19, tr20,
	tr21, tr22, tr23] ) .
airplanes( [ pl1, pl2, pl3, pl4 ] ) .


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
const( loc_at( c12_1, c12) ) .
const( loc_at( c12_2, c12) ) .
const( loc_at( c13_1, c13) ) .
const( loc_at( c13_2, c13) ) .
const( loc_at( c14_1, c14) ) .
const( loc_at( c14_2, c14) ) .
const( loc_at( c15_1, c15) ) .
const( loc_at( c15_2, c15) ) .
const( loc_at( c16_1, c16) ) .
const( loc_at( c16_2, c16) ) .
const( loc_at( c17_1, c17) ) .
const( loc_at( c17_2, c17) ) .
const( loc_at( c18_1, c18) ) .
const( loc_at( c18_2, c18) ) .
const( loc_at( c19_1, c19) ) .
const( loc_at( c19_2, c19) ) .
const( loc_at( c20_1, c20) ) .
const( loc_at( c20_2, c20) ) .
const( loc_at( c21_1, c21) ) .
const( loc_at( c21_2, c21) ) .
const( loc_at( c22_1, c22) ) .
const( loc_at( c22_2, c22) ) .
const( loc_at( c23_1, c23) ) .
const( loc_at( c23_2, c23) ) .


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
truck_city(tr15, c15).
truck_city(tr16, c16).
truck_city(tr17, c17).
truck_city(tr18, c18).
truck_city(tr19, c19).
truck_city(tr20, c20).
truck_city(tr21, c21).
truck_city(tr22, c22).
truck_city(tr23, c23).

initial([at(pl4,c11_2),at(pl3,c13_2),at(pl2,c18_2),at(pl1,c16_2),
at(tr23,c23_1),at(tr22,c22_1),at(tr21,c21_1),at(tr20,c20_1),at(tr19,c19_1),at(tr18,c18_1),at(tr17,c17_1),
at(tr16,c16_1),at(tr15,c15_1),at(tr14,c14_1),at(tr13,c13_1),at(tr12,c12_1),at(tr11,c11_1),at(tr10,c10_1),
at(tr9,c9_1),at(tr8,c8_1),at(tr7,c7_1),at(tr6,c6_1),at(tr5,c5_1),at(tr4,c4_1),at(tr3,c3_1),at(tr2,c2_1),at(tr1,c1_1),
at(p17,c8_2),at(p16,c13_2),at(p15,c15_2),at(p14,c3_2),at(p13,c14_2),at(p12,c5_1),at(p11,c16_1),at(p10,c3_2),
at(p9,c21_1),at(p8,c8_1),at(p7,c11_1),at(p6,c15_2),at(p5,c6_1),at(p4,c7_1),at(p3,c19_1),at(p2,c22_1),at(p1,c13_1),
out(p1), out(p2), out(p3), out(p4), out(p5), out(p6), out(p7), out(p8), out(p9), out(p10), 
out(p11), out(p12), out(p13), out(p14), out(p15), out(p16), out(p17)]):-!.

goal([at(p17,c3_1),at(p16,c4_2),at(p15,c19_1),at(p14,c9_1),at(p13,c3_2),at(p12,c21_1),at(p11,c21_2),
at(p10,c9_2),at(p9,c20_2),at(p8,c13_2),at(p7,c3_1),at(p6,c15_2),at(p5,c8_1),at(p4,c1_1),at(p3,c9_2),at(p2,c2_1),at(p1,c13_1),
out(p1), out(p2), out(p3), out(p4), out(p5), out(p6), out(p7), out(p8), out(p9), out(p10), 
out(p11), out(p12), out(p13), out(p14), out(p15), out(p16), out(p17)]):-!.

goal1( List ):-findall(X, ndt(X), List).


ndt(at(pl4,c11_2)).
ndt(at(pl3,c13_2)).
ndt(at(pl2,c18_2)).
ndt(at(pl1,c16_2)).

ndt(at(tr23,c23_1)).
ndt(at(tr22,c22_1)).
ndt(at(tr21,c21_1)).
ndt(at(tr20,c20_2)).
ndt(at(tr19,c19_1)).
ndt(at(tr18,c18_1)).
ndt(at(tr17,c17_1)).
ndt(at(tr16,c16_1)).
ndt(at(tr15,c15_2)).
ndt(at(tr14,c14_1)).
ndt(at(tr13,c13_2)).
ndt(at(tr12,c12_1)).
ndt(at(tr11,c11_1)).
ndt(at(tr10,c10_1)).
ndt(at(tr9,c9_2)).
ndt(at(tr8,c8_1)).
ndt(at(tr7,c7_1)).
ndt(at(tr6,c6_1)).
ndt(at(tr5,c5_1)).
ndt(at(tr4,c4_2)).
ndt(at(tr3,c3_1)).
ndt(at(tr2,c2_1)).
ndt(at(tr1,c1_1)).

