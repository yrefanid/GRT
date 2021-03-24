packages( [ p1 , p2 , p3 , p4 , p5] ) .
cities( [ c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14,
	c15, c16, c17, c18, c19, c20, c21, c22, c23, c24, c25, c26, c27] ) .
airports( [c27_4,c26_4,c25_4,c24_4,c23_4,c22_4,
c21_4,c20_4,c19_4,c18_4,c17_4,c16_4,c15_4,
c14_4,c13_4,c12_4,c11_4,c10_4,c9_4,c8_4,
c7_4,c6_4,c5_4,c4_4,c3_4,c2_4,c1_4] ) .
locations( [c27_3,c27_2,c27_1 ,
c26_3,c26_2,c26_1,c25_3,c25_2,c25_1,c24_3,
c24_2,c24_1,c23_3,c23_2,c23_1,c22_3,c22_2,
c22_1,c21_3,c21_2,c21_1,c20_3,c20_2,c20_1,
c19_3,c19_2,c19_1,c18_3,c18_2,c18_1,c17_3,
c17_2,c17_1,c16_3,c16_2,c16_1,c15_3,c15_2,
c15_1,c14_3,c14_2,c14_1,c13_3,c13_2,c13_1,
c12_3,c12_2,c12_1,c11_3,c11_2,c11_1,c10_3,
c10_2,c10_1,c9_3,c9_2,c9_1,c8_3,c8_2,
c8_1,c7_3,c7_2,c7_1,c6_3,c6_2,c6_1,
c5_3,c5_2,c5_1,c4_3,c4_2,c4_1,c3_3,
c3_2,c3_1,c2_3,c2_2,c2_1,c1_3,c1_2,
c1_1,c27_4,c26_4,c25_4,c24_4,c23_4,c22_4,
c21_4,c20_4,c19_4,c18_4,c17_4,c16_4,c15_4,
c14_4,c13_4,c12_4,c11_4,c10_4,c9_4,c8_4,
c7_4,c6_4,c5_4,c4_4,c3_4,c2_4,c1_4] ) .
trucks( [tr55,tr54,tr53,tr52,tr51,tr50,tr49,tr48,
tr47,tr46,tr45,tr44,tr43,tr42,tr41,
tr40,tr39,tr38,tr37,tr36,tr35,tr34,
tr33,tr32,tr31,tr30,tr29,tr28,tr27,
tr26,tr25,tr24,tr23,tr22,tr21,tr20,
tr19,tr18,tr17,tr16,tr15,tr14,tr13,
tr12,tr11,tr10,tr9,tr8,tr7,tr6,tr5,
tr4,tr3,tr2,tr1] ) .
airplanes( [pl9,pl8,pl7,pl6,pl5,pl4,pl3,pl2,pl1] ).


def( at( Package , Location ) ) :- packages( D1 ) , locations( D2 ) , member( Package , D1 ) , member( Location , D2 ) .  
def( at( Airplane , Airport ) ) :- airplanes( D1 ) , airports( D2 ) , member( Airplane , D1 ) , member( Airport , D2 ) .  
def( out( Package ) ) :- packages( D1 ) , member( Package , D1 ) .
def( in( Package , Truck ) ) :- packages( D1 ) , trucks( D2 ) , member( Package , D1 ) , member( Truck , D2 ) .
def( in( Package , Airplane ) ) :- packages( D1 ) , airplanes( D2 ) , member( Package , D1 ) , member( Airplane , D2 ) .
def( at( Truck , Location ) ) :- trucks( D1 ) , locations( D2 ) , member( Truck , D1 ) , member( Location , D2 ), truck_city(Truck, City), const(loc_at(Location, City)) .


