packages( [p57,p56,p55,p54,p53
,p52,p51,p50,p49,p48,p47
,p46,p45,p44,p43,p42,p41
,p40,p39,p38,p37,p36,p35
,p34,p33,p32,p31,p30,p29
,p28,p27,p26,p25,p24,p23
,p22,p21,p20,p19,p18,p17
,p16,p15,p14,p13,p12,p11
,p10,p9,p8,p7,p6,p5,p4
,p3,p2,p1] ) .
cities( [c15,c14,c13,c12,c11
,c10,c9,c8,c7,c6,c5,c4,c3,c2,c1 ] ) .
airports( [c15_14,c14_14
,c13_14,c12_14,c11_14,c10_14,c9_14,c8_14
,c7_14,c6_14,c5_14,c4_14,c3_14,c2_14,c1_14] ) .
locations( [c15_13,c15_12
,c15_11,c15_10,c15_9,c15_8,c15_7,c15_6
,c15_5,c15_4,c15_3,c15_2,c15_1,c14_13
,c14_12,c14_11,c14_10,c14_9,c14_8,c14_7
,c14_6,c14_5,c14_4,c14_3,c14_2,c14_1
,c13_13,c13_12,c13_11,c13_10,c13_9,c13_8
,c13_7,c13_6,c13_5,c13_4,c13_3,c13_2,c13_1
,c12_13,c12_12,c12_11,c12_10,c12_9,c12_8
,c12_7,c12_6,c12_5,c12_4,c12_3,c12_2,c12_1
,c11_13,c11_12,c11_11,c11_10,c11_9,c11_8
,c11_7,c11_6,c11_5,c11_4,c11_3,c11_2,c11_1
,c10_13,c10_12,c10_11,c10_10,c10_9,c10_8
,c10_7,c10_6,c10_5,c10_4,c10_3,c10_2,c10_1
,c9_13,c9_12,c9_11,c9_10,c9_9,c9_8,c9_7
,c9_6,c9_5,c9_4,c9_3,c9_2,c9_1,c8_13
,c8_12,c8_11,c8_10,c8_9,c8_8,c8_7,c8_6
,c8_5,c8_4,c8_3,c8_2,c8_1,c7_13,c7_12
,c7_11,c7_10,c7_9,c7_8,c7_7,c7_6,c7_5
,c7_4,c7_3,c7_2,c7_1,c6_13,c6_12,c6_11
,c6_10,c6_9,c6_8,c6_7,c6_6,c6_5,c6_4
,c6_3,c6_2,c6_1,c5_13,c5_12,c5_11,c5_10
,c5_9,c5_8,c5_7,c5_6,c5_5,c5_4,c5_3
,c5_2,c5_1,c4_13,c4_12,c4_11,c4_10,c4_9
,c4_8,c4_7,c4_6,c4_5,c4_4,c4_3,c4_2
,c4_1,c3_13,c3_12,c3_11,c3_10,c3_9,c3_8
,c3_7,c3_6,c3_5,c3_4,c3_3,c3_2,c3_1
,c2_13,c2_12,c2_11,c2_10,c2_9,c2_8,c2_7
,c2_6,c2_5,c2_4,c2_3,c2_2,c2_1,c1_13
,c1_12,c1_11,c1_10,c1_9,c1_8,c1_7,c1_6
,c1_5,c1_4,c1_3,c1_2,c1_1,c15_14,c14_14
,c13_14,c12_14,c11_14,c10_14,c9_14,c8_14
,c7_14,c6_14,c5_14,c4_14,c3_14,c2_14,c1_14 ] ) .
trucks( [tr28,tr27,tr26,tr25,tr24,tr23,tr22
,tr21,tr20,tr19,tr18,tr17,tr16,tr15
,tr14,tr13,tr12,tr11,tr10,tr9,tr8,tr7
,tr6,tr5,tr4,tr3,tr2,tr1] ) .
airplanes( [pl9,pl8,pl7
,pl6,pl5,pl4,pl3,pl2,pl1 ] ) .


