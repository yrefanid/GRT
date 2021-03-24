def(craves(Car,City)):-pleasure(Car), food(City).
def(craves(Cargo,City)):-pain(Cargo), food(City).
def(fears(Cargo, Car)):-pain(Cargo), pleasure(Car).
def(locale(City, Fuel)):-food(City),province(Fuel).
def(harmony(Car, V)):-pleasure(Car), planet(V).


food(chicken).
food(pepper).
food(guava).
food(marzipan).
food(bacon).
food(arugula).
food(flounder).
food(wonderbread).
food(baguette).
food(rice).
food(chocolate).
pleasure(rest).
pleasure(stimulation).
pleasure(excitement).
pleasure(satiety).
pleasure(learning).
pleasure(achievement).
pleasure(triumph).
pain(prostatitis).
pain(boils).
pain(loneliness).
pain(depression).
pain(angina).
pain(jealousy).
pain(abrasion).
pain(sciatica).
pain(grief).
province(manitoba).
province(alsace).
province(bosnia).
province(kentucky).
province(pennsylvania).
province(goias).
planet(mercury).
planet(neptune).
planet(vulcan).
planet(earth).
eats(wonderbread,flounder).
eats(chicken,bacon).
attacks(pennsylvania,goias).
eats(arugula,baguette).
eats(chocolate,flounder).
eats(pepper,chocolate).
orbits(mercury,neptune).
eats(arugula,wonderbread).
attacks(alsace,bosnia).
eats(guava,baguette).
orbits(neptune,vulcan).
attacks(manitoba,alsace).
orbits(vulcan,earth).
attacks(kentucky,pennsylvania).
eats(baguette,arugula).
eats(pepper,guava).
eats(wonderbread,arugula).
eats(bacon,chicken).
eats(rice,bacon).
eats(chicken,marzipan).
eats(chocolate,marzipan).
eats(marzipan,chicken).
eats(rice,baguette).
eats(flounder,chocolate).
eats(guava,pepper).
eats(baguette,guava).
eats(chocolate,pepper).
eats(flounder,wonderbread).
eats(marzipan,chocolate).
eats(bacon,rice).
attacks(bosnia,kentucky).
eats(baguette,rice).


initial([
locale(flounder,alsace),
harmony(stimulation,earth),
harmony(learning,vulcan),
locale(baguette,manitoba),
harmony(satiety,neptune),
craves(excitement,arugula),
craves(angina,wonderbread),
locale(bacon,pennsylvania),
craves(rest,chicken),
craves(triumph,chocolate),
craves(depression,bacon),
locale(chicken,manitoba),
locale(rice,alsace),
locale(chocolate,goias),
craves(learning,baguette),
craves(stimulation,pepper),
craves(sciatica,baguette),
craves(boils,pepper),
locale(guava,pennsylvania),
locale(marzipan,manitoba),
craves(grief,baguette),
craves(prostatitis,chicken),
craves(jealousy,wonderbread),
craves(loneliness,bacon),
harmony(achievement,vulcan),
craves(satiety,wonderbread),
craves(abrasion,baguette),
harmony(rest,neptune),
harmony(excitement,earth),
locale(arugula,kentucky),
craves(achievement,rice),
harmony(triumph,vulcan),
locale(wonderbread,bosnia),
locale(pepper,kentucky)]):-!.


goal([craves(abrasion,rice),craves(sciatica,rice)]):-!.

goal1(List):-findall(X, not_determined(X), List).

not_determined(locale(City, Fuel)):-
	food(City),
	province(Fuel).

not_determined(craves(rest, rice)).
not_determined(craves(Car,City)):-pleasure(Car), Car\= rest, 
		food(City).
%		initial(Initial), 
%		member(craves(Car, City), Initial).

not_determined(harmony(Car, V)):-
	pleasure(Car),
	planet(V).

not_determined(craves(Cargo, City)):-
	pain(Cargo), 
	Cargo\= abrasion,
	Cargo\= sciatica, 
 	initial(Initial),
	member(craves(Cargo, City), Initial).



