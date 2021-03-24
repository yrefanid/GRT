def(craves(Car,City)):-pleasure(Car), food(City).
def(craves(Cargo,City)):-pain(Cargo), food(City).
def(fears(Cargo, Car)):-pain(Cargo), pleasure(Car).
def(locale(City, Fuel)):-food(City),province(Fuel).
def(harmony(Car, V)):-pleasure(Car), planet(V).


food(wurst).
food(shrimp).
food(muffin).
food(broccoli).
food(lamb).
pleasure(intoxication).
pain(loneliness).
pain(anxiety).
pain(hangover).
pain(anger).
pain(angina).
pain(boils).
pain(grief).
province(goias).
province(bosnia).
province(pennsylvania).
province(moravia).
province(quebec).
province(oregon).
province(alsace).
province(kentucky).
planet(neptune).
planet(vulcan).
planet(earth).
attacks(moravia,quebec).
eats(lamb,shrimp).
eats(shrimp,wurst).
eats(wurst,muffin).
attacks(goias,bosnia).
eats(broccoli,lamb).
eats(wurst,lamb).
eats(muffin,wurst).
attacks(quebec,oregon).
eats(broccoli,muffin).
attacks(alsace,kentucky).
eats(shrimp,lamb).
orbits(vulcan,earth).
orbits(neptune,vulcan).
eats(wurst,shrimp).
attacks(pennsylvania,moravia).
eats(lamb,wurst).
attacks(oregon,alsace).
eats(lamb,broccoli).
eats(muffin,broccoli).
attacks(bosnia,pennsylvania).


initial([
craves(hangover,shrimp),
craves(anger,muffin),
craves(intoxication,wurst),
craves(boils,broccoli),
locale(shrimp,alsace),
locale(lamb,kentucky),
craves(anxiety,shrimp),
locale(broccoli,kentucky),
harmony(intoxication,earth),
craves(grief,lamb),
locale(wurst,bosnia),
locale(muffin,pennsylvania),
craves(angina,muffin),
craves(loneliness,wurst)]):-!.

goal([craves(anger,lamb),craves(boils,lamb)]):-!.

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
    Cargo\=anger,
    Cargo\=boils,
    food(City).
not_determined(fears(Cargo, Car)):-
    pain(Cargo),
    Cargo\=anger,
    Cargo\=boils,
    pleasure(Car).

