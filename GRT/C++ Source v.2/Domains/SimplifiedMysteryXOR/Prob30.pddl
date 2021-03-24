(define (problem strips-mysty-x-30)
   (:domain mystery-strips)
   (:objects city1 city2 city3 city4 city5 city6 city7
             city8 city9 city10 city11 city12 city13 truck1
             truck2 truck3 truck4 truck5 package1 package2
             package3 package4 package5 package6 package7   
                   
                   )
   (:init (city city1)
          (city city2)
          (city city3)
          (city city4)
          (city city5)
          (city city6)
          (city city7)
          (city city8)
          (city city9)
          (city city10)
          (city city11)
          (city city12)
          (city city13)
          (truck truck1)
          (truck truck2)
          (truck truck3)
          (truck truck4)
          (truck truck5)
          (package package1)
          (package package2)
          (package package3)
          (package package4)
          (package package5)
          (package package6)
          (package package7)
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          (connected city6 city2)
          
          
          (connected city5 city3)
          (connected city3 city5)
          (connected city12 city11)
          (at package1 city2)
          (at truck2 city4)
          
          
          (connected city13 city10)
          (connected city1 city8)
          (at package6 city10)
          
          (at truck4 city10)
          (at package4 city8)
          (connected city1 city5)
          (connected city4 city9)
          (connected city3 city12)
          (connected city9 city6)
          (connected city7 city8)
          
          
          
          
          (connected city7 city6)
          (connected city8 city6)
          (connected city13 city12)
          
          (connected city6 city9)
          (connected city5 city1)
          (connected city2 city6)
          (connected city12 city3)
          (connected city4 city3)
          (at truck1 city1)
          
          (connected city1 city2)
          (connected city3 city4)
          (connected city11 city10)
          (connected city9 city4)
          (connected city4 city6)
          
          
          
          (at truck5 city13)
          
          (connected city2 city3)
          (connected city8 city7)
          (connected city3 city2)
          
          
          
          (connected city11 city12)
          
          
          (connected city8 city1)
          
          (at package2 city3)
          
          (connected city6 city4)
          
          (at package7 city13)
          
          (connected city12 city13)
          (at truck3 city9)
          (connected city2 city1)
          
          
          (connected city10 city13)
          (connected city6 city8)
          
          (connected city10 city11)
          
          
          
          
          
          (at package3 city5)
          
          (connected city6 city7)
          (at package5 city9))
   (:goal (and (at package2 city7)
               (at package5 city7)
               (at package4 city8))))