const( loc_at( c1_1, c1) ) .
const( loc_at( c1_2, c1) ) .
const( loc_at( c1_3, c1) ) .
const( loc_at( c1_4, c1) ) .
const( loc_at( c2_1, c2) ) .
const( loc_at( c2_2, c2) ) .
const( loc_at( c2_3, c2) ) .
const( loc_at( c2_4, c2) ) .
const( loc_at( c3_1, c3) ) .
const( loc_at( c3_2, c3) ) .
const( loc_at( c3_3, c3) ) .
const( loc_at( c3_4, c3) ) .
const( loc_at( c4_1, c4) ) .
const( loc_at( c4_2, c4) ) .
const( loc_at( c4_3, c4) ) .
const( loc_at( c4_4, c4) ) .
const( loc_at( c5_1, c5) ) .
const( loc_at( c5_2, c5) ) .
const( loc_at( c5_3, c5) ) .
const( loc_at( c5_4, c5) ) .
const( loc_at( c6_1, c6) ) .
const( loc_at( c6_2, c6) ) .
const( loc_at( c6_3, c6) ) .
const( loc_at( c6_4, c6) ) .
const( loc_at( c7_1, c7) ) .
const( loc_at( c7_2, c7) ) .
const( loc_at( c7_3, c7) ) .
const( loc_at( c7_4, c7) ) .
const( loc_at( c8_1, c8) ) .
const( loc_at( c8_2, c8) ) .
const( loc_at( c8_3, c8) ) .
const( loc_at( c8_4, c8) ) .
const( loc_at( c9_1, c9) ) .
const( loc_at( c9_2, c9) ) .
const( loc_at( c9_3, c9) ) .
const( loc_at( c9_4, c9) ) .
const( loc_at( c10_1, c10) ) .
const( loc_at( c10_2, c10) ) .
const( loc_at( c10_3, c10) ) .
const( loc_at( c10_4, c10) ) .
const( loc_at( c11_1, c11) ) .
const( loc_at( c11_2, c11) ) .
const( loc_at( c11_3, c11) ) .
const( loc_at( c11_4, c11) ) .
const( loc_at( c12_1, c12) ) .
const( loc_at( c12_2, c12) ) .
const( loc_at( c12_3, c12) ) .
const( loc_at( c12_4, c12) ) .
const( loc_at( c13_1, c13) ) .
const( loc_at( c13_2, c13) ) .
const( loc_at( c13_3, c13) ) .
const( loc_at( c13_4, c13) ) .
const( loc_at( c14_1, c14) ) .
const( loc_at( c14_2, c14) ) .
const( loc_at( c14_3, c14) ) .
const( loc_at( c14_4, c14) ) .
const( loc_at( c15_1, c15) ) .
const( loc_at( c15_2, c15) ) .
const( loc_at( c15_3, c15) ) .
const( loc_at( c15_4, c15) ) .
const( loc_at( c16_1, c16) ) .
const( loc_at( c16_2, c16) ) .
const( loc_at( c16_3, c16) ) .
const( loc_at( c16_4, c16) ) .
const( loc_at( c17_1, c17) ) .
const( loc_at( c17_2, c17) ) .
const( loc_at( c17_3, c17) ) .
const( loc_at( c17_4, c17) ) .
const( loc_at( c18_1, c18) ) .
const( loc_at( c18_2, c18) ) .
const( loc_at( c18_3, c18) ) .
const( loc_at( c18_4, c18) ) .
const( loc_at( c19_1, c19) ) .
const( loc_at( c19_2, c19) ) .
const( loc_at( c19_3, c19) ) .
const( loc_at( c19_4, c19) ) .
const( loc_at( c20_1, c20) ) .
const( loc_at( c20_2, c20) ) .
const( loc_at( c20_3, c20) ) .
const( loc_at( c20_4, c20) ) .
const( loc_at( c21_1, c21) ) .
const( loc_at( c21_2, c21) ) .
const( loc_at( c21_3, c21) ) .
const( loc_at( c21_4, c21) ) .
const( loc_at( c22_1, c22) ) .
const( loc_at( c22_2, c22) ) .
const( loc_at( c22_3, c22) ) .
const( loc_at( c22_4, c22) ) .
const( loc_at( c23_1, c23) ) .
const( loc_at( c23_2, c23) ) .
const( loc_at( c23_3, c23) ) .
const( loc_at( c23_4, c23) ) .
const( loc_at( c24_1, c24) ) .
const( loc_at( c24_2, c24) ) .
const( loc_at( c24_3, c24) ) .
const( loc_at( c24_4, c24) ) .
const( loc_at( c25_1, c25) ) .
const( loc_at( c25_2, c25) ) .
const( loc_at( c25_3, c25) ) .
const( loc_at( c25_4, c25) ) .
const( loc_at( c26_1, c26) ) .
const( loc_at( c26_2, c26) ) .
const( loc_at( c26_3, c26) ) .
const( loc_at( c26_4, c26) ) .
const( loc_at( c27_1, c27) ) .
const( loc_at( c27_2, c27) ) .
const( loc_at( c27_3, c27) ) .
const( loc_at( c27_4, c27) ) .



