(define (problem strips-mysty-x-28)
   (:domain mystery-strips)
   (:objects city1 city2 city3 city4 city5 truck1
             package1 package2 package3 package4 package5 package6 package7  
                    
             )
   (:init (city city1)
          (city city2)
          (city city3)
          (city city4)
          (city city5)
          (truck truck1)
          (package package1)
          (package package2)
          (package package3)
          (package package4)
          (package package5)
          (package package6)
          (package package7)
          
          
          
          
          
          
          
          
          
          
          
          (at package3 city2)
          
          (at package4 city3)
          (connected city5 city2)
          (connected city2 city1)
          (connected city1 city3)
          (at truck1 city1)
          
          (connected city4 city5)
          (connected city1 city5)
          (connected city3 city1)
          (at package6 city4)
          
          
          (connected city4 city3)
          
          
          (connected city2 city5)
          
          (at package2 city2)
          
          
          (at package7 city5)
          
          
          (connected city1 city2)
          
          
          (connected city5 city1)
          
          (connected city5 city4)
          (at package5 city3)
          (at package1 city1)
          (connected city3 city4)
          )
   (:goal (and (at package4 city5)
               (at package6 city5))))
