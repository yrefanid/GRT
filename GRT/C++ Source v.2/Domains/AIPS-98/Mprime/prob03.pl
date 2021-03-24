def(craves(Car,City)):-pleasure(Car), food(City).
def(craves(Cargo,City)):-pain(Cargo), food(City).
def(fears(Cargo, Car)):-pain(Cargo), pleasure(Car).
def(locale(City, Fuel)):-food(City),province(Fuel).
def(harmony(Car, V)):-pleasure(Car), planet(V).


food(pepper).
food(pea).
food(lemon).
food(snickers).
food(marzipan).
food(popover).
food(melon).
food(orange).
food(chocolate).
food(ham).
food(mutton).
pleasure(entertainment).
pleasure(triumph).
pleasure(love).
pleasure(satisfaction).
pain(laceration).
pain(anxiety).
pain(grief).
pain(depression).
pain(boils).
pain(angina).
pain(hangover).
pain(jealousy).
province(goias).
province(guanabara).
province(bavaria).
province(arizona).
province(manitoba).
planet(vulcan).
planet(venus).
planet(neptune).
eats(orange,mutton).
eats(pea,snickers).
eats(popover,pepper).
attacks(guanabara,bavaria).
eats(mutton,orange).
attacks(bavaria,arizona).
attacks(goias,guanabara).
eats(marzipan,pea).
eats(mutton,melon).
eats(pea,pepper).
eats(pepper,melon).
eats(popover,lemon).
eats(popover,marzipan).
eats(chocolate,ham).
eats(melon,ham).
orbits(venus,neptune).
eats(marzipan,snickers).
eats(pepper,popover).
orbits(vulcan,venus).
eats(ham,melon).
eats(chocolate,orange).
eats(marzipan,popover).
eats(orange,chocolate).
eats(snickers,pea).
eats(pea,marzipan).
eats(lemon,pea).
eats(melon,pepper).
eats(melon,mutton).
eats(pepper,pea).
eats(ham,chocolate).
eats(snickers,marzipan).
attacks(arizona,manitoba).
eats(lemon,popover).
eats(pea,lemon).


initial([harmony(satisfaction,neptune),
craves(angina,orange),
craves(grief,marzipan),
harmony(triumph,neptune),
locale(popover,arizona),
locale(ham,manitoba),
craves(jealousy,ham),
locale(melon,manitoba),
locale(pea,bavaria),
craves(boils,melon),
craves(laceration,pepper),
locale(mutton,guanabara),
harmony(love,neptune),
locale(lemon,goias),
craves(triumph,popover),
locale(marzipan,bavaria),
harmony(entertainment,venus),
locale(orange,bavaria),
craves(love,orange),
craves(anxiety,snickers),
locale(pepper,manitoba),
locale(chocolate,guanabara),
craves(entertainment,pepper),
craves(satisfaction,mutton),
locale(snickers,bavaria),
craves(depression,popover),
craves(hangover,chocolate)]).


goal([craves(hangover,ham)]).


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
    Cargo\=hangover,
    food(City).
not_determined(fears(Cargo, Car)):-
    pain(Cargo),
    Cargo\=hangover,
    pleasure(Car).

