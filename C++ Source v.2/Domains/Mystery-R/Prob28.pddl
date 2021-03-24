(define (problem strips-mysty-x-28)
   (:domain mystery-strips)
   (:objects city1 city2 city3 city4 city5 truck1
             package1 package2 package3 package4 package5 package6 package7  
                    
             )

   
(:resources fuel1 fuel2 fuel3 fuel4 fuel5 volume1
                     
                    
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
          (truck truck1)
          (truck_volume truck1 volume1)
          (package package1)
          (package package2)
          (package package3)
          (package package4)
          (package package5)
          (package package6)
          (package package7)
          (at package3 city2)
          (at package4 city3)
          (connected city5 city2)
          (connected city2 city1)
          (connected city1 city3)
          (at truck1 city1)
          (connected city4 city5)
          (connected city1 city5)
          (connected city3 city1)
          (at package6 city4)
          (amount fuel2 6)
          (connected city4 city3)
          (amount fuel5 7)
          (connected city2 city5)
          (at package2 city2)
          (amount fuel4 7)
          (amount volume1 2)
          (at package7 city5)
          (amount fuel1 1)
          (connected city1 city2)
          (amount fuel3 2)
          (connected city5 city1)
          (connected city5 city4)
          (at package5 city3)
          (at package1 city1)
          (connected city3 city4)
          )
   (:goal (and (at package4 city5)
               (at package6 city5))))