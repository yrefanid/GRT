problem_name('log22.txt').

packages( [p44,p43,p42,p41,p40,
p39,p38,p37,p36,p35,p34,
p33,p32,p31,p30,p29,p28,
p27,p26,p25,p24,p23,p22,
p21,p20,p19,p18,p17,p16,
p15,p14,p13,p12,p11,p10,
p9,p8,p7,p6,p5,p4,p3,
p2,p1] ) .
cities( [c30,c29,c28,c27,c26,c25,
c24,c23,c22,c21,c20,c19,c18,c17,c16,
c15,c14,c13,c12,c11,c10,c9,c8,c7,
c6,c5,c4,c3,c2,c1] ) .
airports( [c30_4,c29_4,c28_4,c27_4,
c26_4,c25_4,c24_4,c23_4,c22_4,c21_4,c20_4,
c19_4,c18_4,c17_4,c16_4,c15_4,c14_4,c13_4,
c12_4,c11_4,c10_4,c9_4,c8_4,c7_4,c6_4,
c5_4,c4_4,c3_4,c2_4,c1_4] ) .
locations( [c30_3,c30_2,c30_1,
c29_3,c29_2,c29_1,c28_3,c28_2,c28_1,c27_3,
c27_2,c27_1,c26_3,c26_2,c26_1,c25_3,c25_2,
c25_1,c24_3,c24_2,c24_1,c23_3,c23_2,c23_1,
c22_3,c22_2,c22_1,c21_3,c21_2,c21_1,c20_3,
c20_2,c20_1,c19_3,c19_2,c19_1,c18_3,c18_2,
c18_1,c17_3,c17_2,c17_1,c16_3,c16_2,c16_1,
c15_3,c15_2,c15_1,c14_3,c14_2,c14_1,c13_3,
c13_2,c13_1,c12_3,c12_2,c12_1,c11_3,c11_2,
c11_1,c10_3,c10_2,c10_1,c9_3,c9_2,c9_1,
c8_3,c8_2,c8_1,c7_3,c7_2,c7_1,c6_3,
c6_2,c6_1,c5_3,c5_2,c5_1,c4_3,c4_2,
c4_1,c3_3,c3_2,c3_1,c2_3,c2_2,c2_1,
c1_3,c1_2,c1_1,c30_4,c29_4,c28_4,c27_4,
c26_4,c25_4,c24_4,c23_4,c22_4,c21_4,c20_4,
c19_4,c18_4,c17_4,c16_4,c15_4,c14_4,c13_4,
c12_4,c11_4,c10_4,c9_4,c8_4,c7_4,c6_4,
c5_4,c4_4,c3_4,c2_4,c1_4 ] ) .
trucks( [tr74,tr73,tr72,
tr71,tr70,tr69,tr68,tr67,tr66,tr65,
tr64,tr63,tr62,tr61,tr60,tr59,tr58,
tr57,tr56,tr55,tr54,tr53,tr52,tr51,
tr50,tr49,tr48,tr47,tr46,tr45,tr44,
tr43,tr42,tr41,tr40,tr39,tr38,tr37,
tr36,tr35,tr34,tr33,tr32,tr31,tr30,
tr29,tr28,tr27,tr26,tr25,tr24,tr23,
tr22,tr21,tr20,tr19,tr18,tr17,tr16,
tr15,tr14,tr13,tr12,tr11,tr10,tr9,tr8,
tr7,tr6,tr5,tr4,tr3,tr2,tr1 ] ) .
airplanes( [pl6,pl5,
pl4,pl3,pl2,pl1 ] ) .

def( at( Package , Location ) ) :- packages( D1 ) , locations( D2 ) , member( Package , D1 ) , member( Location , D2 ) .  
def( at( Airplane , Airport ) ) :- airplanes( D1 ) , airports( D2 ) , member( Airplane , D1 ) , member( Airport , D2 ) .  
def( out( Package ) ) :- packages( D1 ) , member( Package , D1 ) .
def( in( Package , Truck ) ) :- packages( D1 ) , trucks( D2 ) , member( Package , D1 ) , member( Truck , D2 ) .
def( in( Package , Airplane ) ) :- packages( D1 ) , airplanes( D2 ) , member( Package , D1 ) , member( Airplane , D2 ) .
def( at( Truck , Location ) ) :- trucks( D1 ) , locations( D2 ) , member( Truck , D1 ) , member( Location , D2 ), truck_city(Truck, City), const(loc_at(Location, City)) .


