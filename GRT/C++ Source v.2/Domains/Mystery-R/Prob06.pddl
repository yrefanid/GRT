(define (problem strips-mysty-x-6)
   (:domain mystery-strips)
   (:objects city1 city2 city3 city4 city5 city6 city7
             city8 city9 city10 city11 city12 city13 city14
             city15 city16 city17 city18 city19 truck1 truck2 truck3
             truck4 truck5 truck6 truck7 truck8
             truck9 truck10 truck11 package1 package2 package3 package4
             package5 package6 package7 package8 package9  
                     )

   
(:resources fuel1 fuel2 fuel3 fuel4 fuel5 fuel6 fuel7
             fuel8 fuel9 fuel10 fuel11 fuel12 fuel13 fuel14
             fuel15 fuel16 fuel17 fuel18 fuel19 volume1 volume2 volume3
             volume4 volume5 volume6 volume7 volume8
             volume9 volume10 volume11    
                   
                     )


(:init (city city1)
          (city_fuel city1 fuel1)
          (city city2)
          (city_fuel city2 fuel2)
          (city city3)
          (city_fuel city3 fuel3)
          (city city4)
          (city_fuel city4 fuel4)
          (city city5)
          (city_fuel city5 fuel5)
          (city city6)
          (city_fuel city6 fuel6)
          (city city7)
          (city_fuel city7 fuel7)
          (city city8)
          (city_fuel city8 fuel8)
          (city city9)
          (city_fuel city9 fuel9)
          (city city10)
          (city_fuel city10 fuel10)
          (city city11)
          (city_fuel city11 fuel11)
          (city city12)
          (city_fuel city12 fuel12)
          (city city13)
          (city_fuel city13 fuel13)
          (city city14)
          (city_fuel city14 fuel14)
          (city city15)
          (city_fuel city15 fuel15)
          (city city16)
          (city_fuel city16 fuel16)
          (city city17)
          (city_fuel city17 fuel17)
          (city city18)
          (city_fuel city18 fuel18)
          (city city19)
          (city_fuel city19 fuel19)
          (truck truck1)
          (truck_volume truck1 volume1)
          (truck truck2)
          (truck_volume truck2 volume2)
          (truck truck3)
          (truck_volume truck3 volume3)
          (truck truck4)
          (truck_volume truck4 volume4)
          (truck truck5)
          (truck_volume truck5 volume5)
          (truck truck6)
          (truck_volume truck6 volume6)
          (truck truck7)
          (truck_volume truck7 volume7)
          (truck truck8)
          (truck_volume truck8 volume8)
          (truck truck9)
          (truck_volume truck9 volume9)
          (truck truck10)
          (truck_volume truck10 volume10)
          (truck truck11)
          (truck_volume truck11 volume11)
          (package package1)
          (package package2)
          (package package3)
          (package package4)
          (package package5)
          (package package6)
          (package package7)
          (package package8)
          (package package9)
          (amount volume6 3)
          (amount fuel18 4)
          (connected city11 city19)
          (connected city8 city7)
          (amount volume7 2)
          (connected city5 city2)
          (connected city12 city17)
          (amount fuel2 0)
          (connected city7 city6)
          (amount volume3 3)
          (connected city7 city17)
          (amount volume5 1)
          (connected city14 city16)
          (at truck4 city4)
          (amount volume4 3)
          (connected city15 city13)
          (amount fuel10 3)
          (amount fuel13 3)
          (connected city17 city7)
          (connected city18 city17)
          (connected city8 city9)
          (amount fuel4 4)
          (connected city1 city4)
          (connected city16 city14)
          (at package7 city15)
          (connected city17 city18)
          (connected city17 city15)
          (connected city9 city6)
          (amount volume8 3)
          (amount fuel9 2)
          (at truck3 city3)
          (amount fuel19 6)
          (connected city4 city1)
          (amount fuel1 3)
          (at package8 city18)
          (connected city2 city5)
          (at truck6 city8)
          (at truck10 city16)
          (connected city3 city2)
          (at truck11 city17)
          (connected city6 city9)
          (amount fuel12 2)
          (at package1 city3)
          (connected city19 city14)
          (connected city9 city5)
          (connected city18 city12)
          (amount fuel14 5)
          (at truck7 city10)
          (amount volume11 3)
          (amount fuel11 3)
          (at package5 city9)
          (amount volume2 2)
          (at truck2 city2)
          (connected city12 city18)
          (amount fuel17 3)
          (connected city5 city9)
          (connected city17 city12)
          (connected city19 city12)
          (amount fuel3 1)
          (at package2 city4)
          (amount fuel16 0)
          (amount fuel8 1)
          (connected city1 city5)
          (amount fuel7 2)
          (amount fuel15 4)
          (connected city11 city10)
          (amount fuel5 3)
          (connected city14 city19)
          (connected city13 city16)
          (connected city16 city13)
          (connected city18 city10)
          (connected city10 city11)
          (connected city4 city3)
          (connected city14 city17)
          (at package6 city11)
          (at truck1 city1)
          (connected city19 city11)
          (connected city7 city8)
          (connected city12 city19)
          (at truck9 city14)
          (amount volume1 1)
          (connected city3 city4)
          (at package3 city6)
          (amount volume9 3)
          (connected city10 city18)
          (connected city17 city14)
          (connected city13 city15)
          (amount fuel6 1)
          (connected city9 city8)
          (amount volume10 1)
          (at package9 city19)
          (at truck5 city7)
          (connected city6 city7)
          (connected city2 city3)
          (connected city15 city17)
          (at package4 city7)
          (at truck8 city13)
          (connected city5 city1))
   (:goal (and (at package1 city17)
               (at package5 city17))))
