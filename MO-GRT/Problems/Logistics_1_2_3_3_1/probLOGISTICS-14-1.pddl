(define (problem logistics-14-1)
(:domain logistics)
(:objects apn2 apn1 apt5 pos5 apt4 pos4 apt3 pos3 apt2 pos2 apt1 pos1 cit5 cit4 cit3 cit2 cit1 tru5 tru4 tru3 tru2 tru1 obj53 obj52 obj51 obj43 obj42 obj41 obj33 obj32 obj31 obj23 obj22 obj21 obj13 obj12 obj11 van1)
(:criteria 1 2 (length 3 (34 136) min)
			(duration 1 (341 2728) min)
			(cost 3 (215 1718) min)
)

(:init (package obj11) (package obj12) (package obj13) (package obj21)
 (package obj22) (package obj23) (package obj31) (package obj32) (package obj33)
 (package obj41) (package obj42) (package obj43) (package obj51) (package obj52)
 (package obj53) (truck tru1) (truck tru2) (truck tru3) (truck tru4) (truck tru5)
 (city cit1) (city cit2) (city cit3) (city cit4) (city cit5) (location pos1)
 (location apt1) (location pos2) (location apt2) (location pos3) (location apt3)
 (location pos4) (location apt4) (location pos5) (location apt5) (airport apt1)
 (airport apt2) (airport apt3) (airport apt4) (airport apt5) (airplane apn1)
 (airplane apn2) (at apn1 apt1) (at apn2 apt5) (at tru1 pos1) (at obj11 pos1)
 (at obj12 pos1) (at obj13 pos1) (at tru2 pos2) (at obj21 pos2) (at obj22 pos2)
 (at obj23 pos2) (at tru3 pos3) (at obj31 pos3) (at obj32 pos3) (at obj33 pos3)
 (at tru4 pos4) (at obj41 pos4) (at obj42 pos4) (at obj43 pos4) (at tru5 pos5)
 (at obj51 pos5) (at obj52 pos5) (at obj53 pos5) (in-city pos1 cit1)
 (in-city apt1 cit1) (in-city pos2 cit2) (in-city apt2 cit2) (in-city pos3 cit3)
 (in-city apt3 cit3) (in-city pos4 cit4) (in-city apt4 cit4) (in-city pos5 cit5)
 (in-city apt5 cit5)(amount duration 0) (amount cost 0)
(van van1) (terminal pos5) (terminal pos4) (terminal pos3) (terminal pos2) (terminal pos1) (at van1 pos1)
)
(:goal (and (at obj33 pos3) (at obj22 pos3) (at obj13 apt2) (at obj43 apt1)
            (at obj41 apt1) (at obj51 pos4) (at obj53 apt5) (at obj11 pos4)
            (at obj31 pos3) (at obj42 pos1) (at obj52 pos1) (at obj12 apt3)
            (at obj32 apt4) (at obj21 pos4)))
)