const(loc_at(c30_3, c30)).
const(loc_at(c30_2, c30)).
const(loc_at(c30_1, c30)).
const(loc_at(c29_3, c29)).
const(loc_at(c29_2, c29)).
const(loc_at(c29_1, c29)).
const(loc_at(c28_3, c28)).
const(loc_at(c28_2, c28)).
const(loc_at(c28_1, c28)).
const(loc_at(c27_3, c27)).
const(loc_at(c27_2, c27)).
const(loc_at(c27_1, c27)).
const(loc_at(c26_3, c26)).
const(loc_at(c26_2, c26)).
const(loc_at(c26_1, c26)).
const(loc_at(c25_3, c25)).
const(loc_at(c25_2, c25)).
const(loc_at(c25_1, c25)).
const(loc_at(c24_3, c24)).
const(loc_at(c24_2, c24)).
const(loc_at(c24_1, c24)).
const(loc_at(c23_3, c23)).
const(loc_at(c23_2, c23)).
const(loc_at(c23_1, c23)).
const(loc_at(c22_3, c22)).
const(loc_at(c22_2, c22)).
const(loc_at(c22_1, c22)).
const(loc_at(c21_3, c21)).
const(loc_at(c21_2, c21)).
const(loc_at(c21_1, c21)).
const(loc_at(c20_3, c20)).
const(loc_at(c20_2, c20)).
const(loc_at(c20_1, c20)).
const(loc_at(c19_3, c19)).
const(loc_at(c19_2, c19)).
const(loc_at(c19_1, c19)).
const(loc_at(c18_3, c18)).
const(loc_at(c18_2, c18)).
const(loc_at(c18_1, c18)).
const(loc_at(c17_3, c17)).
const(loc_at(c17_2, c17)).
const(loc_at(c17_1, c17)).
const(loc_at(c16_3, c16)).
const(loc_at(c16_2, c16)).
const(loc_at(c16_1, c16)).
const(loc_at(c15_3, c15)).
const(loc_at(c15_2, c15)).
const(loc_at(c15_1, c15)).
const(loc_at(c14_3, c14)).
const(loc_at(c14_2, c14)).
const(loc_at(c14_1, c14)).
const(loc_at(c13_3, c13)).
const(loc_at(c13_2, c13)).
const(loc_at(c13_1, c13)).
const(loc_at(c12_3, c12)).
const(loc_at(c12_2, c12)).
const(loc_at(c12_1, c12)).
const(loc_at(c11_3, c11)).
const(loc_at(c11_2, c11)).
const(loc_at(c11_1, c11)).
const(loc_at(c10_3, c10)).
const(loc_at(c10_2, c10)).
const(loc_at(c10_1, c10)).
const(loc_at(c9_3, c9)).
const(loc_at(c9_2, c9)).
const(loc_at(c9_1, c9)).
const(loc_at(c8_3, c8)).
const(loc_at(c8_2, c8)).
const(loc_at(c8_1, c8)).
const(loc_at(c7_3, c7)).
const(loc_at(c7_2, c7)).
const(loc_at(c7_1, c7)).
const(loc_at(c6_3, c6)).
const(loc_at(c6_2, c6)).
const(loc_at(c6_1, c6)).
const(loc_at(c5_3, c5)).
const(loc_at(c5_2, c5)).
const(loc_at(c5_1, c5)).
const(loc_at(c4_3, c4)).
const(loc_at(c4_2, c4)).
const(loc_at(c4_1, c4)).
const(loc_at(c3_3, c3)).
const(loc_at(c3_2, c3)).
const(loc_at(c3_1, c3)).
const(loc_at(c2_3, c2)).
const(loc_at(c2_2, c2)).
const(loc_at(c2_1, c2)).
const(loc_at(c1_3, c1)).
const(loc_at(c1_2, c1)).
const(loc_at(c1_1, c1)).
const(loc_at(c30_4, c30)).
const(loc_at(c29_4, c29)).
const(loc_at(c28_4, c28)).
const(loc_at(c27_4, c27)).
const(loc_at(c26_4, c26)).
const(loc_at(c25_4, c25)).
const(loc_at(c24_4, c24)).
const(loc_at(c23_4, c23)).
const(loc_at(c22_4, c22)).
const(loc_at(c21_4, c21)).
const(loc_at(c20_4, c20)).
const(loc_at(c19_4, c19)).
const(loc_at(c18_4, c18)).
const(loc_at(c17_4, c17)).
const(loc_at(c16_4, c16)).
const(loc_at(c15_4, c15)).
const(loc_at(c14_4, c14)).
const(loc_at(c13_4, c13)).
const(loc_at(c12_4, c12)).
const(loc_at(c11_4, c11)).
const(loc_at(c10_4, c10)).
const(loc_at(c9_4, c9)).
const(loc_at(c8_4, c8)).
const(loc_at(c7_4, c7)).
const(loc_at(c6_4, c6)).
const(loc_at(c5_4, c5)).
const(loc_at(c4_4, c4)).
const(loc_at(c3_4, c3)).
const(loc_at(c2_4, c2)).
const(loc_at(c1_4, c1)).


