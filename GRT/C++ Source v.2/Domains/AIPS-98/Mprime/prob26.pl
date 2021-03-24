def(craves(Car,City)):-pleasure(Car), food(City).
def(craves(Cargo,City)):-pain(Cargo), food(City).
def(fears(Cargo, Car)):-pain(Cargo), pleasure(Car).
def(locale(City, Fuel)):-food(City),province(Fuel).
def(harmony(Car, V)):-pleasure(Car), planet(V).


food(pepper).
food(papaya).
food(flounder).
food(endive).
food(marzipan).
food(haroset).
food(turkey).
food(scallop).
food(pistachio).
food(snickers).
food(hamburger).
food(rice).
pleasure(understanding).
pleasure(learning).
pleasure(entertainment).
pleasure(empathy).
pleasure(satisfaction).
pain(depression).
pain(boils).
pain(hangover).
pain(jealousy).
province(moravia).
province(kentucky).
province(quebec).
province(manitoba).
province(oregon).
province(bavaria).
planet(earth).
planet(neptune).
planet(venus).
planet(saturn).
eats(haroset,hamburger).
eats(flounder,papaya).
eats(hamburger,haroset).
eats(rice,haroset).
eats(rice,scallop).
eats(marzipan,haroset).
eats(endive,haroset).
eats(endive,pistachio).
eats(pepper,snickers).
eats(turkey,marzipan).
eats(haroset,marzipan).
attacks(manitoba,oregon).
eats(turkey,papaya).
eats(rice,pistachio).
attacks(quebec,manitoba).
eats(hamburger,marzipan).
orbits(neptune,venus).
eats(endive,rice).
eats(pepper,flounder).
eats(haroset,endive).
eats(papaya,flounder).
eats(pistachio,rice).
attacks(moravia,kentucky).
eats(papaya,turkey).
eats(haroset,rice).
eats(scallop,hamburger).
attacks(oregon,bavaria).
eats(scallop,rice).
eats(marzipan,hamburger).
eats(rice,endive).
attacks(kentucky,quebec).
eats(snickers,hamburger).
eats(hamburger,scallop).
eats(flounder,pepper).
eats(pistachio,endive).
eats(pistachio,turkey).
orbits(venus,saturn).
eats(turkey,pistachio).
eats(snickers,pepper).
eats(hamburger,snickers).
eats(marzipan,turkey).
orbits(earth,neptune).


initial([
harmony(satisfaction,saturn),
craves(entertainment,haroset),
locale(hamburger,bavaria),
locale(pistachio,kentucky),
harmony(entertainment,neptune),
locale(haroset,bavaria),
harmony(understanding,neptune),
locale(turkey,oregon),
locale(scallop,oregon),
locale(snickers,kentucky),
craves(satisfaction,snickers),
locale(marzipan,moravia),
locale(rice,oregon),
craves(depression,marzipan),
locale(endive,kentucky),
locale(papaya,kentucky),
craves(hangover,pistachio),
craves(empathy,scallop),
craves(understanding,papaya),
craves(learning,marzipan),
harmony(empathy,venus),
craves(boils,haroset),
craves(jealousy,snickers),
locale(pepper,moravia),
harmony(learning,neptune),
locale(flounder,quebec)]):-!.

goal([craves(boils,papaya)]):-!.

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
    Cargo\=boils,
food(City).
not_determined(fears(Cargo, Car)):-
    pain(Cargo),
    Cargo\=boils,
    pleasure(Car).

