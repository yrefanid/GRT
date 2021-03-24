(define (problem strips-mysty-x-20)
   (:domain mystery-strips)
   (:objects city1 city2 city3 city4 city5 city6 city7
             city8 city9 city10 city11 city12 city13 city14 city15
             city16 city17 city18 truck1 truck2 truck3 truck4
             truck5 truck6 truck7 truck8 truck9
             truck10 truck11 package1 package2 package3 package4 
                    
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
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          (connected city10 city12)
          
          (connected city9 city12)
          (at truck6 city7)
          
          (at package2 city8)
          
          
          (connected city17 city2)
          (connected city7 city4)
          
          (connected city18 city9)
          
          
          (connected city9 city4)
          (connected city5 city2)
          
          (connected city9 city18)
          
          
          
          
          (at package1 city7)
          
          
          (connected city9 city11)
          (connected city2 city4)
          
          (at truck7 city8)
          
          
          
          (connected city14 city16)
          (connected city10 city18)
          (connected city1 city5)
          (connected city2 city5)
          (connected city17 city14)
          (connected city15 city12)
          
          (connected city11 city13)
          
          (connected city11 city9)
          (connected city6 city4)
          
          
          (at truck9 city14)
          (connected city7 city3)
          (connected city17 city18)
          
          (connected city13 city16)
          (connected city4 city9)
          (connected city4 city2)
          
          (connected city16 city14)
          (connected city3 city6)
          
          
          (at package3 city9)
          
          
          (connected city3 city7)
          
          (connected city7 city8)
          (connected city6 city3)
          (connected city4 city6)
          (connected city16 city13)
          (connected city15 city11)
          (connected city18 city10)
          (connected city5 city1)
          (connected city13 city11)
          (at truck11 city18)
          (connected city6 city5)
          (connected city4 city7)
          (at truck10 city17)
          (connected city14 city17)
          
          (at truck2 city2)
          
          
          
          (connected city8 city7)
          (connected city12 city15)
          (at truck4 city5)
          
          
          
          (connected city12 city10)
          
          (connected city5 city6)
          (connected city8 city1)
          (at truck5 city6)
          
          (connected city11 city15)
          
          (at truck3 city3)
          (connected city2 city17)
          
          (at package4 city18)
          
          (at truck8 city11)
          (at truck1 city1)
          (connected city1 city8)
          (connected city12 city9)
          
          (connected city18 city17)
          )
   (:goal (and (at package2 city10))))
