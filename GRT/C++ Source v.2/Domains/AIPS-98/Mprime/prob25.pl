def(craves(Car,City)):-pleasure(Car), food(City).
def(craves(Cargo,City)):-pain(Cargo), food(City).
def(fears(Cargo, Car)):-pain(Cargo), pleasure(Car).
def(locale(City, Fuel)):-food(City),province(Fuel).
def(harmony(Car, V)):-pleasure(Car), planet(V).


food(wurst).
food(tuna).
food(pistachio).
food(chicken).
pleasure(expectation).
pleasure(rest).
pain(depression).
pain(angina).
province(bosnia).
province(kentucky).
province(bavaria).
province(pennsylvania).
province(surrey).
province(moravia).
planet(jupiter).
planet(uranus).
planet(neptune).
planet(earth).
eats(wurst,chicken).
eats(tuna,pistachio).
eats(chicken,pistachio).
eats(chicken,wurst).
orbits(jupiter,uranus).
attacks(kentucky,bavaria).
eats(pistachio,wurst).
attacks(bosnia,kentucky).
orbits(neptune,earth).
eats(tuna,wurst).
eats(pistachio,tuna).
attacks(pennsylvania,surrey).
eats(wurst,tuna).
orbits(uranus,neptune).
eats(wurst,pistachio).
eats(pistachio,chicken).
attacks(surrey,moravia).
attacks(bavaria,pennsylvania).


initial([
craves(angina,chicken),
craves(rest,pistachio),
locale(tuna,bavaria),
harmony(expectation,uranus),
craves(expectation,tuna),
craves(depression,wurst),
locale(wurst,bavaria),
harmony(rest,earth),
locale(chicken,bavaria),
locale(pistachio,moravia)]):-!.


goal([craves(depression,chicken)]):-!.

goal1(List):-findall(X, not_determined(X), List).
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
    Cargo\=depression,
    food(City).
not_determined(fears(Cargo, Car)):-
    pain(Cargo),
    Cargo\=depression,
    pleasure(Car).

