def(craves(Car,City)):-pleasure(Car), food(City).
def(craves(Cargo,City)):-pain(Cargo), food(City).
def(fears(Cargo, Car)):-pain(Cargo), pleasure(Car).
def(locale(City, Fuel)):-food(City),province(Fuel).
def(harmony(Car, V)):-pleasure(Car), planet(V).


food(chicken).
food(turkey).
food(sweetroll).
food(potato).
food(tofu).
food(apple).
food(hamburger).
food(muffin).
food(yogurt).
food(shrimp).
food(onion).
food(popover).
food(haroset).
pleasure(aesthetics).
pleasure(satisfaction).
pleasure(achievement).
pleasure(intoxication).
pleasure(excitement).
pain(boils).
pain(hangover).
pain(dread).
pain(loneliness).
pain(abrasion).
pain(jealousy).
pain(depression).
pain(laceration).
pain(anxiety).
pain(anger).
pain(angina).
pain(laceration_1).
pain(prostatitis_2).
pain(grief).
pain(prostatitis).
pain(sciatica).
pain(dread_4).
pain(depression_7).
pain(loneliness_8).
pain(hangover_3).
pain(boils_15).
pain(anxiety_16).
pain(grief_5).
pain(anger_6).
pain(sciatica_13).
pain(abrasion_14).
pain(loneliness_32).
pain(sciatica_9).
pain(anger_10).
pain(jealousy_11).
pain(angina_12).
pain(abrasion_29).
pain(hangover_30).
pain(angina_31).
pain(grief_28).
pain(anxiety_23).
pain(prostatitis_24).
pain(jealousy_25).
pain(dread_26).
pain(depression_27).
province(goias).
province(kentucky).
province(oregon).
province(alsace).
province(bosnia).
province(bavaria).
planet(uranus).
planet(mars).
planet(mercury).
planet(neptune).
eats(shrimp,yogurt).
eats(hamburger,popover).
eats(turkey,sweetroll).
eats(apple,yogurt).
eats(yogurt,apple).
eats(haroset,apple).
eats(onion,popover).
eats(tofu,potato).
eats(muffin,hamburger).
eats(hamburger,muffin).
eats(potato,turkey).
orbits(uranus,mars).
attacks(oregon,alsace).
eats(onion,shrimp).
eats(turkey,potato).
orbits(mercury,neptune).
eats(chicken,sweetroll).
eats(yogurt,shrimp).
attacks(bosnia,bavaria).
eats(turkey,tofu).
attacks(alsace,bosnia).
eats(potato,chicken).
eats(sweetroll,turkey).
eats(tofu,turkey).
eats(muffin,haroset).
eats(potato,tofu).
eats(haroset,muffin).
eats(apple,haroset).
eats(popover,hamburger).
attacks(kentucky,oregon).
eats(sweetroll,chicken).
eats(chicken,popover).
eats(popover,onion).
orbits(mars,mercury).
attacks(goias,kentucky).
eats(chicken,potato).
eats(shrimp,onion).
eats(popover,chicken).


initial([
craves(achievement,muffin),
craves(sciatica,potato),
craves(satisfaction,hamburger),
craves(prostatitis_24,haroset),
craves(angina_12,shrimp),
locale(apple,bavaria),
craves(prostatitis,potato),
craves(anger,sweetroll),
craves(abrasion,turkey),
craves(boils_15,hamburger),
locale(chicken,alsace),
craves(boils,chicken),
craves(angina,sweetroll),
craves(angina_31,onion),
craves(depression_7,apple),
craves(intoxication,onion),
locale(onion,kentucky),
harmony(excitement,mars),
harmony(satisfaction,mars),
craves(prostatitis_2,potato),
locale(turkey,kentucky),
craves(loneliness_32,shrimp),
craves(anxiety_16,hamburger),
craves(jealousy_25,haroset),
craves(sciatica_9,shrimp),
craves(abrasion_14,yogurt),
harmony(aesthetics,mercury),
locale(yogurt,alsace),
craves(anger_10,shrimp),
locale(sweetroll,alsace),
craves(abrasion_29,onion),
craves(anxiety,sweetroll),
locale(popover,goias),
locale(potato,alsace),
locale(tofu,goias),
craves(depression_27,haroset),
craves(dread_4,tofu),
craves(hangover_30,onion),
harmony(achievement,mars),
craves(grief,potato),
craves(loneliness_8,apple),
craves(dread,turkey),
craves(anger_6,hamburger),
locale(shrimp,kentucky),
craves(dread_26,haroset),
craves(loneliness,turkey),
craves(grief_5,hamburger),
craves(jealousy,turkey),
locale(muffin,alsace),
craves(jealousy_11,shrimp),
locale(haroset,oregon),
craves(grief_28,popover),
craves(depression,sweetroll),
craves(laceration_1,potato),
craves(anxiety_23,haroset),
craves(sciatica_13,yogurt),
locale(hamburger,kentucky),
craves(hangover,chicken),
craves(aesthetics,apple),
craves(excitement,haroset),
craves(hangover_3,apple),
craves(laceration,sweetroll),
harmony(intoxication,neptune)]):-!.


goal([craves(anxiety,haroset)]):-!.

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
    Cargo\= anxiety,
    food(City).
not_determined(fears(Cargo, Car)):-
    pain(Cargo),
    Cargo\= anxiety,
    pleasure(Car).

