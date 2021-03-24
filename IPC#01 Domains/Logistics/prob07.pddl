(define (problem strips-log-x-7)
   (:domain logistics-strips)
   (:objects package10 package9 package8 package7 package6
             package5 package4 package3 package2 package1 city11 city10
             city9 city8 city7 city6 city5 city4 city3 city2 city1 truck11
             truck10 truck9 truck8 truck7 truck6 truck5 truck4 truck3 truck2
             truck1 plane6 plane5 plane4 plane3 plane2 plane1 city11-1
             city10-1 city9-1 city8-1 city7-1 city6-1 city5-1 city4-1
             city3-1 city2-1 city1-1 city11-2 city10-2 city9-2 city8-2
             city7-2 city6-2 city5-2 city4-2 city3-2 city2-2 city1-2)
   (:init (obj package10)
          (obj package9)
          (obj package8)
          (obj package7)
          (obj package6)
          (obj package5)
          (obj package4)
          (obj package3)
          (obj package2)
          (obj package1)
          (city city11)
          (city city10)
          (city city9)
          (city city8)
          (city city7)
          (city city6)
          (city city5)
          (city city4)
          (city city3)
          (city city2)
          (city city1)
          (truck truck11)
          (truck truck10)
          (truck truck9)
          (truck truck8)
          (truck truck7)
          (truck truck6)
          (truck truck5)
          (truck truck4)
          (truck truck3)
          (truck truck2)
          (truck truck1)
          (airplane plane6)
          (airplane plane5)
          (airplane plane4)
          (airplane plane3)
          (airplane plane2)
          (airplane plane1)
          (location city11-1)
          (location city10-1)
          (location city9-1)
          (location city8-1)
          (location city7-1)
          (location city6-1)
          (location city5-1)
          (location city4-1)
          (location city3-1)
          (location city2-1)
          (location city1-1)
          (airport city11-2)
          (location city11-2)
          (airport city10-2)
          (location city10-2)
          (airport city9-2)
          (location city9-2)
          (airport city8-2)
          (location city8-2)
          (airport city7-2)
          (location city7-2)
          (airport city6-2)
          (location city6-2)
          (airport city5-2)
          (location city5-2)
          (airport city4-2)
          (location city4-2)
          (airport city3-2)
          (location city3-2)
          (airport city2-2)
          (location city2-2)
          (airport city1-2)
          (location city1-2)
          (in-city city11-2 city11)
          (in-city city11-1 city11)
          (in-city city10-2 city10)
          (in-city city10-1 city10)
          (in-city city9-2 city9)
          (in-city city9-1 city9)
          (in-city city8-2 city8)
          (in-city city8-1 city8)
          (in-city city7-2 city7)
          (in-city city7-1 city7)
          (in-city city6-2 city6)
          (in-city city6-1 city6)
          (in-city city5-2 city5)
          (in-city city5-1 city5)
          (in-city city4-2 city4)
          (in-city city4-1 city4)
          (in-city city3-2 city3)
          (in-city city3-1 city3)
          (in-city city2-2 city2)
          (in-city city2-1 city2)
          (in-city city1-2 city1)
          (in-city city1-1 city1)
          (at plane6 city2-2)
          (at plane5 city5-2)
          (at plane4 city6-2)
          (at plane3 city9-2)
          (at plane2 city8-2)
          (at plane1 city1-2)
          (at truck11 city11-1)
          (at truck10 city10-1)
          (at truck9 city9-1)
          (at truck8 city8-1)
          (at truck7 city7-1)
          (at truck6 city6-1)
          (at truck5 city5-1)
          (at truck4 city4-1)
          (at truck3 city3-1)
          (at truck2 city2-1)
          (at truck1 city1-1)
          (at package10 city6-2)
          (at package9 city5-2)
          (at package8 city10-2)
          (at package7 city6-2)
          (at package6 city1-2)
          (at package5 city4-1)
          (at package4 city4-2)
          (at package3 city1-2)
          (at package2 city10-2)
          (at package1 city8-1))
   (:goal (and (at package10 city9-1)
               (at package9 city9-2)
               (at package8 city1-2)
               (at package7 city5-1)
               (at package6 city10-2)
               (at package5 city7-1)))
(:goal1 (and
		(at package4 city4-2)
          (at package3 city1-2)
          (at package2 city10-2)
          (at package1 city8-1)
		(at plane6 city2-2)
          (at plane5 city5-2)
          (at plane4 city6-2)
          (at plane3 city9-2)
          (at plane2 city8-2)
          (at plane1 city1-2)
          (at truck11 city11-1)
          (at truck10 city10-1)
          (at truck9 city9-1)
          (at truck8 city8-1)
          (at truck7 city7-1)
          (at truck6 city6-1)
          (at truck5 city5-1)
          (at truck4 city4-1)
          (at truck3 city3-1)
          (at truck2 city2-1)
          (at truck1 city1-1)
)))
