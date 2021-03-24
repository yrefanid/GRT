def(craves(Car,City)):-pleasure(Car), food(City).
def(craves(Cargo,City)):-pain(Cargo), food(City).
def(fears(Cargo, Car)):-pain(Cargo), pleasure(Car).
def(locale(City, Fuel)):-food(City),province(Fuel).
def(harmony(Car, V)):-pleasure(Car), planet(V).


food(lemon).
food(potato).
food(muffin).
food(hamburger).
food(pepper).
food(melon).
food(lobster).
food(wurst).
pleasure(excitement).
pleasure(satiety).
pleasure(intoxication).
pleasure(rest).
pleasure(learning).
pain(grief).
pain(dread).
pain(abrasion).
pain(hangover).
pain(depression).
pain(boils).
pain(anger).
pain(sciatica).
pain(loneliness).
pain(prostatitis).
pain(angina).
pain(dread_2).
pain(laceration).
pain(anxiety).
pain(jealousy).
pain(anger_8).
pain(prostatitis_3).
pain(laceration_4).
pain(grief_1).
pain(loneliness_6).
pain(depression_7).
pain(sciatica_5).
province(alsace).
province(surrey).
province(quebec).
planet(uranus).
planet(earth).
planet(mars).
planet(saturn).
eats(pepper,wurst).
eats(lemon,hamburger).
eats(lemon,melon).
eats(pepper,muffin).
eats(potato,muffin).
eats(potato,hamburger).
eats(melon,lobster).
eats(melon,muffin).
eats(muffin,lemon).
eats(lobster,lemon).
eats(lemon,lobster).
eats(lobster,melon).
eats(hamburger,lemon).
eats(muffin,melon).
eats(lemon,wurst).
eats(hamburger,potato).
eats(wurst,pepper).
eats(lemon,muffin).
orbits(uranus,earth).
eats(potato,wurst).
attacks(alsace,surrey).
eats(muffin,pepper).
eats(melon,lemon).
eats(wurst,lemon).
attacks(surrey,quebec).
orbits(earth,mars).
eats(wurst,potato).
orbits(mars,saturn).
eats(muffin,potato).


initial([
craves(depression_7,lobster),
locale(muffin,alsace),
locale(hamburger,surrey),
craves(grief,lemon),
craves(satiety,muffin),
locale(pepper,alsace),
craves(laceration_4,melon),
locale(lemon,quebec),
harmony(learning,saturn),
craves(sciatica,muffin),
craves(angina,hamburger),
craves(excitement,lemon),
craves(intoxication,hamburger),
locale(lobster,surrey),
craves(rest,pepper),
craves(dread_2,pepper),
craves(prostatitis,muffin),
craves(depression,potato),
craves(anxiety,pepper),
locale(potato,quebec),
craves(jealousy,pepper),
craves(laceration,pepper),
craves(loneliness,muffin),
craves(prostatitis_3,melon),
craves(anger_8,melon),
harmony(excitement,saturn),
harmony(satiety,earth),
craves(hangover,potato),
craves(sciatica_5,wurst),
craves(dread,lemon),
craves(boils,potato),
craves(abrasion,lemon),
craves(anger,muffin),
craves(loneliness_6,lobster),
craves(learning,wurst),
locale(wurst,surrey),
harmony(intoxication,mars),
harmony(rest,saturn),
locale(melon,alsace),
craves(grief_1,melon)]):-!.


goal([craves(angina,lobster)]):-!.

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
    Cargo\= angina,
    food(City).
not_determined(fears(Cargo, Car)):-
    pain(Cargo),
    Cargo\= angina,
    pleasure(Car).

