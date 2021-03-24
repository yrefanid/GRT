def(craves(Car,City)):-pleasure(Car), food(City).
def(craves(Cargo,City)):-pain(Cargo), food(City).
def(fears(Cargo, Car)):-pain(Cargo), pleasure(Car).
def(locale(City, Fuel)):-food(City),province(Fuel).
def(harmony(Car, V)):-pleasure(Car), planet(V).


food(marzipan).
food(tofu).
food(chicken).
food(snickers).
food(ham).
food(arugula).
pleasure(love).
pleasure(intoxication).
pleasure(empathy).
pleasure(excitement).
pain(depression).
pain(sciatica).
province(manitoba).
province(arizona).
province(kentucky).
province(bosnia).
province(guanabara).
province(goias).
planet(uranus).
planet(earth).
planet(mars).
planet(jupiter).
eats(chicken,arugula).
eats(tofu,arugula).
eats(ham,marzipan).
eats(arugula,tofu).
attacks(bosnia,guanabara).
attacks(arizona,kentucky).
eats(marzipan,tofu).
eats(ham,snickers).
eats(chicken,ham).
attacks(manitoba,arizona).
eats(chicken,snickers).
eats(tofu,marzipan).
attacks(kentucky,bosnia).
orbits(uranus,earth).
eats(snickers,ham).
orbits(mars,jupiter).
eats(snickers,chicken).
eats(marzipan,ham).
eats(arugula,chicken).
attacks(guanabara,goias).
orbits(earth,mars).
eats(ham,chicken).


initial([
harmony(empathy,mars),
locale(tofu,goias),
locale(marzipan,manitoba),
craves(sciatica,arugula),
harmony(excitement,jupiter),
locale(ham,arizona),
locale(snickers,bosnia),
locale(chicken,bosnia),
harmony(intoxication,mars),
craves(depression,arugula),
craves(excitement,arugula),
craves(empathy,chicken),
craves(love,marzipan),
locale(arugula,manitoba),
craves(intoxication,tofu),
harmony(love,jupiter)]):-!.

goal([craves(sciatica,ham)]):-!.

goal1(List):-findall(X, not_determined(X), List).
not_determined(locale(City, Fuel)):-
    food(City),
    province(Fuel).
not_determined(craves(Car,City)):-
    pleasure(Car),
    food(City).
not_determined(harmony(Car, V)):-
    pleasure(Car),
    planet(V).
not_determined(craves(Cargo, City)):-
    pain(Cargo),
    Cargo\= sciatica,
    food(City).
not_determined(fears(Cargo, Car)):-
    pain(Cargo),
    Cargo\= sciatica,
    pleasure(Car).