truck_city(tr74,c30).
truck_city(tr73,c29).
truck_city(tr72,c28).
truck_city(tr71,c27).
truck_city(tr70,c26).
truck_city(tr69,c25).
truck_city(tr68,c24).
truck_city(tr67,c23).
truck_city(tr66,c22).
truck_city(tr65,c21).
truck_city(tr64,c20).
truck_city(tr63,c19).
truck_city(tr62,c18).
truck_city(tr61,c17).
truck_city(tr60,c16).
truck_city(tr59,c15).
truck_city(tr58,c14).
truck_city(tr57,c13).
truck_city(tr56,c12).
truck_city(tr55,c11).
truck_city(tr54,c10).
truck_city(tr53,c9).
truck_city(tr52,c8).
truck_city(tr51,c7).
truck_city(tr50,c6).
truck_city(tr49,c5).
truck_city(tr48,c4).
truck_city(tr47,c3).
truck_city(tr46,c2).
truck_city(tr45,c1).
truck_city(tr44,c7).
truck_city(tr43,c1).
truck_city(tr42,c29).
truck_city(tr41,c9).
truck_city(tr40,c26).
truck_city(tr39,c12).
truck_city(tr38,c28).
truck_city(tr37,c6).
truck_city(tr36,c8).
truck_city(tr35,c14).
truck_city(tr34,c29).
truck_city(tr33,c4).
truck_city(tr32,c17).
truck_city(tr31,c29).
truck_city(tr30,c14).
truck_city(tr29,c9).
truck_city(tr28,c28).
truck_city(tr27,c18).
truck_city(tr26,c17).
truck_city(tr25,c15).
truck_city(tr24,c28).
truck_city(tr23,c7).
truck_city(tr22,c6).
truck_city(tr21,c29).
truck_city(tr20,c18).
truck_city(tr19,c28).
truck_city(tr18,c26).
truck_city(tr17,c1).
truck_city(tr16,c5).
truck_city(tr15,c18).
truck_city(tr14,c29).
truck_city(tr13,c12).
truck_city(tr12,c30).
truck_city(tr11,c7).
truck_city(tr10,c29).
truck_city(tr9,c26).
truck_city(tr8,c2).
truck_city(tr7,c13).
truck_city(tr6,c3).
truck_city(tr5,c8).
truck_city(tr4,c20).
truck_city(tr3,c10).
truck_city(tr2,c10).
truck_city(tr1,c21).


