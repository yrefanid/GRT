packages( [p53,p52,p51,p50,p49
,p48,p47,p46,p45,p44,p43
,p42,p41,p40,p39,p38,p37
,p36,p35,p34,p33,p32,p31
,p30,p29,p28,p27,p26,p25
,p24,p23,p22,p21,p20,p19
,p18,p17,p16,p15,p14,p13
,p12,p11,p10,p9,p8,p7
,p6,p5,p4,p3,p2,p1] ) .
cities( [c27
,c26,c25,c24,c23,c22,c21,c20,c19,c18
,c17,c16,c15,c14,c13,c12,c11,c10,c9
,c8,c7,c6,c5,c4,c3,c2,c1 ] ) .
airports( [c27_3,c26_3,c25_3,c24_3,c23_3,c22_3
,c21_3,c20_3,c19_3,c18_3,c17_3,c16_3,c15_3
,c14_3,c13_3,c12_3,c11_3,c10_3,c9_3,c8_3
,c7_3,c6_3,c5_3,c4_3,c3_3,c2_3,c1_3 ] ) .
locations( [c27_2,c27_1,c26_2,c26_1
,c25_2,c25_1,c24_2,c24_1,c23_2,c23_1,c22_2
,c22_1,c21_2,c21_1,c20_2,c20_1,c19_2,c19_1
,c18_2,c18_1,c17_2,c17_1,c16_2,c16_1,c15_2
,c15_1,c14_2,c14_1,c13_2,c13_1,c12_2,c12_1
,c11_2,c11_1,c10_2,c10_1,c9_2,c9_1,c8_2
,c8_1,c7_2,c7_1,c6_2,c6_1,c5_2,c5_1
,c4_2,c4_1,c3_2,c3_1,c2_2,c2_1,c1_2
,c1_1,c27_3,c26_3,c25_3,c24_3,c23_3,c22_3
,c21_3,c20_3,c19_3,c18_3,c17_3,c16_3,c15_3
,c14_3,c13_3,c12_3,c11_3,c10_3,c9_3,c8_3
,c7_3,c6_3,c5_3,c4_3,c3_3,c2_3,c1_3] ) .
trucks( [tr46
,tr45,tr44,tr43,tr42,tr41,tr40,tr39
,tr38,tr37,tr36,tr35,tr34,tr33,tr32
,tr31,tr30,tr29,tr28,tr27,tr26,tr25
,tr24,tr23,tr22,tr21,tr20,tr19,tr18
,tr17,tr16,tr15,tr14,tr13,tr12,tr11
,tr10,tr9,tr8,tr7,tr6,tr5,tr4,tr3,tr2
,tr1] ) .
airplanes( [pl10,pl9,pl8,pl7,pl6,pl5,pl4
,pl3,pl2,pl1] ) .



def( at( Package , Location ) ) :- packages( D1 ) , locations( D2 ) , member( Package , D1 ) , member( Location , D2 ) .  
def( at( Airplane , Airport ) ) :- airplanes( D1 ) , airports( D2 ) , member( Airplane , D1 ) , member( Airport , D2 ) .  
def( out( Package ) ) :- packages( D1 ) , member( Package , D1 ) .
def( in( Package , Truck ) ) :- packages( D1 ) , trucks( D2 ) , member( Package , D1 ) , member( Truck , D2 ) .
def( in( Package , Airplane ) ) :- packages( D1 ) , airplanes( D2 ) , member( Package , D1 ) , member( Airplane , D2 ) .
def( at( Truck , Location ) ) :- trucks( D1 ) , locations( D2 ) , member( Truck , D1 ) , member( Location , D2 ), truck_city(Truck, City), const(loc_at(Location, City)) .


