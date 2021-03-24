(define (problem strips-mysty-x-29)
   (:domain mystery-strips)
   (:objects city1 city2 city3 city4 city5 city6 city7 city8
             truck1 truck2 package1 package2 package3 package4 package5
             package6 package7 package8 package9 package10 package11 
                    
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
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          (connected city3 city6)
          (at package5 city3)
          (connected city4 city6)
          (at truck1 city2)
          (at truck2 city8)
          (connected city2 city8)
          (connected city3 city2)
          (at package1 city1)
          
          (connected city6 city3)
          (connected city7 city8)
          
          (connected city8 city2)
          
          
          (connected city5 city1)
          
          (connected city1 city4)
          (at package4 city3)
          (connected city4 city1)
          (connected city1 city5)
          
          (at package6 city3)
          (at package9 city7)
          
          (connected city6 city7)
          (at package2 city2)
          (at package7 city6)
          
          (connected city6 city4)
          (at package3 city2)
          (at package10 city8)
          
          
          
          (connected city8 city5)
          
          (at package11 city8)
          (connected city8 city7)
          (connected city5 city8)
          
          
          (connected city2 city3)
          
          
          (at package8 city6)
          
          
          
          (connected city7 city6))
   (:goal (and (at package11 city6)
               (at package8 city6))))
