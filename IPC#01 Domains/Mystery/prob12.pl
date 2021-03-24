def(craves(Car,City)):-pleasure(Car), food(City).
def(craves(Cargo,City)):-pain(Cargo), food(City).
def(fears(Cargo, Car)):-pain(Cargo), pleasure(Car).
def(locale(City, Fuel)):-food(City),province(Fuel).
def(harmony(Car, V)):-pleasure(Car), planet(V).


food(broccoli).
food(turkey).
food(lettuce).
food(kale).
food(hotdog).
food(pork).
food(wurst).
food(arugula).
pleasure(excitement).
pleasure(intoxication).
pleasure(love).
pleasure(rest).
pain(abrasion).
pain(grief).
pain(anger).
province(kentucky).
province(pennsylvania).
province(quebec).
province(arizona).
province(surrey).
province(guanabara).
province(goias).
planet(pluto).
planet(jupiter).
planet(neptune).
eats(lettuce,arugula).
attacks(surrey,guanabara).
eats(hotdog,kale).
attacks(guanabara,goias).
eats(wurst,broccoli).
attacks(quebec,arizona).
eats(broccoli,wurst).
eats(arugula,wurst).
eats(turkey,broccoli).
eats(pork,wurst).
orbits(pluto,jupiter).
eats(hotdog,lettuce).
eats(kale,pork).
eats(lettuce,wurst).
eats(lettuce,hotdog).
eats(kale,hotdog).
attacks(pennsylvania,quebec).
eats(wurst,lettuce).
eats(broccoli,turkey).
eats(pork,kale).
eats(wurst,arugula).
attacks(kentucky,pennsylvania).
orbits(jupiter,neptune).
eats(turkey,hotdog).
eats(arugula,lettuce).
eats(wurst,pork).
eats(hotdog,turkey).
attacks(arizona,surrey).


initial([
locale(wurst,goias),
locale(pork,pennsylvania),
locale(lettuce,surrey),
craves(abrasion,hotdog),
harmony(rest,jupiter),
craves(excitement,broccoli),
harmony(intoxication,jupiter),
craves(love,hotdog),
craves(anger,arugula),
harmony(love,jupiter),
craves(grief,hotdog),
craves(rest,arugula),
locale(broccoli,quebec),
locale(turkey,arizona),
locale(kale,pennsylvania),
craves(intoxication,lettuce),
harmony(excitement,neptune),
locale(hotdog,pennsylvania),
locale(arugula,kentucky)]):-!.

goal([craves(anger,kale)]):-!.

goal1(List):-findall(X, not_determined(X), List).

not_determined(locale(City, Fuel)):-
	food(City),
	province(Fuel).

not_determined(craves(excitement, kale)).
not_determined(craves(Car,City)):-pleasure(Car), Car\= excitement, 
%		initial(Initial), 
		food(City).
%		member(craves(Car, City), Initial).

not_determined(harmony(Car, V)):-
	pleasure(Car),
	planet(V).

not_determined(craves(Cargo, City)):-
	pain(Cargo), 
	Cargo\= anger, 
	initial(Initial),
	member(craves(Cargo, City), Initial).





