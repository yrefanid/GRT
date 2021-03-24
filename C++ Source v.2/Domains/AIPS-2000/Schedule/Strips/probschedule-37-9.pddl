(define (problem schedule-37-9)
(:domain schedule)
(:objects
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
    (SHAPE A0 CYLINDRICAL)
    (SURFACE-CONDITION A0 SMOOTH)
    (PAINTED A0 BLACK)
    (HAS-HOLE A0 THREE BACK) (lasthole A0 THREE BACK) (linked A0 nowidth noorient THREE BACK)
    (TEMPERATURE A0 COLD)
    (SHAPE B0 CYLINDRICAL)
    (SURFACE-CONDITION B0 ROUGH)
    (PAINTED B0 YELLOW)
    (HAS-HOLE B0 ONE BACK) (lasthole B0 ONE BACK) (linked B0 nowidth noorient ONE BACK)
    (TEMPERATURE B0 COLD)
    (SHAPE C0 CYLINDRICAL)
    (SURFACE-CONDITION C0 ROUGH)
    (PAINTED C0 BLUE)
    (HAS-HOLE C0 ONE BACK) (lasthole C0 ONE BACK) (linked C0 nowidth noorient ONE BACK)
    (TEMPERATURE C0 COLD)
    (SHAPE D0 CIRCULAR)
    (SURFACE-CONDITION D0 SMOOTH)
    (PAINTED D0 BLACK)
    (HAS-HOLE D0 TWO BACK) (lasthole D0 TWO BACK) (linked D0 nowidth noorient TWO BACK)
    (TEMPERATURE D0 COLD)
    (SHAPE E0 OBLONG)
    (SURFACE-CONDITION E0 SMOOTH)
    (PAINTED E0 BLUE)
    (HAS-HOLE E0 ONE FRONT) (lasthole E0 ONE FRONT) (linked E0 nowidth noorient ONE FRONT)
    (TEMPERATURE E0 COLD)
    (SHAPE F0 OBLONG)
    (SURFACE-CONDITION F0 SMOOTH)
    (PAINTED F0 YELLOW)
    (HAS-HOLE F0 ONE BACK) (lasthole F0 ONE BACK) (linked F0 nowidth noorient ONE BACK)
    (TEMPERATURE F0 COLD)
    (SHAPE G0 CIRCULAR)
    (SURFACE-CONDITION G0 ROUGH)
    (PAINTED G0 BLUE)
    (HAS-HOLE G0 TWO BACK) (lasthole G0 TWO BACK) (linked G0 nowidth noorient TWO BACK)
    (TEMPERATURE G0 COLD)
    (SHAPE H0 CYLINDRICAL)
    (SURFACE-CONDITION H0 POLISHED)
    (PAINTED H0 RED)
    (HAS-HOLE H0 ONE BACK) (lasthole H0 ONE BACK) (linked H0 nowidth noorient ONE BACK)
    (TEMPERATURE H0 COLD)
    (SHAPE I0 CYLINDRICAL)
    (SURFACE-CONDITION I0 POLISHED)
    (PAINTED I0 RED)
    (HAS-HOLE I0 TWO BACK) (lasthole I0 TWO BACK) (linked I0 nowidth noorient TWO BACK)
    (TEMPERATURE I0 COLD)
    (SHAPE J0 CYLINDRICAL)
    (SURFACE-CONDITION J0 ROUGH)
    (PAINTED J0 BLACK)
    (HAS-HOLE J0 TWO FRONT) (lasthole J0 TWO FRONT) (linked J0 nowidth noorient TWO FRONT)
    (TEMPERATURE J0 COLD)
    (SHAPE K0 OBLONG)
    (SURFACE-CONDITION K0 ROUGH)
    (PAINTED K0 BLUE)
    (HAS-HOLE K0 TWO FRONT) (lasthole K0 TWO FRONT) (linked K0 nowidth noorient TWO FRONT)
    (TEMPERATURE K0 COLD)
    (SHAPE L0 CYLINDRICAL)
    (SURFACE-CONDITION L0 SMOOTH)
    (PAINTED L0 BLUE)
    (HAS-HOLE L0 ONE FRONT) (lasthole L0 ONE FRONT) (linked L0 nowidth noorient ONE FRONT)
    (TEMPERATURE L0 COLD)
    (SHAPE M0 CYLINDRICAL)
    (SURFACE-CONDITION M0 SMOOTH)
    (PAINTED M0 RED)
    (HAS-HOLE M0 THREE BACK) (lasthole M0 THREE BACK) (linked M0 nowidth noorient THREE BACK)
    (TEMPERATURE M0 COLD)
    (SHAPE N0 OBLONG)
    (SURFACE-CONDITION N0 SMOOTH)
    (PAINTED N0 BLACK)
    (HAS-HOLE N0 TWO BACK) (lasthole N0 TWO BACK) (linked N0 nowidth noorient TWO BACK)
    (TEMPERATURE N0 COLD)
    (SHAPE O0 CIRCULAR)
    (SURFACE-CONDITION O0 POLISHED)
    (PAINTED O0 BLUE)
    (HAS-HOLE O0 THREE BACK) (lasthole O0 THREE BACK) (linked O0 nowidth noorient THREE BACK)
    (TEMPERATURE O0 COLD)
    (SHAPE Q0 CYLINDRICAL)
    (SURFACE-CONDITION Q0 POLISHED)
    (PAINTED Q0 BLACK)
    (HAS-HOLE Q0 THREE BACK) (lasthole Q0 THREE BACK) (linked Q0 nowidth noorient THREE BACK)
    (TEMPERATURE Q0 COLD)
    (SHAPE P0 CIRCULAR)
    (SURFACE-CONDITION P0 ROUGH)
    (PAINTED P0 YELLOW)
    (HAS-HOLE P0 TWO BACK) (lasthole P0 TWO BACK) (linked P0 nowidth noorient TWO BACK)
    (TEMPERATURE P0 COLD)
    (SHAPE R0 OBLONG)
    (SURFACE-CONDITION R0 ROUGH)
    (PAINTED R0 BLACK)
    (HAS-HOLE R0 THREE BACK) (lasthole R0 THREE BACK) (linked R0 nowidth noorient THREE BACK)
    (TEMPERATURE R0 COLD)
    (SHAPE S0 CIRCULAR)
    (SURFACE-CONDITION S0 ROUGH)
    (PAINTED S0 YELLOW)
    (HAS-HOLE S0 ONE BACK) (lasthole S0 ONE BACK) (linked S0 nowidth noorient ONE BACK)
    (TEMPERATURE S0 COLD)
    (SHAPE U0 OBLONG)
    (SURFACE-CONDITION U0 POLISHED)
    (PAINTED U0 RED)
    (HAS-HOLE U0 TWO FRONT) (lasthole U0 TWO FRONT) (linked U0 nowidth noorient TWO FRONT)
    (TEMPERATURE U0 COLD)
    (SHAPE V0 OBLONG)
    (SURFACE-CONDITION V0 POLISHED)
    (PAINTED V0 BLUE)
    (HAS-HOLE V0 ONE FRONT) (lasthole V0 ONE FRONT) (linked V0 nowidth noorient ONE FRONT)
    (TEMPERATURE V0 COLD)
    (SHAPE W0 CIRCULAR)
    (SURFACE-CONDITION W0 SMOOTH)
    (PAINTED W0 BLUE)
    (HAS-HOLE W0 ONE BACK) (lasthole W0 ONE BACK) (linked W0 nowidth noorient ONE BACK)
    (TEMPERATURE W0 COLD)
    (SHAPE Z0 OBLONG)
    (SURFACE-CONDITION Z0 ROUGH)
    (PAINTED Z0 YELLOW)
    (HAS-HOLE Z0 THREE BACK) (lasthole Z0 THREE BACK) (linked Z0 nowidth noorient THREE BACK)
    (TEMPERATURE Z0 COLD)
    (SHAPE A1 OBLONG)
    (SURFACE-CONDITION A1 SMOOTH)
    (PAINTED A1 BLACK)
    (HAS-HOLE A1 THREE FRONT) (lasthole A1 THREE FRONT) (linked A1 nowidth noorient THREE FRONT)
    (TEMPERATURE A1 COLD)
    (SHAPE B1 CIRCULAR)
    (SURFACE-CONDITION B1 POLISHED)
    (PAINTED B1 YELLOW)
    (HAS-HOLE B1 ONE FRONT) (lasthole B1 ONE FRONT) (linked B1 nowidth noorient ONE FRONT)
    (TEMPERATURE B1 COLD)
    (SHAPE C1 CIRCULAR)
    (SURFACE-CONDITION C1 POLISHED)
    (PAINTED C1 BLACK)
    (HAS-HOLE C1 ONE BACK) (lasthole C1 ONE BACK) (linked C1 nowidth noorient ONE BACK)
    (TEMPERATURE C1 COLD)
    (SHAPE D1 OBLONG)
    (SURFACE-CONDITION D1 POLISHED)
    (PAINTED D1 YELLOW)
    (HAS-HOLE D1 THREE BACK) (lasthole D1 THREE BACK) (linked D1 nowidth noorient THREE BACK)
    (TEMPERATURE D1 COLD)
    (SHAPE E1 OBLONG)
    (SURFACE-CONDITION E1 POLISHED)
    (PAINTED E1 YELLOW)
    (HAS-HOLE E1 TWO BACK) (lasthole E1 TWO BACK) (linked E1 nowidth noorient TWO BACK)
    (TEMPERATURE E1 COLD)
    (SHAPE F1 OBLONG)
    (SURFACE-CONDITION F1 ROUGH)
    (PAINTED F1 RED)
    (HAS-HOLE F1 TWO FRONT) (lasthole F1 TWO FRONT) (linked F1 nowidth noorient TWO FRONT)
    (TEMPERATURE F1 COLD)
    (SHAPE G1 CYLINDRICAL)
    (SURFACE-CONDITION G1 POLISHED)
    (PAINTED G1 BLACK)
    (HAS-HOLE G1 THREE FRONT) (lasthole G1 THREE FRONT) (linked G1 nowidth noorient THREE FRONT)
    (TEMPERATURE G1 COLD)
    (SHAPE H1 CIRCULAR)
    (SURFACE-CONDITION H1 SMOOTH)
    (PAINTED H1 BLACK)
    (HAS-HOLE H1 ONE BACK) (lasthole H1 ONE BACK) (linked H1 nowidth noorient ONE BACK)
    (TEMPERATURE H1 COLD)
    (SHAPE I1 CYLINDRICAL)
    (SURFACE-CONDITION I1 ROUGH)
    (PAINTED I1 RED)
    (HAS-HOLE I1 TWO BACK) (lasthole I1 TWO BACK) (linked I1 nowidth noorient TWO BACK)
    (TEMPERATURE I1 COLD)
    (SHAPE J1 OBLONG)
    (SURFACE-CONDITION J1 ROUGH)
    (PAINTED J1 YELLOW)
    (HAS-HOLE J1 THREE FRONT) (lasthole J1 THREE FRONT) (linked J1 nowidth noorient THREE FRONT)
    (TEMPERATURE J1 COLD)
    (SHAPE K1 CIRCULAR)
    (SURFACE-CONDITION K1 POLISHED)
    (PAINTED K1 BLUE)
    (HAS-HOLE K1 TWO FRONT) (lasthole K1 TWO FRONT) (linked K1 nowidth noorient TWO FRONT)
    (TEMPERATURE K1 COLD)
    (SHAPE L1 CYLINDRICAL)
    (SURFACE-CONDITION L1 ROUGH)
    (PAINTED L1 BLUE)
    (HAS-HOLE L1 ONE FRONT) (lasthole L1 ONE FRONT) (linked L1 nowidth noorient ONE FRONT)
    (TEMPERATURE L1 COLD)
    (SHAPE M1 CYLINDRICAL)
    (SURFACE-CONDITION M1 ROUGH)
    (PAINTED M1 YELLOW)
    (HAS-HOLE M1 TWO BACK) (lasthole M1 TWO BACK) (linked M1 nowidth noorient TWO BACK)
    (TEMPERATURE M1 COLD)
    (SHAPE N1 CIRCULAR)
    (SURFACE-CONDITION N1 SMOOTH)
    (PAINTED N1 RED)
    (HAS-HOLE N1 ONE FRONT) (lasthole N1 ONE FRONT) (linked N1 nowidth noorient ONE FRONT)
    (TEMPERATURE N1 COLD)
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
    (SURFACE-CONDITION E1 SMOOTH)
    (SHAPE P0 CYLINDRICAL)
    (PAINTED C1 YELLOW)
    (SHAPE H1 CYLINDRICAL)
    (SURFACE-CONDITION V0 SMOOTH)
    (SURFACE-CONDITION C1 ROUGH)
    (SHAPE D1 CYLINDRICAL)
    (SHAPE N0 CYLINDRICAL)
    (SURFACE-CONDITION M0 ROUGH)
    (SURFACE-CONDITION Z0 SMOOTH)
    (PAINTED M1 BLACK)
    (SHAPE S0 CYLINDRICAL)
    (PAINTED F1 BLACK)
    (PAINTED L1 RED)
    (SURFACE-CONDITION N0 POLISHED)
    (SHAPE E1 CYLINDRICAL)
    (SHAPE Z0 CYLINDRICAL)
    (SHAPE F1 CYLINDRICAL)
    (PAINTED A1 RED)
    (PAINTED W0 RED)
    (SHAPE N1 CYLINDRICAL)
    (SHAPE D0 CYLINDRICAL)
    (SURFACE-CONDITION L1 POLISHED)
    (SURFACE-CONDITION B1 ROUGH)
    (SHAPE J1 CYLINDRICAL)
    (PAINTED G1 RED)
    (SURFACE-CONDITION A1 ROUGH)
    (PAINTED V0 YELLOW)
    (PAINTED B0 BLUE)
    (SURFACE-CONDITION L0 POLISHED)
    (SURFACE-CONDITION S0 SMOOTH)
    (SHAPE G0 CYLINDRICAL)
    (SHAPE C1 CYLINDRICAL)
    (SURFACE-CONDITION H1 ROUGH)
    (SURFACE-CONDITION C0 SMOOTH)
    (SURFACE-CONDITION R0 SMOOTH)
    (PAINTED E0 YELLOW)
)))
