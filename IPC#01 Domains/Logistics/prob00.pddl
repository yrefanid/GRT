(define (problem strips-log-x-1)
   (:domain logistics-strips)
   (:objects package1
             city2 city1 
		truck2 truck1 
		plane1 city2-1 city1-1 
             city2-2 city1-2)
   (:init (obj package1)
          (city city2)
          (city city1)
          (truck truck2)
          (truck truck1)
          (airplane plane1)
          (location city2-1)
          (location city1-1)
          (airport city2-2)
          (location city2-2)
          (airport city1-2)
          (location city1-2)
          (in-city city2-2 city2)
          (in-city city2-1 city2)
          (in-city city1-2 city1)
          (in-city city1-1 city1)
          (at plane1 city2-2)
          (at truck2 city2-1)
          (at truck1 city1-1)
          (at package1 city2-1))
   (:goal (at package1 city1-1))
)