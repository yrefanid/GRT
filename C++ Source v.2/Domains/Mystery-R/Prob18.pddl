(define (problem strips-mysty-x-18)
   (:domain mystery-strips)
   (:objects city1 city2 city3 city4 city5 city6 city7
             city8 city9 city10 city11 city12 city13 city14 city15
             city16 city17 city18 city19 city20 city21 city22
             truck1 truck2 truck3 truck4 truck5 truck6
             truck7 package1 package2 package3 package4 package5 package6
             package7 package8 package9     
                   )

   
(:resources fuel1 fuel2 fuel3 fuel4 fuel5 fuel6 fuel7
             fuel8 fuel9 fuel10 fuel11 fuel12 fuel13 fuel14 fuel15
             fuel16 fuel17 fuel18 fuel19 fuel20 fuel21 fuel22
             volume1 volume2 volume3 volume4 volume5 volume6
             volume7      
                    
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
          (city city20)
          (city_fuel city20 fuel20)
          (city city21)
          (city_fuel city21 fuel21)
          (city city22)
          (city_fuel city22 fuel22)
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
          (package package1)
          (package package2)
          (package package3)
          (package package4)
          (package package5)
          (package package6)
          (package package7)
          (package package8)
          (package package9)
          
          (amount volume4 1)
          (connected city3 city1)
          (connected city6 city2)
          (amount volume6 3)
          (amount fuel12 7)
          (connected city7 city12)
          (connected city9 city11)
          (connected city10 city13)
          (amount fuel8 6)
          (connected city3 city6)
          (connected city17 city18)
          (at truck1 city2)
          (connected city9 city13)
          (connected city2 city5)
          (connected city2 city6)
          (connected city4 city5)
          (amount volume1 3)
          (amount fuel1 4)
          (at package1 city3)
          (at package6 city19)
          (connected city5 city4)
          (connected city8 city7)
          (at truck5 city15)
          (amount volume7 2)
          (connected city11 city9)
          (connected city20 city16)
          (connected city16 city9)
          (connected city11 city12)
          (at package5 city18)
          (connected city16 city22)
          (connected city12 city11)
          (connected city3 city7)
          (connected city1 city4)
          (connected city9 city16)
          (connected city10 city11)
          (connected city14 city20)
          (connected city22 city16)
          (connected city15 city20)
          (amount fuel10 0)
          (connected city5 city2)
          (connected city10 city9)
          (connected city19 city22)
          (connected city12 city7)
          (connected city13 city8)
          (at truck7 city22)
          (amount fuel16 1)
          (amount fuel9 0)
          (connected city22 city17)
          (connected city7 city8)
          (connected city4 city1)
          (at package2 city9)
          (amount fuel2 2)
          (amount fuel17 0)
          (connected city7 city3)
          (connected city20 city14)
          (at package4 city11)
          (connected city20 city15)
          (amount fuel6 6)
          (connected city13 city10)
          (amount fuel14 3)
          (connected city8 city13)
          (connected city16 city20)
          (amount fuel3 3)
          (connected city14 city21)
          (amount fuel7 2)
          (at truck2 city4)
          (connected city21 city14)
          (connected city18 city21)
          (at truck4 city9)
          (connected city15 city19)
          (connected city22 city19)
          (at package8 city21)
          (at package3 city10)
          (connected city21 city18)
          (amount fuel21 0)
          (connected city1 city3)
          (amount fuel5 5)
          (amount fuel15 0)
          (amount volume2 1)
          (at package9 city22)
          (connected city17 city22)
          (amount fuel22 2)
          (amount fuel11 4)
          (at truck3 city5)
          (connected city18 city17)
          (at package7 city20)
          (amount fuel18 5)
          (connected city13 city9)
          (amount volume3 1)
          (connected city19 city15)
          (amount volume5 3)
          (at truck6 city16)
          (amount fuel19 2)
          (connected city11 city10)
          (amount fuel4 5)
          (amount fuel13 1)
          (amount fuel20 7)
          (connected city9 city10)
          (connected city6 city3))
   (:goal (and (at package5 city2))))