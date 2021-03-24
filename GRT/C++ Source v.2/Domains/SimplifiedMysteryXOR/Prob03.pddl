(define (problem strips-mysty-x-3)
   (:domain mystery-strips)
   (:objects city1 city2 city3 city4 city5 city6 city7 city8
             city9 city10 city11 truck1 truck2 truck3 truck4
             package1 package2 package3 package4 package5 package6 package7
             package8 )
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
          (package package1)
          (package package2)
          (package package3)
          (package package4)
          (package package5)
          (package package6)
          (package package7)
          (package package8)
          (connected city8 city11)

          (at package6 city8)
          (at package3 city5)
          (connected city2 city4)
          (connected city6 city1)

          (connected city11 city8)
          (connected city5 city2)
          (connected city11 city7)
          (at package8 city10)
          (connected city2 city1)
          (connected city1 city7)
          (at package5 city7)
          (connected city6 city3)
          (at package1 city1)
          (connected city6 city5)
          (connected city9 city10)

          (connected city7 city10)


          (connected city5 city4)
          (connected city1 city6)

          (at truck2 city6)

          (connected city10 city7)

          (connected city9 city8)
          (connected city5 city6)
          (connected city8 city9)
          (connected city4 city2)
          (connected city2 city5)

          (connected city3 city2)
          (connected city7 city1)

          (at truck3 city8)
          (at package2 city4)

          (connected city7 city11)
          (connected city1 city2)

          (connected city10 city9)
          (at truck1 city1)
          (connected city4 city5)
          (at truck4 city11)
          (connected city3 city6)

          (connected city2 city3)
          (at package4 city6)
          (at package7 city9))
   (:goal (and (at package7 city10))))