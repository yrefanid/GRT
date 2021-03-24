(define (problem strips-log-x-1)
   (:domain logistics-strips)
   (:objects package1
             city1 
		truck1 
		city1-1 
             city1-2)
   (:init (obj package1)
          
          (city city1)
          
          (truck truck1)
          
          
          (location city1-1)
          (airport city1-2)
          (location city1-2)
          (in-city city1-2 city1)
          (in-city city1-1 city1)
          (at truck1 city1-1)
          (at package1 city1-1))
   (:goal (at package1 city1-1))
)
