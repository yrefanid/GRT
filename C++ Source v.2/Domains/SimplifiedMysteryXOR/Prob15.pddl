(define (problem strips-mysty-x-15)
   (:domain mystery-strips)
   (:objects city1 city2 city3 city4 city5 city6 city7 city8
             city9 city10 city11 city12 city13 city14 city15 city16 city17
             truck1 truck2 truck3 truck4 truck5
             truck6 truck7 truck8 truck9 truck10 truck11
             package1 package2 package3 package4 package5 package6 package7
             package8 package9 package10 package11 package12 package13  
                   
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
          (city city16)
          (city city17)
          (truck truck1)
          (truck truck2)
          (truck truck3)
          (truck truck4)
          (truck truck5)
          (truck truck6)
          (truck truck7)
          (truck truck8)
          (truck truck9)
          (truck truck10)
          (truck truck11)
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
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          (connected city14 city17)
          (at truck4 city7)
          (at truck8 city14)
          (at package6 city7)
          
          (at package7 city7)
          (at package11 city12)
          (connected city12 city13)
          (connected city15 city16)
          (connected city8 city4)
          
          (at truck3 city4)
          
          
          (at truck11 city17)
          (at truck1 city1)
          
          (connected city1 city3)
          (connected city11 city12)
          
          (at truck7 city11)
          (at package1 city1)
          (at package5 city5)
          (connected city4 city8)
          (connected city7 city9)
          (at package4 city5)
          (connected city17 city14)
          
          (connected city17 city13)
          (at truck2 city2)
          (connected city9 city7)
          (connected city6 city1)
          (connected city4 city2)
          
          
          (connected city12 city11)
          (at package8 city9)
          
          (connected city5 city2)
          
          (connected city10 city13)
          
          (connected city5 city6)
          
          (connected city3 city1)
          (connected city6 city2)
          (connected city16 city15)
          
          (connected city2 city4)
          
          (at truck9 city15)
          
          
          
          
          
          
          (connected city3 city4)
          
          (connected city2 city6)
          (connected city6 city5)
          
          (connected city14 city8)
          
          
          
          (connected city10 city16)
          
          (at package3 city3)
          (connected city7 city8)
          
          
          (connected city8 city14)
          (connected city14 city11)
          (at truck10 city16)
          (at truck6 city10)
          (connected city11 city14)
          (connected city5 city4)
          (connected city1 city6)
          (at truck5 city9)
          (connected city13 city10)
          (connected city9 city15)
          (connected city15 city9)
          
          
          (connected city4 city5)
          (at package10 city12)
          (at package2 city3)
          
          
          
          (connected city13 city12)
          (connected city16 city10)
          
          (at package12 city16)
          
          (connected city4 city3)
          (at package9 city10)
          (connected city13 city17)
          
          
          
          (connected city2 city5)
          (connected city8 city7)
          (at package13 city17)
          )
   (:goal (and (at package8 city5))))