const(loc_at(c27_2, c27)).
const(loc_at(c27_1, c27)).
const(loc_at(c26_2, c26)).
const(loc_at(c26_1, c26)).
const(loc_at(c25_2, c25)).
const(loc_at(c25_1, c25)).
const(loc_at(c24_2, c24)).
const(loc_at(c24_1, c24)).
const(loc_at(c23_2, c23)).
const(loc_at(c23_1, c23)).
const(loc_at(c22_2, c22)).
const(loc_at(c22_1, c22)).
const(loc_at(c21_2, c21)).
const(loc_at(c21_1, c21)).
const(loc_at(c20_2, c20)).
const(loc_at(c20_1, c20)).
const(loc_at(c19_2, c19)).
const(loc_at(c19_1, c19)).
const(loc_at(c18_2, c18)).
const(loc_at(c18_1, c18)).
const(loc_at(c17_2, c17)).
const(loc_at(c17_1, c17)).
const(loc_at(c16_2, c16)).
const(loc_at(c16_1, c16)).
const(loc_at(c15_2, c15)).
const(loc_at(c15_1, c15)).
const(loc_at(c14_2, c14)).
const(loc_at(c14_1, c14)).
const(loc_at(c13_2, c13)).
const(loc_at(c13_1, c13)).
const(loc_at(c12_2, c12)).
const(loc_at(c12_1, c12)).
const(loc_at(c11_2, c11)).
const(loc_at(c11_1, c11)).
const(loc_at(c10_2, c10)).
const(loc_at(c10_1, c10)).
const(loc_at(c9_2, c9)).
const(loc_at(c9_1, c9)).
const(loc_at(c8_2, c8)).
const(loc_at(c8_1, c8)).
const(loc_at(c7_2, c7)).
const(loc_at(c7_1, c7)).
const(loc_at(c6_2, c6)).
const(loc_at(c6_1, c6)).
const(loc_at(c5_2, c5)).
const(loc_at(c5_1, c5)).
const(loc_at(c4_2, c4)).
const(loc_at(c4_1, c4)).
const(loc_at(c3_2, c3)).
const(loc_at(c3_1, c3)).
const(loc_at(c2_2, c2)).
const(loc_at(c2_1, c2)).
const(loc_at(c1_2, c1)).
const(loc_at(c1_1, c1)).
const(loc_at(c27_3, c27)).
const(loc_at(c26_3, c26)).
const(loc_at(c25_3, c25)).
const(loc_at(c24_3, c24)).
const(loc_at(c23_3, c23)).
const(loc_at(c22_3, c22)).
const(loc_at(c21_3, c21)).
const(loc_at(c20_3, c20)).
const(loc_at(c19_3, c19)).
const(loc_at(c18_3, c18)).
const(loc_at(c17_3, c17)).
const(loc_at(c16_3, c16)).
const(loc_at(c15_3, c15)).
const(loc_at(c14_3, c14)).
const(loc_at(c13_3, c13)).
const(loc_at(c12_3, c12)).
const(loc_at(c11_3, c11)).
const(loc_at(c10_3, c10)).
const(loc_at(c9_3, c9)).
const(loc_at(c8_3, c8)).
const(loc_at(c7_3, c7)).
const(loc_at(c6_3, c6)).
const(loc_at(c5_3, c5)).
const(loc_at(c4_3, c4)).
const(loc_at(c3_3, c3)).
const(loc_at(c2_3, c2)).
const(loc_at(c1_3, c1)).

loc_at(tr46,c27).
loc_at(tr45,c26).
loc_at(tr44,c25).
loc_at(tr43,c24).
loc_at(tr42,c23).
loc_at(tr41,c22).
loc_at(tr40,c21).
loc_at(tr39,c20).
loc_at(tr38,c19).
loc_at(tr37,c18).
loc_at(tr36,c17).
loc_at(tr35,c16).
loc_at(tr34,c15).
loc_at(tr33,c14).
loc_at(tr32,c13).
loc_at(tr31,c12).
loc_at(tr30,c11).
loc_at(tr29,c10).
loc_at(tr28,c9).
loc_at(tr27,c8).
loc_at(tr26,c7).
loc_at(tr25,c6).
loc_at(tr24,c5).
loc_at(tr23,c4).
loc_at(tr22,c3).
loc_at(tr21,c2).
loc_at(tr20,c1).
loc_at(tr19,c16).
loc_at(tr18,c21).
loc_at(tr17,c1).
loc_at(tr16,c25).
loc_at(tr15,c15).
loc_at(tr14,c25).
loc_at(tr13,c16).
loc_at(tr12,c24).
loc_at(tr11,c7).
loc_at(tr10,c10).
loc_at(tr9,c4).
loc_at(tr8,c25).
loc_at(tr7,c19).
loc_at(tr6,c25).
loc_at(tr5,c4).
loc_at(tr4,c19).
loc_at(tr3,c3).
loc_at(tr2,c27).
loc_at(tr1,c9).



