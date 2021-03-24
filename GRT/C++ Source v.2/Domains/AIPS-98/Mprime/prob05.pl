def(craves(Car,City)):-pleasure(Car), food(City).
def(craves(Cargo,City)):-pain(Cargo), food(City).
def(fears(Cargo, Car)):-pain(Cargo), pleasure(Car).
def(locale(City, Fuel)):-food(City),province(Fuel).
def(harmony(Car, V)):-pleasure(Car), planet(V).


food(broccoli).
food(chocolate).
food(turkey).
food(tuna).
food(sweetroll).
food(shrimp).
food(cherry).
food(scallop).
pleasure(satisfaction).
pleasure(excitement).
pleasure(intoxication).
pleasure(lubricity).
pain(sciatica).
pain(anxiety).
pain(grief).
pain(boils).
pain(depression).
pain(abrasion).
pain(prostatitis).
pain(angina).
pain(jealousy).
pain(laceration).
pain(anger).
pain(grief_2).
pain(dread).
pain(loneliness).
pain(hangover).
province(alsace).
province(kentucky).
province(goias).
province(arizona).
planet(uranus).
planet(mercury).
planet(earth).
planet(mars).
eats(scallop,cherry).
eats(tuna,broccoli).
eats(sweetroll,scallop).
attacks(kentucky,goias).
attacks(alsace,kentucky).
eats(cherry,shrimp).
orbits(uranus,mercury).
eats(shrimp,sweetroll).
eats(cherry,scallop).
eats(broccoli,chocolate).
eats(tuna,turkey).
eats(chocolate,shrimp).
eats(turkey,chocolate).
attacks(goias,arizona).
eats(shrimp,cherry).
eats(chocolate,turkey).
eats(chocolate,broccoli).
orbits(mercury,earth).
eats(sweetroll,shrimp).
eats(broccoli,tuna).
eats(scallop,sweetroll).
eats(shrimp,chocolate).
orbits(earth,mars).
eats(turkey,tuna).


initial([
craves(satisfaction,broccoli),
harmony(excitement,mars),
craves(jealousy,shrimp),
craves(grief,broccoli),
craves(intoxication,tuna),
locale(tuna,arizona),
craves(hangover,scallop),
harmony(lubricity,earth),
craves(excitement,turkey),
craves(loneliness,scallop),
craves(depression,turkey),
craves(lubricity,sweetroll),
locale(cherry,kentucky),
craves(dread,scallop),
craves(grief_2,scallop),
craves(angina,shrimp),
harmony(satisfaction,earth),
craves(laceration,shrimp),
craves(anxiety,broccoli),
locale(scallop,alsace),
craves(prostatitis,turkey),
craves(boils,broccoli),
locale(shrimp,kentucky),
locale(turkey,kentucky),
locale(broccoli,arizona),
craves(abrasion,turkey),
locale(chocolate,goias),
harmony(intoxication,earth),
craves(anger,cherry),
locale(sweetroll,alsace),
craves(sciatica,broccoli)]):-!.

goal([craves(loneliness,shrimp),craves(grief,shrimp)]):-!.

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
    Cargo\= loneliness,
    Cargo\= grief,
    food(City).
not_determined(fears(Cargo, Car)):-
    pain(Cargo),
    Cargo\= loneliness,
    Cargo\= grief,
    pleasure(Car).

