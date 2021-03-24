def(craves(Car,City)):-pleasure(Car), food(City).
def(craves(Cargo,City)):-pain(Cargo), food(City).
def(fears(Cargo, Car)):-pain(Cargo), pleasure(Car).
def(locale(City, Fuel)):-food(City),province(Fuel).
def(harmony(Car, V)):-pleasure(Car), planet(V).


food(pea).
food(chocolate).
food(lobster).
food(potato).
food(hotdog).
food(baguette).
food(wurst).
food(bacon).
food(scallion).
food(yogurt).
food(shrimp).
food(flounder).
food(papaya).
food(cod).
food(scallop).
food(lettuce).
food(lemon).
food(ham).
food(pistachio).
food(mutton).
food(cucumber).
pleasure(triumph).
pleasure(curiosity).
pleasure(excitement).
pleasure(achievement).
pleasure(learning).
pleasure(rest).
pleasure(intoxication).
pleasure(love).
pleasure(aesthetics).
pain(laceration).
pain(hangover).
pain(grief).
pain(sciatica).
pain(dread).
pain(loneliness).
pain(abrasion).
pain(jealousy).
pain(anger).
pain(angina).
pain(anxiety).
pain(depression).
pain(anger_1).
pain(laceration_2).
pain(prostatitis).
pain(boils).
pain(anxiety_3).
pain(prostatitis_4).
pain(grief_6).
pain(depression_7).
pain(jealousy_8).
pain(sciatica_15).
pain(dread_16).
pain(abrasion_5).
pain(angina_12).
pain(boils_13).
pain(loneliness_14).
pain(jealousy_32).
pain(grief_9).
pain(anger_10).
pain(hangover_11).
pain(sciatica_28).
pain(boils_29).
pain(angina_30).
pain(depression_31).
pain(laceration_26).
pain(hangover_27).
pain(prostatitis_23).
pain(loneliness_24).
pain(anxiety_25).
pain(dread_22).
pain(grief_19).
pain(angina_20).
pain(abrasion_21).
province(alsace).
province(arizona).
province(pennsylvania).
province(surrey).
province(quebec).
province(bavaria).
planet(mars).
planet(vulcan).
planet(jupiter).
planet(neptune).
eats(bacon,scallion).
eats(pea,hotdog).
eats(lemon,cucumber).
eats(hotdog,pea).
eats(flounder,yogurt).
eats(papaya,cod).
eats(hotdog,lobster).
eats(chocolate,wurst).
attacks(surrey,quebec).
eats(yogurt,shrimp).
eats(scallion,shrimp).
eats(papaya,scallion).
eats(lettuce,pistachio).
orbits(vulcan,jupiter).
eats(mutton,cucumber).
attacks(quebec,bavaria).
eats(shrimp,scallion).
eats(bacon,yogurt).
eats(cod,shrimp).
attacks(pennsylvania,surrey).
eats(pistachio,lettuce).
eats(shrimp,potato).
eats(scallop,lettuce).
eats(potato,pea).
eats(lemon,scallop).
eats(lettuce,mutton).
eats(baguette,chocolate).
eats(scallion,scallop).
eats(ham,cucumber).
eats(scallion,papaya).
eats(scallop,baguette).
eats(potato,wurst).
eats(scallop,lemon).
eats(yogurt,bacon).
eats(yogurt,flounder).
eats(shrimp,yogurt).
eats(scallion,bacon).
attacks(alsace,arizona).
eats(mutton,pistachio).
eats(lemon,ham).
eats(mutton,lettuce).
orbits(mars,vulcan).
eats(scallop,scallion).
attacks(arizona,pennsylvania).
eats(mutton,lemon).
eats(flounder,scallion).
eats(wurst,potato).
eats(lettuce,scallop).
eats(lemon,mutton).
eats(lobster,baguette).
eats(potato,shrimp).
eats(baguette,scallop).
eats(ham,lemon).
eats(shrimp,cod).
eats(baguette,lobster).
eats(scallion,flounder).
eats(cucumber,mutton).
eats(pea,potato).
eats(cucumber,ham).
orbits(jupiter,neptune).
eats(lobster,hotdog).
eats(wurst,chocolate).
eats(chocolate,baguette).
eats(cod,papaya).
eats(pistachio,mutton).
eats(cucumber,lemon).


