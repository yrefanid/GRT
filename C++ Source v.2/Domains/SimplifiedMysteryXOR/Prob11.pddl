(define (problem strips-mysty-x-11)
   (:domain mystery-strips)
   (:objects city1 city2 city3 city4 city5 city6 city7
             city8 truck1 package1 package2 package3 package4
             package5 package6 package7 package8    
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
          (package package1)
          (package package2)
          (package package3)
          (package package4)
          (package package5)
          (package package6)
          (package package7)
          (package package8)
          
          
          
          
          
          
          
          
          
          (at package5 city5)
          (connected city3 city7)
          (connected city2 city1)
          
          (connected city1 city6)
          
          (connected city4 city3)
          
          
          
          (connected city8 city6)
          (connected city7 city3)
          (connected city4 city8)
          (connected city1 city2)
          (at truck1 city3)
          (connected city6 city1)
          
          (connected city8 city5)
          (connected city2 city3)
          (connected city3 city4)
          (at package2 city2)
          (connected city5 city6)
          
          (at package1 city1)
          (connected city6 city8)
          
          (at package8 city8)
          
          (connected city8 city4)
          
          (at package6 city6)
          (at package3 city3)
          
          (connected city5 city8)
          (connected city3 city2)
          
          (connected city7 city6)
          
          (at package4 city4)
          (connected city6 city7)
          (at package7 city7)
          
          (connected city6 city5)
          
          )
   (:goal (and (at package3 city5)
               (at package4 city5))))
