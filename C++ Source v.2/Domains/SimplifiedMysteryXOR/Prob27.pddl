(define (problem strips-mysty-x-27)
   (:domain mystery-strips)
   (:objects city1 city2 city3 city4 city5 city6 city7 truck1
             truck2 truck3 package1 package2 package3 package4 package5
             package6     
                    
                )
   (:init (city city1)
          (city city2)
          (city city3)
          (city city4)
          (city city5)
          (city city6)
          (city city7)
          (truck truck1)
          (truck truck2)
          (truck truck3)
          (package package1)
          (package package2)
          (package package3)
          (package package4)
          (package package5)
          (package package6)
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          (at package1 city1)
          
          (connected city1 city2)
          (connected city4 city3)
          
          (connected city7 city3)
          
          (at package2 city1)
          (connected city7 city6)
          (at package6 city7)
          
          (connected city3 city7)
          
          (connected city5 city1)
          (connected city7 city2)
          
          (connected city3 city4)
          (at truck1 city5)
          (connected city1 city5)
          (at package3 city1)
          
          
          
          
          
          
          
          
          
          
          
          (connected city3 city5)
          (at truck3 city7)
          (connected city6 city5)
          (connected city5 city3)
          (connected city6 city7)
          
          (connected city2 city7)
          (connected city5 city4)
          
          (connected city2 city1)
          
          (connected city5 city6)
          (connected city4 city5)
          
          (at truck2 city6)
          (at package4 city7)
          
          (at package5 city7)
          
          )
   (:goal (and (at package5 city2)
               (at package6 city2))))