truck_city(tr55,c27).
truck_city(tr54,c26).
truck_city(tr53,c25).
truck_city(tr52,c24).
truck_city(tr51,c23).
truck_city(tr50,c22).
truck_city(tr49,c21).
truck_city(tr48,c20).
truck_city(tr47,c19).
truck_city(tr46,c18).
truck_city(tr45,c17).
truck_city(tr44,c16).
truck_city(tr43,c15).
truck_city(tr42,c14).
truck_city(tr41,c13).
truck_city(tr40,c12).
truck_city(tr39,c11).
truck_city(tr38,c10).
truck_city(tr37,c9).
truck_city(tr36,c8).
truck_city(tr35,c7).
truck_city(tr34,c6).
truck_city(tr33,c5).
truck_city(tr32,c4).
truck_city(tr31,c3).
truck_city(tr30,c2).
truck_city(tr29,c1).
truck_city(tr28,c10).
truck_city(tr27,c7).
truck_city(tr26,c12).
truck_city(tr25,c7).
truck_city(tr24,c11).
truck_city(tr23,c15).
truck_city(tr22,c8).
truck_city(tr21,c8).
truck_city(tr20,c10).
truck_city(tr19,c22).
truck_city(tr18,c25).
truck_city(tr17,c14).
truck_city(tr16,c15).
truck_city(tr15,c25).
truck_city(tr14,c2).
truck_city(tr13,c12).
truck_city(tr12,c19).
truck_city(tr11,c14).
truck_city(tr10,c11).
truck_city(tr9,c24).
truck_city(tr8,c3).
truck_city(tr7,c22).
truck_city(tr6,c25).
truck_city(tr5,c23).
truck_city(tr4,c8).
truck_city(tr3,c3).
truck_city(tr2,c3).
truck_city(tr1,c15).



initial([at(pl9,c7_4),at(pl8,c2_4),at(pl7,c14_4),at(pl6,c25_4),at(pl5,c23_4),at(pl4,c2_4),at(pl3,c13_4),at(pl2,c1_4),at(pl1,c23_4),
at(tr55,c27_2),at(tr54,c26_3),at(tr53,c25_2),at(tr52,c24_3),at(tr51,c23_1),at(tr50,c22_2),at(tr49,c21_1),
at(tr48,c20_2),at(tr47,c19_1),at(tr46,c18_3),at(tr45,c17_1),at(tr44,c16_3),at(tr43,c15_1),at(tr42,c14_3),
at(tr41,c13_1),at(tr40,c12_3),at(tr39,c11_2),at(tr38,c10_1),at(tr37,c9_2),at(tr36,c8_1),at(tr35,c7_2),
at(tr34,c6_1),at(tr33,c5_1),at(tr32,c4_1),at(tr31,c3_3),at(tr30,c2_2),at(tr29,c1_2),at(tr28,c10_4),
at(tr27,c7_3),at(tr26,c12_4),at(tr25,c7_1),at(tr24,c11_3),at(tr23,c15_3),at(tr22,c8_4),at(tr21,c8_3),
at(tr20,c10_1),at(tr19,c22_4),at(tr18,c25_2),at(tr17,c14_2),at(tr16,c15_3),at(tr15,c25_3),at(tr14,c2_3),
at(tr13,c12_3),at(tr12,c19_4),at(tr11,c14_2),at(tr10,c11_3),at(tr9,c24_2),at(tr8,c3_3),at(tr7,c22_2),
at(tr6,c25_2),at(tr5,c23_3),at(tr4,c8_4),at(tr3,c3_4),at(tr2,c3_3),at(tr1,c15_4),
at(p5,c12_1),at(p4,c7_2),at(p3,c8_1),at(p2,c23_3),at(p1,c1_4),
out(p5), out(p4), out(p3), out(p2), out(p1)]):-!.

