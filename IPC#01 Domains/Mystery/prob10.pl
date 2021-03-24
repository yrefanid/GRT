def(craves(Car,City)):-pleasure(Car), food(City).
def(craves(Cargo,City)):-pain(Cargo), food(City).
def(fears(Cargo, Car)):-pain(Cargo), pleasure(Car).
def(locale(City, Fuel)):-food(City),province(Fuel).
def(harmony(Car, V)):-pleasure(Car), planet(V).


food(tofu).
food(snickers).
food(popover).
food(lamb).
food(potato).
food(melon).
food(beef).
food(pork).
food(bacon).
food(orange).
food(ham).
food(kale).
food(pepper).
food(hamburger).
food(cantelope).
food(flounder).
food(grapefruit).
food(wurst).
food(arugula).
pleasure(triumph).
pleasure(stimulation).
pleasure(expectation).
pleasure(rest).
pleasure(love).
pleasure(satisfaction).
pleasure(learning).
pleasure(aesthetics).
pleasure(intoxication).
pain(laceration).
pain(depression).
pain(loneliness).
pain(hangover).
pain(prostatitis).
pain(angina).
pain(anger).
pain(grief).
pain(anxiety).
pain(sciatica).
pain(jealousy).
pain(boils).
pain(dread).
pain(loneliness_1).
pain(grief_2).
pain(abrasion).
pain(dread_8).
pain(angina_3).
pain(sciatica_4).
pain(anger_7).
pain(abrasion_5).
pain(hangover_6).
pain(jealousy_16).
pain(anxiety_12).
pain(prostatitis_13).
pain(depression_14).
pain(boils_15).
pain(loneliness_9).
pain(anger_10).
pain(laceration_11).
pain(angina_30).
pain(dread_31).
pain(boils_32).
pain(laceration_27).
pain(jealousy_28).
pain(hangover_29).
pain(prostatitis_24).
pain(anxiety_25).
pain(grief_26).
province(surrey).
province(moravia).
province(quebec).
province(oregon).
province(alsace).
province(kentucky).
planet(mercury).
planet(mars).
planet(neptune).
planet(pluto).
eats(snickers,potato).
eats(wurst,grapefruit).
attacks(quebec,oregon).
eats(flounder,kale).
eats(ham,pork).
eats(arugula,hamburger).
eats(beef,snickers).
attacks(moravia,quebec).
eats(beef,ham).
eats(arugula,cantelope).
eats(beef,arugula).
eats(pepper,cantelope).
eats(orange,beef).
eats(hamburger,cantelope).
eats(hamburger,wurst).
eats(pork,bacon).
eats(kale,flounder).
eats(tofu,lamb).
eats(popover,melon).
attacks(surrey,moravia).
eats(kale,arugula).
eats(ham,beef).
eats(cantelope,hamburger).
eats(arugula,beef).
eats(pork,ham).
eats(wurst,hamburger).
eats(cantelope,arugula).
eats(lamb,tofu).
eats(grapefruit,pepper).
eats(cantelope,flounder).
orbits(neptune,pluto).
eats(beef,orange).
eats(orange,pork).
eats(cantelope,pepper).
eats(bacon,orange).
eats(orange,bacon).
eats(potato,melon).
orbits(mercury,mars).
eats(flounder,cantelope).
eats(popover,tofu).
eats(bacon,pork).
eats(melon,potato).
eats(snickers,beef).
eats(arugula,kale).
eats(hamburger,arugula).
eats(tofu,popover).
eats(melon,popover).
orbits(mars,neptune).
eats(lamb,snickers).
attacks(alsace,kentucky).
eats(potato,snickers).
attacks(oregon,alsace).
eats(pork,orange).
eats(snickers,lamb).
eats(grapefruit,wurst).
eats(pepper,grapefruit).

initial([
craves(prostatitis_13,pepper),
harmony(triumph,pluto),
craves(expectation,beef),
craves(loneliness,snickers),
craves(satisfaction,ham),
locale(kale,quebec),
locale(ham,alsace),
craves(laceration_11,hamburger),
craves(aesthetics,flounder),
craves(anger,popover),
craves(anxiety_25,arugula),
craves(boils_15,pepper),
harmony(satisfaction,neptune),
craves(jealousy,melon),
locale(potato,quebec),
craves(stimulation,melon),
locale(grapefruit,oregon),
harmony(expectation,pluto),
craves(dread_31,cantelope),
craves(anger_7,orange),
craves(dread,beef),
craves(loneliness_9,hamburger),
craves(hangover_6,ham),
craves(grief,lamb),
craves(boils_32,cantelope),
craves(love,orange),
locale(tofu,surrey),
craves(depression,snickers),
craves(angina_30,cantelope),
craves(jealousy_16,kale),
craves(anxiety,potato),
craves(learning,pepper),
locale(orange,quebec),
harmony(aesthetics,neptune),
harmony(rest,mars),
craves(prostatitis,popover),
craves(intoxication,grapefruit),
craves(abrasion,pork),
locale(hamburger,quebec),
locale(snickers,alsace),
locale(pork,kentucky),
craves(boils,melon),
harmony(love,mars),
craves(hangover,popover),
craves(grief_26,arugula),
craves(angina_3,bacon),
harmony(stimulation,pluto),
craves(laceration,snickers),
craves(sciatica,melon),
craves(jealousy_28,grapefruit),
harmony(learning,mars),
craves(loneliness_1,pork),
craves(laceration_27,grapefruit),
craves(depression_14,pepper),
craves(hangover_29,grapefruit),
locale(beef,moravia),
craves(rest,pork),
locale(bacon,alsace),
locale(cantelope,quebec),
locale(flounder,moravia),
craves(dread_8,bacon),
craves(prostatitis_24,arugula),
craves(abrasion_5,ham),
locale(arugula,moravia),
craves(angina,popover),
locale(wurst,alsace),
craves(triumph,tofu),
locale(pepper,oregon),
craves(anxiety_12,pepper),
locale(melon,alsace),
craves(grief_2,pork),
craves(anger_10,hamburger),
craves(sciatica_4,bacon),
locale(popover,oregon),
locale(lamb,moravia),
harmony(intoxication,neptune)]):-!.

goal([craves(jealousy_16,tofu)]):-!.

goal1(List):-findall(X, not_determined(X), List).

not_determined(locale(City, Fuel)):-
	food(City),
	province(Fuel).

not_determined(craves(triumph, tofu)).
not_determined(craves(Car,City)):-pleasure(Car), Car\= triumph, 
		initial(Initial), 
		member(craves(Car, City), Initial).

not_determined(harmony(Car, V)):-
	pleasure(Car),
	planet(V).

not_determined(craves(Cargo, City)):-
	pain(Cargo), 
	Cargo\= jealousy_16, 
	initial(Initial),
	member(craves(Cargo, City), Initial).





