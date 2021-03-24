(define (problem strips-mysty-x-6)
   (:domain mystery-strips)
   (:objects city1 city2 city3 city4 city5 city6 city7
             city8 city9 city10 city11 city12 city13 city14
             city15 city16 city17 city18 city19 truck1 truck2 truck3
             truck4 truck5 truck6 truck7 truck8
             truck9 truck10 truck11 package1 package2 package3 package4
             package5 package6 package7 package8 package9  
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
          
          
          
          
          
          
          
          
          
          
          
          
          
          (connected city11 city19)
          (connected city8 city7)
          
          (connected city5 city2)
          (connected city12 city17)
          
          (connected city7 city6)
          
          (connected city7 city17)
          
          (connected city14 city16)
          (at truck4 city4)
          
          (connected city15 city13)
          
          
          (connected city17 city7)
          (connected city18 city17)
          (connected city8 city9)
          
          (connected city1 city4)
          (connected city16 city14)
          (at package7 city15)
          (connected city17 city18)
          (connected city17 city15)
          (connected city9 city6)
          
          
          (at truck3 city3)
          
          (connected city4 city1)
          
          (at package8 city18)
          (connected city2 city5)
          (at truck6 city8)
          (at truck10 city16)
          (connected city3 city2)
          (at truck11 city17)
          (connected city6 city9)
          
          (at package1 city3)
          (connected city19 city14)
          
          (connected city9 city5)
          (connected city18 city12)
          
          (at truck7 city10)
          
          
          (at package5 city9)
          
          
          
          
          (at truck2 city2)
          (connected city12 city18)
          
          (connected city5 city9)
          (connected city17 city12)
          (connected city19 city12)
          
          (at package2 city4)
          
          
          (connected city1 city5)
          
          
          (connected city11 city10)
          
          (connected city14 city19)
          (connected city13 city16)
          (connected city16 city13)
          
          (connected city18 city10)
          (connected city10 city11)
          (connected city4 city3)
          (connected city14 city17)
          (at package6 city11)
          (at truck1 city1)
          (connected city19 city11)
          (connected city7 city8)
          (connected city12 city19)
          (at truck9 city14)
          
          
          (connected city3 city4)
          
          (at package3 city6)
          
          (connected city10 city18)
          (connected city17 city14)
          (connected city13 city15)
          
          (connected city9 city8)
          
          (at package9 city19)
          
          (at truck5 city7)
          (connected city6 city7)
          (connected city2 city3)
          (connected city15 city17)
          (at package4 city7)
          
          (at truck8 city13)
          (connected city5 city1))
   (:goal (and (at package1 city17)
               (at package5 city17))))
