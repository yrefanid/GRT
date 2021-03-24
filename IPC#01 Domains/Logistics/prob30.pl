packages( [p15,p14,p13,p12,p11
,p10,p9,p8,p7,p6,p5,p4
,p3,p2,p1 ] ) .
cities( [c22,c21,c20,c19,c18
,c17,c16,c15,c14,c13,c12,c11,c10,c9
,c8,c7,c6,c5,c4,c3,c2,c1 ] ) .
airports( [c22_12,c21_12,c20_12,c19_12,c18_12,c17_12
,c16_12,c15_12,c14_12,c13_12,c12_12,c11_12
,c10_12,c9_12,c8_12,c7_12,c6_12,c5_12,c4_12
,c3_12,c2_12,c1_12 ] ) .
locations( [c22_11,c22_10,c22_9,c22_8,c22_7
,c22_6,c22_5,c22_4,c22_3,c22_2,c22_1
,c21_11,c21_10,c21_9,c21_8,c21_7,c21_6
,c21_5,c21_4,c21_3,c21_2,c21_1,c20_11
,c20_10,c20_9,c20_8,c20_7,c20_6,c20_5,c20_4
,c20_3,c20_2,c20_1,c19_11,c19_10,c19_9
,c19_8,c19_7,c19_6,c19_5,c19_4,c19_3,c19_2
,c19_1,c18_11,c18_10,c18_9,c18_8,c18_7
,c18_6,c18_5,c18_4,c18_3,c18_2,c18_1
,c17_11,c17_10,c17_9,c17_8,c17_7,c17_6
,c17_5,c17_4,c17_3,c17_2,c17_1,c16_11
,c16_10,c16_9,c16_8,c16_7,c16_6,c16_5,c16_4
,c16_3,c16_2,c16_1,c15_11,c15_10,c15_9
,c15_8,c15_7,c15_6,c15_5,c15_4,c15_3,c15_2
,c15_1,c14_11,c14_10,c14_9,c14_8,c14_7
,c14_6,c14_5,c14_4,c14_3,c14_2,c14_1
,c13_11,c13_10,c13_9,c13_8,c13_7,c13_6
,c13_5,c13_4,c13_3,c13_2,c13_1,c12_11
,c12_10,c12_9,c12_8,c12_7,c12_6,c12_5,c12_4
,c12_3,c12_2,c12_1,c11_11,c11_10,c11_9
,c11_8,c11_7,c11_6,c11_5,c11_4,c11_3,c11_2
,c11_1,c10_11,c10_10,c10_9,c10_8,c10_7
,c10_6,c10_5,c10_4,c10_3,c10_2,c10_1,c9_11
,c9_10,c9_9,c9_8,c9_7,c9_6,c9_5,c9_4
,c9_3,c9_2,c9_1,c8_11,c8_10,c8_9,c8_8
,c8_7,c8_6,c8_5,c8_4,c8_3,c8_2,c8_1
,c7_11,c7_10,c7_9,c7_8,c7_7,c7_6,c7_5
,c7_4,c7_3,c7_2,c7_1,c6_11,c6_10,c6_9
,c6_8,c6_7,c6_6,c6_5,c6_4,c6_3,c6_2
,c6_1,c5_11,c5_10,c5_9,c5_8,c5_7,c5_6
,c5_5,c5_4,c5_3,c5_2,c5_1,c4_11,c4_10
,c4_9,c4_8,c4_7,c4_6,c4_5,c4_4,c4_3
,c4_2,c4_1,c3_11,c3_10,c3_9,c3_8,c3_7
,c3_6,c3_5,c3_4,c3_3,c3_2,c3_1,c2_11
,c2_10,c2_9,c2_8,c2_7,c2_6,c2_5,c2_4
,c2_3,c2_2,c2_1,c1_11,c1_10,c1_9,c1_8
,c1_7,c1_6,c1_5,c1_4,c1_3,c1_2,c1_1
,c22_12,c21_12,c20_12,c19_12,c18_12,c17_12
,c16_12,c15_12,c14_12,c13_12,c12_12,c11_12
,c10_12,c9_12,c8_12,c7_12,c6_12,c5_12,c4_12
,c3_12,c2_12,c1_12] ) .
trucks( [tr80
,tr79,tr78,tr77,tr76,tr75,tr74,tr73
,tr72,tr71,tr70,tr69,tr68,tr67,tr66
,tr65,tr64,tr63,tr62,tr61,tr60,tr59
,tr58,tr57,tr56,tr55,tr54,tr53,tr52
,tr51,tr50,tr49,tr48,tr47,tr46,tr45
,tr44,tr43,tr42,tr41,tr40,tr39,tr38
,tr37,tr36,tr35,tr34,tr33,tr32,tr31
,tr30,tr29,tr28,tr27,tr26,tr25,tr24
,tr23,tr22,tr21,tr20,tr19,tr18,tr17
,tr16,tr15,tr14,tr13,tr12,tr11,tr10,tr9
,tr8,tr7,tr6,tr5,tr4,tr3,tr2,tr1 ] ) .
airplanes( [pl3
,pl2,pl1 ] ) .


