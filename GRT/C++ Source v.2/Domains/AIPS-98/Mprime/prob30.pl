def(craves(Car,City)):-pleasure(Car), food(City).
def(craves(Cargo,City)):-pain(Cargo), food(City).
def(fears(Cargo, Car)):-pain(Cargo), pleasure(Car).
def(locale(City, Fuel)):-food(City),province(Fuel).
def(harmony(Car, V)):-pleasure(Car), planet(V).


food(turkey).
food(cucumber).
food(baguette).
food(beef).
food(muffin).
food(hotdog).
food(mutton).
food(chicken).
food(hamburger).
food(yogurt).
food(scallop).
food(rice).
food(guava).
pleasure(triumph).
pleasure(intoxication).
pleasure(expectation).
pleasure(excitement).
pleasure(achievement).
pain(prostatitis).
pain(dread).
pain(laceration).
pain(anxiety).
pain(boils).
pain(sciatica).
pain(abrasion).
province(quebec).
province(goias).
province(manitoba).
province(surrey).
province(pennsylvania).
province(alsace).
province(guanabara).
province(arizona).
province(oregon).
province(bosnia).
province(bavaria).
province(moravia).
province(kentucky).
planet(mars).
planet(vulcan).
planet(neptune).
planet(venus).
eats(hotdog,cucumber).
eats(muffin,baguette).
eats(baguette,muffin).
eats(rice,scallop).
attacks(surrey,pennsylvania).
eats(guava,yogurt).
eats(turkey,chicken).
attacks(quebec,goias).
eats(turkey,muffin).
eats(beef,hamburger).
eats(baguette,rice).
eats(hamburger,hotdog).
eats(mutton,chicken).
eats(mutton,hotdog).
eats(chicken,hotdog).
eats(guava,rice).
attacks(arizona,oregon).
eats(hotdog,hamburger).
eats(muffin,turkey).
eats(cucumber,hotdog).
eats(rice,baguette).
eats(beef,baguette).
attacks(guanabara,arizona).
eats(turkey,cucumber).
eats(baguette,beef).
eats(scallop,yogurt).
eats(hamburger,beef).
eats(beef,hotdog).
attacks(alsace,guanabara).
attacks(manitoba,surrey).
eats(cucumber,baguette).
eats(chicken,mutton).
eats(baguette,cucumber).
attacks(moravia,kentucky).
orbits(neptune,venus).
eats(scallop,rice).
attacks(oregon,bosnia).
eats(chicken,turkey).
attacks(bosnia,bavaria).
attacks(bavaria,moravia).
eats(hotdog,beef).
attacks(goias,manitoba).
eats(rice,guava).
eats(cucumber,turkey).
orbits(vulcan,neptune).
eats(yogurt,guava).
eats(hotdog,chicken).
eats(yogurt,scallop).
orbits(mars,vulcan).
attacks(pennsylvania,alsace).
eats(hotdog,mutton).

initial([
locale(baguette,guanabara),
locale(hamburger,bavaria),
craves(prostatitis,cucumber),
craves(intoxication,beef),
locale(muffin,oregon),
craves(sciatica,yogurt),
craves(excitement,yogurt),
craves(anxiety,chicken),
harmony(excitement,venus),
harmony(triumph,vulcan),
locale(guava,oregon),
locale(hotdog,kentucky),
craves(triumph,turkey),
locale(chicken,surrey),
craves(achievement,guava),
locale(turkey,pennsylvania),
harmony(expectation,venus),
locale(yogurt,bosnia),
craves(dread,baguette),
harmony(achievement,vulcan),
craves(abrasion,guava),
craves(expectation,hamburger),
harmony(intoxication,venus),
locale(cucumber,bavaria),
locale(beef,bavaria),
locale(mutton,goias),
locale(scallop,oregon),
locale(rice,guanabara),
craves(laceration,muffin),
craves(boils,hamburger)]).

goal([craves(dread,mutton), craves(boils,mutton), craves(anxiety,chicken)]).

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
    Cargo\=dread,
    Cargo\=boils,
    Cargo\=anxiety,
    food(City).
not_determined(fears(Cargo, Car)):-
    pain(Cargo),
Cargo\=dread,
    Cargo\=boils,
    Cargo\=anxiety,
    pleasure(Car).

