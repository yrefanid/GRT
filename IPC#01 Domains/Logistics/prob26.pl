packages( [p33,p32,p31,p30,p29
,p28,p27,p26,p25,p24,p23
,p22,p21,p20,p19,p18,p17
,p16,p15,p14,p13,p12,p11
,p10,p9,p8,p7,p6,p5,p4
,p3,p2,p1] ) .
cities( [c47,c46,c45,c44,c43
,c42,c41,c40,c39,c38,c37,c36,c35,c34
,c33,c32,c31,c30,c29,c28,c27,c26,c25
,c24,c23,c22,c21,c20,c19,c18,c17,c16
,c15,c14,c13,c12,c11,c10,c9,c8,c7
,c6,c5,c4,c3,c2,c1 ] ) .
airports( [c44_2,c43_2,c42_2,c41_2,c40_2,c39_2,c38_2
,c37_2,c36_2,c35_2,c34_2,c33_2,c32_2,c31_2
,c30_2,c29_2,c28_2,c27_2,c26_2,c25_2,c24_2
,c23_2,c22_2,c21_2,c20_2,c19_2,c18_2,c17_2
,c16_2,c15_2,c14_2,c13_2,c12_2,c11_2,c10_2
,c9_2,c8_2,c7_2,c6_2,c5_2,c4_2,c3_2
,c2_2,c1_2 ] ) .
locations( [c47_1
,c46_1,c45_1,c44_1,c43_1,c42_1,c41_1,c40_1
,c39_1,c38_1,c37_1,c36_1,c35_1,c34_1,c33_1
,c32_1,c31_1,c30_1,c29_1,c28_1,c27_1,c26_1
,c25_1,c24_1,c23_1,c22_1,c21_1,c20_1,c19_1
,c18_1,c17_1,c16_1,c15_1,c14_1,c13_1,c12_1
,c11_1,c10_1,c9_1,c8_1,c7_1,c6_1,c5_1
,c4_1,c3_1,c2_1,c1_1,c47_2,c46_2,c45_2
,c44_2,c43_2,c42_2,c41_2,c40_2,c39_2,c38_2
,c37_2,c36_2,c35_2,c34_2,c33_2,c32_2,c31_2
,c30_2,c29_2,c28_2,c27_2,c26_2,c25_2,c24_2
,c23_2,c22_2,c21_2,c20_2,c19_2,c18_2,c17_2
,c16_2,c15_2,c14_2,c13_2,c12_2,c11_2,c10_2
,c9_2,c8_2,c7_2,c6_2,c5_2,c4_2,c3_2
,c2_2,c1_2 ] ) .
trucks( [tr106,tr105
,tr104,tr103,tr102,tr101,tr100,tr99,tr98
,tr97,tr96,tr95,tr94,tr93,tr92,tr91
,tr90,tr89,tr88,tr87,tr86,tr85,tr84
,tr83,tr82,tr81,tr80,tr79,tr78,tr77
,tr76,tr75,tr74,tr73,tr72,tr71,tr70
,tr69,tr68,tr67,tr66,tr65,tr64,tr63
,tr62,tr61,tr60,tr59,tr58,tr57,tr56
,tr55,tr54,tr53,tr52,tr51,tr50,tr49
,tr48,tr47,tr46,tr45,tr44,tr43,tr42
,tr41,tr40,tr39,tr38,tr37,tr36,tr35
,tr34,tr33,tr32,tr31,tr30,tr29,tr28
,tr27,tr26,tr25,tr24,tr23,tr22,tr21
,tr20,tr19,tr18,tr17,tr16,tr15,tr14
,tr13,tr12,tr11,tr10,tr9,tr8,tr7,tr6
,tr5,tr4,tr3,tr2,tr1 ] ) .
airplanes( [pl2,pl1 ] ) .

def( at( Package , Location ) ) :- packages( D1 ) , locations( D2 ) , member( Package , D1 ) , member( Location , D2 ) .  
def( at( Airplane , Airport ) ) :- airplanes( D1 ) , airports( D2 ) , member( Airplane , D1 ) , member( Airport , D2 ) .  
def( out( Package ) ) :- packages( D1 ) , member( Package , D1 ) .
def( in( Package , Truck ) ) :- packages( D1 ) , trucks( D2 ) , member( Package , D1 ) , member( Truck , D2 ) .
def( in( Package , Airplane ) ) :- packages( D1 ) , airplanes( D2 ) , member( Package , D1 ) , member( Airplane , D2 ) .
def( at( Truck , Location ) ) :- trucks( D1 ) , locations( D2 ) , member( Truck , D1 ) , member( Location , D2 ), truck_city(Truck, City), const(loc_at(Location, City)) .


