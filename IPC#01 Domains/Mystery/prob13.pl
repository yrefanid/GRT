def(craves(Car,City)):-pleasure(Car), food(City).
def(craves(Cargo,City)):-pain(Cargo), food(City).
def(fears(Cargo, Car)):-pain(Cargo), pleasure(Car).
def(locale(City, Fuel)):-food(City),province(Fuel).
def(harmony(Car, V)):-pleasure(Car), planet(V).


food(lettuce).
food(chocolate).
food(mutton).
food(marzipan).
food(scallop).
food(yogurt).
food(rice).
food(haroset).
food(muffin).
food(potato).
food(turkey).
food(ham).
food(onion).
food(melon).
food(wurst).
food(flounder).
food(baguette).
food(scallion).
food(hamburger).
food(papaya).
food(lobster).
food(lemon).
pleasure(entertainment).
pleasure(intoxication).
pleasure(satisfaction).
pleasure(achievement).
pleasure(curiosity).
pleasure(love).
pleasure(aesthetics).
pain(anger).
pain(jealousy).
pain(hangover).
pain(grief).
pain(abrasion).
pain(loneliness).
pain(anxiety).
pain(boils).
pain(sciatica).
pain(dread).
pain(angina).
pain(laceration).
pain(depression).
pain(grief_1).
pain(anxiety_2).
pain(prostatitis).
pain(laceration_7).
pain(jealousy_8).
pain(boils_3).
pain(dread_4).
pain(angina_14).
pain(hangover_15).
pain(sciatica_16).
pain(depression_5).
pain(anger_6).
pain(loneliness_11).
pain(abrasion_12).
pain(prostatitis_13).
pain(anxiety_9).
pain(sciatica_10).
pain(loneliness_32).
pain(prostatitis_29).
pain(laceration_30).
pain(hangover_31).
pain(dread_24).
pain(grief_25).
pain(abrasion_26).
pain(boils_27).
pain(depression_28).
pain(anger_21).
pain(jealousy_22).
pain(angina_23).
pain(loneliness_17).
pain(prostatitis_18).
pain(depression_19).
pain(laceration_20).
province(oregon).
province(alsace).
province(bavaria).
province(quebec).
planet(mars).
planet(neptune).
planet(vulcan).
planet(venus).
eats(lobster,marzipan).
eats(marzipan,lobster).
eats(rice,lettuce).
eats(lobster,baguette).
eats(turkey,potato).
eats(wurst,ham).
eats(mutton,marzipan).
eats(baguette,lobster).
eats(papaya,hamburger).
eats(baguette,lemon).
eats(hamburger,papaya).
eats(scallop,turkey).
orbits(vulcan,venus).
eats(marzipan,mutton).
eats(flounder,scallion).
orbits(neptune,vulcan).
eats(hamburger,scallion).
eats(haroset,wurst).
eats(turkey,onion).
eats(melon,haroset).
eats(flounder,lemon).
eats(potato,muffin).
eats(lettuce,rice).
eats(turkey,scallop).
eats(lettuce,chocolate).
eats(lemon,onion).
eats(yogurt,scallop).
eats(lemon,flounder).
eats(chocolate,lettuce).
eats(onion,lemon).
eats(haroset,melon).
eats(mutton,scallop).
eats(rice,marzipan).
eats(scallion,flounder).
eats(muffin,ham).
eats(scallop,yogurt).
eats(papaya,lobster).
attacks(bavaria,quebec).
attacks(alsace,bavaria).
attacks(oregon,alsace).
eats(yogurt,chocolate).
eats(ham,muffin).
eats(scallop,mutton).
eats(onion,melon).
eats(ham,wurst).
eats(chocolate,yogurt).
eats(wurst,haroset).
eats(potato,turkey).
eats(melon,onion).
eats(onion,turkey).
eats(muffin,potato).
eats(lobster,papaya).
eats(marzipan,rice).
orbits(mars,neptune).
eats(scallion,hamburger).
eats(lemon,baguette).


initial([
craves(depression,rice),
craves(dread,rice),
craves(prostatitis_18,lemon),
locale(melon,alsace),
craves(laceration_7,potato),
craves(loneliness_32,flounder),
locale(ham,oregon),
craves(anger,mutton),
craves(satisfaction,rice),
locale(marzipan,oregon),
craves(achievement,turkey),
locale(chocolate,bavaria),
craves(sciatica_16,turkey),
craves(abrasion_26,scallion),
locale(baguette,bavaria),
locale(yogurt,alsace),
craves(prostatitis_29,baguette),
craves(grief_1,muffin),
craves(laceration_30,baguette),
craves(jealousy_8,potato),
harmony(love,venus),
craves(dread_24,scallion),
craves(intoxication,yogurt),
craves(boils_27,scallion),
locale(lemon,quebec),
craves(loneliness,scallop),
locale(muffin,bavaria),
locale(scallop,oregon),
harmony(curiosity,vulcan),
craves(grief_25,scallion),
harmony(satisfaction,neptune),
craves(entertainment,mutton),
craves(abrasion,scallop),
craves(hangover_31,baguette),
craves(grief,scallop),
craves(aesthetics,hamburger),
locale(onion,alsace),
craves(love,baguette),
harmony(intoxication,vulcan),
locale(flounder,quebec),
craves(curiosity,ham),
locale(wurst,bavaria),
craves(abrasion_12,ham),
craves(dread_4,potato),
craves(hangover,scallop),
locale(turkey,bavaria),
craves(anxiety_9,melon),
craves(laceration,rice),
craves(anger_6,turkey),
locale(potato,alsace),
harmony(achievement,venus),
craves(jealousy,marzipan),
craves(prostatitis_13,ham),
locale(lobster,alsace),
craves(depression_28,scallion),
craves(angina_23,hamburger),
craves(sciatica,rice),
craves(boils,yogurt),
locale(rice,quebec),
craves(laceration_20,lemon),
craves(boils_3,potato),
craves(loneliness_11,ham),
craves(jealousy_22,hamburger),
craves(anxiety,yogurt),
locale(mutton,quebec),
craves(hangover_15,turkey),
craves(angina,rice),
locale(lettuce,alsace),
locale(scallion,alsace),
craves(depression_5,turkey),
craves(prostatitis,muffin),
harmony(entertainment,venus),
craves(depression_19,lemon),
locale(papaya,bavaria),
craves(anger_21,hamburger),
locale(hamburger,bavaria),
craves(angina_14,turkey),
locale(haroset,oregon),
craves(loneliness_17,lemon),
harmony(aesthetics,neptune),
craves(anxiety_2,muffin),
craves(sciatica_10,melon)]):-!.

goal([craves(prostatitis_18,lobster),craves(laceration_20,ham)]):-!.

goal1(List):-findall(X, not_determined(X), List).

not_determined(locale(City, Fuel)):-
	food(City),
	province(Fuel).


not_determined(craves(entertainment, lobster)).
not_determined(craves(intoxication, ham)).

not_determined(craves(Car,City)):-pleasure(Car), Car\=entertainment, 
		Car\= intoxication,
		food(City).
%		initial(Initial), 
%		member(craves(Car, City), Initial).

not_determined(harmony(Car, V)):-
	pleasure(Car),
	planet(V).

not_determined(craves(Cargo, City)):-
	pain(Cargo), 
	Cargo\= prostatitis_18, 
	Cargo\= laceration_20, 
	initial(Initial),
	member(craves(Cargo, City), Initial).





