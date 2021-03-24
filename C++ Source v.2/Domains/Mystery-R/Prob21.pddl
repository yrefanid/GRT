(define (problem strips-mysty-x-21)
   (:domain mystery-strips)
   (:objects city1 city2 city3 city4 city5 city6 city7 city8
             city9 city10 city11 city12 truck1 truck2 truck3
             truck4 truck5 truck6 package1 package2 package3 package4
             package5 package6 package7 package8 package9 package10 package11
             package12 package13 package14 package15 package16 package17
             package18 package19 package20 package21 package22
             package23 package24 package25 package26 package27
             package28 package29 package30 package31 package32 package33
             package34       )

   
(:resources fuel1 fuel2 fuel3 fuel4 fuel5 fuel6 fuel7 fuel8
             fuel9 fuel10 fuel11 fuel12 volume1 volume2 volume3
             volume4 volume5 volume6    
                   
                  
                 
                 
                  
                    )


(:init (city city1)
          (city_fuel city1 fuel1)
          (city city2)
          (city_fuel city2 fuel2)
          (city city3)
          (city_fuel city3 fuel3)
          (city city4)
          (city_fuel city4 fuel4)
          (city city5)
          (city_fuel city5 fuel5)
          (city city6)
          (city_fuel city6 fuel6)
          (city city7)
          (city_fuel city7 fuel7)
          (city city8)
          (city_fuel city8 fuel8)
          (city city9)
          (city_fuel city9 fuel9)
          (city city10)
          (city_fuel city10 fuel10)
          (city city11)
          (city_fuel city11 fuel11)
          (city city12)
          (city_fuel city12 fuel12)
          (truck truck1)
          (truck_volume truck1 volume1)
          (truck truck2)
          (truck_volume truck2 volume2)
          (truck truck3)
          (truck_volume truck3 volume3)
          (truck truck4)
          (truck_volume truck4 volume4)
          (truck truck5)
          (truck_volume truck5 volume5)
          (truck truck6)
          (truck_volume truck6 volume6)
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
          (package package17)
          (package package18)
          (package package19)
          (package package20)
          (package package21)
          (package package22)
          (package package23)
          (package package24)
          (package package25)
          (package package26)
          (package package27)
          (package package28)
          (package package29)
          (package package30)
          (package package31)
          (package package32)
          (package package33)
          (package package34)
          (amount fuel1 0)
          (connected city5 city3)
          (at package20 city7)
          (amount volume4 2)
          (at package14 city5)
          (connected city7 city5)
          (connected city5 city7)
          (connected city10 city11)
          (at package9 city3)
          (connected city10 city7)
          (connected city12 city9)
          (at package12 city4)
          (connected city6 city11)
          (at package17 city6)
          (amount volume5 2)
          (connected city1 city7)
          (at package11 city4)
          (at package18 city6)
          (connected city5 city2)
          (connected city3 city2)
          (at package27 city10)
          (connected city4 city5)
          (amount volume6 1)
          (at package25 city10)
          (connected city8 city12)
          (connected city1 city4)
          (amount fuel7 2)
          (amount volume3 3)
          (at package2 city1)
          (at package19 city6)
          (amount fuel2 0)
          (at package6 city2)
          (at package32 city11)
          (at truck5 city6)
          (at truck1 city1)
          (connected city6 city8)
          (at truck6 city12)
          (at package16 city6)
          (at package7 city2)
          (connected city5 city4)
          (amount fuel9 1)
          (at package28 city10)
          (at package10 city3)
          (at truck2 city2)
          (at package1 city1)
          (connected city11 city10)
          (at package29 city10)
          (connected city3 city5)
          (amount volume1 2)
          (amount fuel11 1)
          (connected city1 city3)
          (connected city4 city1)
          (at package24 city9)
          (amount fuel8 0)
          (at package5 city2)
          (at package15 city5)
          (at package22 city9)
          (connected city2 city5)
          (connected city8 city6)
          (at package31 city11)
          (connected city9 city12)
          (connected city7 city1)
          (at truck4 city4)
          (at package21 city8)
          (at package26 city10)
          (amount fuel10 2)
          (connected city7 city9)
          (amount volume2 3)
          (at truck3 city3)
          (at package8 city2)
          (amount fuel5 0)
          (connected city11 city6)
          (connected city3 city1)
          (connected city9 city7)
          (amount fuel12 1)
          (at package30 city11)
          (connected city7 city10)
          (amount fuel6 2)
          (connected city2 city3)
          (amount fuel4 1)
          (at package4 city2)
          (amount fuel3 1)
          (connected city12 city8)
          (at package3 city1)
          (at package33 city11)
          (at package23 city9)
          (at package13 city5)
          (at package34 city12))
   (:goal (and (at package14 city1))))