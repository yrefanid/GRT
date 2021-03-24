def(craves(Car,City)):-pleasure(Car), food(City).
def(craves(Cargo,City)):-pain(Cargo), food(City).
def(fears(Cargo, Car)):-pain(Cargo), pleasure(Car).
def(locale(City, Fuel)):-food(City),province(Fuel).
def(harmony(Car, V)):-pleasure(Car), planet(V).


food(apple).
food(flounder).
food(haroset).
food(hamburger).
food(wurst).
food(hotdog).
food(guava).
pleasure(entertainment).
pleasure(intoxication).
pleasure(curiosity).
pleasure(excitement).
pain(dread).
pain(sciatica).
pain(abrasion).
pain(prostatitis).
pain(loneliness).
pain(anger).
pain(hangover).
pain(anxiety).
pain(laceration).
pain(boils).
pain(jealousy).
pain(angina).
pain(grief).
province(bosnia).
province(bavaria).
province(arizona).
province(manitoba).
province(kentucky).
planet(earth).
planet(uranus).
planet(saturn).
planet(venus).
eats(apple,guava).
eats(guava,apple).
eats(hamburger,haroset).
eats(flounder,hamburger).
attacks(bavaria,arizona).
eats(hamburger,flounder).
eats(haroset,guava).
attacks(bosnia,bavaria).
eats(hotdog,wurst).
eats(guava,haroset).
eats(hotdog,apple).
eats(flounder,wurst).
eats(apple,hotdog).
eats(wurst,flounder).
attacks(arizona,manitoba).
orbits(earth,uranus).
eats(wurst,hotdog).
orbits(uranus,saturn).
orbits(saturn,venus).
attacks(manitoba,kentucky).
eats(haroset,hamburger).


initial([
locale(hotdog,bavaria),
locale(wurst,bavaria),
craves(hangover,haroset),
craves(loneliness,haroset),
harmony(intoxication,uranus),
craves(laceration,wurst),
craves(anxiety,wurst),
locale(hamburger,bosnia),
harmony(excitement,uranus),
craves(anger,haroset),
craves(curiosity,hotdog),
craves(dread,flounder),
harmony(entertainment,venus),
craves(intoxication,haroset),
craves(angina,guava),
craves(excitement,guava),
craves(jealousy,guava),
craves(sciatica,flounder),
craves(grief,guava),
craves(boils,guava),
craves(entertainment,flounder),
locale(haroset,arizona),
harmony(curiosity,uranus),
craves(prostatitis,haroset),
craves(abrasion,haroset),
locale(flounder,arizona),
locale(guava,kentucky),
locale(apple,arizona)]):-!.

goal([craves(sciatica,hamburger),craves(jealousy,wurst)]):-!.

goal1(List):-findall(X, not_determined(X), List).


not_determined(locale(City, Fuel)):-
	food(City),
	province(Fuel).

not_determined(craves(entertainment, hamburger)).
not_determined(craves(intoxication, wurst)).

not_determined(craves(Car,City)):-pleasure(Car), Car\=entertainment, 
		Car\= intoxication, 
		initial(Initial), 
		member(craves(Car, City), Initial).

not_determined(harmony(Car, V)):-
	pleasure(Car),
	planet(V).

not_determined(craves(Cargo, City)):-
	pain(Cargo), 
	Cargo\= sciatica, 
	Cargo\= jealousy, 
	initial(Initial),
	member(craves(Cargo, City), Initial).

