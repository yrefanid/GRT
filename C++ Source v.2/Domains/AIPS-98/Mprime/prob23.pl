def(craves(Car,City)):-pleasure(Car), food(City).
def(craves(Cargo,City)):-pain(Cargo), food(City).
def(fears(Cargo, Car)):-pain(Cargo), pleasure(Car).
def(locale(City, Fuel)):-food(City),province(Fuel).
def(harmony(Car, V)):-pleasure(Car), planet(V).


food(flounder).
food(okra).
food(ham).
food(papaya).
food(cherry).
food(scallop).
food(pistachio).
food(lamb).
food(sweetroll).
food(apple).
food(onion).
food(haroset).
food(lobster).
food(chicken).
food(beef).
food(grapefruit).
food(hotdog).
food(wonderbread).
food(bacon).
pleasure(learning).
pleasure(understanding).
pleasure(satisfaction).
pleasure(intoxication).
pleasure(empathy).
pleasure(curiosity).
pleasure(triumph).
pain(sciatica).
pain(boils).
pain(abrasion).
pain(angina).
pain(anger).
pain(anxiety).
pain(loneliness).
pain(hangover).
pain(laceration).
pain(jealousy).
pain(depression).
pain(prostatitis).
pain(grief).
pain(dread).
pain(boils_2).
pain(anxiety_1).
province(manitoba).
province(alsace).
province(bosnia).
province(kentucky).
province(pennsylvania).
province(goias).
planet(mercury).
planet(neptune).
planet(mars).
planet(jupiter).
attacks(kentucky,pennsylvania).
eats(lamb,flounder).
eats(papaya,lamb).
eats(scallop,ham).
eats(sweetroll,okra).
eats(scallop,pistachio).
eats(pistachio,apple).
eats(onion,pistachio).
eats(sweetroll,cherry).
eats(haroset,grapefruit).
orbits(mercury,neptune).
eats(bacon,lobster).
eats(grapefruit,haroset).
eats(bacon,haroset).
eats(grapefruit,hotdog).
eats(lobster,bacon).
eats(apple,onion).
eats(pistachio,onion).
eats(apple,pistachio).
eats(grapefruit,beef).
eats(papaya,ham).
eats(cherry,pistachio).
eats(hotdog,wonderbread).
eats(chicken,beef).
eats(hotdog,chicken).
orbits(neptune,mars).
eats(hotdog,lamb).
eats(pistachio,scallop).
eats(ham,papaya).
eats(hotdog,grapefruit).
eats(flounder,lamb).
eats(chicken,hotdog).
eats(onion,apple).
attacks(manitoba,alsace).
orbits(mars,jupiter).
attacks(alsace,bosnia).
eats(lamb,papaya).
eats(lamb,hotdog).
eats(pistachio,cherry).
eats(cherry,sweetroll).
eats(beef,lobster).
eats(lamb,okra).
eats(lobster,beef).
eats(okra,sweetroll).
eats(beef,chicken).
attacks(pennsylvania,goias).
eats(okra,lamb).
eats(haroset,bacon).
eats(onion,flounder).
eats(wonderbread,bacon).
eats(ham,scallop).
attacks(bosnia,kentucky).
eats(flounder,onion).
eats(beef,grapefruit).
eats(bacon,wonderbread).
eats(wonderbread,hotdog).


initial([
craves(learning,okra),
craves(boils_2,grapefruit),
craves(intoxication,onion),
locale(okra,alsace),
craves(grief,chicken),
locale(beef,alsace),
craves(anxiety_1,wonderbread),
harmony(intoxication,mars),
craves(abrasion,ham),
harmony(curiosity,mars),
craves(triumph,bacon),
craves(angina,papaya),
locale(ham,goias),
harmony(learning,neptune),
locale(scallop,goias),
craves(anger,cherry),
locale(lamb,kentucky),
harmony(triumph,jupiter),
locale(wonderbread,bosnia),
harmony(understanding,mars),
locale(onion,alsace),
craves(prostatitis,lobster),
craves(boils,okra),
craves(dread,beef),
craves(jealousy,onion),
craves(loneliness,pistachio),
locale(sweetroll,manitoba),
locale(cherry,kentucky),
locale(chicken,pennsylvania),
craves(depression,haroset),
locale(papaya,kentucky),
harmony(satisfaction,mars),
locale(grapefruit,alsace),
craves(understanding,cherry),
craves(sciatica,flounder),
locale(apple,pennsylvania),
craves(hangover,sweetroll),
craves(anxiety,scallop),
craves(satisfaction,lamb),
locale(haroset,pennsylvania),
locale(lobster,bosnia),
craves(laceration,apple),
craves(empathy,haroset),
locale(hotdog,manitoba),
locale(flounder,pennsylvania),
locale(bacon,pennsylvania),
craves(curiosity,grapefruit),
harmony(empathy,neptune),
locale(pistachio,pennsylvania)]):-!.


goal([craves(laceration,chicken)]):-!.

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
    Cargo\=laceration,
    food(City).
not_determined(fears(Cargo, Car)):-
    pain(Cargo),
    Cargo\=laceration,
    pleasure(Car).

