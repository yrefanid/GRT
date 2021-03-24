def(craves(Car,City)):-pleasure(Car), food(City).
def(craves(Cargo,City)):-pain(Cargo), food(City).
def(fears(Cargo, Car)):-pain(Cargo), pleasure(Car).
def(locale(City, Fuel)):-food(City),province(Fuel).
def(harmony(Car, V)):-pleasure(Car), planet(V).


food(papaya).
food(endive).
food(cherry).
food(rice).
food(wurst).
food(yogurt).
food(potato).
food(onion).
food(marzipan).
food(shrimp).
food(wonderbread).
food(mutton).
food(turkey).
food(arugula).
food(ham).
food(haroset).
pleasure(excitement).
pleasure(achievement).
pleasure(satiety).
pleasure(love).
pleasure(entertainment).
pleasure(satisfaction).
pleasure(lubricity).
pleasure(intoxication).
pleasure(rest).
pain(dread).
pain(hangover).
pain(grief).
pain(depression).
pain(laceration).
pain(jealousy).
pain(prostatitis).
pain(abrasion).
pain(loneliness).
pain(angina).
pain(anger).
pain(anxiety).
pain(boils).
pain(jealousy_2).
pain(sciatica).
pain(boils_1).
pain(loneliness_3).
pain(abrasion_4).
pain(depression_7).
pain(laceration_8).
province(goias).
province(bavaria).
province(guanabara).
province(bosnia).
province(alsace).
province(surrey).
planet(mercury).
planet(saturn).
planet(earth).
planet(uranus).
eats(papaya,rice).
eats(potato,yogurt).
orbits(saturn,earth).
attacks(goias,bavaria).
eats(turkey,haroset).
eats(endive,wurst).
eats(onion,ham).
attacks(bavaria,guanabara).
orbits(mercury,saturn).
eats(ham,onion).
eats(papaya,wurst).
eats(wonderbread,yogurt).
eats(wurst,papaya).
eats(rice,papaya).
eats(potato,shrimp).
eats(yogurt,potato).
eats(wonderbread,ham).
eats(marzipan,rice).
eats(potato,arugula).
eats(marzipan,cherry).
eats(endive,cherry).
eats(marzipan,haroset).
eats(ham,mutton).
eats(marzipan,onion).
eats(shrimp,potato).
eats(shrimp,onion).
eats(cherry,rice).
eats(rice,cherry).
eats(mutton,ham).
eats(wurst,endive).
eats(ham,wonderbread).
eats(yogurt,wonderbread).
eats(cherry,marzipan).
eats(marzipan,mutton).
attacks(guanabara,bosnia).
eats(haroset,turkey).
eats(arugula,potato).
eats(shrimp,turkey).
eats(haroset,marzipan).
orbits(earth,uranus).
eats(rice,marzipan).
eats(wonderbread,arugula).
eats(turkey,shrimp).
eats(onion,shrimp).
eats(arugula,wonderbread).
attacks(bosnia,alsace).
eats(onion,marzipan).
attacks(alsace,surrey).
eats(cherry,endive).
eats(mutton,marzipan).


initial([
craves(anger,marzipan),
locale(shrimp,alsace),
craves(prostatitis,wurst),
locale(yogurt,bosnia),
locale(arugula,surrey),
locale(papaya,alsace),
harmony(satisfaction,saturn),
craves(lubricity,shrimp),
craves(boils_1,arugula),
craves(abrasion,yogurt),
craves(dread,papaya),
locale(marzipan,surrey),
locale(wonderbread,alsace),
craves(sciatica,wonderbread),
harmony(rest,saturn),
craves(intoxication,arugula),
craves(laceration,cherry),
locale(potato,bosnia),
craves(angina,onion),
locale(mutton,guanabara),
locale(ham,guanabara),
craves(love,rice),
harmony(lubricity,uranus),
craves(grief,endive),
locale(onion,alsace),
craves(depression,endive),
craves(satisfaction,potato),
harmony(entertainment,uranus),
craves(abrasion_4,ham),
locale(wurst,goias),
locale(cherry,alsace),
harmony(excitement,uranus),
harmony(achievement,earth),
locale(endive,alsace),
craves(loneliness_3,ham),
craves(jealousy_2,wonderbread),
craves(achievement,endive),
harmony(love,uranus),
harmony(intoxication,uranus),
locale(haroset,guanabara),
craves(satiety,cherry),
craves(entertainment,wurst),
locale(turkey,bavaria),
harmony(satiety,saturn),
craves(loneliness,potato),
craves(anxiety,marzipan),
craves(excitement,papaya),
craves(laceration_8,haroset),
craves(boils,shrimp),
craves(rest,ham),
locale(rice,alsace),
craves(depression_7,haroset),
craves(jealousy,rice),
craves(hangover,papaya)]):-!.


goal([craves(abrasion,wonderbread)]):-!.

goal1(List):-findall(X, not_determined(X), List).

not_determined(locale(City, Fuel)):-
	food(City),
	province(Fuel).

not_determined(craves(excitement, wonderbread)).
not_determined(craves(Car,City)):-pleasure(Car), Car\= excitement, 
		food(City).
%		initial(Initial), 
%		member(craves(Car, City), Initial).

not_determined(harmony(Car, V)):-
	pleasure(Car),
	planet(V).

not_determined(craves(Cargo, City)):-
	pain(Cargo), 
	Cargo\= abrasion, 
	initial(Initial),
	member(craves(Cargo, City), Initial).





