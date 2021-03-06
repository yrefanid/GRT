(define (problem strips-mysty-x-4)
   (:domain mystery-strips)
   (:objects city1 city2 city3 city4 city5 city6 city7
             city8 city9 city10 truck1 package1 package2 package3
             package4 package5 package6 package7    
               )

   
(:resources fuel1 fuel2 fuel3 fuel4 fuel5 fuel6 fuel7
             fuel8 fuel9 fuel10 volume1   
                    
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
          (truck truck1)
          (truck_volume truck1 volume1)
          (package package1)
          (package package2)
          (package package3)
          (package package4)
          (package package5)
          (package package6)
          (package package7)
          (amount fuel5 4)
          (connected city2 city1)
          (connected city5 city4)
          (amount fuel3 1)
          (at package2 city2)
          (connected city5 city2)
          (connected city6 city9)
          (at package3 city6)
          (connected city10 city7)
          (connected city1 city2)
          (connected city8 city9)
          (connected city8 city7)
          (connected city7 city10)
          (connected city8 city1)
          (at package7 city10)
          (connected city3 city4)
          (connected city8 city10)
          (amount fuel8 4)
          (connected city6 city10)
          (at package5 city8)
          (amount volume1 1)
          (connected city1 city5)
          (connected city9 city8)
          (amount fuel1 4)
          (amount fuel6 0)
          (at package1 city1)
          (connected city5 city8)
          (connected city4 city3)
          (amount fuel2 2)
          (connected city1 city3)
          (connected city8 city5)
          (connected city9 city6)
          (at package6 city9)
          (connected city7 city8)
          (connected city2 city5)
          (connected city5 city1)
          (amount fuel7 1)
          (amount fuel10 0)
          (amount fuel9 3)
          (connected city4 city5)
          (connected city10 city8)
          (connected city1 city8)
          (at truck1 city4)
          (connected city3 city1)
          (amount fuel4 2)
          (at package4 city7)
          (connected city10 city6))
   (:goal (and (at package3 city10))))
