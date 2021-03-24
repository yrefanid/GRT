(define (problem strips-mysty-x-1)
   (:domain mystery-strips)
   (:objects city1 city2 city3 city4 city5 city6 truck1 package1
             package2 package3)
   (:resources fuel1 fuel2 fuel3 fuel4 fuel5 fuel6 volume1)
   (:init (city city1)
          (city city2)
          (city city3)
          (city city4)
          (city city5)
          (city city6)
	    (city_fuel city1 fuel1)
	    (city_fuel city2 fuel2)
	    (city_fuel city3 fuel3)
	    (city_fuel city4 fuel4)
	    (city_fuel city5 fuel5)
	    (city_fuel city6 fuel6)
          (amount fuel1 1)
          (amount fuel2 2)
          (amount fuel3 4)
          (amount fuel4 6)
          (amount fuel5 5)
          (amount fuel6 3)

          (truck truck1)
          (at truck1 city5)
	    (truck_volume truck1 volume1)
          (amount volume1 3)


          (package package1)
          (package package2)
          (package package3)
          (at package1 city1)
          (at package2 city3)
          (at package3 city5)

          (connected city6 city5)
          (connected city5 city4)
          (connected city5 city6)
          (connected city6 city3)
          (connected city4 city2)
          (connected city1 city3)
          (connected city3 city6)
          (connected city3 city1)
          (connected city1 city2)
          (connected city2 city4)
          (connected city2 city1)
          (connected city4 city5)
)
   (:goal (and (at package3 city1)))) 