initial([
harmony(love,jupiter),
harmony(rest,jupiter),
craves(sciatica_15,shrimp),
locale(shrimp,surrey),
craves(depression_7,yogurt),
locale(cod,arizona),
locale(scallop,bavaria),
harmony(excitement,neptune),
craves(aesthetics,cucumber),
craves(jealousy,potato),
craves(boils,bacon),
craves(laceration_2,bacon),
craves(grief_6,yogurt),
locale(papaya,surrey),
locale(baguette,bavaria),
locale(potato,pennsylvania),
craves(angina_30,lettuce),
locale(lobster,bavaria),
locale(chocolate,pennsylvania),
harmony(intoxication,neptune),
craves(anxiety_3,scallion),
craves(intoxication,ham),
craves(laceration,pea),
craves(rest,scallop),
craves(loneliness_14,flounder),
craves(depression,wurst),
craves(anxiety,hotdog),
craves(anger_1,bacon),
craves(loneliness_24,pistachio),
craves(laceration_26,ham),
craves(triumph,pea),
craves(grief_19,cucumber),
locale(wurst,arizona),
harmony(achievement,jupiter),
craves(abrasion_5,shrimp),
craves(sciatica,chocolate),
craves(hangover_27,ham),
craves(abrasion,lobster),
craves(anger_10,papaya),
craves(love,mutton),
locale(flounder,pennsylvania),
craves(dread_16,shrimp),
craves(dread,lobster),
craves(prostatitis_4,scallion),
craves(curiosity,chocolate),
harmony(triumph,vulcan),
locale(mutton,alsace),
craves(boils_13,flounder),
craves(prostatitis,bacon),
locale(yogurt,surrey),
craves(angina_12,flounder),
craves(jealousy_8,yogurt),
craves(loneliness,lobster),
locale(bacon,arizona),
craves(grief_9,papaya),
craves(grief,chocolate),
craves(angina,potato),
locale(lemon,pennsylvania),
craves(angina_20,cucumber),
locale(hotdog,bavaria),
craves(boils_29,lettuce),
craves(hangover,chocolate),
locale(cucumber,pennsylvania),
harmony(curiosity,jupiter),
locale(pea,quebec),
craves(jealousy_32,papaya),
craves(sciatica_28,lettuce),
craves(abrasion_21,cucumber),
locale(lettuce,pennsylvania),
craves(learning,yogurt),
locale(ham,bavaria),
harmony(aesthetics,neptune),
harmony(learning,neptune),
craves(anxiety_25,pistachio),
craves(hangover_11,papaya),
locale(pistachio,arizona),
craves(achievement,potato),
craves(anger,potato),
craves(prostatitis_23,pistachio),
craves(depression_31,lettuce),
craves(excitement,lobster),
locale(scallion,surrey),
craves(dread_22,mutton)]):-!.

goal([and,craves(prostatitis_23,potato),craves(anxiety_25,potato)]):-!.

goal1(List):-findall(X, not_determined(X), List).

not_determined(locale(City, Fuel)):-
	food(City),
	province(Fuel).

not_determined(craves(triumph, potato)).
not_determined(craves(Car,City)):-pleasure(Car), Car\= triumph, 
		food(City).	
%		initial(Initial), 
%		member(craves(Car, City), Initial).

not_determined(harmony(Car, V)):-
	pleasure(Car),
	planet(V).

not_determined(craves(Cargo, City)):-
	pain(Cargo), 
	Cargo\= prostatitis_23, 
	Cargo\= anxiety_25,
	initial(Initial),
	member(craves(Cargo, City), Initial).





