def(craves(Car,City)):-pleasure(Car), food(City).
def(craves(Cargo,City)):-pain(Cargo), food(City).
def(fears(Cargo, Car)):-pain(Cargo), pleasure(Car).
def(locale(City, Fuel)):-food(City),province(Fuel).
def(harmony(Car, V)):-pleasure(Car), planet(V).


food(bacon).
food(tofu).
food(lamb).
food(lobster).
food(beef).
food(cantelope).
food(onion).
food(wonderbread).
food(lemon).
food(haroset).
food(marzipan).
food(flounder).
food(okra).
food(snickers).
food(ham).
pleasure(aesthetics).
pleasure(stimulation).
pleasure(entertainment).
pleasure(achievement).
pleasure(lubricity).
pleasure(love).
pleasure(expectation).
pleasure(learning).
pain(sciatica).
pain(loneliness).
pain(laceration).
pain(grief).
pain(abrasion).
pain(anxiety).
pain(dread).
pain(boils).
pain(jealousy).
pain(prostatitis).
pain(anger).
pain(hangover).
pain(depression).
pain(angina).
province(bavaria).
province(manitoba).
province(pennsylvania).
province(oregon).
province(goias).
province(bosnia).
planet(vulcan).
planet(uranus).
planet(saturn).
planet(earth).
eats(lobster,bacon).
eats(lobster,haroset).
eats(lemon,ham).
eats(wonderbread,bacon).
eats(okra,snickers).
eats(beef,lemon).
eats(haroset,flounder).
eats(lemon,cantelope).
eats(marzipan,tofu).
attacks(pennsylvania,oregon).
eats(wonderbread,okra).
eats(onion,tofu).
eats(marzipan,cantelope).
eats(lemon,beef).
eats(bacon,wonderbread).
eats(okra,wonderbread).
eats(beef,lamb).
eats(lamb,beef).
eats(wonderbread,marzipan).
eats(snickers,wonderbread).
eats(haroset,lamb).
eats(tofu,marzipan).
eats(marzipan,wonderbread).
eats(cantelope,lemon).
eats(beef,marzipan).
attacks(goias,bosnia).
eats(bacon,lobster).
attacks(manitoba,pennsylvania).
eats(lamb,haroset).
eats(snickers,okra).
eats(flounder,ham).
attacks(bavaria,manitoba).
orbits(uranus,saturn).
orbits(vulcan,uranus).
eats(cantelope,marzipan).
eats(ham,lemon).
eats(marzipan,beef).
eats(haroset,lobster).
orbits(saturn,earth).
attacks(oregon,goias).
eats(onion,snickers).
eats(flounder,haroset).
eats(wonderbread,snickers).
eats(tofu,onion).
eats(snickers,onion).
eats(ham,flounder).


initial([
locale(cantelope,bavaria),
harmony(achievement,saturn),
harmony(love,uranus),
locale(onion,bavaria),
craves(jealousy,haroset),
craves(love,haroset),
craves(sciatica,bacon),
craves(abrasion,beef),
harmony(stimulation,earth),
harmony(lubricity,earth),
craves(hangover,okra),
craves(stimulation,lamb),
locale(marzipan,oregon),
harmony(expectation,saturn),
craves(dread,wonderbread),
locale(lemon,manitoba),
locale(okra,manitoba),
craves(angina,ham),
craves(laceration,lamb),
locale(lobster,manitoba),
craves(loneliness,tofu),
locale(bacon,manitoba),
craves(lubricity,lemon),
locale(haroset,manitoba),
craves(depression,snickers),
locale(beef,oregon),
craves(anger,flounder),
locale(lamb,bosnia),
harmony(entertainment,uranus),
harmony(learning,saturn),
craves(anxiety,onion),
craves(learning,snickers),
harmony(aesthetics,earth),
locale(flounder,oregon),
craves(grief,lobster),
locale(ham,bosnia),
locale(wonderbread,bavaria),
locale(tofu,manitoba),
craves(expectation,okra),
craves(achievement,wonderbread),
locale(snickers,manitoba),
craves(boils,lemon),
craves(prostatitis,marzipan),
craves(aesthetics,bacon),
craves(entertainment,lobster)]):-!.


goal([craves(abrasion,lobster)]):-!.

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
    Cargo\=abrasion,
    food(City).
not_determined(fears(Cargo, Car)):-
    pain(Cargo),
    Cargo\=abrasion,
    pleasure(Car).

