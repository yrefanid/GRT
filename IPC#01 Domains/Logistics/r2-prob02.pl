def( at( Package , Location ) ) :- obj( Package) , location(Location).
def( at( Airplane , Airport ) ) :- airplane(Airplane) , airport( Airport).
def( out( Package ) ) :- obj(Package).
def( in( Package , Truck ) ) :- obj(Package) , truck(Truck) .
def( in( Package , Airplane ) ) :- obj(Package) , airplane(Airplane).
def( at( Truck , Location ) ) :- truck(Truck),location(Location), truck_city(Truck, City), const(loc_at(Location, City)) .


obj(p5).
obj(p4).
obj(p3).
obj(p2).
obj(p1).
c(c3).
c(c2).
c(c1).
tr(tr6).
tr(tr5).
tr(tr4).
tr(tr3).
tr(tr2).
tr(tr1).
airplane(plane1).
location(c3_1).
location(c2_1).
location(c1_1).
airport(c3_2).
location(c3_2).
airport(c2_2).
location(c2_2).
airport(c1_2).
location(c1_2).
loc_at(c3_2,c3).
loc_at(c3_1,c3).
loc_at(c2_2,c2).
loc_at(c2_1,c2).
loc_at(c1_2,c1).
loc_at(c1_1,c1).
at(plane1,c3_2).
at(tr6,c3_1).
at(tr5,c2_1).
at(tr4,c1_1).
at(tr3,c3_2).
at(tr2,c1_2).
at(tr1,c2_2).
at(p5,c2_1).
at(p4,c1_2).
at(p3,c1_1).
at(p2,c2_2).
at(p1,c2_1)).
,(:goal,(and,at(p5,c3_2).
,at(p4,c2_1).
,at(p3,c2_1)))).

