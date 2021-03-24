def(craves(Car,City)):-pleasure(Car), food(City).
def(craves(Cargo,City)):-pain(Cargo), food(City).
def(fears(Cargo, Car)):-pain(Cargo), pleasure(Car).
def(locale(City, Fuel)):-food(City),province(Fuel).
def(harmony(Car, V)):-pleasure(Car), planet(V).


food(turkey).
food(chicken).
food(cod).
food(onion).
food(cantelope).
food(yogurt).
food(cucumber).
food(pork).
food(pepper).
food(sweetroll).
pleasure(excitement).
pleasure(satiety).
pain(grief).
pain(abrasion).
pain(prostatitis).
pain(anger).
pain(hangover).
pain(angina).
pain(boils).
pain(depression).
pain(sciatica).
pain(jealousy).
pain(loneliness).
pain(laceration).
pain(dread).
province(alsace).
province(goias).
province(kentucky).
planet(mars).
planet(neptune).
planet(uranus).
planet(pluto).
eats(chicken,turkey).
eats(turkey,onion).
eats(cantelope,pepper).
orbits(neptune,uranus).
eats(cod,chicken).
orbits(uranus,pluto).
eats(turkey,cod).
eats(cod,turkey).
eats(turkey,pepper).
eats(chicken,cod).
eats(cantelope,yogurt).
eats(sweetroll,yogurt).
eats(pork,cucumber).
attacks(alsace,goias).
eats(pepper,cantelope).
attacks(goias,kentucky).
eats(pepper,pork).
orbits(mars,neptune).
eats(onion,turkey).
eats(yogurt,cantelope).
eats(pepper,turkey).
eats(cucumber,sweetroll).
eats(cod,onion).
eats(onion,cod).
eats(pork,pepper).
eats(sweetroll,cucumber).
eats(yogurt,sweetroll).
eats(cucumber,pork).
eats(turkey,chicken).


initial([
craves(laceration,pork),
locale(cantelope,goias),
locale(turkey,alsace),
locale(yogurt,kentucky),
craves(angina,cantelope),
craves(boils,yogurt),
craves(hangover,cantelope),
craves(dread,pepper),
craves(depression,yogurt),
craves(prostatitis,cod),
locale(cod,kentucky),
locale(cucumber,kentucky),
locale(pork,goias),
craves(excitement,yogurt),
locale(pepper,goias),
craves(jealousy,cucumber),
craves(sciatica,cucumber),
locale(onion,goias),
craves(anger,onion),
craves(satiety,pepper),
locale(chicken,goias),
harmony(excitement,pluto),
craves(loneliness,pork),
craves(grief,turkey),
harmony(satiety,uranus),
locale(sweetroll,goias),
craves(abrasion,chicken)]):-!.

goal([craves(sciatica,cantelope)]):-!.

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