initial([at(pl6,c11_4),at(pl5,c24_4),at(pl4,c30_4),at(pl3,c9_4),at(pl2,c20_4),at(pl1,c2_4),
at(tr74,c30_2),at(tr73,c29_2),at(tr72,c28_2),at(tr71,c27_3),at(tr70,c26_1),at(tr69,c25_2),at(tr68,c24_1),
at(tr67,c23_3),at(tr66,c22_2),at(tr65,c21_3),at(tr64,c20_1),at(tr63,c19_2),at(tr62,c18_3),at(tr61,c17_1),
at(tr60,c16_1),at(tr59,c15_1),at(tr58,c14_2),at(tr57,c13_3),at(tr56,c12_3),at(tr55,c11_2),at(tr54,c10_3),
at(tr53,c9_2),at(tr52,c8_3),
at(tr51,c7_2),at(tr50,c6_1),
at(tr49,c5_1),at(tr48,c4_3),
at(tr47,c3_3),at(tr46,c2_3),at(tr45,c1_2),at(tr44,c7_3),at(tr43,c1_4),at(tr42,c29_3),at(tr41,c9_2),at(tr40,
c26_2),at(tr39,c12_1),at(tr38,c28_3),at(tr37,c6_4),at(tr36,c8_3),at(tr35,c14_4),at(tr34,c29_4),at(tr33,c4_4),
at(tr32,c17_1),at(tr31,c29_1),at(tr30,c14_2),at(tr29,c9_2),at(tr28,c28_1),at(tr27,c18_2),at(tr26,c17_2),
at(tr25,c15_4),at(tr24,c28_2),at(tr23,c7_3),at(tr22,c6_2),at(tr21,c29_3),at(tr20,c18_2),at(tr19,c28_3),
at(tr18,c26_2),at(tr17,c1_4),at(tr16,c5_1),at(tr15,c18_1),at(tr14,c29_1),at(tr13,c12_4),at(tr12,c30_3),
at(tr11,c7_3),at(tr10,c29_1),at(tr9,c26_4),at(tr8,c2_4),at(tr7,c13_1),at(tr6,c3_4),at(tr5,c8_4),at(tr4,c20_4),at(tr3,c10_1),at(tr2,c10_1),at(tr1,c21_2),
at(p44,c13_1),at(p43,c20_2),
at(p42,c30_4),at(p41,c14_4),at(p40,c10_3),at(p39,c3_3),at(p38,c27_3),at(p37,c30_3),at(p36,c22_1),at(p35,c10_3),
at(p34,c2_4),at(p33,c22_2),at(p32,c1_4),at(p31,c6_3),at(p30,c7_3),at(p29,c5_3),at(p28,c23_2),at(p27,c21_3),
at(p26,c9_4),at(p25,c11_2),at(p24,c12_3),at(p23,c30_2),at(p22,c22_1),at(p21,c18_2),at(p20,c22_1),at(p19,c4_1),
at(p18,c19_2),at(p17,c6_4),at(p16,c9_1),at(p15,c1_1),at(p14,c3_2),at(p13,c28_2),at(p12,c9_3),at(p11,c26_2),
at(p10,c30_2),at(p9,c20_3),at(p8,c27_4),at(p7,c2_2),at(p6,c18_3),at(p5,c20_1),at(p4,c10_3),at(p3,c20_1),at(p2,c8_2),at(p1,c22_1),
out(p44),out(p43),out(p42),out(p41),out(p40),out(p39),out(p38),out(p37),out(p36),out(p35),out(p34),out(p33),out(p32),out(p31),out(p30),out(p29),out(p28),out(p27),out(p26),out(p25),out(p24),out(p23),out(p22),out(p21),out(p20),out(p19),out(p18),out(p17),out(p16),out(p15),out(p14),out(p13),out(p12),out(p11),out(p10),out(p9),out(p8),out(p7),out(p6),out(p5),out(p4),p3,
out(p2),out(p1)]):-!.


goal([at(p44,c29_3),at(p43,c28_3),at(p42,c30_3),at(p41,c29_3),at(p40,c4_2),at(p39,c15_3),
at(p38,c6_4),at(p37,c10_1),at(p36,c28_2),at(p35,c20_2),at(p34,c10_4),at(p33,c21_2),at(p32,c26_4),
at(p31,c17_4),at(p30,c13_4),at(p29,c30_4),at(p28,c12_3),at(p27,c10_1),at(p26,c29_2),at(p25,c22_1),
at(p24,c30_3),at(p23,c20_3),at(p22,c28_4),at(p21,c22_2),at(p20,c16_2),at(p19,c5_3),at(p18,c16_2),
at(p17,c22_2),at(p16,c14_4),at(p15,c18_3),at(p14,c13_2),at(p13,c2_3),at(p12,c28_1),at(p11,c22_2),
at(p10,c5_4),at(p9,c12_3), 
out(p44),out(p43),out(p42),out(p41),out(p40),out(p39),out(p38),out(p37),out(p36),out(p35),out(p34),out(p33),out(p32),out(p31),out(p30),out(p29),out(p28),out(p27),out(p26),out(p25),out(p24),out(p23),out(p22),out(p21),out(p20),out(p19),out(p18),out(p17),out(p16),out(p15),out(p14),out(p13),out(p12),out(p11),out(p10),out(p9)]):-!.

