(define (problem strips-mysty-x-23)
   (:domain mystery-strips)
   (:objects city1 city2 city3 city4 city5 city6 city7 city8
             city9 city10 city11 city12 city13 city14 city15 city16
             city17 city18 city19 truck1 truck2
             truck3 truck4 truck5 truck6 truck7 package1 package2
             package3 package4 package5 package6 package7 package8 package9
             package10 package11 package12 package13 package14 package15 package16
                   
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
          (package package15)
          (package package16)
          
          
          
          
          
          
          
          
          
          
          
          (at truck1 city2)
          (connected city8 city1)
          (connected city4 city8)
          (at package15 city16)
          (at truck4 city11)
          
          (at package13 city14)
          
          (connected city6 city3)
          (connected city9 city2)
          (connected city6 city7)
          (at package16 city18)
          (connected city7 city10)
          
          (connected city11 city7)
          (at package3 city3)
          
          (connected city9 city5)
          (at truck7 city19)
          (at package4 city4)
          
          
          
          (at package5 city5)
          (connected city12 city16)
          
          (connected city19 city13)
          (connected city16 city12)
          
          (connected city19 city12)
          
          (connected city16 city17)
          
          (connected city13 city19)
          (connected city10 city11)
          
          
          (at package12 city13)
          (at package2 city2)
          (at package14 city15)
          (at package10 city11)
          (connected city7 city11)
          (at package7 city7)
          (connected city10 city7)
          
          (connected city16 city15)
          (connected city4 city3)
          (connected city5 city7)
          (connected city17 city18)
          
          
          (at package11 city12)
          
          
          
          (connected city14 city15)
          (connected city17 city14)
          
          (connected city17 city8)
          (connected city7 city6)
          (at truck2 city5)
          (at package1 city1)
          
          (at package8 city9)
          (connected city3 city4)
          (connected city17 city16)
          (connected city1 city8)
          (at package6 city6)
          (connected city14 city17)
          (connected city11 city10)
          
          (at truck3 city8)
          
          
          
          
          (connected city8 city4)
          (at package9 city10)
          (at truck5 city12)
          (connected city8 city17)
          (connected city7 city5)
          
          (connected city5 city9)
          (connected city15 city13)
          (connected city8 city2)
          
          (connected city13 city15)
          (connected city2 city9)
          (connected city15 city14)
          
          (connected city2 city8)
          (connected city12 city19)
          (connected city11 city1)
          
          (connected city18 city19)
          (connected city3 city6)
          (at truck6 city16)
          
          (connected city1 city11)
          
          (connected city15 city16)
          (connected city19 city18)
          (connected city18 city17)
          )
   (:goal (and (at package9 city14))))