const(loc_at(c47_1, c47)).
const(loc_at(c46_1, c46)).
const(loc_at(c45_1, c45)).
const(loc_at(c44_1, c44)).
const(loc_at(c43_1, c43)).
const(loc_at(c42_1, c42)).
const(loc_at(c41_1, c41)).
const(loc_at(c40_1, c40)).
const(loc_at(c39_1, c39)).
const(loc_at(c38_1, c38)).
const(loc_at(c37_1, c37)).
const(loc_at(c36_1, c36)).
const(loc_at(c35_1, c35)).
const(loc_at(c34_1, c34)).
const(loc_at(c33_1, c33)).
const(loc_at(c32_1, c32)).
const(loc_at(c31_1, c31)).
const(loc_at(c30_1, c30)).
const(loc_at(c29_1, c29)).
const(loc_at(c28_1, c28)).
const(loc_at(c27_1, c27)).
const(loc_at(c26_1, c26)).
const(loc_at(c25_1, c25)).
const(loc_at(c24_1, c24)).
const(loc_at(c23_1, c23)).
const(loc_at(c22_1, c22)).
const(loc_at(c21_1, c21)).
const(loc_at(c20_1, c20)).
const(loc_at(c19_1, c19)).
const(loc_at(c18_1, c18)).
const(loc_at(c17_1, c17)).
const(loc_at(c16_1, c16)).
const(loc_at(c15_1, c15)).
const(loc_at(c14_1, c14)).
const(loc_at(c13_1, c13)).
const(loc_at(c12_1, c12)).
const(loc_at(c11_1, c11)).
const(loc_at(c10_1, c10)).
const(loc_at(c9_1, c9)).
const(loc_at(c8_1, c8)).
const(loc_at(c7_1, c7)).
const(loc_at(c6_1, c6)).
const(loc_at(c5_1, c5)).
const(loc_at(c4_1, c4)).
const(loc_at(c3_1, c3)).
const(loc_at(c2_1, c2)).
const(loc_at(c1_1, c1)).
const(loc_at(c47_2, c47)).
const(loc_at(c46_2, c46)).
const(loc_at(c45_2, c45)).
const(loc_at(c44_2, c44)).
const(loc_at(c43_2, c43)).
const(loc_at(c42_2, c42)).
const(loc_at(c41_2, c41)).
const(loc_at(c40_2, c40)).
const(loc_at(c39_2, c39)).
const(loc_at(c38_2, c38)).
const(loc_at(c37_2, c37)).
const(loc_at(c36_2, c36)).
const(loc_at(c35_2, c35)).
const(loc_at(c34_2, c34)).
const(loc_at(c33_2, c33)).
const(loc_at(c32_2, c32)).
const(loc_at(c31_2, c31)).
const(loc_at(c30_2, c30)).
const(loc_at(c29_2, c29)).
const(loc_at(c28_2, c28)).
const(loc_at(c27_2, c27)).
const(loc_at(c26_2, c26)).
const(loc_at(c25_2, c25)).
const(loc_at(c24_2, c24)).
const(loc_at(c23_2, c23)).
const(loc_at(c22_2, c22)).
const(loc_at(c21_2, c21)).
const(loc_at(c20_2, c20)).
const(loc_at(c19_2, c19)).
const(loc_at(c18_2, c18)).
const(loc_at(c17_2, c17)).
const(loc_at(c16_2, c16)).
const(loc_at(c15_2, c15)).
const(loc_at(c14_2, c14)).
const(loc_at(c13_2, c13)).
const(loc_at(c12_2, c12)).
const(loc_at(c11_2, c11)).
const(loc_at(c10_2, c10)).
const(loc_at(c9_2, c9)).
const(loc_at(c8_2, c8)).
const(loc_at(c7_2, c7)).
const(loc_at(c6_2, c6)).
const(loc_at(c5_2, c5)).
const(loc_at(c4_2, c4)).
const(loc_at(c3_2, c3)).
const(loc_at(c2_2, c2)).
const(loc_at(c1_2, c1)).


