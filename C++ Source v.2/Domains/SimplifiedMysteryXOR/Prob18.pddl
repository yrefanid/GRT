(define (problem strips-mysty-x-18)
   (:domain mystery-strips)
   (:objects city1 city2 city3 city4 city5 city6 city7
             city8 city9 city10 city11 city12 city13 city14 city15
             city16 city17 city18 city19 city20 city21 city22
             truck1 truck2 truck3 truck4 truck5 truck6
             truck7 package1 package2 package3 package4 package5 package6
             package7 package8 package9     
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
          (city city18)
          (city city19)
          (city city20)
          (city city21)
          (city city22)
          (truck truck1)
          (truck truck2)
          (truck truck3)
          (truck truck4)
          (truck truck5)
          (truck truck6)
          (truck truck7)
          (package package1)
          (package package2)
          (package package3)
          (package package4)
          (package package5)
          (package package6)
          (package package7)
          (package package8)
          (package package9)
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          (connected city3 city1)
          
          (connected city6 city2)
          
          
          (connected city7 city12)
          (connected city9 city11)
          (connected city10 city13)
          
          
          (connected city3 city6)
          (connected city17 city18)
          (at truck1 city2)
          (connected city9 city13)
          (connected city2 city5)
          (connected city2 city6)
          (connected city4 city5)
          
          
          (at package1 city3)
          (at package6 city19)
          (connected city5 city4)
          
          (connected city8 city7)
          (at truck5 city15)
          
          (connected city11 city9)
          (connected city20 city16)
          (connected city16 city9)
          (connected city11 city12)
          (at package5 city18)
          (connected city16 city22)
          (connected city12 city11)
          (connected city3 city7)
          (connected city1 city4)
          (connected city9 city16)
          (connected city10 city11)
          
          (connected city14 city20)
          (connected city22 city16)
          (connected city15 city20)
          
          (connected city5 city2)
          (connected city10 city9)
          (connected city19 city22)
          (connected city12 city7)
          (connected city13 city8)
          (at truck7 city22)
          
          
          (connected city22 city17)
          (connected city7 city8)
          (connected city4 city1)
          
          (at package2 city9)
          
          
          (connected city7 city3)
          (connected city20 city14)
          (at package4 city11)
          
          (connected city20 city15)
          
          (connected city13 city10)
          
          (connected city8 city13)
          (connected city16 city20)
          
          (connected city14 city21)
          
          (at truck2 city4)
          (connected city21 city14)
          (connected city18 city21)
          (at truck4 city9)
          (connected city15 city19)
          (connected city22 city19)
          (at package8 city21)
          (at package3 city10)
          (connected city21 city18)
          
          
          (connected city1 city3)
          
          
          
          
          (at package9 city22)
          (connected city17 city22)
          
          
          (at truck3 city5)
          (connected city18 city17)
          (at package7 city20)
          
          (connected city13 city9)
          
          (connected city19 city15)
          
          
          (at truck6 city16)
          
          (connected city11 city10)
          
          
          
          (connected city9 city10)
          (connected city6 city3))
   (:goal (and (at package5 city2))))
