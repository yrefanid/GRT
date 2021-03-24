def(craves(Car,City)):-pleasure(Car), food(City).
def(craves(Cargo,City)):-pain(Cargo), food(City).
def(fears(Cargo, Car)):-pain(Cargo), pleasure(Car).
def(locale(City, Fuel)):-food(City),province(Fuel).
def(harmony(Car, V)):-pleasure(Car), planet(V).


food(mutton).
food(haroset).
food(popover).
food(shrimp).
food(snickers).
food(pepper).
food(pea).
food(muffin).
food(lobster).
food(pear).
pleasure(stimulation).
pleasure(learning).
pain(grief).
pain(depression).
pain(anger).
pain(loneliness).
pain(angina).
pain(jealousy).
pain(hangover).
pain(boils).
pain(dread).
pain(sciatica).
pain(abrasion).
pain(prostatitis).
pain(laceration).
pain(anxiety).
pain(dread_3).
pain(depression_4).
pain(abrasion_1).
pain(loneliness_2).
pain(angina_8).
pain(sciatica_16).
pain(grief_5).
pain(anger_6).
pain(prostatitis_7).
pain(boils_15).
province(arizona).
province(manitoba).
province(moravia).
province(surrey).
planet(mercury).
planet(saturn).
attacks(manitoba,moravia).
eats(mutton,muffin).
eats(pepper,pea).
eats(mutton,pea).
eats(muffin,popover).
eats(pea,mutton).
eats(popover,lobster).
eats(snickers,shrimp).
eats(lobster,haroset).
eats(shrimp,snickers).
eats(shrimp,pepper).
eats(pepper,pear).
eats(pepper,shrimp).
eats(shrimp,haroset).
eats(pea,pepper).
eats(pea,snickers).
eats(muffin,lobster).
orbits(mercury,saturn).
eats(pear,lobster).
eats(lobster,muffin).
eats(popover,muffin).
eats(popover,snickers).
eats(lobster,pear).
eats(lobster,popover).
eats(snickers,popover).
eats(snickers,pea).
eats(haroset,lobster).
eats(pear,pepper).
attacks(moravia,surrey).
attacks(arizona,manitoba).
eats(haroset,shrimp).
eats(muffin,mutton).


initial([
craves(angina_8,muffin),
locale(muffin,arizona),
craves(boils_15,pear),
craves(anger,mutton),
craves(abrasion,snickers),
locale(pea,moravia),
harmony(stimulation,saturn),
craves(depression_4,pea),
locale(popover,manitoba),
craves(abrasion_1,pea),
locale(shrimp,moravia),
craves(hangover,shrimp),
craves(learning,pea),
craves(angina,haroset),
craves(stimulation,snickers),
craves(laceration,pepper),
craves(sciatica_16,lobster),
craves(sciatica,snickers),
craves(grief_5,lobster),
craves(anger_6,lobster),
locale(snickers,arizona),
craves(jealousy,popover),
craves(anxiety,pepper),
locale(haroset,arizona),
craves(loneliness_2,pea),
locale(pepper,manitoba),
craves(grief,mutton),
locale(mutton,arizona),
craves(loneliness,haroset),
craves(dread_3,pea),
craves(dread,snickers),
craves(prostatitis,snickers),
craves(prostatitis_7,lobster),
locale(lobster,surrey),
harmony(learning,saturn),
craves(depression,mutton),
locale(pear,arizona),
craves(boils,shrimp)]):-!.


goal([craves(jealousy,muffin)]):-!.

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
    food(City).
not_determined(fears(Cargo, Car)):-
    pain(Cargo),
    Cargo\= jealousy,
    pleasure(Car).

