def(craves(Car,City)):-pleasure(Car), food(City).
def(craves(Cargo,City)):-pain(Cargo), food(City).
def(fears(Cargo, Car)):-pain(Cargo), pleasure(Car).
def(locale(City, Fuel)):-food(City),province(Fuel).
def(harmony(Car, V)):-pleasure(Car), planet(V).


food(tomato).
food(rice).
food(popover).
food(cantelope).
food(tuna).
food(papaya).
food(chicken).
food(scallop).
food(beef).
food(pistachio).
food(muffin).
food(mutton).
food(potato).
food(wonderbread).
food(snickers).
food(marzipan).
food(turkey).
food(onion).
food(bacon).
pleasure(love).
pleasure(intoxication).
pleasure(rest).
pleasure(aesthetics).
pleasure(achievement).
pleasure(excitement).
pleasure(satisfaction).
pleasure(curiosity).
pleasure(lubricity).
pleasure(understanding).
pleasure(triumph).
pain(anger).
pain(hangover).
pain(sciatica).
pain(grief).
pain(abrasion).
pain(prostatitis).
pain(angina).
pain(boils).
pain(loneliness).
province(bosnia).
province(surrey).
province(kentucky).
province(alsace).
province(goias).
province(quebec).
province(arizona).
planet(venus).
planet(neptune).
planet(mars).
planet(saturn).
eats(muffin,bacon).
eats(scallop,chicken).
eats(tuna,rice).
eats(mutton,turkey).
eats(chicken,papaya).
eats(chicken,turkey).
eats(wonderbread,marzipan).
eats(snickers,potato).
eats(turkey,chicken).
eats(onion,turkey).
eats(scallop,beef).
eats(tomato,cantelope).
eats(marzipan,wonderbread).
eats(turkey,onion).
eats(turkey,snickers).
eats(beef,papaya).
eats(cantelope,tomato).
eats(rice,tuna).
eats(popover,rice).
eats(papaya,beef).
eats(bacon,wonderbread).
attacks(goias,quebec).
eats(beef,tuna).
eats(onion,mutton).
orbits(mars,saturn).
attacks(quebec,arizona).
attacks(bosnia,surrey).
eats(mutton,onion).
eats(tuna,beef).
eats(turkey,mutton).
eats(bacon,mutton).
eats(tomato,tuna).
eats(muffin,pistachio).
eats(wonderbread,bacon).
eats(potato,marzipan).
eats(marzipan,potato).
orbits(venus,neptune).
eats(onion,pistachio).
eats(pistachio,muffin).
eats(cantelope,popover).
eats(wonderbread,turkey).
eats(bacon,muffin).
eats(chicken,scallop).
eats(mutton,bacon).
orbits(neptune,mars).
eats(popover,cantelope).
attacks(kentucky,alsace).
eats(pistachio,onion).
eats(turkey,wonderbread).
eats(potato,snickers).
eats(beef,scallop).
attacks(surrey,kentucky).
eats(papaya,chicken).
eats(rice,popover).
eats(snickers,turkey).
attacks(alsace,goias).
eats(tuna,tomato).


initial([
harmony(excitement,saturn),
locale(onion,goias),
harmony(satisfaction,mars),
locale(rice,bosnia),
harmony(rest,saturn),
harmony(achievement,neptune),
craves(aesthetics,cantelope),
harmony(aesthetics,saturn),
locale(pistachio,alsace),
locale(potato,alsace),
locale(cantelope,goias),
craves(angina,snickers),
harmony(curiosity,saturn),
locale(beef,kentucky),
craves(rest,popover),
locale(bacon,arizona),
locale(tomato,alsace),
craves(boils,onion),
craves(excitement,scallop),
craves(understanding,marzipan),
craves(triumph,turkey),
locale(mutton,kentucky),
craves(anger,popover),
locale(wonderbread,quebec),
craves(satisfaction,pistachio),
harmony(triumph,saturn),
locale(muffin,alsace),
craves(abrasion,beef),
harmony(intoxication,mars),
craves(intoxication,rice),
locale(turkey,alsace),
locale(popover,surrey),
craves(hangover,cantelope),
locale(marzipan,bosnia),
locale(scallop,surrey),
locale(chicken,kentucky),
locale(snickers,goias),
locale(tuna,alsace),
craves(prostatitis,muffin),
craves(love,tomato),
craves(lubricity,wonderbread),
harmony(love,neptune),
craves(sciatica,papaya),
harmony(lubricity,saturn),
locale(papaya,surrey),
harmony(understanding,neptune),
craves(loneliness,bacon),
craves(achievement,chicken),
craves(grief,chicken),
craves(curiosity,potato)]):-!.

goal([craves(anger,turkey),craves(abrasion,turkey)]):-!.

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
    Cargo\= anger,
    Cargo\=abrasion,
    food(City).
not_determined(fears(Cargo, Car)):-
    pain(Cargo),
    Cargo\= anger,
    Cargo\=abrasion,
    pleasure(Car).

