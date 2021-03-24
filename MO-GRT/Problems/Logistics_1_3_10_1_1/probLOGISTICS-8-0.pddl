(define (problem logistics-8-0)
(:domain logistics)
(:objects apn1 apt3 pos3 apt2 pos2 apt1 pos1 cit3 cit2 cit1 tru3 tru2 tru1 obj33 obj32 obj31 obj23 obj22 obj21 obj13 obj12 obj11 van1)
(:criteria 1 3 (length 10 (14 56) min)
			(duration 1 (129 1028) min)
			(cost 1 (83 664) min)
)

(:init (package obj11) (package obj12) (package obj13) (package obj21)
 (package obj22) (package obj23) (package obj31) (package obj32) (package obj33)
 (truck tru1) (truck tru2) (truck tru3) (city cit1) (city cit2) (city cit3)
 (location pos1) (location apt1) (location pos2) (location apt2) (location pos3)
 (location apt3) (airport apt1) (airport apt2) (airport apt3) (airplane apn1)
 (at apn1 apt1) (at tru1 pos1) (at obj11 pos1) (at obj12 pos1) (at obj13 pos1)
 (at tru2 pos2) (at obj21 pos2) (at obj22 pos2) (at obj23 pos2) (at tru3 pos3)
 (at obj31 pos3) (at obj32 pos3) (at obj33 pos3) (in-city pos1 cit1)
 (in-city apt1 cit1) (in-city pos2 cit2) (in-city apt2 cit2) (in-city pos3 cit3)
 (in-city apt3 cit3)(amount duration 0) (amount cost 0)
(van van1) (terminal pos3) (terminal pos2) (terminal pos1) (at van1 pos1)
)
(:goal (and (at obj11 pos3) (at obj21 pos2) (at obj31 apt3) (at obj22 pos3)
            (at obj12 pos1) (at obj23 apt2) (at obj13 apt2) (at obj32 apt1)))
)
