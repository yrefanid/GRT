(define (problem logistics-4-0)
(:domain logistics)
(:objects apn1 apt2 pos2 apt1 pos1 cit2 cit1 tru2 tru1 obj23 obj22 obj21 obj13 obj12 obj11 van1)

(:criteria 1 2 (length 3 (8 32) min)
			(duration 3 (67 536) min)
			(cost 1 (45 356) min)
)


(:init (package obj11) (package obj12) (package obj13) (package obj21)
 (package obj22) (package obj23) 
(truck tru1) (truck tru2) 
(city cit1) (city cit2)
(van van1)
 (location pos1) (location apt1) (location pos2) (location apt2) 
(terminal pos1) (terminal pos2)

(airport apt1) (airport apt2)
(airplane apn1) (at apn1 apt2)
 (at tru1 pos1) (at obj11 pos1)
 (at obj12 pos1) (at obj13 pos1) 
(at tru2 pos2) (at obj21 pos2) (at obj22 pos2)
 (at obj23 pos2)
 (in-city pos1 cit1) (in-city apt1 cit1) (in-city pos2 cit2)
 (in-city apt2 cit2)
(at van1 pos1)
(amount duration 0) (amount cost 0)
)
(:goal (and (at obj11 apt1) (at obj23 pos1) (at obj13 apt1) (at obj21 pos1)))
)
