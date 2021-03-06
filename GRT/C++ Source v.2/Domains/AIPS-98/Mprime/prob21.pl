def(craves(Car,City)):-pleasure(Car), food(City).
def(craves(Cargo,City)):-pain(Cargo), food(City).
def(fears(Cargo, Car)):-pain(Cargo), pleasure(Car).
def(locale(City, Fuel)):-food(City),province(Fuel).
def(harmony(Car, V)):-pleasure(Car), planet(V).


food(apple).
food(muffin).
food(lemon).
food(flounder).
food(wurst).
food(okra).
food(snickers).
food(onion).
food(marzipan).
food(popover).
food(hamburger).
food(guava).
pleasure(triumph).
pleasure(satisfaction).
pleasure(learning).
pleasure(love).
pleasure(expectation).
pleasure(rest).
pain(laceration).
pain(boils).
pain(anxiety).
pain(dread).
pain(abrasion).
pain(jealousy).
pain(prostatitis).
pain(grief).
pain(hangover).
pain(depression).
pain(angina).
pain(anger).
pain(grief_2).
pain(sciatica).
pain(loneliness).
pain(depression_8).
pain(hangover_3).
pain(anger_4).
pain(angina_1).
pain(prostatitis_7).
pain(abrasion_6).
pain(loneliness_15).
pain(sciatica_16).
pain(laceration_5).
pain(laceration_10).
pain(jealousy_11).
pain(boils_12).
pain(anxiety_13).
pain(dread_14).
pain(boils_30).
pain(grief_31).
pain(loneliness_32).
pain(hangover_9).
pain(abrasion_29).
province(alsace).
province(kentucky).
province(goias).
planet(mars).
planet(uranus).
planet(neptune).
planet(saturn).
eats(wurst,lemon).
eats(snickers,wurst).
eats(wurst,snickers).
eats(popover,hamburger).
eats(popover,snickers).
eats(guava,marzipan).
eats(okra,hamburger).
eats(apple,snickers).
eats(wurst,muffin).
eats(lemon,muffin).
eats(flounder,wurst).
orbits(uranus,neptune).
eats(onion,guava).
eats(apple,flounder).
eats(okra,onion).
eats(wurst,flounder).
eats(hamburger,popover).
eats(lemon,wurst).
attacks(alsace,kentucky).
eats(apple,lemon).
eats(flounder,apple).
eats(muffin,wurst).
eats(onion,okra).
eats(marzipan,guava).
eats(snickers,apple).
eats(snickers,marzipan).
orbits(mars,uranus).
orbits(neptune,saturn).
eats(hamburger,okra).
eats(lemon,apple).
eats(marzipan,snickers).
eats(snickers,popover).
eats(muffin,lemon).
eats(guava,onion).
attacks(kentucky,goias).


initial([
locale(apple,alsace),
craves(prostatitis_7,snickers),
harmony(love,neptune),
craves(sciatica,wurst),
craves(hangover,lemon),
craves(anger,flounder),
craves(hangover_3,okra),
harmony(expectation,neptune),
craves(angina,flounder),
craves(anger_4,okra),
craves(boils_12,popover),
harmony(rest,uranus),
craves(laceration_10,popover),
locale(snickers,goias),
harmony(learning,saturn),
craves(boils,apple),
craves(angina_1,okra),
locale(muffin,alsace),
craves(jealousy,muffin),
craves(loneliness_32,hamburger),
craves(expectation,okra),
craves(triumph,apple),
craves(rest,guava),
craves(depression_8,okra),
craves(prostatitis,muffin),
locale(marzipan,kentucky),
craves(anxiety_13,popover),
craves(depression,lemon),
craves(satisfaction,muffin),
craves(laceration,apple),
craves(dread_14,popover),
harmony(triumph,neptune),
locale(hamburger,kentucky),
craves(laceration_5,marzipan),
locale(onion,alsace),
craves(abrasion,muffin),
craves(loneliness,wurst),
craves(loneliness_15,marzipan),
craves(grief_31,hamburger),
craves(love,flounder),
craves(abrasion_6,onion),
craves(jealousy_11,popover),
locale(popover,goias),
harmony(satisfaction,saturn),
craves(learning,lemon),
craves(grief,muffin),
locale(wurst,alsace),
locale(guava,kentucky),
craves(boils_30,hamburger),
locale(okra,goias),
locale(flounder,kentucky),
craves(dread,muffin),
locale(lemon,kentucky),
craves(anxiety,apple),
craves(hangover_9,hamburger),
craves(sciatica_16,marzipan),
craves(grief_2,wurst),
craves(abrasion_29,guava)]):-!.

goal([craves(sciatica,apple)]):-!.

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
    Cargo\=sciatica,
    food(City).
not_determined(fears(Cargo, Car)):-
    pain(Cargo),
    Cargo\=sciatica,
    pleasure(Car).

