def(craves(Car,City)):-pleasure(Car), food(City).
def(craves(Cargo,City)):-pain(Cargo), food(City).
def(fears(Cargo, Car)):-pain(Cargo), pleasure(Car).
def(locale(City, Fuel)):-food(City),province(Fuel).
def(harmony(Car, V)):-pleasure(Car), planet(V).


food(papaya).
food(scallop).
food(melon).
food(popover).
food(pear).
food(shrimp).
food(broccoli).
food(pork).
pleasure(achievement).
pleasure(excitement).
pain(abrasion).
pain(hangover).
pain(anger).
pain(laceration).
pain(anxiety).
pain(angina).
pain(grief).
pain(prostatitis).
pain(boils).
pain(sciatica).
pain(jealousy).
province(arizona).
province(pennsylvania).
province(alsace).
province(quebec).
province(manitoba).
province(bavaria).
province(oregon).
province(kentucky).
province(moravia).
planet(earth).
planet(pluto).
planet(neptune).
planet(uranus).
eats(melon,shrimp).
eats(popover,shrimp).
eats(scallop,pork).
eats(melon,scallop).
attacks(bavaria,oregon).
eats(shrimp,melon).
eats(broccoli,pork).
attacks(arizona,pennsylvania).
eats(pork,scallop).
orbits(earth,pluto).
eats(pear,papaya).
eats(papaya,popover).
eats(popover,papaya).
eats(papaya,pear).
attacks(manitoba,bavaria).
attacks(oregon,kentucky).
eats(shrimp,broccoli).
eats(shrimp,popover).
orbits(pluto,neptune).
attacks(pennsylvania,alsace).
eats(pork,pear).
attacks(quebec,manitoba).
eats(pork,broccoli).
eats(pear,pork).
attacks(alsace,quebec).
orbits(neptune,uranus).
eats(scallop,melon).
attacks(kentucky,moravia).
eats(broccoli,shrimp).


initial([
locale(scallop,oregon),
locale(melon,moravia),
craves(anxiety,melon),
craves(achievement,scallop),
craves(excitement,pork),
craves(abrasion,papaya),
locale(popover,bavaria),
harmony(excitement,uranus),
craves(laceration,melon),
craves(angina,melon),
craves(boils,broccoli),
craves(hangover,scallop),
craves(grief,shrimp),
locale(pear,arizona),
craves(anger,scallop),
craves(sciatica,pork),
locale(papaya,quebec),
craves(jealousy,pork),
locale(broccoli,alsace),
locale(shrimp,kentucky),
craves(prostatitis,shrimp),
locale(pork,bavaria),
harmony(achievement,uranus)]):-!.

goal([craves(jealousy,shrimp),craves(prostatitis,shrimp)]):-!.

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
    Cargo\= jealousy,
    Cargo\= prostatitis,
    food(City).
not_determined(fears(Cargo, Car)):-
    pain(Cargo),
    Cargo\= jealousy,
    Cargo\= prostatitis,
    pleasure(Car).