initial([at(pl10,c9_3),at(pl9,c18_3),at(pl8,c15_3),at(pl7,c6_3),at(pl6,c7_3),at(pl5,c15_3),at(pl4,c13_3),at(pl3,c25_3),at(pl2,c6_3),at(pl1,c4_3),
at(tr46,c27_2),at(tr45,c26_1),at(tr44,c25_1),at(tr43,c24_1),at(tr42,c23_2),at(tr41,c22_1),at(tr40,c21_1),
at(tr39,c20_1),at(tr38,c19_2),at(tr37,c18_2),at(tr36,c17_1),at(tr35,c16_2),at(tr34,c15_1),at(tr33,c14_2),
at(tr32,c13_2),at(tr31,c12_1),at(tr30,c11_2),at(tr29,c10_1),at(tr28,c9_1),at(tr27,c8_1),at(tr26,c7_1),
at(tr25,c6_1),at(tr24,c5_2),at(tr23,c4_2),at(tr22,c3_2),at(tr21,c2_2),at(tr20,c1_1),at(tr19,c16_3),
at(tr18,c21_1),at(tr17,c1_3),at(tr16,c25_3),at(tr15,c15_3),at(tr14,c25_1),at(tr13,c16_2),at(tr12,c24_1),
at(tr11,c7_1),at(tr10,c10_3),at(tr9,c4_3),at(tr8,c25_1),at(tr7,c19_3),at(tr6,c25_2),at(tr5,c4_2),at(tr4,c19_2),
at(tr3,c3_2),at(tr2,c27_3),at(tr1,c9_1),at(p53,c6_3),at(p52,c6_3),at(p51,c16_2),at(p50,c25_1),at(p49,c24_1),
at(p48,c1_2),at(p47,c6_2),at(p46,c7_3),at(p45,c15_1),at(p44,c20_2),at(p43,c25_3),at(p42,c20_2),at(p41,c18_1),
at(p40,c20_2),at(p39,c6_1),at(p38,c27_3),at(p37,c8_2),at(p36,c14_3),at(p35,c20_2),at(p34,c25_1),at(p33,c23_3),at(p32,c4_1),at(p31,c27_1),at(p30,c17_3),at(p29,c13_2),at(p28,c25_3),at(p27,c19_1),
at(p26,c26_3),at(p25,c8_2),at(p24,c3_1),at(p23,c10_2),at(p22,c11_2),at(p21,c8_2),at(p20,c4_2),at(p19,c22_2),
at(p18,c23_1),at(p17,c24_1),at(p16,c14_1),at(p15,c6_2),at(p14,c11_1),at(p13,c16_1),at(p12,c5_3),at(p11,c9_2),
at(p10,c21_2),at(p9,c18_2),at(p8,c9_1),at(p7,c27_1),at(p6,c12_3),at(p5,c23_1),at(p4,c21_3),at(p3,c18_3),at(p2,c6_3),at(p1,c25_1),
out(p53),out(p52),out(p51),out(p50),out(p49),out(p48),out(p47),out(p46),out(p45),out(p44),out(p43),out(p42),
out(p41),out(p40),out(p39),out(p38),out(p37),out(p36),out(p35),out(p34),out(p33),out(p32),out(p31),
out(p30),out(p29),out(p28),out(p27),out(p26),out(p25),out(p24),out(p23),out(p22),out(p21),out(p20),
out(p19),out(p18),out(p17),out(p16),out(p15),out(p14),out(p13),out(p12),out(p11),out(p10),out(p9),out(p8),
out(p7),out(p6),out(p5),out(p4),out(p3),out(p2),out(p1)]):-!.

goal([at(p53,c16_2),at(p52,c6_3),at(p51,c12_2),at(p50,c9_2),at(p49,c9_3),at(p48,c20_1),at(p47,c17_2),
at(p46,c22_3),at(p45,c8_3),at(p44,c8_1),at(p43,c19_3),at(p42,c7_1),at(p41,c26_3),at(p40,c2_2),
at(p39,c12_1),at(p38,c11_2),at(p37,c1_3),at(p36,c22_3),at(p35,c14_2),at(p34,c1_3),at(p33,c3_3),
at(p32,c9_3),at(p31,c1_2),at(p30,c1_2),at(p29,c14_1),at(p28,c23_3),at(p27,c23_3),at(p26,c22_1),
at(p25,c23_2),at(p24,c7_3),at(p23,c23_3),at(p22,c12_1),at(p21,c12_2),at(p20,c10_3),at(p19,c18_1),
at(p18,c24_2),at(p17,c16_3),at(p16,c18_3),at(p15,c8_2),at(p14,c18_3),at(p13,c7_1),at(p12,c22_1),
at(p11,c1_1),at(p10,c6_3),at(p9,c9_1),
out(p53),out(p52),out(p51),out(p50),out(p49),out(p48),out(p47),out(p46),out(p45),out(p44),
out(p43),out(p42),out(p41),out(p40),out(p39),out(p38),out(p37),out(p36),out(p35),out(p34),
out(p33),out(p32),out(p31),out(p30),out(p29),out(p28),out(p27),out(p26),out(p25),out(p24),
out(p23),out(p22),out(p21),out(p20),out(p19),out(p18),out(p17),out(p16),out(p15),out(p14),
out(p13),out(p12),out(p11),out(p10),out(p9)]):-!.




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
	member(Object, [p1, p2, p3, p4, p5, p6, p7, p8]), 
	locations(Locations), 
	member(Location, Locations).

not_determined(out(Object)):-
	member(Object, [p1, p2, p3, p4, p5, p6, p7, p8]).

not_determined(in(Object, Truck)):-
	member(Object, [p1, p2, p3, p4, p5, p6, p7, p8]), 
	trucks(Trucks),
	member(Truck, Trucks).

not_determined(in(Object, Airplane)):-
	member(Object, [p1, p2, p3, p4, p5, p6, p7, p8]), 
	airplanes(Airplanes),
	member(Airplane, Airplanes).











