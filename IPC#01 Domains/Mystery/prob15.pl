def(craves(Car,City)):-pleasure(Car), food(City).
def(craves(Cargo,City)):-pain(Cargo), food(City).
def(fears(Cargo, Car)):-pain(Cargo), pleasure(Car).
def(locale(City, Fuel)):-food(City),province(Fuel).
def(harmony(Car, V)):-pleasure(Car), planet(V).


food(turkey).
food(lamb).
food(pea).
food(cod).
food(chicken).
food(cantelope).
food(broccoli).
food(lemon).
food(pistachio).
food(lobster).
food(pepper).
food(bacon).
food(ham).
food(haroset).
food(okra).
food(cucumber).
food(onion).
pleasure(curiosity).
pleasure(expectation).
pleasure(understanding).
pleasure(learning).
pleasure(satisfaction).
pleasure(stimulation).
pleasure(entertainment).
pleasure(satiety).
pleasure(lubricity).
pleasure(aesthetics).
pleasure(empathy).
pain(anxiety).
pain(boils).
pain(anger).
pain(angina).
pain(prostatitis).
pain(laceration).
pain(depression).
pain(jealousy).
pain(loneliness).
pain(hangover).
pain(grief).
pain(sciatica).
pain(dread).
province(oregon).
province(goias).
province(surrey).
province(moravia).
province(bavaria).
province(alsace).
province(arizona).
province(manitoba).
province(bosnia).
province(pennsylvania).
province(quebec).
planet(uranus).
planet(mars).
planet(neptune).
planet(earth).
attacks(arizona,manitoba).
eats(haroset,onion).
eats(bacon,ham).
eats(okra,cucumber).
eats(lemon,cod).
attacks(bavaria,alsace).
eats(turkey,pea).
eats(pepper,bacon).
attacks(manitoba,bosnia).
eats(cod,lemon).
eats(broccoli,pistachio).
eats(onion,haroset).
eats(onion,ham).
eats(pistachio,broccoli).
eats(cantelope,turkey).
eats(cod,lamb).
attacks(bosnia,pennsylvania).
eats(bacon,pepper).
eats(chicken,lamb).
eats(lobster,ham).
eats(chicken,cantelope).
eats(pea,turkey).
eats(cantelope,lamb).
eats(cucumber,okra).
eats(lamb,cod).
orbits(mars,neptune).
attacks(goias,surrey).
attacks(moravia,bavaria).
eats(pea,cod).
eats(lamb,cantelope).
eats(cantelope,chicken).
eats(haroset,lemon).
attacks(oregon,goias).
orbits(neptune,earth).
eats(lobster,cucumber).
eats(broccoli,lemon).
eats(lemon,haroset).
eats(haroset,pepper).
eats(pepper,haroset).
eats(chicken,cod).
eats(turkey,cantelope).
eats(ham,lobster).
eats(pistachio,okra).
eats(okra,pistachio).
eats(cod,chicken).
attacks(surrey,moravia).
eats(ham,bacon).
eats(cucumber,lobster).
orbits(uranus,mars).
eats(cod,pea).
eats(ham,onion).
attacks(pennsylvania,quebec).
attacks(alsace,arizona).
eats(lamb,chicken).
eats(lemon,broccoli).


initial([
craves(learning,broccoli),
craves(satiety,haroset),
craves(laceration,broccoli),
harmony(expectation,earth),
craves(depression,broccoli),
craves(grief,bacon),
craves(understanding,cod),
locale(bacon,bavaria),
locale(okra,moravia),
craves(empathy,onion),
craves(curiosity,turkey),
locale(lobster,alsace),
craves(entertainment,pepper),
craves(anxiety,turkey),
craves(prostatitis,chicken),
craves(angina,chicken),
harmony(learning,neptune),
craves(expectation,lamb),
locale(cantelope,bavaria),
craves(jealousy,pistachio),
harmony(empathy,mars),
harmony(aesthetics,earth),
harmony(understanding,mars),
harmony(lubricity,earth),
harmony(satiety,earth),
locale(cucumber,surrey),
craves(lubricity,okra),
locale(broccoli,moravia),
locale(pistachio,moravia),
locale(cod,quebec),
locale(pea,bavaria),
locale(ham,arizona),
locale(lamb,arizona),
locale(haroset,moravia),
craves(anger,pea),
harmony(curiosity,mars),
locale(pepper,surrey),
craves(aesthetics,cucumber),
craves(stimulation,lobster),
craves(satisfaction,pistachio),
locale(lemon,alsace),
locale(chicken,manitoba),
craves(hangover,bacon),
craves(boils,pea),
locale(turkey,goias),
locale(onion,goias),
harmony(stimulation,neptune),
craves(sciatica,cucumber),
craves(loneliness,lobster),
harmony(satisfaction,earth),
craves(dread,onion),
harmony(entertainment,mars)]):-!.


goal([craves(jealousy,chicken)]):-!.

goal1(List):-findall(X, not_determined(X), List).

not_determined(locale(City, Fuel)):-
	food(City),
	province(Fuel).

not_determined(craves(curiosity, chicken)).
not_determined(craves(Car,City)):-pleasure(Car), Car\= curiosity, 
		food(City).
%		initial(Initial), 
%		member(craves(Car, City), Initial).

not_determined(harmony(Car, V)):-
	pleasure(Car),
	planet(V).

not_determined(craves(Cargo, City)):-
	pain(Cargo), 
	Cargo\= jealousy, 
	initial(Initial),
	member(craves(Cargo, City), Initial).


