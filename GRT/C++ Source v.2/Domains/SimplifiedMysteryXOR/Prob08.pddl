(define (problem strips-mysty-x-8)
   (:domain mystery-strips)
   (:objects city1 city2 city3 city4 city5 city6 city7 city8 city9
             city10 city11 city12 city13 city14 city15 city16
             city17 city18 truck1 truck2 truck3 truck4
             truck5 truck6 truck7 truck8 truck9 package1
             package2 package3 package4 package5   
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
          (package package1)
          (package package2)
          (package package3)
          (package package4)
          (package package5)
          
          
          
          
          
          
          
          
          
          
          
          (connected city9 city10)
          (connected city5 city6)
          (connected city14 city12)
          
          (connected city12 city16)
          (at truck9 city17)
          (connected city6 city5)
          (connected city18 city11)
          
          
          
          (at package2 city5)
          (connected city1 city4)
          
          (connected city8 city11)
          
          (connected city7 city15)
          (at truck6 city11)
          
          (connected city2 city3)
          
          (at package1 city2)
          (at package3 city5)
          (connected city14 city15)
          
          (connected city6 city1)
          
          (at truck2 city2)
          (connected city2 city12)
          
          (connected city11 city18)
          (connected city1 city6)
          
          (at package4 city10)
          (connected city10 city9)
          (connected city17 city16)
          (connected city6 city2)
          
          
          (connected city16 city17)
          
          (connected city3 city2)
          (at truck3 city3)
          (connected city3 city4)
          
          (connected city5 city1)
          (at truck5 city8)
          (at package5 city10)
          (connected city5 city4)
          (at truck7 city12)
          
          (connected city12 city14)
          (connected city12 city2)
          (connected city4 city1)
          
          (at truck1 city1)
          (connected city10 city17)
          
          
          (connected city17 city10)
          (connected city4 city5)
          (connected city4 city3)
          
          (connected city11 city8)
          
          (connected city1 city5)
          (connected city16 city12)
          (connected city18 city13)
          (connected city15 city7)
          (connected city15 city14)
          (connected city13 city9)
          
          
          
          (connected city7 city8)
          
          
          
          
          (connected city2 city6)
          (connected city8 city7)
          (connected city9 city13)
          
          
          (at truck8 city16)
          (at truck4 city5)
          (connected city13 city18)
          )
   (:goal (and (at package3 city12))))
