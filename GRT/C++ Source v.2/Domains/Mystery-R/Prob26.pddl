(define (problem strips-mysty-x-26)
   (:domain mystery-strips)
   (:objects city1 city2 city3 city4 city5 city6 city7
             city8 city9 city10 city11 city12 truck1
             truck2 truck3 truck4 truck5 package1 package2
             package3 package4     
                 )

   
(:resources fuel1 fuel2 fuel3 fuel4 fuel5 fuel6 fuel7
             fuel8 fuel9 fuel10 fuel11 fuel12 volume1
             volume2 volume3 volume4 volume5  
                   
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
          (package package1)
          (package package2)
          (package package3)
          (package package4)
          (amount volume5 3)
          (connected city6 city11)
          (at truck3 city6)
          (connected city3 city2)
          (connected city11 city6)
          (connected city12 city6)
          (connected city12 city8)
          (amount fuel11 5)
          (connected city5 city6)
          (connected city4 city6)
          (amount fuel9 1)
          (connected city4 city9)
          (connected city1 city10)
          (connected city7 city5)
          (connected city6 city5)
          (amount volume3 1)
          (connected city7 city2)
          (amount fuel6 5)
          (connected city12 city9)
          (connected city11 city5)
          (connected city4 city12)
          (connected city1 city3)
          (amount volume1 1)
          (connected city6 city4)
          (connected city2 city3)
          (connected city9 city12)
          (amount fuel7 4)
          (amount fuel8 4)
          (amount fuel10 1)
          (connected city2 city7)
          (at truck5 city10)
          (connected city6 city12)
          (connected city8 city11)
          (amount fuel5 0)
          (connected city8 city12)
          (amount fuel12 4)
          (at package1 city5)
          (amount fuel4 1)
          (amount fuel2 1)
          (at package3 city9)
          (connected city5 city11)
          (connected city12 city4)
          (at truck4 city8)
          (at truck1 city2)
          (connected city10 city11)
          (at truck2 city5)
          (connected city11 city8)
          (amount volume4 2)
          (connected city3 city1)
          (connected city9 city4)
          (connected city9 city7)
          (at package2 city6)
          (at package4 city10)
          (amount fuel1 0)
          (amount volume2 1)
          (connected city7 city9)
          (connected city10 city1)
          (connected city11 city10)
          (amount fuel3 2)
          (connected city5 city7)
          )
   (:goal (and (at package2 city2))))