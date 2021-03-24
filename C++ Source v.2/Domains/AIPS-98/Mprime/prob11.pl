def(craves(Car,City)):-pleasure(Car), food(City).
def(craves(Cargo,City)):-pain(Cargo), food(City).
def(fears(Cargo, Car)):-pain(Cargo), pleasure(Car).
def(locale(City, Fuel)):-food(City),province(Fuel).
def(harmony(Car, V)):-pleasure(Car), planet(V).


food(pistachio).
food(bacon).
food(pear).
food(sweetroll).
food(shrimp).
food(chicken).
food(cherry).
food(tomato).
pleasure(lubricity).
pain(jealousy).
pain(dread).
pain(laceration).
pain(loneliness).
pain(sciatica).
pain(hangover).
pain(prostatitis).
pain(boils).
province(alsace).
province(quebec).
province(bosnia).
province(surrey).
province(manitoba).
province(kentucky).
planet(neptune).
planet(uranus).
planet(saturn).
eats(pear,cherry).
eats(bacon,pistachio).
eats(pistachio,chicken).
eats(sweetroll,pear).
attacks(quebec,bosnia).
eats(tomato,chicken).
eats(cherry,pear).
eats(sweetroll,tomato).
eats(pistachio,bacon).
eats(chicken,pistachio).
eats(tomato,shrimp).
eats(bacon,pear).
eats(pear,sweetroll).
eats(shrimp,chicken).
attacks(alsace,quebec).
eats(chicken,tomato).
orbits(uranus,saturn).
attacks(bosnia,surrey).
eats(tomato,sweetroll).
eats(shrimp,tomato).
eats(pear,bacon).
attacks(surrey,manitoba).
eats(cherry,chicken).
orbits(neptune,uranus).
eats(chicken,cherry).
attacks(manitoba,kentucky).
eats(chicken,shrimp).


initial([
craves(sciatica,shrimp),
locale(shrimp,manitoba),
locale(sweetroll,quebec),
locale(pear,bosnia),
locale(bacon,alsace),
craves(lubricity,pear),
locale(tomato,bosnia),
craves(dread,bacon),
craves(jealousy,pistachio),
craves(boils,tomato),
locale(chicken,kentucky),
craves(hangover,chicken),
craves(laceration,pear),
locale(cherry,surrey),
craves(loneliness,sweetroll),
craves(prostatitis,cherry),
locale(pistachio,surrey),
harmony(lubricity,saturn)]):-!.


goal([craves(laceration,shrimp),craves(loneliness,shrimp)]):-!.

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
    Cargo\= laceration,
    Cargo\= loneliness,
    food(City).
not_determined(fears(Cargo, Car)):-
    pain(Cargo),
    Cargo\= laceration,
    Cargo\= loneliness,
    pleasure(Car).