def( at( Package , Location ) ) :- packages( D1 ) , locations( D2 ) , member( Package , D1 ) , member( Location , D2 ) .  
def( at( Airplane , Airport ) ) :- airplanes( D1 ) , airports( D2 ) , member( Airplane , D1 ) , member( Airport , D2 ) .  
def( out( Package ) ) :- packages( D1 ) , member( Package , D1 ) .
def( in( Package , Truck ) ) :- packages( D1 ) , trucks( D2 ) , member( Package , D1 ) , member( Truck , D2 ) .
def( in( Package , Airplane ) ) :- packages( D1 ) , airplanes( D2 ) , member( Package , D1 ) , member( Airplane , D2 ) .
def( at( Truck , Location ) ) :- trucks( D1 ) , locations( D2 ) , member( Truck , D1 ) , member( Location , D2 ), truck_city(Truck, City), const(loc_at(Location, City)) .


const(loc_at(c15_13, c15)).
const(loc_at(c15_12, c15)).
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
const(loc_at(c14_13, c14)).
const(loc_at(c14_12, c14)).
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
const(loc_at(c13_13, c13)).
const(loc_at(c13_12, c13)).
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
const(loc_at(c12_13, c12)).
const(loc_at(c12_12, c12)).
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
const(loc_at(c11_13, c11)).
const(loc_at(c11_12, c11)).
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
const(loc_at(c10_13, c10)).
const(loc_at(c10_12, c10)).
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
const(loc_at(c9_13, c9)).
const(loc_at(c9_12, c9)).
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
const(loc_at(c8_13, c8)).
const(loc_at(c8_12, c8)).
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
const(loc_at(c7_13, c7)).
const(loc_at(c7_12, c7)).
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
const(loc_at(c6_13, c6)).
const(loc_at(c6_12, c6)).
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
const(loc_at(c5_13, c5)).
const(loc_at(c5_12, c5)).
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
const(loc_at(c4_13, c4)).
const(loc_at(c4_12, c4)).
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
const(loc_at(c3_13, c3)).
const(loc_at(c3_12, c3)).
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
const(loc_at(c2_13, c2)).
const(loc_at(c2_12, c2)).
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
const(loc_at(c1_13, c1)).
const(loc_at(c1_12, c1)).
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
const(loc_at(c15_14, c15)).
const(loc_at(c14_14, c14)).
const(loc_at(c13_14, c13)).
const(loc_at(c12_14, c12)).
const(loc_at(c11_14, c11)).
const(loc_at(c10_14, c10)).
const(loc_at(c9_14, c9)).
const(loc_at(c8_14, c8)).
const(loc_at(c7_14, c7)).
const(loc_at(c6_14, c6)).
const(loc_at(c5_14, c5)).
const(loc_at(c4_14, c4)).
const(loc_at(c3_14, c3)).
const(loc_at(c2_14, c2)).
const(loc_at(c1_14, c1)).


