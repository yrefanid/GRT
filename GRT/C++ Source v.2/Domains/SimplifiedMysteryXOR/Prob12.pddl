(define (problem strips-mysty-x-12)
   (:domain mystery-strips)
   (:objects city1 city2 city3 city4 city5 city6 city7 city8
             truck1 truck2 truck3 truck4 package1 package2 package3 
                    
             )
   (:init (city city1)
          (city city2)
          (city city3)
          (city city4)
          (city city5)
          (city city6)
          (city city7)
          (city city8)
          (truck truck1)
          (truck truck2)
          (truck truck3)
          (truck truck4)
          (package package1)
          (package package2)
          (package package3)
          
          
          
          
          
          
          
          
          
          
          (connected city3 city8)
          
          
          
          
          (connected city5 city4)
          
          (at package1 city5)
          (connected city7 city1)
          
          
          (at truck1 city1)
          
          (connected city1 city7)
          (connected city8 city7)
          (connected city2 city1)
          (at truck3 city5)
          (connected city6 city7)
          
          (connected city5 city3)
          (at package3 city8)
          (connected city4 city6)
          (connected city3 city7)
          
          (at package2 city5)
          (at truck4 city8)
          
          (connected city3 city5)
          
          (connected city4 city5)
          
          (at truck2 city3)
          
          (connected city7 city3)
          (connected city1 city2)
          (connected city6 city4)
          (connected city7 city8)
          
          
          
          (connected city2 city5)
          (connected city8 city3)
          
          
          (connected city7 city6)
          (connected city5 city2)
          )
   (:goal (and (at package3 city4))))
