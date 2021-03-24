(define (problem strips-mysty-x-25)
   (:domain mystery-strips)
   (:objects city1 city2 city3 city4 truck1 truck2
             package1 package2     
                 )
   (:init (city city1)
          (city city2)
          (city city3)
          (city city4)
          (truck truck1)
          (truck truck2)
          (package package1)
          (package package2)
          
          
          
          
          
          
          
          
          
          
          (connected city1 city4)
          (connected city2 city3)
          (at package2 city4)
          (connected city4 city3)
          (at truck2 city3)
          
          (connected city4 city1)
          
          
          (at truck1 city2)
          
          (at package1 city1)
          (connected city3 city1)
          
          
          (connected city2 city1)
          
          (connected city3 city2)
          
          (connected city1 city2)
          
          
          (connected city1 city3)
          (connected city3 city4)
          
          
          
          )
   (:goal (and (at package1 city4))))
