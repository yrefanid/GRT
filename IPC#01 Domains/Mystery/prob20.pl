def(craves(Car,City)):-pleasure(Car), food(City).
def(craves(Cargo,City)):-pain(Cargo), food(City).
def(fears(Cargo, Car)):-pain(Cargo), pleasure(Car).
def(locale(City, Fuel)):-food(City),province(Fuel).
def(harmony(Car, V)):-pleasure(Car), planet(V).


food(mutton).
food(cod).
food(muffin).
food(tuna).
food(pork).
food(sweetroll).
food(yogurt).
food(wonderbread).
food(turkey).
food(pepper).
food(rice).
food(guava).
food(potato).
food(orange).
food(baguette).
food(scallion).
food(marzipan).
food(cherry).
pleasure(love).
pleasure(curiosity).
pleasure(aesthetics).
pleasure(empathy).
pleasure(satisfaction).
pleasure(triumph).
pleasure(intoxication).
pleasure(lubricity).
pleasure(expectation).
pleasure(understanding).
pleasure(achievement).
pain(dread).
pain(abrasion).
pain(grief).
pain(laceration).
province(manitoba).
province(guanabara).
province(quebec).
province(alsace).
province(kentucky).
province(moravia).
province(bosnia).
province(goias).
province(arizona).
province(oregon).
province(surrey).
province(bavaria).
planet(saturn).
planet(neptune).
planet(venus).
planet(pluto).
eats(pepper,guava).
eats(turkey,guava).
eats(marzipan,cod).
eats(yogurt,tuna).
eats(cherry,turkey).
orbits(saturn,neptune).
eats(turkey,tuna).
eats(pork,cod).
eats(turkey,cherry).
attacks(oregon,surrey).
attacks(surrey,bavaria).
attacks(bosnia,goias).
attacks(goias,arizona).
eats(turkey,rice).
eats(cod,tuna).
attacks(alsace,kentucky).
eats(orange,scallion).
eats(pepper,cherry).
eats(mutton,pork).
eats(cod,pork).
eats(marzipan,orange).
eats(baguette,guava).
eats(rice,potato).
eats(rice,turkey).
eats(sweetroll,tuna).
attacks(moravia,bosnia).
orbits(venus,pluto).
eats(yogurt,muffin).
eats(marzipan,cherry).
eats(potato,scallion).
eats(tuna,turkey).
eats(tuna,cod).
eats(scallion,orange).
eats(muffin,sweetroll).
eats(muffin,yogurt).
eats(yogurt,wonderbread).
eats(sweetroll,muffin).
eats(tuna,sweetroll).
eats(scallion,potato).
eats(baguette,rice).
eats(cherry,pepper).
eats(pork,mutton).
eats(potato,rice).
eats(sweetroll,pork).
eats(tuna,yogurt).
eats(orange,marzipan).
attacks(quebec,alsace).
orbits(neptune,venus).
attacks(kentucky,moravia).
eats(wonderbread,yogurt).
eats(guava,baguette).
attacks(manitoba,guanabara).
eats(guava,pepper).
eats(pork,sweetroll).
eats(wonderbread,mutton).
eats(rice,baguette).
eats(cod,marzipan).
attacks(arizona,oregon).
eats(mutton,wonderbread).
eats(guava,turkey).
attacks(guanabara,quebec).
eats(cherry,marzipan).


initial([
locale(yogurt,arizona),
craves(triumph,yogurt),
harmony(love,neptune),
craves(abrasion,wonderbread),
locale(pork,quebec),
locale(guava,goias),
locale(cod,goias),
locale(tuna,arizona),
harmony(intoxication,venus),
locale(marzipan,moravia),
harmony(achievement,venus),
craves(dread,yogurt),
locale(potato,surrey),
craves(intoxication,wonderbread),
harmony(empathy,neptune),
locale(orange,quebec),
locale(pepper,bavaria),
locale(turkey,alsace),
craves(expectation,orange),
harmony(lubricity,pluto),
harmony(triumph,venus),
locale(wonderbread,bosnia),
locale(scallion,surrey),
craves(grief,turkey),
locale(mutton,quebec),
locale(cherry,goias),
harmony(aesthetics,neptune),
craves(achievement,cherry),
craves(understanding,marzipan),
craves(curiosity,cod),
locale(muffin,arizona),
craves(empathy,pork),
locale(rice,manitoba),
harmony(expectation,venus),
harmony(satisfaction,venus),
craves(satisfaction,sweetroll),
locale(baguette,quebec),
locale(sweetroll,goias),
craves(aesthetics,muffin),
craves(laceration,cherry),
harmony(curiosity,neptune),
craves(lubricity,rice),
craves(love,mutton),
harmony(understanding,neptune)]):-!.


goal([craves(abrasion,pepper)]):-!.

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

