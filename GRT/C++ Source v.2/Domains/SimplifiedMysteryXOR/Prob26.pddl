(define (problem strips-mysty-x-26)
   (:domain mystery-strips)
   (:objects city1 city2 city3 city4 city5 city6 city7
             city8 city9 city10 city11 city12 truck1
             truck2 truck3 truck4 truck5 package1 package2
             package3 package4     
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
          (truck truck1)
          (truck truck2)
          (truck truck3)
          (truck truck4)
          (truck truck5)
          (package package1)
          (package package2)
          (package package3)
          (package package4)
          
          
          
          
          
          
          
          
          
          
          
          (connected city6 city11)
          (at truck3 city6)
          (connected city3 city2)
          (connected city11 city6)
          (connected city12 city6)
          (connected city12 city8)
          
          (connected city5 city6)
          (connected city4 city6)
          
          (connected city4 city9)
          (connected city1 city10)
          (connected city7 city5)
          (connected city6 city5)
          
          
          (connected city7 city2)
          
          (connected city12 city9)
          
          (connected city11 city5)
          
          (connected city4 city12)
          (connected city1 city3)
          
          (connected city6 city4)
          (connected city2 city3)
          (connected city9 city12)
          
          
          
          
          (connected city2 city7)
          (at truck5 city10)
          (connected city6 city12)
          (connected city8 city11)
          
          
          (connected city8 city12)
          
          (at package1 city5)
          
          
          (at package3 city9)
          (connected city5 city11)
          (connected city12 city4)
          (at truck4 city8)
          
          (at truck1 city2)
          (connected city10 city11)
          (at truck2 city5)
          (connected city11 city8)
          
          (connected city3 city1)
          (connected city9 city4)
          (connected city9 city7)
          (at package2 city6)
          (at package4 city10)
          
          
          
          (connected city7 city9)
          (connected city10 city1)
          (connected city11 city10)
          
          (connected city5 city7)
          )
   (:goal (and (at package2 city2))))
