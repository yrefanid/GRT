def(craves(Car,City)):-pleasure(Car), food(City).
def(craves(Cargo,City)):-pain(Cargo), food(City).
def(fears(Cargo, Car)):-pain(Cargo), pleasure(Car).
def(locale(City, Fuel)):-food(City),province(Fuel).
def(harmony(Car, V)):-pleasure(Car), planet(V).


food(muffin).
food(ham).
food(scallion).
food(shrimp).
food(cherry).
food(grapefruit).
food(bacon).
food(arugula).
food(scallop).
food(wurst).

pleasure(aesthetics).

pain(hangover).
pain(dread).
pain(sciatica).
pain(jealousy).
pain(loneliness).
pain(abrasion).
pain(anger).
 
province(surrey).
province(quebec).
province(bosnia).
province(oregon).
province(kentucky).

planet(mars).
planet(vulcan).

eats(ham,muffin).
eats(cherry,shrimp).
eats(cherry,ham).
eats(grapefruit,scallop).
eats(wurst,bacon).
eats(muffin,ham).
attacks(oregon,kentucky).
eats(arugula,scallop).
eats(arugula,bacon).
eats(bacon,wurst).
eats(arugula,muffin).
eats(scallion,shrimp).
eats(arugula,wurst).
eats(grapefruit,wurst).
eats(muffin,cherry).
eats(scallop,arugula).
eats(cherry,arugula).
eats(shrimp,scallion).
eats(muffin,scallion).
eats(arugula,cherry).
eats(scallop,grapefruit).
eats(bacon,arugula).
eats(ham,cherry).
eats(cherry,muffin).
attacks(bosnia,oregon).
eats(shrimp,cherry).
eats(wurst,arugula).
attacks(quebec,bosnia).
eats(muffin,arugula).
attacks(surrey,quebec).
eats(scallion,muffin).
orbits(mars,vulcan).
eats(wurst,grapefruit).

initial([
locale(cherry,kentucky),
locale(scallion,quebec),
craves(dread,ham),
craves(sciatica,grapefruit),
craves(anger,wurst),
locale(arugula,kentucky),
craves(loneliness,arugula),
harmony(aesthetics,vulcan),
locale(muffin,kentucky),
locale(grapefruit,surrey),
craves(hangover,muffin),
locale(ham,bosnia),
craves(abrasion,scallop),
locale(bacon,quebec),
locale(wurst,surrey),
locale(scallop,oregon),
craves(aesthetics,shrimp),
locale(shrimp,bosnia),
craves(jealousy,bacon)]).

goal([craves(sciatica,wurst)]).


goal1(List):-findall(X, not_determined(X), List).
not_determined(locale(City, Fuel)):-
	food(City),
	province(Fuel).

not_determined(craves(aesthetics,wurst)).

not_determined(harmony(Car, V)):-
	pleasure(Car),
	planet(V).

not_determined(craves(Cargo, City)):-
	pain(Cargo), 
	Cargo\= sciatica, 
	initial(Initial),
	member(craves(Cargo, City), Initial).