initial([at(pl9,c11_14),at(pl8,c2_14),at(pl7,c6_14),at(pl6,c4_14),at(pl5,c6_14),
at(pl4,c13_14),at(pl3,c7_14),at(pl2,c8_14),at(pl1,c9_14),
at(tr28,c15_5),at(tr27,c14_8),at(tr26,c13_2),at(tr25,c12_8),at(tr24,c11_7),at(tr23,c10_10),
at(tr22,c9_8),at(tr21,c8_6),at(tr20,c7_1),at(tr19,c6_13),at(tr18,c5_9),at(tr17,c4_8),at(tr16,c3_6),
at(tr15,c2_12),at(tr14,c1_11),at(tr13,c7_9),at(tr12,c2_12),at(tr11,c9_12),at(tr10,c12_9),
at(tr9,c14_9),at(tr8,c14_4),at(tr7,c10_6),at(tr6,c14_10),at(tr5,c10_11),at(tr4,c7_10),at(tr3,c5_2),
at(tr2,c3_2),at(tr1,c15_1),
at(p57,c6_7),at(p56,c2_4),at(p55,c2_8),at(p54,c15_7),at(p53,c6_14),
at(p52,c11_4),at(p51,c11_14),at(p50,c14_13),at(p49,c2_7),at(p48,c5_14),at(p47,c14_13),at(p46,c2_2),
at(p45,c3_5),at(p44,c2_1),at(p43,c15_12),at(p42,c15_1),at(p41,c13_14),at(p40,c4_14),at(p39,c13_6),
at(p38,c2_12),at(p37,c9_7),at(p36,c7_10),at(p35,c7_3),at(p34,c10_4),at(p33,c6_14),at(p32,c13_6),
at(p31,c15_13),at(p30,c11_5),at(p29,c12_12),at(p28,c14_1),at(p27,c7_8),at(p26,c15_7),at(p25,c4_6),
at(p24,c7_8),at(p23,c10_14),at(p22,c9_11),at(p21,c8_14),at(p20,c3_8),at(p19,c9_4),at(p18,c8_2),
at(p17,c11_9),at(p16,c10_14),at(p15,c7_8),at(p14,c5_13),at(p13,c5_12),at(p12,c6_12),at(p11,c5_12),
at(p10,c11_1),at(p9,c10_12),at(p8,c12_3),at(p7,c13_4),at(p6,c5_8),at(p5,c2_1),at(p4,c3_9),at(p3,c9_2),at(p2,c8_7),at(p1,c6_12),
out(p57),out(p56),out(p55),out(p54),out(p53),out(p52),out(p51),out(p50),out(p49),out(p48),out(p47),out(p46),out(p45),out(p44),out(p43),out(p42),out(p41),out(p40),out(p39),out(p38),out(p37),out(p36),out(p35),out(p34),out(p33),out(p32),out(p31),out(p30),out(p29),out(p28),out(p27),out(p26),out(p25),out(p24),out(p23),out(p22),out(p21),out(p20),out(p19),out(p18),out(p17),out(p16),out(p15),out(p14),out(p13),out(p12),out(p11),out(p10),out(p9),out(p8),out(p7),out(p6),out(p5),out(p4),out(p3),out(p2),out(p1)]):-!.


goal([at(57,c12_11),at(p56,c2_8),at(p55,c10_4),at(p54,c11_12),at(p53,c4_6),at(p52,c8_4),
at(p51,c13_4),at(p50,c14_7),at(p49,c15_10),at(p48,c9_12),at(p47,c9_7),at(p46,c8_2),
at(p45,c9_4),at(p44,c4_13),at(p43,c14_7),at(p42,c11_3),at(p41,c9_9),
out(p57),out(p56),out(p55),out(p54),out(p53),out(p52),out(p51),out(p50),out(p49),out(p48),out(p47),out(p46),out(p45),out(p44),out(p43),out(p42),out(p41)]):-!.


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
	member(Object, [p40,p39,p38,p37,p36,p35
,p34,p33,p32,p31,p30,p29
,p28,p27,p26,p25,p24,p23
,p22,p21,p20,p19,p18,p17
,p16,p15,p14,p13,p12,p11
,p10,p9,p8,p7,p6,p5,p4
,p3,p2,p1 ]), 
	locations(Locations), 
	member(Location, Locations).

not_determined(out(Object)):-
	member(Object, [p40,p39,p38,p37,p36,p35
,p34,p33,p32,p31,p30,p29
,p28,p27,p26,p25,p24,p23
,p22,p21,p20,p19,p18,p17
,p16,p15,p14,p13,p12,p11
,p10,p9,p8,p7,p6,p5,p4
,p3,p2,p1 ]). 

not_determined(in(Object, Truck)):-
	member(Object, [p40,p39,p38,p37,p36,p35
,p34,p33,p32,p31,p30,p29
,p28,p27,p26,p25,p24,p23
,p22,p21,p20,p19,p18,p17
,p16,p15,p14,p13,p12,p11
,p10,p9,p8,p7,p6,p5,p4
,p3,p2,p1 ]), 
	trucks(Trucks),
	member(Truck, Trucks).

not_determined(in(Object, Airplane)):-
	member(Object, [p40,p39,p38,p37,p36,p35
,p34,p33,p32,p31,p30,p29
,p28,p27,p26,p25,p24,p23
,p22,p21,p20,p19,p18,p17
,p16,p15,p14,p13,p12,p11
,p10,p9,p8,p7,p6,p5,p4
,p3,p2,p1 ]), 
	airplanes(Airplanes),
	member(Airplane, Airplanes).