def( at( Package , Location ) ) :- packages( D1 ) , locations( D2 ) , member( Package , D1 ) , member( Location , D2 ) .  
def( at( Airplane , Airport ) ) :- airplanes( D1 ) , airports( D2 ) , member( Airplane , D1 ) , member( Airport , D2 ) .  
def( out( Package ) ) :- packages( D1 ) , member( Package , D1 ) .
def( in( Package , Truck ) ) :- packages( D1 ) , trucks( D2 ) , member( Package , D1 ) , member( Truck , D2 ) .
def( in( Package , Airplane ) ) :- packages( D1 ) , airplanes( D2 ) , member( Package , D1 ) , member( Airplane , D2 ) .
def( at( Truck , Location ) ) :- trucks( D1 ) , locations( D2 ) , member( Truck , D1 ) , member( Location , D2 ), truck_city(Truck, City), const(loc_at(Location, City)) .


const(loc_at(c22_11, c22)).
const(loc_at(c22_10, c22)).
const(loc_at(c22_9, c22)).
const(loc_at(c22_8, c22)).
const(loc_at(c22_7, c22)).
const(loc_at(c22_6, c22)).
const(loc_at(c22_5, c22)).
const(loc_at(c22_4, c22)).
const(loc_at(c22_3, c22)).
const(loc_at(c22_2, c22)).
const(loc_at(c22_1, c22)).
const(loc_at(c21_11, c21)).
const(loc_at(c21_10, c21)).
const(loc_at(c21_9, c21)).
const(loc_at(c21_8, c21)).
const(loc_at(c21_7, c21)).
const(loc_at(c21_6, c21)).
const(loc_at(c21_5, c21)).
const(loc_at(c21_4, c21)).
const(loc_at(c21_3, c21)).
const(loc_at(c21_2, c21)).
const(loc_at(c21_1, c21)).
const(loc_at(c20_11, c20)).
const(loc_at(c20_10, c20)).
const(loc_at(c20_9, c20)).
const(loc_at(c20_8, c20)).
const(loc_at(c20_7, c20)).
const(loc_at(c20_6, c20)).
const(loc_at(c20_5, c20)).
const(loc_at(c20_4, c20)).
const(loc_at(c20_3, c20)).
const(loc_at(c20_2, c20)).
const(loc_at(c20_1, c20)).
const(loc_at(c19_11, c19)).
const(loc_at(c19_10, c19)).
const(loc_at(c19_9, c19)).
const(loc_at(c19_8, c19)).
const(loc_at(c19_7, c19)).
const(loc_at(c19_6, c19)).
const(loc_at(c19_5, c19)).
const(loc_at(c19_4, c19)).
const(loc_at(c19_3, c19)).
const(loc_at(c19_2, c19)).
const(loc_at(c19_1, c19)).
const(loc_at(c18_11, c18)).
const(loc_at(c18_10, c18)).
const(loc_at(c18_9, c18)).
const(loc_at(c18_8, c18)).
const(loc_at(c18_7, c18)).
const(loc_at(c18_6, c18)).
const(loc_at(c18_5, c18)).
const(loc_at(c18_4, c18)).
const(loc_at(c18_3, c18)).
const(loc_at(c18_2, c18)).
const(loc_at(c18_1, c18)).
const(loc_at(c17_11, c17)).
const(loc_at(c17_10, c17)).
const(loc_at(c17_9, c17)).
const(loc_at(c17_8, c17)).
const(loc_at(c17_7, c17)).
const(loc_at(c17_6, c17)).
const(loc_at(c17_5, c17)).
const(loc_at(c17_4, c17)).
const(loc_at(c17_3, c17)).
const(loc_at(c17_2, c17)).
const(loc_at(c17_1, c17)).
const(loc_at(c16_11, c16)).
const(loc_at(c16_10, c16)).
const(loc_at(c16_9, c16)).
const(loc_at(c16_8, c16)).
const(loc_at(c16_7, c16)).
const(loc_at(c16_6, c16)).
const(loc_at(c16_5, c16)).
const(loc_at(c16_4, c16)).
const(loc_at(c16_3, c16)).
const(loc_at(c16_2, c16)).
const(loc_at(c16_1, c16)).
const(loc_at(c15_11, c15)).
const(loc_at(c15_10, c15)).
const(loc_at(c15_9, c15)).
const(loc_at(c15_8, c15)).
const(loc_at(c15_7, c15)).
const(loc_at(c15_6, c15)).
const(loc_at(c15_5, c15)).
const(loc_at(c15_4, c15)).
const(loc_at(c15_3, c15)).
const(loc_at(c15_2, c15)).
const(loc_at(c15_1, c15)).
const(loc_at(c14_11, c14)).
const(loc_at(c14_10, c14)).
const(loc_at(c14_9, c14)).
const(loc_at(c14_8, c14)).
const(loc_at(c14_7, c14)).
const(loc_at(c14_6, c14)).
const(loc_at(c14_5, c14)).
const(loc_at(c14_4, c14)).
const(loc_at(c14_3, c14)).
const(loc_at(c14_2, c14)).
const(loc_at(c14_1, c14)).
const(loc_at(c13_11, c13)).
const(loc_at(c13_10, c13)).
const(loc_at(c13_9, c13)).
const(loc_at(c13_8, c13)).
const(loc_at(c13_7, c13)).
const(loc_at(c13_6, c13)).
const(loc_at(c13_5, c13)).
const(loc_at(c13_4, c13)).
const(loc_at(c13_3, c13)).
const(loc_at(c13_2, c13)).
const(loc_at(c13_1, c13)).
const(loc_at(c12_11, c12)).
const(loc_at(c12_10, c12)).
const(loc_at(c12_9, c12)).
const(loc_at(c12_8, c12)).
const(loc_at(c12_7, c12)).
const(loc_at(c12_6, c12)).
const(loc_at(c12_5, c12)).
const(loc_at(c12_4, c12)).
const(loc_at(c12_3, c12)).
const(loc_at(c12_2, c12)).
const(loc_at(c12_1, c12)).
const(loc_at(c11_11, c11)).
const(loc_at(c11_10, c11)).
const(loc_at(c11_9, c11)).
const(loc_at(c11_8, c11)).
const(loc_at(c11_7, c11)).
const(loc_at(c11_6, c11)).
const(loc_at(c11_5, c11)).
const(loc_at(c11_4, c11)).
const(loc_at(c11_3, c11)).
const(loc_at(c11_2, c11)).
const(loc_at(c11_1, c11)).
const(loc_at(c10_11, c10)).
const(loc_at(c10_10, c10)).
const(loc_at(c10_9, c10)).
const(loc_at(c10_8, c10)).
const(loc_at(c10_7, c10)).
const(loc_at(c10_6, c10)).
const(loc_at(c10_5, c10)).
const(loc_at(c10_4, c10)).
const(loc_at(c10_3, c10)).
const(loc_at(c10_2, c10)).
const(loc_at(c10_1, c10)).
const(loc_at(c9_11, c9)).
const(loc_at(c9_10, c9)).
const(loc_at(c9_9, c9)).
const(loc_at(c9_8, c9)).
const(loc_at(c9_7, c9)).
const(loc_at(c9_6, c9)).
const(loc_at(c9_5, c9)).
const(loc_at(c9_4, c9)).
const(loc_at(c9_3, c9)).
const(loc_at(c9_2, c9)).
const(loc_at(c9_1, c9)).
const(loc_at(c8_11, c8)).
const(loc_at(c8_10, c8)).
const(loc_at(c8_9, c8)).
const(loc_at(c8_8, c8)).
const(loc_at(c8_7, c8)).
const(loc_at(c8_6, c8)).
const(loc_at(c8_5, c8)).
const(loc_at(c8_4, c8)).
const(loc_at(c8_3, c8)).
const(loc_at(c8_2, c8)).
const(loc_at(c8_1, c8)).
const(loc_at(c7_11, c7)).
const(loc_at(c7_10, c7)).
const(loc_at(c7_9, c7)).
const(loc_at(c7_8, c7)).
const(loc_at(c7_7, c7)).
const(loc_at(c7_6, c7)).
const(loc_at(c7_5, c7)).
const(loc_at(c7_4, c7)).
const(loc_at(c7_3, c7)).
const(loc_at(c7_2, c7)).
const(loc_at(c7_1, c7)).
const(loc_at(c6_11, c6)).
const(loc_at(c6_10, c6)).
const(loc_at(c6_9, c6)).
const(loc_at(c6_8, c6)).
const(loc_at(c6_7, c6)).
const(loc_at(c6_6, c6)).
const(loc_at(c6_5, c6)).
const(loc_at(c6_4, c6)).
const(loc_at(c6_3, c6)).
const(loc_at(c6_2, c6)).
const(loc_at(c6_1, c6)).
const(loc_at(c5_11, c5)).
const(loc_at(c5_10, c5)).
const(loc_at(c5_9, c5)).
const(loc_at(c5_8, c5)).
const(loc_at(c5_7, c5)).
const(loc_at(c5_6, c5)).
const(loc_at(c5_5, c5)).
const(loc_at(c5_4, c5)).
const(loc_at(c5_3, c5)).
const(loc_at(c5_2, c5)).
const(loc_at(c5_1, c5)).
const(loc_at(c4_11, c4)).
const(loc_at(c4_10, c4)).
const(loc_at(c4_9, c4)).
const(loc_at(c4_8, c4)).
const(loc_at(c4_7, c4)).
const(loc_at(c4_6, c4)).
const(loc_at(c4_5, c4)).
const(loc_at(c4_4, c4)).
const(loc_at(c4_3, c4)).
const(loc_at(c4_2, c4)).
const(loc_at(c4_1, c4)).
const(loc_at(c3_11, c3)).
const(loc_at(c3_10, c3)).
const(loc_at(c3_9, c3)).
const(loc_at(c3_8, c3)).
const(loc_at(c3_7, c3)).
const(loc_at(c3_6, c3)).
const(loc_at(c3_5, c3)).
const(loc_at(c3_4, c3)).
const(loc_at(c3_3, c3)).
const(loc_at(c3_2, c3)).
const(loc_at(c3_1, c3)).
const(loc_at(c2_11, c2)).
const(loc_at(c2_10, c2)).
const(loc_at(c2_9, c2)).
const(loc_at(c2_8, c2)).
const(loc_at(c2_7, c2)).
const(loc_at(c2_6, c2)).
const(loc_at(c2_5, c2)).
const(loc_at(c2_4, c2)).
const(loc_at(c2_3, c2)).
const(loc_at(c2_2, c2)).
const(loc_at(c2_1, c2)).
const(loc_at(c1_11, c1)).
const(loc_at(c1_10, c1)).
const(loc_at(c1_9, c1)).
const(loc_at(c1_8, c1)).
const(loc_at(c1_7, c1)).
const(loc_at(c1_6, c1)).
const(loc_at(c1_5, c1)).
const(loc_at(c1_4, c1)).
const(loc_at(c1_3, c1)).
const(loc_at(c1_2, c1)).
const(loc_at(c1_1, c1)).
const(loc_at(c22_12, c22)).
const(loc_at(c21_12, c21)).
const(loc_at(c20_12, c20)).
const(loc_at(c19_12, c19)).
const(loc_at(c18_12, c18)).
const(loc_at(c17_12, c17)).
const(loc_at(c16_12, c16)).
const(loc_at(c15_12, c15)).
const(loc_at(c14_12, c14)).
const(loc_at(c13_12, c13)).
const(loc_at(c12_12, c12)).
const(loc_at(c11_12, c11)).
const(loc_at(c10_12, c10)).
const(loc_at(c9_12, c9)).
const(loc_at(c8_12, c8)).
const(loc_at(c7_12, c7)).
const(loc_at(c6_12, c6)).
const(loc_at(c5_12, c5)).
const(loc_at(c4_12, c4)).
const(loc_at(c3_12, c3)).
const(loc_at(c2_12, c2)).
const(loc_at(c1_12, c1)).


