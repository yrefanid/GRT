(define (problem strips-mysty-x-16)
   (:domain mystery-strips)
   (:objects city1 city2 city3 city4 city5 city6 city7
             city8 city9 city10 city11 truck1 truck2 truck3
             truck4 truck5 truck6 truck7 package1 package2
             package3 package4 package5 package6 package7 package8 package9
                   
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
          
          
          
          
          
          
          
          
          
          
          (connected city8 city7)
          
          
          
          
          (connected city1 city5)
          
          
          (at truck3 city6)
          (at package5 city8)
          
          (at truck1 city1)
          (at truck7 city11)
          (connected city6 city9)
          (connected city11 city7)
          (connected city2 city11)
          (at package4 city5)
          
          
          (connected city6 city8)
          
          
          
          (at truck5 city9)
          (connected city3 city9)
          
          
          
          
          (connected city9 city6)
          (at truck2 city2)
          (at package8 city9)
          (at package2 city2)
          
          
          (at package9 city9)
          (connected city2 city3)
          (connected city8 city6)
          (connected city5 city1)
          (connected city10 city5)
          (at package1 city1)
          (connected city1 city4)
          (connected city11 city4)
          (at package6 city8)
          (connected city4 city1)
          (at package3 city5)
          (connected city10 city9)
          (connected city7 city11)
          
          (at truck4 city8)
          (at package7 city9)
          
          (connected city3 city2)
          
          (connected city9 city3)
          (connected city11 city2)
          (connected city7 city8)
          
          (at truck6 city10)
          (connected city4 city11)
          (connected city5 city10)
          
          (connected city9 city10)
          
          
          )
   (:goal (and (at package7 city10)
               (at package8 city10))))
