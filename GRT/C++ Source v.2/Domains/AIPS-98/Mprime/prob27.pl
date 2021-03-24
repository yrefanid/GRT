def(craves(Car,City)):-pleasure(Car), food(City).
def(craves(Cargo,City)):-pain(Cargo), food(City).
def(fears(Cargo, Car)):-pain(Cargo), pleasure(Car).
def(locale(City, Fuel)):-food(City),province(Fuel).
def(harmony(Car, V)):-pleasure(Car), planet(V).


food(wurst).
food(guava).
food(muffin).
food(pork).
food(onion).
food(popover).
food(scallion).
pleasure(triumph).
pleasure(love).
pleasure(satisfaction).
pain(abrasion).
pain(anxiety).
pain(dread).
pain(loneliness).
pain(grief).
pain(boils).
province(moravia).
province(surrey).
province(guanabara).
province(manitoba).
province(arizona).
province(pennsylvania).
province(alsace).
province(quebec).
province(kentucky).
province(oregon).
province(bavaria).
province(goias).
province(bosnia).
planet(mercury).
planet(mars).
planet(uranus).
planet(earth).
attacks(kentucky,oregon).
eats(wurst,guava).
eats(pork,muffin).
attacks(goias,bosnia).
eats(scallion,muffin).
eats(scallion,popover).
eats(muffin,scallion).
eats(onion,wurst).
eats(scallion,guava).
attacks(quebec,kentucky).
eats(muffin,pork).
eats(wurst,onion).
attacks(oregon,bavaria).
orbits(uranus,earth).
attacks(guanabara,manitoba).
attacks(pennsylvania,alsace).
orbits(mercury,mars).
attacks(manitoba,arizona).
eats(muffin,onion).
eats(popover,onion).
eats(onion,muffin).
eats(popover,scallion).
attacks(alsace,quebec).
eats(guava,scallion).
eats(onion,pork).
attacks(bavaria,goias).
eats(guava,wurst).
attacks(surrey,guanabara).
eats(onion,popover).
eats(pork,onion).
attacks(arizona,pennsylvania).
orbits(mars,uranus).
attacks(moravia,surrey).


initial([
locale(wurst,bavaria),
craves(abrasion,wurst),
locale(onion,bosnia),
craves(anxiety,wurst),
craves(boils,scallion),
harmony(satisfaction,uranus),
locale(scallion,pennsylvania),
craves(triumph,onion),
craves(dread,wurst),
harmony(love,uranus),
locale(popover,oregon),
harmony(triumph,earth),
locale(guava,oregon),
locale(muffin,guanabara),
craves(satisfaction,scallion),
craves(love,popover),
craves(loneliness,scallion),
locale(pork,pennsylvania),
craves(grief,scallion)]):-!.

goal([craves(grief,guava)
,craves(boils,guava)]):-!.

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
    Cargo\=grief,
    Cargo\=boils,
    food(City).
not_determined(fears(Cargo, Car)):-
    pain(Cargo),
    Cargo\=grief,
    Cargo\=boils,
    pleasure(Car).

