(define (problem strips-mysty-x-25)
   (:domain mystery-strips)
   (:objects city1 city2 city3 city4 truck1 truck2
             package1 package2     
                 )

   
(:resources fuel1 fuel2 fuel3 fuel4 volume1 volume2
                   
                 )


(:init (city city1)
          (city_fuel city1 fuel1)
          (city city2)
          (city_fuel city2 fuel2)
          (city city3)
          (city_fuel city3 fuel3)
          (city city4)
          (city_fuel city4 fuel4)
          (truck truck1)
          (truck_volume truck1 volume1)
          (truck truck2)
          (truck_volume truck2 volume2)
          (package package1)
          (package package2)
          
          (connected city1 city4)
          (connected city2 city3)
          (at package2 city4)
          (connected city4 city3)
          (at truck2 city3)
          (amount fuel2 2)
          (connected city4 city1)
          (amount volume1 1)
          (at truck1 city2)
          (at package1 city1)
          (connected city3 city1)
          (connected city2 city1)
          (amount fuel1 2)
          (connected city3 city2)
          (connected city1 city2)
          (amount volume2 3)
          (connected city1 city3)
          (connected city3 city4)
          (amount fuel4 2)
          (amount fuel3 5))
   (:goal (and (at package1 city4))))