loc_at(tr80,c22).
loc_at(tr79,c21).
loc_at(tr78,c20).
loc_at(tr77,c19).
loc_at(tr76,c18).
loc_at(tr75,c17).
loc_at(tr74,c16).
loc_at(tr73,c15).
loc_at(tr72,c14).
loc_at(tr71,c13).
loc_at(tr70,c12).
loc_at(tr69,c11).
loc_at(tr68,c10).
loc_at(tr67,c9).
loc_at(tr66,c8).
loc_at(tr65,c7).
loc_at(tr64,c6).
loc_at(tr63,c5).
loc_at(tr62,c4).
loc_at(tr61,c3).
loc_at(tr60,c2).
loc_at(tr59,c1).
loc_at(tr58,c1).
loc_at(tr57,c20).
loc_at(tr56,c5).
loc_at(tr55,c19).
loc_at(tr54,c5).
loc_at(tr53,c11).
loc_at(tr52,c21).
loc_at(tr51,c3).
loc_at(tr50,c11).
loc_at(tr49,c9).
loc_at(tr48,c17).
loc_at(tr47,c6).
loc_at(tr46,c3).
loc_at(tr45,c14).
loc_at(tr44,c8).
loc_at(tr43,c5).
loc_at(tr42,c2).
loc_at(tr41,c15).
loc_at(tr40,c14).
loc_at(tr39,c7).
loc_at(tr38,c10).
loc_at(tr37,c21).
loc_at(tr36,c11).
loc_at(tr35,c21).
loc_at(tr34,c15).
loc_at(tr33,c7).
loc_at(tr32,c8).
loc_at(tr31,c22).
loc_at(tr30,c16).
loc_at(tr29,c8).
loc_at(tr28,c15).
loc_at(tr27,c12).
loc_at(tr26,c14).
loc_at(tr25,c8).
loc_at(tr24,c10).
loc_at(tr23,c10).
loc_at(tr22,c11).
loc_at(tr21,c9).
loc_at(tr20,c6).
loc_at(tr19,c4).
loc_at(tr18,c5).
loc_at(tr17,c5).
loc_at(tr16,c7).
loc_at(tr15,c21).
loc_at(tr14,c16).
loc_at(tr13,c1).
loc_at(tr12,c2).
loc_at(tr11,c4).
loc_at(tr10,c7).
loc_at(tr9,c8).
loc_at(tr8,c12).
loc_at(tr7,c19).
loc_at(tr6,c3).
loc_at(tr5,c13).
loc_at(tr4,c6).
loc_at(tr3,c2).
loc_at(tr2,c11).
loc_at(tr1,c14).


