(define (problem strips-mysty-x-19)
   (:domain mystery-strips)
   (:objects city1 city2 city3 city4 city5 city6 city7
             city8 city9 city10 city11 city12 city13 city14 city15
             truck1 truck2 truck3 truck4 truck5 truck6
             truck7 truck8 package1 package2 package3 package4
             package5 package6 package7 package8 package9 package10 package11
             package12 package13 package14   
                   )

   
(:resources fuel1 fuel2 fuel3 fuel4 fuel5 fuel6 fuel7
             fuel8 fuel9 fuel10 fuel11 fuel12 fuel13 fuel14 fuel15
             volume1 volume2 volume3 volume4 volume5 volume6
             volume7 volume8    
                   
                  
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
          (package package1)
          (package package2)
          (package package3)
          (package package4)
          (package package5)
          (package package6)
          (package package7)
          (package package8)
          (package package9)
          (package package10)
          (package package11)
          (package package12)
          (package package13)
          (package package14)
          (amount fuel6 0)
          (amount volume4 2)
          (amount volume6 1)
          (amount fuel7 0)
          (connected city4 city1)
          (at package9 city10)
          (at truck6 city10)
          (at package1 city1)
          (at package5 city5)
          (connected city4 city10)
          (connected city9 city15)
          (amount volume2 3)
          (connected city8 city1)
          (amount volume5 3)
          (at package12 city13)
          (at truck2 city3)
          (connected city13 city14)
          (amount fuel11 3)
          (connected city5 city9)
          (connected city10 city12)
          (connected city9 city6)
          (connected city11 city2)
          (amount volume7 2)
          (at package7 city8)
          (connected city8 city13)
          (connected city7 city2)
          (connected city11 city6)
          (amount fuel9 1)
          (amount fuel13 1)
          (connected city9 city5)
          (at package14 city15)
          (connected city1 city8)
          (connected city13 city8)
          (connected city5 city3)
          (at package3 city3)
          (connected city3 city5)
          (connected city8 city11)
          (connected city14 city8)
          (amount fuel4 1)
          (connected city10 city3)
          (at package2 city2)
          (amount fuel1 1)
          (connected city2 city11)
          (connected city11 city8)
          (at truck5 city9)
          (connected city6 city9)
          (connected city5 city11)
          (amount fuel10 1)
          (at package13 city14)
          (connected city1 city4)
          (connected city3 city10)
          (connected city14 city13)
          (connected city12 city15)
          (amount fuel5 3)
          (at package11 city12)
          (amount fuel3 5)
          (amount volume3 1)
          (amount volume8 2)
          (at package6 city7)
          (connected city6 city11)
          (at truck8 city14)
          (amount volume1 3)
          (amount fuel12 3)
          (connected city15 city9)
          (at package4 city4)
          (connected city11 city5)
          (amount fuel15 5)
          (amount fuel8 0)
          (amount fuel2 1)
          (at truck7 city13)
          (at truck4 city8)
          (connected city10 city4)
          (amount fuel14 1)
          (connected city7 city14)
          (connected city12 city10)
          (at package8 city9)
          (connected city8 city14)
          (connected city2 city7)
          (connected city14 city7)
          (at package10 city11)
          (at truck1 city1)
          (connected city15 city12)
          (at truck3 city4))
   (:goal (and (at package5 city4))))