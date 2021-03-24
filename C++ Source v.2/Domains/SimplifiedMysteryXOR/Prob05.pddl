(define (problem strips-mysty-x-5)
   (:domain mystery-strips)
   (:objects city1 city2 city3 city4 city5 city6 city7
             city8 truck1 truck2 truck3 truck4
             package1 package2 package3 package4 package5 package6 package7
             package8 package9 package10 package11 package12 package13 package14
             package15 )
   (:init (city city1)
          (city city2)
          (city city3)
          (city city4)
          (city city5)
          (city city6)
          (city city7)
          (city city8)
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
          (package package9)
          (package package10)
          (package package11)
          (package package12)
          (package package13)
          (package package14)
          (package package15)
          (connected city8 city7)
          (at truck1 city1)

          (at package9 city6)
          (connected city4 city1)
          (connected city5 city8)
          (at package3 city1)

          (at truck3 city4)

          (connected city7 city6)

          (connected city6 city5)

          (connected city7 city8)
          (at package15 city8)

          (at truck2 city3)
          (at package14 city8)
          (connected city1 city2)
          (at package5 city3)
          (connected city4 city3)
          (connected city2 city6)
          (at truck4 city5)

          (connected city3 city2)

          (connected city6 city7)
          (at package13 city8)
          (at package12 city8)
          (at package8 city6)

          (connected city2 city3)
          (connected city2 city1)

          (at package10 city6)
          (at package2 city1)

          (at package7 city3)
          (at package4 city1)

          (connected city5 city6)
          (connected city1 city4)
          (at package6 city3)

          (connected city8 city5)

          (connected city6 city2)
          (at package11 city7)

          (at package1 city1)

          (connected city3 city4))
   (:goal (and (at package14 city6)
               (at package3 city6))))