truck_city(tr106,c47).
truck_city(tr105,c46).
truck_city(tr104,c45).
truck_city(tr103,c44).
truck_city(tr102,c43).
truck_city(tr101,c42).
truck_city(tr100,c41).
truck_city(tr99,c40).
truck_city(tr98,c39).
truck_city(tr97,c38).
truck_city(tr96,c37).
truck_city(tr95,c36).
truck_city(tr94,c35).
truck_city(tr93,c34).
truck_city(tr92,c33).
truck_city(tr91,c32).
truck_city(tr90,c31).
truck_city(tr89,c30).
truck_city(tr88,c29).
truck_city(tr87,c28).
truck_city(tr86,c27).
truck_city(tr85,c26).
truck_city(tr84,c25).
truck_city(tr83,c24).
truck_city(tr82,c23).
truck_city(tr81,c22).
truck_city(tr80,c21).
truck_city(tr79,c20).
truck_city(tr78,c19).
truck_city(tr77,c18).
truck_city(tr76,c17).
truck_city(tr75,c16).
truck_city(tr74,c15).
truck_city(tr73,c14).
truck_city(tr72,c13).
truck_city(tr71,c12).
truck_city(tr70,c11).
truck_city(tr69,c10).
truck_city(tr68,c9).
truck_city(tr67,c8).
truck_city(tr66,c7).
truck_city(tr65,c6).
truck_city(tr64,c5).
truck_city(tr63,c4).
truck_city(tr62,c3).
truck_city(tr61,c2).
truck_city(tr60,c1).
truck_city(tr59,c1).
truck_city(tr58,c12).
truck_city(tr57,c15).
truck_city(tr56,c28).
truck_city(tr55,c7).
truck_city(tr54,c36).
truck_city(tr53,c15).
truck_city(tr52,c45).
truck_city(tr51,c3).
truck_city(tr50,c44).
truck_city(tr49,c42).
truck_city(tr48,c42).
truck_city(tr47,c23).
truck_city(tr46,c5).
truck_city(tr45,c11).
truck_city(tr44,c23).
truck_city(tr43,c19).
truck_city(tr42,c17).
truck_city(tr41,c42).
truck_city(tr40,c25).
truck_city(tr39,c14).
truck_city(tr38,c9).
truck_city(tr37,c32).
truck_city(tr36,c3).
truck_city(tr35,c13).
truck_city(tr34,c47).
truck_city(tr33,c1).
truck_city(tr32,c10).
truck_city(tr31,c35).
truck_city(tr30,c44).
truck_city(tr29,c14).
truck_city(tr28,c23).
truck_city(tr27,c24).
truck_city(tr26,c24).
truck_city(tr25,c23).
truck_city(tr24,c5).
truck_city(tr23,c4).
truck_city(tr22,c30).
truck_city(tr21,c6).
truck_city(tr20,c31).
truck_city(tr19,c7).
truck_city(tr18,c35).
truck_city(tr17,c40).
truck_city(tr16,c45).
truck_city(tr15,c35).
truck_city(tr14,c12).
truck_city(tr13,c2).
truck_city(tr12,c29).
truck_city(tr11,c1).
truck_city(tr10,c25).
truck_city(tr9,c1).
truck_city(tr8,c30).
truck_city(tr7,c16).
truck_city(tr6,c25).
truck_city(tr5,c37).
truck_city(tr4,c41).
truck_city(tr3,c36).
truck_city(tr2,c39).
truck_city(tr1,c4).


