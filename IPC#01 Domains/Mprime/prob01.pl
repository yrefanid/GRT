def(craves(Car,City)):-pleasure(Car), food(City).
def(craves(Cargo,City)):-pain(Cargo), food(City).
def(fears(Cargo, Car)):-pain(Cargo), pleasure(Car).
def(locale(City, Fuel)):-food(City),province(Fuel).
def(harmony(Car, V)):-pleasure(Car), planet(V).

food(rice).
food(pear).
food(flounder).
food(okra).
food(pork).
food(lamb).

eats(pork,lamb).
eats(lamb,pork).
eats(pork,okra).
eats(lamb,flounder).
eats(okra,pear).
eats(rice,rice).
eats(rice,flounder).
eats(flounder,lamb).
eats(flounder,rice).
eats(rice,pear).
eats(pear,okra).
eats(pear,rice).
eats(okra,pork).

pleasure(rest).

pain(hangover).
pain(depression).
pain(abrasion).

province(kentucky).
province(bosnia).
province(surrey).
province(pennsylvania).
province(alsace).
province(quebec).
province(guanabara).

attacks(kentucky,bosnia).
attacks(bosnia,surrey).
attacks(surrey,pennsylvania).
attacks(pennsylvania,alsace).
attacks(alsace,quebec).
attacks(quebec,guanabara).

planet(mars).
planet(earth).
planet(uranus).
planet(venus).

orbits(mars,earth).
orbits(earth,uranus).
orbits(uranus,venus).





initial([	craves(rest,pork), 
	harmony(rest,venus),
	craves(depression,flounder), craves(abrasion,pork), craves(hangover,rice), 
	locale(okra,guanabara), locale(pork,quebec), locale(lamb,pennsylvania), locale(pear,surrey),locale(rice,bosnia),locale(flounder,alsace)]):-!.

goal([craves(abrasion,rice), craves(rest, rice) ]):-!.
%goal([craves(abrasion,rice), craves(rest, rice)]):-!.

goal1( List ):-findall(X, not_determined(X), List).
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



%xor(L):-pleasure(Car), findall(craves(Car,City), food(City), L).
xor(L):-pain(Cargo), Cargo\=abrasion, findall(craves(Cargo, City), food(City), L1), findall(fears(Cargo, Car), pleasure(Car), L2), append(L1, L2, L).
xor([locale(City, Fuel)]):-food(City), province(Fuel).
xor([harmony(Car, V)]):-pleasure(Car), planet(V).