goal([at(p5,c18_4),at(p4,c10_3),at(p3,c1_4),at(p2,c14_3),at(p1,c9_2),
out(p5), out(p4), out(p3), out(p2), out(p1)]):-!.

goal1( List ):-findall(X, ndt(X), List).


ndt(at(pl9,c18_4)).
ndt(at(pl8,c10_4)).
ndt(at(pl7,c1_4)).
ndt(at(pl6,c14_4)).
ndt(at(pl5,c9_4)).
ndt(at(pl4,c2_4)).
ndt(at(pl3,c13_4)).
ndt(at(pl2,c1_4)).
ndt(at(pl1,c23_4)).

ndt(at(tr55,c27_2)).
ndt(at(tr54,c26_3)).
ndt(at(tr53,c25_2)).
ndt(at(tr52,c24_3)).
ndt(at(tr51,c23_1)).
ndt(at(tr50,c22_2)).
ndt(at(tr49,c21_1)).
ndt(at(tr48,c20_2)).
ndt(at(tr47,c19_1)).
ndt(at(tr46,c18_4)).
ndt(at(tr45,c17_1)).
ndt(at(tr44,c16_3)).
ndt(at(tr43,c15_1)).
ndt(at(tr42,c14_3)).
ndt(at(tr41,c13_1)).
ndt(at(tr40,c12_3)).
ndt(at(tr39,c11_2)).
ndt(at(tr38,c10_3)).
ndt(at(tr37,c9_2)).
ndt(at(tr36,c8_1)).
ndt(at(tr35,c7_2)).
ndt(at(tr34,c6_1)).
ndt(at(tr33,c5_1)).
ndt(at(tr32,c4_1)).
ndt(at(tr31,c3_3)).
ndt(at(tr30,c2_2)).
ndt(at(tr29,c1_4)).
ndt(at(tr28,c10_4)).
ndt(at(tr27,c7_3)).
ndt(at(tr26,c12_4)).
ndt(at(tr25,c7_1)).
ndt(at(tr24,c11_3)).
ndt(at(tr23,c15_3)).
ndt(at(tr22,c8_4)).
ndt(at(tr21,c8_3)).
ndt(at(tr20,c10_1)).
ndt(at(tr19,c22_4)).
ndt(at(tr18,c25_2)).
ndt(at(tr17,c14_3)).
ndt(at(tr16,c15_3)).
ndt(at(tr15,c25_3)).
ndt(at(tr14,c2_3)).
ndt(at(tr13,c12_3)).
ndt(at(tr12,c19_4)).
ndt(at(tr11,c14_2)).
ndt(at(tr10,c11_3)).
ndt(at(tr9,c24_2)).
ndt(at(tr8,c3_3)).
ndt(at(tr7,c22_2)).
ndt(at(tr6,c25_2)).
ndt(at(tr5,c23_3)).
ndt(at(tr4,c8_4)).
ndt(at(tr3,c3_4)).
ndt(at(tr2,c3_3)).
ndt(at(tr1,c15_4)).