initial([at(pl3,c20_12),at(pl2,c8_12),at(pl1,c14_12),
at(tr80,c22_1),at(tr79,c21_7),at(tr78,c20_4),at(tr77,c19_7),at(tr76,c18_4),at(tr75,c17_5),at(tr74,c16_2),
at(tr73,c15_9),at(tr72,c14_4),at(tr71,c13_9),at(tr70,c12_5),at(tr69,c11_1),at(tr68,c10_9),at(tr67,c9_8),
at(tr66,c8_8),at(tr65,c7_1),at(tr64,c6_2),at(tr63,c5_4),at(tr62,c4_1),at(tr61,c3_7),at(tr60,c2_7),
at(tr59,c1_10),at(tr58,c1_5),at(tr57,c20_9),at(tr56,c5_10),at(tr55,c19_5),at(tr54,c5_2),at(tr53,c11_8),
at(tr52,c21_9),at(tr51,c3_4),at(tr50,c11_1),at(tr49,c9_6),at(tr48,c17_11),at(tr47,c6_6),at(tr46,c3_7),
at(tr45,c14_6),at(tr44,c8_3),at(tr43,c5_2),at(tr42,c2_8),at(tr41,c15_11),at(tr40,c14_5),at(tr39,c7_2),
at(tr38,c10_8),at(tr37,c21_6),at(tr36,c11_2),at(tr35,c21_6),at(tr34,c15_12),at(tr33,c7_12),at(tr32,c8_3),
at(tr31,c22_9),at(tr30,c16_7),at(tr29,c8_6),at(tr28,c15_7),at(tr27,c12_12),at(tr26,c14_10),at(tr25,c8_7),
at(tr24,c10_7),at(tr23,c10_10),at(tr22,c11_3),at(tr21,c9_5),at(tr20,c6_3),at(tr19,c4_4),at(tr18,c5_6),
at(tr17,c5_10),at(tr16,c7_3),at(tr15,c21_7),at(tr14,c16_9),at(tr13,c1_10),at(tr12,c2_10),at(tr11,c4_9),
at(tr10,c7_11),at(tr9,c8_9),at(tr8,c12_7),at(tr7,c19_5),at(tr6,c3_12),at(tr5,c13_2),at(tr4,c6_12),
at(tr3,c2_6),at(tr2,c11_3),at(tr1,c14_1),
at(p15,c5_7),at(p14,c15_7),at(p13,c11_12),at(p12,c8_3),at(p11,c10_7),at(p10,c14_11),at(p9,c16_1),
at(p8,c21_12),at(p7,c13_4),at(p6,c2_3),at(p5,c6_10),at(p4,c11_2),at(p3,c7_7),at(p2,c8_6),at(p1,c6_12),
out(p15),out(p14),out(p13),out(p12),out(p11),out(p10),out(p9),out(p8),out(p7),out(p6),out(p5),out(p4),out(p3),out(p2),out(p1)]):-!.



goal([at(p15,c14_12),at(p14,c20_9),at(p13,c5_8),at(p12,c20_4),at(p11,c1_4),at(p10,c20_7),
at(p9,c2_5),at(p8,c11_10),at(p7,c4_12),at(p6,c3_11),at(p5,c9_3),at(p4,c9_6),at(p3,c5_12),at(p2,c11_8),at(p1,c5_5),
out(p15),out(p14),out(p13),out(p12),out(p11),out(p10),out(p9),out(p8),out(p7),out(p6),out(p5),out(p4),out(p3),out(p2),out(p1)]):-!.




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
	member(Object, [p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12,
	p13, p14, p15, p16, p17, p18]), 
	locations(Locations), 
	member(Location, Locations).

not_determined(out(Object)):-
	member(Object, [p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12,
	p13, p14, p15, p16, p17, p18]).

not_determined(in(Object, Truck)):-
	member(Object, [p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12,
	p13, p14, p15, p16, p17, p18]), 
	trucks(Trucks),
	member(Truck, Trucks).

not_determined(in(Object, Airplane)):-
	member(Object, [p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12,
	p13, p14, p15, p16, p17, p18]), 
	airplanes(Airplanes),
	member(Airplane, Airplanes).










