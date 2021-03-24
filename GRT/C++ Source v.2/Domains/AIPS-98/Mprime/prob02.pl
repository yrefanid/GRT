def(craves(Car,City)):-pleasure(Car), food(City).
def(craves(Cargo,City)):-pain(Cargo), food(City).
def(fears(Cargo, Car)):-pain(Cargo), pleasure(Car).
def(locale(City, Fuel)):-food(City),province(Fuel).
def(harmony(Car, V)):-pleasure(Car), planet(V).


food(beef).
food(onion).
food(tuna).
food(flounder).
food(cherry).
food(muffin).
food(ham).

pleasure(satiety).
pleasure(stimulation).
pleasure(curiosity).
pleasure(entertainment).

pain(anger).
pain(depression).
pain(prostatitis).
pain(grief).
pain(abrasion).
pain(loneliness).
pain(dread).
pain(angina).
pain(boils).
pain(laceration).
pain(sciatica).
pain(hangover).
pain(anxiety).
pain(jealousy).
pain(jealousy_2).
pain(depression_1).
pain(grief_7).
pain(dread_8).
pain(prostatitis_3).
pain(boils_4).

province(alsace).
province(arizona).
province(kentucky).
province(bosnia).
province(surrey).

planet(mercury).
planet(vulcan).
planet(pluto).
planet(jupiter).

orbits(mercury,vulcan).

eats(onion,muffin).
eats(tuna,muffin).
eats(muffin,ham).

attacks(arizona,kentucky).

eats(flounder,tuna).

eats(tuna,ham).

eats(onion,cherry).
eats(tuna,flounder).
eats(beef,tuna).
eats(cherry,flounder).

orbits(vulcan,pluto).
attacks(alsace,arizona).

eats(ham,tuna).

eats(onion,beef).
eats(cherry,onion).

attacks(kentucky,bosnia).

eats(muffin,tuna).

eats(beef,onion).
attacks(bosnia,surrey).
eats(cherry,beef).
eats(beef,cherry).
eats(muffin,onion).
orbits(pluto,jupiter).
eats(flounder,cherry).
eats(tuna,beef).
eats(ham,muffin).


initial([craves(laceration,tuna), craves(dread,onion), craves(prostatitis,beef), craves(boils_4,ham), 
craves(entertainment,ham), craves(satiety,onion), craves(stimulation,flounder), craves(curiosity,cherry), 
craves(jealousy,flounder), craves(loneliness,onion), craves(anxiety,flounder), craves(sciatica,tuna),
 craves(grief,beef), craves(grief_7,ham), craves(jealousy_2,cherry), craves(angina,onion),
 craves(depression_1,muffin), craves(anger,beef), craves(abrasion,beef), craves(hangover,tuna),
 craves(boils,tuna), craves(prostatitis_3,ham),craves(dread_8,ham), craves(depression,beef), 
locale(onion,bosnia), locale(tuna,kentucky), locale(ham,surrey),
locale(beef,surrey), locale(muffin,kentucky), locale(cherry,surrey), harmony(satiety,vulcan), harmony(curiosity,pluto), harmony(stimulation,pluto), locale(flounder,kentucky), harmony(entertainment,jupiter)]).


goal([craves(grief_7,beef),craves(depression_1,beef)]).


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
	Cargo\=grief_7, 
	Cargo\=depression_1, 
	food(City).
not_determined(fears(Cargo, Car)):-
	pain(Cargo), 
	Cargo\=grief_7, 
	Cargo\=depression_1, 
	pleasure(Car).










