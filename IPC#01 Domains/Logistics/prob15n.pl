packages( [p23,p22,p21,p20,p19,
p18,p17,p16,p15,p14,p13,
p12,p11,p10,p9,p8,p7,
p6,p5,p4,p3,p2,p1] ) .
cities( [c3,c2,c1] ) .
airports( [c3_6,c2_6,c1_6] ) .
locations( [c3_5,c3_4,c3_3,
c3_2,c3_1,c2_5,c2_4,c2_3,c2_2,c2_1,
c1_5,c1_4,c1_3,c1_2,c1_1,c3_6,c2_6,
c1_6 ] ) .
trucks( [tr5,tr4,tr3,tr2,tr1] ) .
airplanes( [pl7,pl6,
pl5,pl4,pl3,pl2,pl1] ) .


def( at( Package , Location ) ) :- packages( D1 ) , locations( D2 ) , member( Package , D1 ) , member( Location , D2 ) .  
def( at( Airplane , Airport ) ) :- airplanes( D1 ) , airports( D2 ) , member( Airplane , D1 ) , member( Airport , D2 ) .  
def( out( Package ) ) :- packages( D1 ) , member( Package , D1 ) .
def( in( Package , Truck ) ) :- packages( D1 ) , trucks( D2 ) , member( Package , D1 ) , member( Truck , D2 ) .
def( in( Package , Airplane ) ) :- packages( D1 ) , airplanes( D2 ) , member( Package , D1 ) , member( Airplane , D2 ) .
def( at( Truck , Location ) ) :- trucks( D1 ) , locations( D2 ) , member( Truck , D1 ) , member( Location , D2 ), truck_city(Truck, City), const(loc_at(Location, City)) .


const(loc_at(c3_5, c3)).
const(loc_at(c3_4, c3)).
const(loc_at(c3_3, c3)).
const(loc_at(c3_2, c3)).
const(loc_at(c3_1, c3)).
const(loc_at(c2_5, c2)).
const(loc_at(c2_4, c2)).
const(loc_at(c2_3, c2)).
const(loc_at(c2_2, c2)).
const(loc_at(c2_1, c2)).
const(loc_at(c1_5, c1)).
const(loc_at(c1_4, c1)).
const(loc_at(c1_3, c1)).
const(loc_at(c1_2, c1)).
const(loc_at(c1_1, c1)).
const(loc_at(c3_6, c3)).
const(loc_at(c2_6, c2)).
const(loc_at(c1_6, c1)).


truck_city(tr5,c3).
truck_city(tr4,c2).
truck_city(tr3,c1).
truck_city(tr2,c1).
truck_city(tr1,c1).


initial([at(pl7,c1_6),at(pl6,c2_6),at(pl5,c1_6),at(pl4,c1_6),at(pl3,c3_6),
at(pl2,c1_6),at(pl1,c2_6),at(tr5,c3_4),at(tr4,c2_3),at(tr3,c1_5),at(tr2,c1_3),
at(tr1,c1_6),at(p23,c1_5),at(p22,c1_5),at(p21,c2_4),at(p20,c2_3),at(p19,c1_2),
at(p18,c3_3),at(p17,c2_3),at(p16,c3_5),at(p15,c2_2),at(p14,c2_1),at(p13,c3_4),
at(p12,c1_6),at(p11,c1_4),at(p10,c3_3),at(p9,c3_3),at(p8,c1_2),at(p7,c1_4),
at(p6,c1_4),at(p5,c3_1),at(p4,c2_1),at(p3,c1_5),at(p2,c3_3),at(p1,c1_2),
out(p23),out(p22),out(p21),out(p20),out(p19),out(p18),out(p17),out(p16),out(p15),
out(p14),out(p13),out(p12),out(p11),out(p10),out(p9),out(p8),out(p7),out(p6),
out(p5),out(p4),out(p3),out(p2),out(p1)]):-!.




goal([at(p23,c2_3),at(p22,c1_5),at(p21,c1_6),at(p20,c1_1),at(p19,c1_3),at(p18,c1_3),at(p17,c1_5),at(p16,c1_1),at(p15,c3_3),at(p14,c1_5),at(p13,c2_5),
at(p12,c3_2),at(p11,c2_6),at(p10,c1_6),
out(p23),out(p22),out(p21),out(p20),out(p19),out(p18),out(p17),out(p16),out(p15),
out(p14),out(p13),out(p12),out(p11),out(p10)]):-!.


goal1( List ):-findall(X, ndt(X), List).

ndt(at(pl7,c1_6)).
ndt(at(pl6,c2_6)).
ndt(at(pl5,c3_6)).
ndt(at(pl4,c1_6)).
ndt(at(pl3,c2_6)).
ndt(at(pl2,c3_6)).
ndt(at(pl1,c1_6)).

ndt(at(tr5,c3_3)).

ndt(at(tr4,c2_3)).

ndt(at(tr3,c1_5)).
ndt(at(tr2,c1_3)).
ndt(at(tr1,c1_6)).
ndt(at(p9,c3_3)).
ndt(at(p8,c1_2)).
ndt(at(p7,c1_4)).
ndt(at(p6,c1_4)).
ndt(at(p5,c3_1)).
ndt(at(p4,c2_1)).
ndt(at(p3,c1_5)).
ndt(at(p2,c3_3)).
ndt(at(p1,c1_2)).
ndt(out(p9)).
ndt(out(p8)).
ndt(out(p7)).
ndt(out(p6)).
ndt(out(p5)).
ndt(out(p4)).
ndt(out(p3)).
ndt(out(p2)).
ndt(out(p1)).




