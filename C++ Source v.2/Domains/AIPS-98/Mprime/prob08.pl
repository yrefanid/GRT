def(craves(Car,City)):-pleasure(Car), food(City).
def(craves(Cargo,City)):-pain(Cargo), food(City).
def(fears(Cargo, Car)):-pain(Cargo), pleasure(Car).
def(locale(City, Fuel)):-food(City),province(Fuel).
def(harmony(Car, V)):-pleasure(Car), planet(V).


food(rice).
food(okra).
food(hotdog).
food(tofu).
food(muffin).
food(tuna).
food(pork).
food(cantelope).
food(turkey).
food(baguette).
food(arugula).
food(wonderbread).
food(pepper).
food(flounder).
food(lobster).
food(scallop).
food(tomato).
food(pistachio).
pleasure(achievement).
pleasure(love).
pleasure(triumph).
pleasure(stimulation).
pleasure(learning).
pleasure(lubricity).
pleasure(rest).
pleasure(aesthetics).
pleasure(excitement).
pain(sciatica).
pain(hangover).
pain(anxiety).
pain(abrasion).
pain(anger).
province(bavaria).
province(goias).
province(pennsylvania).
province(bosnia).
province(surrey).
planet(earth).
planet(uranus).
planet(vulcan).
planet(jupiter).
attacks(bavaria,goias).
eats(turkey,baguette).
eats(muffin,tuna).
eats(flounder,wonderbread).
eats(wonderbread,scallop).
eats(tuna,muffin).
eats(pistachio,arugula).
eats(rice,tofu).
eats(cantelope,arugula).
attacks(goias,pennsylvania).
eats(pork,lobster).
orbits(uranus,vulcan).
eats(okra,hotdog).
eats(flounder,lobster).
eats(tuna,rice).
eats(okra,wonderbread).
eats(arugula,pistachio).
eats(rice,tuna).
orbits(vulcan,jupiter).
eats(baguette,turkey).
eats(tomato,scallop).
eats(tuna,okra).
attacks(bosnia,surrey).
eats(scallop,tomato).
eats(hotdog,okra).
eats(hotdog,tofu).
eats(muffin,rice).
eats(muffin,tofu).
eats(wonderbread,flounder).
eats(wonderbread,okra).
eats(tofu,rice).
eats(baguette,tomato).
eats(tomato,baguette).
eats(tofu,muffin).
eats(tofu,hotdog).
eats(arugula,cantelope).
eats(rice,muffin).
eats(scallop,wonderbread).
eats(pistachio,pepper).
eats(lobster,pork).
eats(lobster,flounder).
eats(pepper,turkey).
attacks(pennsylvania,bosnia).
orbits(earth,uranus).
eats(pork,cantelope).
eats(okra,tuna).
eats(cantelope,pork).
eats(turkey,pepper).
eats(pepper,pistachio).


initial([
harmony(learning,vulcan),
harmony(stimulation,uranus),
craves(excitement,tomato),
harmony(achievement,vulcan),
harmony(rest,jupiter),
locale(pork,bosnia),
craves(hangover,muffin),
locale(flounder,goias),
craves(lubricity,arugula),
locale(tuna,surrey),
craves(sciatica,okra),
craves(anxiety,muffin),
locale(scallop,pennsylvania),
locale(turkey,goias),
craves(love,okra),
locale(tofu,goias),
craves(abrasion,baguette),
locale(tomato,bosnia),
locale(pepper,goias),
craves(triumph,hotdog),
locale(cantelope,pennsylvania),
craves(learning,cantelope),
craves(anger,baguette),
craves(rest,wonderbread),
locale(hotdog,bavaria),
harmony(love,jupiter),
craves(achievement,rice),
harmony(aesthetics,vulcan),
locale(rice,bavaria),
locale(wonderbread,goias),
locale(pistachio,pennsylvania),
locale(lobster,goias),
locale(baguette,bosnia),
harmony(excitement,jupiter),
locale(okra,bosnia),
harmony(triumph,vulcan),
harmony(lubricity,uranus),
locale(muffin,bavaria),
craves(aesthetics,scallop),
craves(stimulation,muffin),
locale(arugula,bavaria)]):-!.


goal([craves(anxiety,wonderbread)]):-!.

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

