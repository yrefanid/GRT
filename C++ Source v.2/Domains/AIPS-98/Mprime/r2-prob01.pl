def(craves(Car,City)):-pleasure(Car), food(City).
def(craves(Cargo,City)):-pain(Cargo), food(City).
def(fears(Cargo, Car)):-pain(Cargo), pleasure(Car).
def(locale(City, Fuel)):-food(City),province(Fuel).
def(harmony(Car, V)):-pleasure(Car), planet(V).


food(grapefruit).
food(chocolate).
food(cantelope).
food(ham).
food(haroset).
food(snickers).
food(muffin).
food(chicken).
food(pistachio).
food(lemon).
food(bacon).
pleasure(learning).
pleasure(love).
pleasure(rest).
pleasure(intoxication).
pleasure(expectation).
pleasure(understanding).
pleasure(triumph).
pleasure(aesthetics).
pain(prostatitis).
pain(grief).
pain(dread).
pain(depression).
pain(sciatica).
pain(abrasion).
pain(hangover).
pain(loneliness).
pain(anger).
pain(angina).
province(alsace).
province(quebec).
province(kentucky).
planet(earth).
planet(saturn).
planet(neptune).
planet(mars).
orbits(saturn,neptune).
eats(snickers,muffin).
eats(ham,muffin).
eats(cantelope,chocolate).
eats(lemon,bacon).
eats(muffin,ham).
eats(cantelope,bacon).
eats(chocolate,haroset).
eats(haroset,chocolate).
orbits(earth,saturn).
eats(ham,grapefruit).
eats(grapefruit,haroset).
eats(chicken,muffin).
eats(haroset,grapefruit).
eats(lemon,pistachio).
attacks(alsace,quebec).
eats(bacon,chicken).
eats(chocolate,cantelope).
attacks(quebec,kentucky).
eats(muffin,snickers).
eats(pistachio,snickers).
eats(pistachio,lemon).
eats(snickers,pistachio).
eats(muffin,chicken).
eats(bacon,cantelope).
eats(grapefruit,ham).
eats(ham,cantelope).
eats(cantelope,ham).
orbits(neptune,mars).
eats(chicken,bacon).
eats(bacon,lemon).


initial([
locale(snickers,kentucky),
craves(rest,haroset),
harmony(expectation,mars),
craves(expectation,muffin),
craves(love,ham),
craves(grief,grapefruit),
harmony(triumph,saturn),
craves(triumph,lemon),
locale(chocolate,quebec),
craves(dread,cantelope),
craves(aesthetics,bacon),
craves(loneliness,pistachio),
craves(hangover,chicken),
locale(muffin,quebec),
craves(learning,grapefruit),
harmony(understanding,neptune),
craves(anger,lemon),
craves(understanding,chicken),
craves(abrasion,muffin),
harmony(rest,mars),
harmony(learning,saturn),
locale(lemon,alsace),
craves(intoxication,snickers),
harmony(aesthetics,neptune),
craves(prostatitis,grapefruit),
locale(ham,kentucky),
craves(sciatica,ham),
locale(grapefruit,quebec),
locale(bacon,alsace),
craves(angina,lemon),
locale(haroset,alsace),
locale(cantelope,quebec),
locale(chicken,quebec),
harmony(intoxication,saturn),
craves(depression,cantelope),
locale(pistachio,alsace),
harmony(love,saturn)]):-!.


goal([craves(prostatitis,cantelope)]):-!.


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
    Cargo\= prostatitis,
    food(City).
not_determined(fears(Cargo, Car)):-
    pain(Cargo),
    Cargo\= prostatitis,
    pleasure(Car).

