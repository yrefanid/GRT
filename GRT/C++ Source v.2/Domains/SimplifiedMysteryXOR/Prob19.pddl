(define (problem strips-mysty-x-19)
   (:domain mystery-strips)
   (:objects city1 city2 city3 city4 city5 city6 city7
             city8 city9 city10 city11 city12 city13 city14 city15
             truck1 truck2 truck3 truck4 truck5 truck6
             truck7 truck8 package1 package2 package3 package4
             package5 package6 package7 package8 package9 package10 package11
             package12 package13 package14   
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
          (city city14)
          (city city15)
          (truck truck1)
          (truck truck2)
          (truck truck3)
          (truck truck4)
          (truck truck5)
          (truck truck6)
          (truck truck7)
          (truck truck8)
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
          (package package12)
          (package package13)
          (package package14)
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          (connected city4 city1)
          (at package9 city10)
          (at truck6 city10)
          (at package1 city1)
          (at package5 city5)
          (connected city4 city10)
          (connected city9 city15)
          
          (connected city8 city1)
          
          (at package12 city13)
          (at truck2 city3)
          (connected city13 city14)
          
          (connected city5 city9)
          (connected city10 city12)
          (connected city9 city6)
          (connected city11 city2)
          
          (at package7 city8)
          
          (connected city8 city13)
          (connected city7 city2)
          (connected city11 city6)
          
          
          (connected city9 city5)
          (at package14 city15)
          (connected city1 city8)
          (connected city13 city8)
          (connected city5 city3)
          (at package3 city3)
          (connected city3 city5)
          (connected city8 city11)
          (connected city14 city8)
          
          (connected city10 city3)
          (at package2 city2)
          
          (connected city2 city11)
          (connected city11 city8)
          (at truck5 city9)
          (connected city6 city9)
          (connected city5 city11)
          
          
          (at package13 city14)
          (connected city1 city4)
          
          (connected city3 city10)
          (connected city14 city13)
          (connected city12 city15)
          
          
          (at package11 city12)
          
          
          
          
          
          (at package6 city7)
          (connected city6 city11)
          (at truck8 city14)
          
          
          (connected city15 city9)
          (at package4 city4)
          (connected city11 city5)
          
          
          
          (at truck7 city13)
          (at truck4 city8)
          (connected city10 city4)
          
          
          
          (connected city7 city14)
          (connected city12 city10)
          (at package8 city9)
          (connected city8 city14)
          (connected city2 city7)
          (connected city14 city7)
          (at package10 city11)
          (at truck1 city1)
          (connected city15 city12)
          (at truck3 city4))
   (:goal (and (at package5 city4))))