initial([at(pl2,c37_2),at(pl1,c33_2),
at(tr106,c47_1),at(tr105,c46_1),at(tr104,c45_1),at(tr103,c44_1),at(tr102,c43_1),at(tr101,c42_1),at(tr100,c41_1),
at(tr99,c40_1),at(tr98,c39_1),
at(tr97,c38_1),at(tr96,c37_1),at(tr95,c36_1),at(tr94,c35_1),at(tr93,c34_1),at(tr92,c33_1),at(tr91,c32_1),
at(tr90,c31_1),at(tr89,c30_1),at(tr88,c29_1),at(tr87,c28_1),at(tr86,c27_1),at(tr85,c26_1),at(tr84,c25_1),
at(tr83,c24_1),at(tr82,c23_1),at(tr81,c22_1),at(tr80,c21_1),at(tr79,c20_1),at(tr78,c19_1),at(tr77,c18_1),
at(tr76,c17_1),at(tr75,c16_1),at(tr74,c15_1),at(tr73,c14_1),at(tr72,c13_1),at(tr71,c12_1),at(tr70,c11_1),
at(tr69,c10_1),at(tr68,c9_1),at(tr67,c8_1),at(tr66,c7_1),at(tr65,c6_1),at(tr64,c5_1),at(tr63,c4_1),at(tr62,c3_1),
at(tr61,c2_1),at(tr60,c1_1),at(tr59,c1_2),at(tr58,c12_1),at(tr57,c15_2),at(tr56,c28_2),at(tr55,c7_1),at(tr54,c36_1),
at(tr53,c15_1),at(tr52,c45_2),at(tr51,c3_1),at(tr50,c44_2),at(tr49,c42_1),at(tr48,c42_2),at(tr47,c23_1),
at(tr46,c5_1),at(tr45,c11_1),at(tr44,c23_2),at(tr43,c19_2),at(tr42,c17_2),at(tr41,c42_1),at(tr40,c25_2),
at(tr39,c14_1),at(tr38,c9_1),at(tr37,c32_2),at(tr36,c3_1),at(tr35,c13_2),at(tr34,c47_2),at(tr33,c1_2),
at(tr32,c10_2),at(tr31,c35_1),at(tr30,c44_2),at(tr29,c14_2),at(tr28,c23_1),at(tr27,c24_1),at(tr26,c24_2),
at(tr25,c23_1),at(tr24,c5_2),at(tr23,c4_1),at(tr22,c30_1),at(tr21,c6_2),at(tr20,c31_2),at(tr19,c7_1),
at(tr18,c35_2),at(tr17,c40_1),at(tr16,c45_2),at(tr15,c35_2),at(tr14,c12_2),at(tr13,c2_2),at(tr12,c29_1),
at(tr11,c1_1),at(tr10,c25_1),at(tr9,c1_2),at(tr8,c30_1),at(tr7,c16_2),at(tr6,c25_2),at(tr5,c37_1),at(tr4,c41_2),at(tr3,c36_2),at(tr2,c39_2),at(tr1,c4_2),
at(p33,c29_2),at(p32,c10_2),at(p31,c45_2),at(p30,c21_2),at(p29,c34_1),at(p28,c4_2),at(p27,c30_2),
at(p26,c5_2),at(p25,c38_1),at(p24,c10_1),at(p23,c23_1),at(p22,c42_1),at(p21,c18_1),at(p20,c35_2),
at(p19,c37_2),at(p18,c43_1),at(p17,c14_2),at(p16,c42_2),at(p15,c27_2),at(p14,c40_2),at(p13,c7_1),
at(p12,c6_1),at(p11,c40_2),at(p10,c14_2),at(p9,c34_1),at(p8,c7_1),at(p7,c12_1),at(p6,c44_1),
at(p5,c11_1),at(p4,c28_2),at(p3,c6_2),at(p2,c27_1),at(p1,c12_2), 
out(p33),out(p32),out(p31),out(p30),out(p29),out(p28),out(p27),out(p26),out(p25),out(p24),out(p23),
out(p22),out(p21),out(p20),out(p19),out(p18),out(p17),out(p16),out(p15),out(p14),out(p13),
out(p12),out(p11),out(p10),out(p9),out(p8),out(p7),out(p6),out(p5),out(p4),out(p3),out(p2),out(p1)]):-!.




goal([at(p33,c40_2),at(p32,c46_2),at(p31,c26_2),at(p30,c25_2),at(p29,c23_1),at(p28,c30_2),at(p27,c11_2),
at(p26,c2_1),at(p25,c7_1),at(p24,c46_1),at(p23,c39_1),at(p22,c25_1),at(p21,c31_2),at(p20,c11_2),
at(p19,c14_1),at(p18,c3_2),at(p17,c2_1),at(p16,c19_2),at(p15,c8_2),at(p14,c17_1),at(p13,c37_2),
at(p12,c27_1),at(p11,c9_2),at(p10,c22_2),at(p9,c38_1),at(p8,c20_1),at(p7,c30_1),at(p6,c46_1),
at(p5,c6_2),at(p4,c5_2),at(p3,c2_2),
out(p33),out(p32),out(p31),out(p30),out(p29),out(p28),out(p27),out(p26),out(p25),out(p24),out(p23),
out(p22),out(p21),out(p20),out(p19),out(p18),out(p17),out(p16),out(p15),out(p14),out(p13),
out(p12),out(p11),out(p10),out(p9),out(p8),out(p7),out(p6),out(p5),out(p4),out(p3)]):-!.




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