goal1( List ):-findall(X, not_determined(X), List).


ndt(at(p8,c27_4)).
ndt(at(p7,c2_2)).
ndt(at(p6,c18_3)).
ndt(at(p5,c20_1)).
ndt(at(p4,c10_3)).
ndt(at(p3,c20_1)).
ndt(at(p2,c8_2)).
ndt(at(p1,c22_1)).
 ndt(out(p8)).
ndt(out(p7)).
ndt(out(p6)).
ndt(out(p5)).
ndt(out(p4)).
ndt(out(p3)).
ndt(out(p2)).
ndt(out(p1)).
ndt(at(pl6,c11_4)).
ndt(at(pl5,c24_4)).
ndt(at(pl4,c30_4)).
ndt(at(pl3,c9_4)).
ndt(at(pl2,c20_4)).
ndt(at(pl1,c2_4)).
ndt(at(tr74,c30_2)).
ndt(at(tr73,c29_2)).
ndt(at(tr72,c28_2)).
ndt(at(tr71,c27_3)).
ndt(at(tr70,c26_1)).
ndt(at(tr69,c25_2)).
ndt(at(tr68,c24_1)).
ndt(at(tr67,c23_3)).
ndt(at(tr66,c22_2)).
ndt(at(tr65,c21_3)).
ndt(at(tr64,c20_1)).
ndt(at(tr63,c19_2)).
ndt(at(tr62,c18_3)).
ndt(at(tr61,c17_1)).
ndt(at(tr60,c16_1)).
ndt(at(tr59,c15_1)).
ndt(at(tr58,c14_2)).
ndt(at(tr57,c13_3)).
ndt(at(tr56,c12_3)).
ndt(at(tr55,c11_2)).
ndt(at(tr54,c10_3)).
ndt(at(tr53,c9_2)).
ndt(at(tr52,c8_3)).
ndt(at(tr51,c7_2)).
ndt(at(tr50,c6_1)).
ndt(at(tr49,c5_1)).
ndt(at(tr48,c4_3)).
ndt(at(tr47,c3_3)).
ndt(at(tr46,c2_3)).
ndt(at(tr45,c1_2)).
ndt(at(tr44,c7_3)).
ndt(at(tr43,c1_4)).
ndt(at(tr42,c29_3)).
ndt(at(tr41,c9_2)).
ndt(at(tr40,
c26_2)).
ndt(at(tr39,c12_1)).
ndt(at(tr38,c28_3)).
ndt(at(tr37,c6_4)).
ndt(at(tr36,c8_3)).
ndt(at(tr35,c14_4)).
ndt(at(tr34,c29_4)).
ndt(at(tr33,c4_4)).
ndt(at(tr32,c17_1)).
ndt(at(tr31,c29_1)).
ndt(at(tr30,c14_2)).
ndt(at(tr29,c9_2)).
ndt(at(tr28,c28_1)).
ndt(at(tr27,c18_2)).
ndt(at(tr26,c17_2)).
ndt(at(tr25,c15_4)).
ndt(at(tr24,c28_2)).
ndt(at(tr23,c7_3)).
ndt(at(tr22,c6_2)).
ndt(at(tr21,c29_3)).
ndt(at(tr20,c18_2)).
ndt(at(tr19,c28_3)).
ndt(at(tr18,c26_2)).
ndt(at(tr17,c1_4)).
ndt(at(tr16,c5_1)).
ndt(at(tr15,c18_1)).
ndt(at(tr14,c29_1)).
ndt(at(tr13,c12_4)).
ndt(at(tr12,c30_3)).
ndt(at(tr11,c7_3)).
ndt(at(tr10,c29_1)).
ndt(at(tr9,c26_4)).
ndt(at(tr8,c2_4)).
ndt(at(tr7,c13_1)).
ndt(at(tr6,c3_4)).
ndt(at(tr5,c8_4)).
ndt(at(tr4,c20_4)).
ndt(at(tr3,c10_1)).
ndt(at(tr2,c10_1)).
ndt(at(tr1,c21_2)).


