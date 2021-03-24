(define (problem strips-mysty-x-2)
   (:domain mystery-strips)
   (:objects city1 city2 city3 city4 city5 city6 city7 truck1
             truck2 truck3 truck4 package1 package2 package3
             package4 package5 package6 package7 package8 package9 package10
             package11 package12 package13 package14 package15 package16
             package17 package18 package19 package20   
                  )
   
(:resources fuel1 fuel2 fuel3 fuel4 fuel5 fuel6 fuel7 volume1
             volume2 volume3 volume4   
                   
                  
                   
                  )

(:init    (city city1)
          (city city2)
          (city city3)
          (city city4)
          (city city5)
          (city city6)
          (city city7)

          (city_fuel city1 fuel1)
          (city_fuel city2 fuel2)
          (city_fuel city3 fuel3)
          (city_fuel city4 fuel4)
          (city_fuel city5 fuel5)
          (city_fuel city6 fuel6)
          (city_fuel city7 fuel7)

          (amount fuel1 4)
          (amount fuel2 3)
          (amount fuel3 2)
          (amount fuel4 2)
          (amount fuel5 4)
          (amount fuel6 2)
          (amount fuel7 4)

          (connected city2 city6)
          (connected city3 city6)
          (connected city6 city7)
          (connected city4 city3)
          (connected city2 city5)
          (connected city3 city4)
          (connected city1 city3)
          (connected city5 city4)
          (connected city3 city7)
          (connected city7 city3)
          (connected city2 city1)
          (connected city5 city2)
          (connected city5 city1)
          (connected city1 city5)
          (connected city6 city3)
          (connected city1 city2)
          (connected city6 city2)
          (connected city4 city5)
          (connected city3 city1)
          (connected city7 city6)

          (truck truck1)
          (truck truck2)
          (truck truck3)
          (truck truck4)

          (at truck1 city2)
          (at truck2 city4)
          (at truck3 city5)
          (at truck4 city7)

          (truck_volume truck1 volume1)
          (truck_volume truck2 volume2)
          (truck_volume truck3 volume3)
          (truck_volume truck4 volume4)

          (amount volume1 1)
          (amount volume2 2)
          (amount volume3 2)
          (amount volume4 3)

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
          (package package15)
          (package package16)
          (package package17)
          (package package18)
          (package package19)
          (package package20)


          (at package1 city1)
          (at package2 city1)
          (at package3 city1)
          (at package4 city1)
          (at package5 city1)
          (at package6 city2)
          (at package7 city2)
          (at package8 city2)
          (at package9 city3)
          (at package10 city3)
          (at package11 city3)
          (at package12 city3)
          (at package13 city4)
          (at package14 city4)
          (at package15 city5)
          (at package16 city6)
          (at package17 city7)
          (at package18 city7)
          (at package19 city7)
          (at package20 city7)

		)
   (:goal (and (at package17 city1)
               (at package16 city1)))) 