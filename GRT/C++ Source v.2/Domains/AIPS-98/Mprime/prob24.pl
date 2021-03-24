def(craves(Car,City)):-pleasure(Car), food(City).
def(craves(Cargo,City)):-pain(Cargo), food(City).
def(fears(Cargo, Car)):-pain(Cargo), pleasure(Car).
def(locale(City, Fuel)):-food(City),province(Fuel).
def(harmony(Car, V)):-pleasure(Car), planet(V).


food(turkey).
food(cherry).
food(tofu).
food(lettuce).
food(bacon).
food(chicken).
food(muffin).
food(chocolate).
food(pepper).
food(shrimp).
food(orange).
food(apple).
food(wurst).
food(potato).
food(melon).
pleasure(achievement).
pleasure(satiety).
pleasure(curiosity).
pain(grief).
pain(angina).
pain(depression).
pain(sciatica).
pain(loneliness).
pain(jealousy).
pain(anxiety).
pain(boils).
pain(dread).
pain(hangover).
pain(laceration).
pain(prostatitis).
pain(abrasion).
pain(anger).
pain(abrasion_2).
pain(jealousy_8).
pain(prostatitis_3).
pain(anxiety_4).
pain(loneliness_1).
pain(angina_16).
pain(boils_5).
pain(dread_6).
pain(laceration_7).
pain(hangover_13).
pain(depression_14).
pain(grief_15).
pain(sciatica_11).
pain(anger_12).
pain(angina_32).
pain(anger_9).
pain(hangover_10).
pain(loneliness_31).
pain(anxiety_26).
pain(abrasion_27).
pain(dread_28).
pain(sciatica_29).
pain(depression_30).
province(surrey).
province(arizona).
province(alsace).
province(goias).
province(manitoba).
province(bosnia).
province(oregon).
province(moravia).
province(guanabara).
province(bavaria).
planet(vulcan).
planet(uranus).
planet(saturn).
planet(earth).
eats(potato,wurst).
eats(lettuce,bacon).
eats(melon,potato).
eats(muffin,tofu).
eats(turkey,bacon).
orbits(uranus,saturn).
attacks(goias,manitoba).
eats(orange,shrimp).
eats(cherry,chicken).
eats(shrimp,apple).
attacks(bosnia,oregon).
eats(pepper,potato).
attacks(oregon,moravia).
eats(wurst,potato).
attacks(arizona,alsace).
eats(apple,shrimp).
eats(chocolate,apple).
eats(cherry,tofu).
attacks(surrey,arizona).
eats(tofu,muffin).
eats(potato,pepper).
orbits(vulcan,uranus).
eats(apple,chocolate).
eats(wurst,orange).
eats(turkey,chicken).
eats(tofu,chicken).
eats(muffin,melon).
eats(potato,melon).
eats(chocolate,pepper).
eats(cherry,lettuce).
eats(pepper,melon).
eats(melon,pepper).
eats(chicken,tofu).
eats(orange,wurst).
eats(muffin,apple).
attacks(alsace,goias).
eats(shrimp,orange).
eats(melon,muffin).
eats(apple,muffin).
eats(chicken,turkey).
orbits(saturn,earth).
attacks(moravia,guanabara).
eats(pepper,chocolate).
eats(lettuce,cherry).
eats(bacon,lettuce).
attacks(manitoba,bosnia).
attacks(guanabara,bavaria).
eats(bacon,turkey).
eats(tofu,cherry).
eats(chicken,cherry).


initial([
harmony(satiety,saturn),
craves(anger_9,wurst),
craves(curiosity,muffin),
craves(abrasion_27,melon),
craves(laceration_7,shrimp),
locale(shrimp,arizona),
locale(tofu,surrey),
harmony(curiosity,earth),
craves(satiety,bacon),
locale(lettuce,manitoba),
craves(hangover,chicken),
craves(anger,muffin),
craves(depression_30,melon),
craves(abrasion,chicken),
craves(boils,lettuce),
harmony(achievement,saturn),
craves(jealousy_8,pepper),
craves(grief,turkey),
locale(chocolate,manitoba),
locale(chicken,alsace),
craves(dread,lettuce),
locale(apple,surrey),
craves(sciatica_11,apple),
craves(achievement,cherry),
craves(depression,cherry),
craves(dread_28,melon),
locale(muffin,goias),
craves(jealousy,lettuce),
craves(boils_5,shrimp),
craves(anxiety,lettuce),
craves(anxiety_4,pepper),
craves(angina,turkey),
locale(wurst,arizona),
locale(potato,bavaria),
locale(orange,goias),
craves(anger_12,apple),
craves(laceration,chicken),
locale(melon,bavaria),
locale(bacon,bosnia),
craves(hangover_10,wurst),
craves(grief_15,orange),
craves(loneliness,tofu),
craves(loneliness_31,potato),
craves(sciatica_29,melon),
craves(prostatitis_3,pepper),
locale(turkey,alsace),
locale(pepper,bavaria),
craves(hangover_13,orange),
craves(abrasion_2,chocolate),
craves(sciatica,tofu),
craves(depression_14,orange),
locale(cherry,surrey),
craves(dread_6,shrimp),
craves(angina_32,wurst),
craves(angina_16,shrimp),
craves(anxiety_26,melon),
craves(prostatitis,chicken),
craves(loneliness_1,pepper)]):-!.

goal([and,craves(jealousy_8,pepper),craves(anxiety_4,pepper),craves(anger_12,cherry)]):-!.

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
    Cargo\= jealousy_8,
    Cargo\= anxiety_4,
    Cargo\= anger_12,
    food(City).
not_determined(fears(Cargo, Car)):-
    pain(Cargo),
    Cargo\= jealousy_8,
    Cargo\= anxiety_4,
    Cargo\= anger_12,
    pleasure(Car).

