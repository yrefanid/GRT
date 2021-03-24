(define (problem strips-movie-x-27)
   (:domain movie-strips)
   (:objects c31 c30 c29 c28 c27 c26 c25 c24 c23 c22 c21 c20 c19 c18 c17 c16
             c15 c14 c13 c12 c11 c10 c9 c8 c7 c6 c5 c4 c3 c2 c1 d31 d30 d29 d28 d27
             d26 d25 d24 d23 d22 d21 d20 d19 d18 d17 d16 d15 d14 d13 d12 d11 d10
             d9 d8 d7 d6 d5 d4 d3 d2 d1 p31 p30 p29 p28 p27 p26 p25 p24 p23 p22
             p21 p20 p19 p18 p17 p16 p15 p14 p13 p12 p11 p10 p9 p8 p7 p6 p5 p4 p3
             p2 p1 z31 z30 z29 z28 z27 z26 z25 z24 z23 z22 z21 z20 z19 z18 z17
             z16 z15 z14 z13 z12 z11 z10 z9 z8 z7 z6 z5 z4 z3 z2 z1 k31 k30 k29 k28
             k27 k26 k25 k24 k23 k22 k21 k20 k19 k18 k17 k16 k15 k14 k13 k12 k11
             k10 k9 k8 k7 k6 k5 k4 k3 k2 k1)
   (:init (chips c31)
          (chips c30)
          (chips c29)
          (chips c28)
          (chips c27)
          (chips c26)
          (chips c25)
          (chips c24)
          (chips c23)
          (chips c22)
          (chips c21)
          (chips c20)
          (chips c19)
          (chips c18)
          (chips c17)
          (chips c16)
          (chips c15)
          (chips c14)
          (chips c13)
          (chips c12)
          (chips c11)
          (chips c10)
          (chips c9)
          (chips c8)
          (chips c7)
          (chips c6)
          (chips c5)
          (chips c4)
          (chips c3)
          (chips c2)
          (chips c1)
          (dip d31)
          (dip d30)
          (dip d29)
          (dip d28)
          (dip d27)
          (dip d26)
          (dip d25)
          (dip d24)
          (dip d23)
          (dip d22)
          (dip d21)
          (dip d20)
          (dip d19)
          (dip d18)
          (dip d17)
          (dip d16)
          (dip d15)
          (dip d14)
          (dip d13)
          (dip d12)
          (dip d11)
          (dip d10)
          (dip d9)
          (dip d8)
          (dip d7)
          (dip d6)
          (dip d5)
          (dip d4)
          (dip d3)
          (dip d2)
          (dip d1)
          (pop p31)
          (pop p30)
          (pop p29)
          (pop p28)
          (pop p27)
          (pop p26)
          (pop p25)
          (pop p24)
          (pop p23)
          (pop p22)
          (pop p21)
          (pop p20)
          (pop p19)
          (pop p18)
          (pop p17)
          (pop p16)
          (pop p15)
          (pop p14)
          (pop p13)
          (pop p12)
          (pop p11)
          (pop p10)
          (pop p9)
          (pop p8)
          (pop p7)
          (pop p6)
          (pop p5)
          (pop p4)
          (pop p3)
          (pop p2)
          (pop p1)
          (cheese z31)
          (cheese z30)
          (cheese z29)
          (cheese z28)
          (cheese z27)
          (cheese z26)
          (cheese z25)
          (cheese z24)
          (cheese z23)
          (cheese z22)
          (cheese z21)
          (cheese z20)
          (cheese z19)
          (cheese z18)
          (cheese z17)
          (cheese z16)
          (cheese z15)
          (cheese z14)
          (cheese z13)
          (cheese z12)
          (cheese z11)
          (cheese z10)
          (cheese z9)
          (cheese z8)
          (cheese z7)
          (cheese z6)
          (cheese z5)
          (cheese z4)
          (cheese z3)
          (cheese z2)
          (cheese z1)
          (crackers k31)
          (crackers k30)
          (crackers k29)
          (crackers k28)
          (crackers k27)
          (crackers k26)
          (crackers k25)
          (crackers k24)
          (crackers k23)
          (crackers k22)
          (crackers k21)
          (crackers k20)
          (crackers k19)
          (crackers k18)
          (crackers k17)
          (crackers k16)
          (crackers k15)
          (crackers k14)
          (crackers k13)
          (crackers k12)
          (crackers k11)
          (crackers k10)
          (crackers k9)
          (crackers k8)
          (crackers k7)
          (crackers k6)
          (crackers k5)
          (crackers k4)
          (crackers k3)
          (crackers k2)
          (crackers k1)
          (counter-at-other-than-two-hours)
          (dont-have-chips)
          (dont-have-dip)
          (dont-have-pop)
          (dont-have-cheese)
          (dont-have-crackers)
	(not-movie-rewound))
   (:goal (and (movie-rewound)
               (counter-at-zero)
               (have-chips)
               (have-dip)
               (have-pop)
               (have-cheese)
               (have-crackers))))