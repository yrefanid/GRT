(define (problem strips-mysty-x-1)
   (:domain mystery-strips)
   (:objects city1 city2 city3 city4 city5 city6 truck1 package1
             package2 package3 )
   (:init (city city1)
          (city city2)
          (city city3)
          (city city4)
          (city city5)
          (city city6)
          (truck truck1)
          (package package1)
          (package package2)
          (package package3)
          (connected city6 city5)
          (connected city5 city4)


          (connected city5 city6)

          (connected city6 city3)
          (at package2 city3)
          (connected city4 city2)
          (connected city1 city1)
          (connected city1 city3)
          (at package3 city5)


          (connected city3 city6)
          (at truck1 city5)


          (at package1 city1)
          (connected city3 city1)
          (connected city1 city2)

          (connected city2 city4)
          (connected city2 city1)
          (connected city4 city5)
)
   (:goal (and (at package3 city1))))