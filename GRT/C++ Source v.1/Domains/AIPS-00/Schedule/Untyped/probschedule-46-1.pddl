(define (problem schedule-46-1)
(:domain schedule)
(:objects
    Z1
    W1
    V1
    U1
    S1
    R1
    P1
    Q1
    O1
    N1
    M1
    L1
    K1
    J1
    I1
    H1
    G1
    F1
    E1
    D1
    C1
    B1
    A1
    Z0
    W0
    V0
    U0
    S0
    R0
    P0
    Q0
    O0
    N0
    M0
    L0
    K0
    J0
    I0
    H0
    G0
    F0
    E0
    D0
    C0
    CIRCULAR
    TWO
    THREE
    BLUE
    YELLOW
    BACK
    RED
    B0
    FRONT
    ONE
    BLACK
    OBLONG
    A0
)
(:init
    (idle punch) (idle drill-press) (idle lathe) (idle roller) (idle polisher)
    (idle immersion-painter) (idle spray-painter) (idle grinder) (ru unwantedargs)
    (SHAPE A0 CIRCULAR)
    (SURFACE-CONDITION A0 SMOOTH)
    (PAINTED A0 BLACK)
    (HAS-HOLE A0 THREE FRONT) (lasthole A0 THREE FRONT) (linked A0 nowidth noorient THREE FRONT)
    (TEMPERATURE A0 COLD)
    (SHAPE B0 OBLONG)
    (SURFACE-CONDITION B0 ROUGH)
    (PAINTED B0 RED)
    (HAS-HOLE B0 THREE FRONT) (lasthole B0 THREE FRONT) (linked B0 nowidth noorient THREE FRONT)
    (TEMPERATURE B0 COLD)
    (SHAPE C0 CYLINDRICAL)
    (SURFACE-CONDITION C0 SMOOTH)
    (PAINTED C0 RED)
    (HAS-HOLE C0 ONE FRONT) (lasthole C0 ONE FRONT) (linked C0 nowidth noorient ONE FRONT)
    (TEMPERATURE C0 COLD)
    (SHAPE D0 OBLONG)
    (SURFACE-CONDITION D0 SMOOTH)
    (PAINTED D0 BLUE)
    (HAS-HOLE D0 TWO FRONT) (lasthole D0 TWO FRONT) (linked D0 nowidth noorient TWO FRONT)
    (TEMPERATURE D0 COLD)
    (SHAPE E0 CYLINDRICAL)
    (SURFACE-CONDITION E0 ROUGH)
    (PAINTED E0 BLACK)
    (HAS-HOLE E0 TWO FRONT) (lasthole E0 TWO FRONT) (linked E0 nowidth noorient TWO FRONT)
    (TEMPERATURE E0 COLD)
    (SHAPE F0 CYLINDRICAL)
    (SURFACE-CONDITION F0 POLISHED)
    (PAINTED F0 BLACK)
    (HAS-HOLE F0 TWO FRONT) (lasthole F0 TWO FRONT) (linked F0 nowidth noorient TWO FRONT)
    (TEMPERATURE F0 COLD)
    (SHAPE G0 CYLINDRICAL)
    (SURFACE-CONDITION G0 POLISHED)
    (PAINTED G0 BLUE)
    (HAS-HOLE G0 ONE FRONT) (lasthole G0 ONE FRONT) (linked G0 nowidth noorient ONE FRONT)
    (TEMPERATURE G0 COLD)
    (SHAPE H0 CIRCULAR)
    (SURFACE-CONDITION H0 POLISHED)
    (PAINTED H0 BLUE)
    (HAS-HOLE H0 ONE FRONT) (lasthole H0 ONE FRONT) (linked H0 nowidth noorient ONE FRONT)
    (TEMPERATURE H0 COLD)
    (SHAPE I0 CIRCULAR)
    (SURFACE-CONDITION I0 POLISHED)
    (PAINTED I0 BLUE)
    (HAS-HOLE I0 THREE BACK) (lasthole I0 THREE BACK) (linked I0 nowidth noorient THREE BACK)
    (TEMPERATURE I0 COLD)
    (SHAPE J0 CIRCULAR)
    (SURFACE-CONDITION J0 POLISHED)
    (PAINTED J0 BLACK)
    (HAS-HOLE J0 ONE BACK) (lasthole J0 ONE BACK) (linked J0 nowidth noorient ONE BACK)
    (TEMPERATURE J0 COLD)
    (SHAPE K0 OBLONG)
    (SURFACE-CONDITION K0 POLISHED)
    (PAINTED K0 BLUE)
    (HAS-HOLE K0 ONE FRONT) (lasthole K0 ONE FRONT) (linked K0 nowidth noorient ONE FRONT)
    (TEMPERATURE K0 COLD)
    (SHAPE L0 OBLONG)
    (SURFACE-CONDITION L0 SMOOTH)
    (PAINTED L0 BLUE)
    (HAS-HOLE L0 ONE BACK) (lasthole L0 ONE BACK) (linked L0 nowidth noorient ONE BACK)
    (TEMPERATURE L0 COLD)
    (SHAPE M0 CYLINDRICAL)
    (SURFACE-CONDITION M0 SMOOTH)
    (PAINTED M0 YELLOW)
    (HAS-HOLE M0 THREE FRONT) (lasthole M0 THREE FRONT) (linked M0 nowidth noorient THREE FRONT)
    (TEMPERATURE M0 COLD)
    (SHAPE N0 CYLINDRICAL)
    (SURFACE-CONDITION N0 ROUGH)
    (PAINTED N0 YELLOW)
    (HAS-HOLE N0 TWO FRONT) (lasthole N0 TWO FRONT) (linked N0 nowidth noorient TWO FRONT)
    (TEMPERATURE N0 COLD)
    (SHAPE O0 CYLINDRICAL)
    (SURFACE-CONDITION O0 POLISHED)
    (PAINTED O0 RED)
    (HAS-HOLE O0 ONE FRONT) (lasthole O0 ONE FRONT) (linked O0 nowidth noorient ONE FRONT)
    (TEMPERATURE O0 COLD)
    (SHAPE Q0 OBLONG)
    (SURFACE-CONDITION Q0 POLISHED)
    (PAINTED Q0 YELLOW)
    (HAS-HOLE Q0 TWO BACK) (lasthole Q0 TWO BACK) (linked Q0 nowidth noorient TWO BACK)
    (TEMPERATURE Q0 COLD)
    (SHAPE P0 CYLINDRICAL)
    (SURFACE-CONDITION P0 POLISHED)
    (PAINTED P0 YELLOW)
    (HAS-HOLE P0 TWO FRONT) (lasthole P0 TWO FRONT) (linked P0 nowidth noorient TWO FRONT)
    (TEMPERATURE P0 COLD)
    (SHAPE R0 CIRCULAR)
    (SURFACE-CONDITION R0 POLISHED)
    (PAINTED R0 BLACK)
    (HAS-HOLE R0 ONE FRONT) (lasthole R0 ONE FRONT) (linked R0 nowidth noorient ONE FRONT)
    (TEMPERATURE R0 COLD)
    (SHAPE S0 OBLONG)
    (SURFACE-CONDITION S0 ROUGH)
    (PAINTED S0 BLACK)
    (HAS-HOLE S0 THREE BACK) (lasthole S0 THREE BACK) (linked S0 nowidth noorient THREE BACK)
    (TEMPERATURE S0 COLD)
    (SHAPE U0 CIRCULAR)
    (SURFACE-CONDITION U0 POLISHED)
    (PAINTED U0 BLUE)
    (HAS-HOLE U0 THREE FRONT) (lasthole U0 THREE FRONT) (linked U0 nowidth noorient THREE FRONT)
    (TEMPERATURE U0 COLD)
    (SHAPE V0 OBLONG)
    (SURFACE-CONDITION V0 POLISHED)
    (PAINTED V0 BLUE)
    (HAS-HOLE V0 TWO BACK) (lasthole V0 TWO BACK) (linked V0 nowidth noorient TWO BACK)
    (TEMPERATURE V0 COLD)
    (SHAPE W0 CYLINDRICAL)
    (SURFACE-CONDITION W0 POLISHED)
    (PAINTED W0 YELLOW)
    (HAS-HOLE W0 THREE BACK) (lasthole W0 THREE BACK) (linked W0 nowidth noorient THREE BACK)
    (TEMPERATURE W0 COLD)
    (SHAPE Z0 CIRCULAR)
    (SURFACE-CONDITION Z0 POLISHED)
    (PAINTED Z0 RED)
    (HAS-HOLE Z0 THREE FRONT) (lasthole Z0 THREE FRONT) (linked Z0 nowidth noorient THREE FRONT)
    (TEMPERATURE Z0 COLD)
    (SHAPE A1 OBLONG)
    (SURFACE-CONDITION A1 ROUGH)
    (PAINTED A1 BLUE)
    (HAS-HOLE A1 THREE BACK) (lasthole A1 THREE BACK) (linked A1 nowidth noorient THREE BACK)
    (TEMPERATURE A1 COLD)
    (SHAPE B1 CYLINDRICAL)
    (SURFACE-CONDITION B1 POLISHED)
    (PAINTED B1 RED)
    (HAS-HOLE B1 ONE BACK) (lasthole B1 ONE BACK) (linked B1 nowidth noorient ONE BACK)
    (TEMPERATURE B1 COLD)
    (SHAPE C1 OBLONG)
    (SURFACE-CONDITION C1 ROUGH)
    (PAINTED C1 BLACK)
    (HAS-HOLE C1 THREE FRONT) (lasthole C1 THREE FRONT) (linked C1 nowidth noorient THREE FRONT)
    (TEMPERATURE C1 COLD)
    (SHAPE D1 CIRCULAR)
    (SURFACE-CONDITION D1 SMOOTH)
    (PAINTED D1 BLACK)
    (HAS-HOLE D1 THREE BACK) (lasthole D1 THREE BACK) (linked D1 nowidth noorient THREE BACK)
    (TEMPERATURE D1 COLD)
    (SHAPE E1 CIRCULAR)
    (SURFACE-CONDITION E1 POLISHED)
    (PAINTED E1 BLACK)
    (HAS-HOLE E1 THREE BACK) (lasthole E1 THREE BACK) (linked E1 nowidth noorient THREE BACK)
    (TEMPERATURE E1 COLD)
    (SHAPE F1 CYLINDRICAL)
    (SURFACE-CONDITION F1 ROUGH)
    (PAINTED F1 YELLOW)
    (HAS-HOLE F1 ONE FRONT) (lasthole F1 ONE FRONT) (linked F1 nowidth noorient ONE FRONT)
    (TEMPERATURE F1 COLD)
    (SHAPE G1 CIRCULAR)
    (SURFACE-CONDITION G1 POLISHED)
    (PAINTED G1 YELLOW)
    (HAS-HOLE G1 ONE BACK) (lasthole G1 ONE BACK) (linked G1 nowidth noorient ONE BACK)
    (TEMPERATURE G1 COLD)
    (SHAPE H1 CYLINDRICAL)
    (SURFACE-CONDITION H1 ROUGH)
    (PAINTED H1 RED)
    (HAS-HOLE H1 TWO FRONT) (lasthole H1 TWO FRONT) (linked H1 nowidth noorient TWO FRONT)
    (TEMPERATURE H1 COLD)
    (SHAPE I1 CYLINDRICAL)
    (SURFACE-CONDITION I1 POLISHED)
    (PAINTED I1 BLUE)
    (HAS-HOLE I1 ONE FRONT) (lasthole I1 ONE FRONT) (linked I1 nowidth noorient ONE FRONT)
    (TEMPERATURE I1 COLD)
    (SHAPE J1 OBLONG)
    (SURFACE-CONDITION J1 SMOOTH)
    (PAINTED J1 BLACK)
    (HAS-HOLE J1 ONE FRONT) (lasthole J1 ONE FRONT) (linked J1 nowidth noorient ONE FRONT)
    (TEMPERATURE J1 COLD)
    (SHAPE K1 CYLINDRICAL)
    (SURFACE-CONDITION K1 SMOOTH)
    (PAINTED K1 RED)
    (HAS-HOLE K1 THREE BACK) (lasthole K1 THREE BACK) (linked K1 nowidth noorient THREE BACK)
    (TEMPERATURE K1 COLD)
    (SHAPE L1 OBLONG)
    (SURFACE-CONDITION L1 SMOOTH)
    (PAINTED L1 YELLOW)
    (HAS-HOLE L1 THREE FRONT) (lasthole L1 THREE FRONT) (linked L1 nowidth noorient THREE FRONT)
    (TEMPERATURE L1 COLD)
    (SHAPE M1 CIRCULAR)
    (SURFACE-CONDITION M1 ROUGH)
    (PAINTED M1 BLUE)
    (HAS-HOLE M1 TWO FRONT) (lasthole M1 TWO FRONT) (linked M1 nowidth noorient TWO FRONT)
    (TEMPERATURE M1 COLD)
    (SHAPE N1 CYLINDRICAL)
    (SURFACE-CONDITION N1 SMOOTH)
    (PAINTED N1 BLACK)
    (HAS-HOLE N1 TWO FRONT) (lasthole N1 TWO FRONT) (linked N1 nowidth noorient TWO FRONT)
    (TEMPERATURE N1 COLD)
    (SHAPE O1 CYLINDRICAL)
    (SURFACE-CONDITION O1 SMOOTH)
    (PAINTED O1 BLACK)
    (HAS-HOLE O1 TWO BACK) (lasthole O1 TWO BACK) (linked O1 nowidth noorient TWO BACK)
    (TEMPERATURE O1 COLD)
    (SHAPE Q1 CIRCULAR)
    (SURFACE-CONDITION Q1 POLISHED)
    (PAINTED Q1 BLUE)
    (HAS-HOLE Q1 TWO FRONT) (lasthole Q1 TWO FRONT) (linked Q1 nowidth noorient TWO FRONT)
    (TEMPERATURE Q1 COLD)
    (SHAPE P1 CIRCULAR)
    (SURFACE-CONDITION P1 ROUGH)
    (PAINTED P1 BLACK)
    (HAS-HOLE P1 TWO FRONT) (lasthole P1 TWO FRONT) (linked P1 nowidth noorient TWO FRONT)
    (TEMPERATURE P1 COLD)
    (SHAPE R1 CYLINDRICAL)
    (SURFACE-CONDITION R1 SMOOTH)
    (PAINTED R1 YELLOW)
    (HAS-HOLE R1 TWO FRONT) (lasthole R1 TWO FRONT) (linked R1 nowidth noorient TWO FRONT)
    (TEMPERATURE R1 COLD)
    (SHAPE S1 CYLINDRICAL)
    (SURFACE-CONDITION S1 POLISHED)
    (PAINTED S1 RED)
    (HAS-HOLE S1 TWO FRONT) (lasthole S1 TWO FRONT) (linked S1 nowidth noorient TWO FRONT)
    (TEMPERATURE S1 COLD)
    (SHAPE U1 CIRCULAR)
    (SURFACE-CONDITION U1 POLISHED)
    (PAINTED U1 BLUE)
    (HAS-HOLE U1 THREE BACK) (lasthole U1 THREE BACK) (linked U1 nowidth noorient THREE BACK)
    (TEMPERATURE U1 COLD)
    (SHAPE V1 CIRCULAR)
    (SURFACE-CONDITION V1 SMOOTH)
    (PAINTED V1 BLUE)
    (HAS-HOLE V1 THREE BACK) (lasthole V1 THREE BACK) (linked V1 nowidth noorient THREE BACK)
    (TEMPERATURE V1 COLD)
    (SHAPE W1 OBLONG)
    (SURFACE-CONDITION W1 POLISHED)
    (PAINTED W1 BLACK)
    (HAS-HOLE W1 ONE BACK) (lasthole W1 ONE BACK) (linked W1 nowidth noorient ONE BACK)
    (TEMPERATURE W1 COLD)
    (SHAPE Z1 CYLINDRICAL)
    (SURFACE-CONDITION Z1 POLISHED)
    (PAINTED Z1 BLACK)
    (HAS-HOLE Z1 TWO BACK) (lasthole Z1 TWO BACK) (linked Z1 nowidth noorient TWO BACK)
    (TEMPERATURE Z1 COLD)
    (CAN-ORIENT DRILL-PRESS BACK)
    (CAN-ORIENT PUNCH BACK)
    (CAN-ORIENT DRILL-PRESS FRONT)
    (CAN-ORIENT PUNCH FRONT)
    (HAS-PAINT IMMERSION-PAINTER YELLOW)
    (HAS-PAINT SPRAY-PAINTER YELLOW)
    (HAS-PAINT IMMERSION-PAINTER BLUE)
    (HAS-PAINT SPRAY-PAINTER BLUE)
    (HAS-PAINT IMMERSION-PAINTER BLACK)
    (HAS-PAINT SPRAY-PAINTER BLACK)
    (HAS-PAINT IMMERSION-PAINTER RED)
    (HAS-PAINT SPRAY-PAINTER RED)
    (HAS-BIT DRILL-PRESS THREE)
    (HAS-BIT PUNCH THREE)
    (HAS-BIT DRILL-PRESS TWO)
    (HAS-BIT PUNCH TWO)
    (HAS-BIT DRILL-PRESS ONE)
    (HAS-BIT PUNCH ONE)
    (PART Z1) (unscheduled Z1)
    (PART W1) (unscheduled W1)
    (PART V1) (unscheduled V1)
    (PART U1) (unscheduled U1)
    (PART S1) (unscheduled S1)
    (PART R1) (unscheduled R1)
    (PART P1) (unscheduled P1)
    (PART Q1) (unscheduled Q1)
    (PART O1) (unscheduled O1)
    (PART N1) (unscheduled N1)
    (PART M1) (unscheduled M1)
    (PART L1) (unscheduled L1)
    (PART K1) (unscheduled K1)
    (PART J1) (unscheduled J1)
    (PART I1) (unscheduled I1)
    (PART H1) (unscheduled H1)
    (PART G1) (unscheduled G1)
    (PART F1) (unscheduled F1)
    (PART E1) (unscheduled E1)
    (PART D1) (unscheduled D1)
    (PART C1) (unscheduled C1)
    (PART B1) (unscheduled B1)
    (PART A1) (unscheduled A1)
    (PART Z0) (unscheduled Z0)
    (PART W0) (unscheduled W0)
    (PART V0) (unscheduled V0)
    (PART U0) (unscheduled U0)
    (PART S0) (unscheduled S0)
    (PART R0) (unscheduled R0)
    (PART P0) (unscheduled P0)
    (PART Q0) (unscheduled Q0)
    (PART O0) (unscheduled O0)
    (PART N0) (unscheduled N0)
    (PART M0) (unscheduled M0)
    (PART L0) (unscheduled L0)
    (PART K0) (unscheduled K0)
    (PART J0) (unscheduled J0)
    (PART I0) (unscheduled I0)
    (PART H0) (unscheduled H0)
    (PART G0) (unscheduled G0)
    (PART F0) (unscheduled F0)
    (PART E0) (unscheduled E0)
    (PART D0) (unscheduled D0)
    (PART C0) (unscheduled C0)
    (PART B0) (unscheduled B0)
    (PART A0) (unscheduled A0)
)
(:goal (and
    (PAINTED S1 BLUE)
    (PAINTED D0 YELLOW)
    (PAINTED O1 YELLOW)
    (PAINTED R1 BLACK)
    (SHAPE Z0 CYLINDRICAL)
    (SURFACE-CONDITION B1 SMOOTH)
    (SHAPE Q0 CYLINDRICAL)
    (SHAPE U1 CYLINDRICAL)
    (PAINTED H0 BLACK)
    (SURFACE-CONDITION S0 POLISHED)
    (PAINTED M1 RED)
    (SURFACE-CONDITION H0 SMOOTH)
    (PAINTED N1 BLUE)
    (SURFACE-CONDITION I1 ROUGH)
    (SURFACE-CONDITION E0 POLISHED)
    (PAINTED W0 RED)
    (PAINTED H1 BLUE)
    (PAINTED C0 BLUE)
    (SHAPE S0 CYLINDRICAL)
    (SURFACE-CONDITION L0 ROUGH)
    (PAINTED J0 RED)
    (SURFACE-CONDITION N0 SMOOTH)
    (SURFACE-CONDITION B0 SMOOTH)
    (SHAPE W1 CYLINDRICAL)
    (SURFACE-CONDITION S1 SMOOTH)
    (PAINTED O0 BLUE)
    (SURFACE-CONDITION M1 SMOOTH)
    (SURFACE-CONDITION N1 ROUGH)
    (PAINTED F0 RED)
    (SURFACE-CONDITION W0 ROUGH)
    (PAINTED P1 YELLOW)
    (PAINTED Z0 YELLOW)
    (SURFACE-CONDITION J0 ROUGH)
    (SURFACE-CONDITION H1 SMOOTH)
    (PAINTED F1 BLUE)
    (SURFACE-CONDITION G1 SMOOTH)
    (SURFACE-CONDITION F1 POLISHED)
    (SHAPE I0 CYLINDRICAL)
    (PAINTED K0 YELLOW)
    (SHAPE Q1 CYLINDRICAL)
    (SURFACE-CONDITION I0 ROUGH)
    (PAINTED I1 RED)
    (PAINTED G1 RED)
    (PAINTED I0 RED)
    (SHAPE M1 CYLINDRICAL)
    (PAINTED B0 BLACK)
)))