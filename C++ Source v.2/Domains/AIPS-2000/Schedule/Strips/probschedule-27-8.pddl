(define (problem schedule-27-8)
(:domain schedule)
(:objects
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
(machine punch) (machine drill-press) (machine lathe) (machine roller) (machine polisher)
    (machine immersion-painter) (machine spray-painter) (machine grinder)

    (condition1 POLISHED) (condition1 SMOOTH) (condition1 ROUGH) (condition1 undefined)

    (temperature1 cold) (temperature1 hot)

    (shape1 CYLINDRICAL) (shape1 OBLONG) (shape1 CIRCULAR)

    (color BLACK) (color YELLOW) (color RED) (color BLUE) (color nopaint)

    (width ONE) (width TWO) (width THREE) (width nowidth)

    (orientation BACK) (orientation FRONT) (orientation noorient)



    (idle punch) (idle drill-press) (idle lathe) (idle roller) (idle polisher)
    (idle immersion-painter) (idle spray-painter) (idle grinder) (ru unwantedargs)
    (SHAPE A0 CIRCULAR)
    (SURFACE-CONDITION A0 SMOOTH)
    (PAINTED A0 YELLOW)
    (HAS-HOLE A0 TWO BACK) (lasthole A0 TWO BACK) (linked A0 nowidth noorient TWO BACK)
    (TEMPERATURE A0 COLD)
    (SHAPE B0 OBLONG)
    (SURFACE-CONDITION B0 SMOOTH)
    (PAINTED B0 RED)
    (HAS-HOLE B0 ONE FRONT) (lasthole B0 ONE FRONT) (linked B0 nowidth noorient ONE FRONT)
    (TEMPERATURE B0 COLD)
    (SHAPE C0 CYLINDRICAL)
    (SURFACE-CONDITION C0 SMOOTH)
    (PAINTED C0 YELLOW)
    (HAS-HOLE C0 TWO FRONT) (lasthole C0 TWO FRONT) (linked C0 nowidth noorient TWO FRONT)
    (TEMPERATURE C0 COLD)
    (SHAPE D0 CYLINDRICAL)
    (SURFACE-CONDITION D0 SMOOTH)
    (PAINTED D0 BLACK)
    (HAS-HOLE D0 TWO FRONT) (lasthole D0 TWO FRONT) (linked D0 nowidth noorient TWO FRONT)
    (TEMPERATURE D0 COLD)
    (SHAPE E0 OBLONG)
    (SURFACE-CONDITION E0 ROUGH)
    (PAINTED E0 BLACK)
    (HAS-HOLE E0 ONE FRONT) (lasthole E0 ONE FRONT) (linked E0 nowidth noorient ONE FRONT)
    (TEMPERATURE E0 COLD)
    (SHAPE F0 CIRCULAR)
    (SURFACE-CONDITION F0 POLISHED)
    (PAINTED F0 RED)
    (HAS-HOLE F0 THREE FRONT) (lasthole F0 THREE FRONT) (linked F0 nowidth noorient THREE FRONT)
    (TEMPERATURE F0 COLD)
    (SHAPE G0 CIRCULAR)
    (SURFACE-CONDITION G0 SMOOTH)
    (PAINTED G0 BLUE)
    (HAS-HOLE G0 ONE BACK) (lasthole G0 ONE BACK) (linked G0 nowidth noorient ONE BACK)
    (TEMPERATURE G0 COLD)
    (SHAPE H0 CYLINDRICAL)
    (SURFACE-CONDITION H0 POLISHED)
    (PAINTED H0 BLACK)
    (HAS-HOLE H0 TWO BACK) (lasthole H0 TWO BACK) (linked H0 nowidth noorient TWO BACK)
    (TEMPERATURE H0 COLD)
    (SHAPE I0 CIRCULAR)
    (SURFACE-CONDITION I0 POLISHED)
    (PAINTED I0 BLACK)
    (HAS-HOLE I0 TWO FRONT) (lasthole I0 TWO FRONT) (linked I0 nowidth noorient TWO FRONT)
    (TEMPERATURE I0 COLD)
    (SHAPE J0 OBLONG)
    (SURFACE-CONDITION J0 ROUGH)
    (PAINTED J0 YELLOW)
    (HAS-HOLE J0 THREE FRONT) (lasthole J0 THREE FRONT) (linked J0 nowidth noorient THREE FRONT)
    (TEMPERATURE J0 COLD)
    (SHAPE K0 CYLINDRICAL)
    (SURFACE-CONDITION K0 POLISHED)
    (PAINTED K0 YELLOW)
    (HAS-HOLE K0 THREE FRONT) (lasthole K0 THREE FRONT) (linked K0 nowidth noorient THREE FRONT)
    (TEMPERATURE K0 COLD)
    (SHAPE L0 OBLONG)
    (SURFACE-CONDITION L0 ROUGH)
    (PAINTED L0 BLACK)
    (HAS-HOLE L0 ONE BACK) (lasthole L0 ONE BACK) (linked L0 nowidth noorient ONE BACK)
    (TEMPERATURE L0 COLD)
    (SHAPE M0 OBLONG)
    (SURFACE-CONDITION M0 POLISHED)
    (PAINTED M0 BLUE)
    (HAS-HOLE M0 THREE FRONT) (lasthole M0 THREE FRONT) (linked M0 nowidth noorient THREE FRONT)
    (TEMPERATURE M0 COLD)
    (SHAPE N0 CYLINDRICAL)
    (SURFACE-CONDITION N0 POLISHED)
    (PAINTED N0 BLACK)
    (HAS-HOLE N0 ONE BACK) (lasthole N0 ONE BACK) (linked N0 nowidth noorient ONE BACK)
    (TEMPERATURE N0 COLD)
    (SHAPE O0 OBLONG)
    (SURFACE-CONDITION O0 ROUGH)
    (PAINTED O0 YELLOW)
    (HAS-HOLE O0 TWO BACK) (lasthole O0 TWO BACK) (linked O0 nowidth noorient TWO BACK)
    (TEMPERATURE O0 COLD)
    (SHAPE Q0 CIRCULAR)
    (SURFACE-CONDITION Q0 POLISHED)
    (PAINTED Q0 YELLOW)
    (HAS-HOLE Q0 TWO BACK) (lasthole Q0 TWO BACK) (linked Q0 nowidth noorient TWO BACK)
    (TEMPERATURE Q0 COLD)
    (SHAPE P0 CYLINDRICAL)
    (SURFACE-CONDITION P0 ROUGH)
    (PAINTED P0 BLUE)
    (HAS-HOLE P0 TWO BACK) (lasthole P0 TWO BACK) (linked P0 nowidth noorient TWO BACK)
    (TEMPERATURE P0 COLD)
    (SHAPE R0 CYLINDRICAL)
    (SURFACE-CONDITION R0 SMOOTH)
    (PAINTED R0 RED)
    (HAS-HOLE R0 THREE FRONT) (lasthole R0 THREE FRONT) (linked R0 nowidth noorient THREE FRONT)
    (TEMPERATURE R0 COLD)
    (SHAPE S0 CIRCULAR)
    (SURFACE-CONDITION S0 SMOOTH)
    (PAINTED S0 BLACK)
    (HAS-HOLE S0 ONE BACK) (lasthole S0 ONE BACK) (linked S0 nowidth noorient ONE BACK)
    (TEMPERATURE S0 COLD)
    (SHAPE U0 CIRCULAR)
    (SURFACE-CONDITION U0 ROUGH)
    (PAINTED U0 RED)
    (HAS-HOLE U0 THREE BACK) (lasthole U0 THREE BACK) (linked U0 nowidth noorient THREE BACK)
    (TEMPERATURE U0 COLD)
    (SHAPE V0 CYLINDRICAL)
    (SURFACE-CONDITION V0 ROUGH)
    (PAINTED V0 RED)
    (HAS-HOLE V0 THREE BACK) (lasthole V0 THREE BACK) (linked V0 nowidth noorient THREE BACK)
    (TEMPERATURE V0 COLD)
    (SHAPE W0 OBLONG)
    (SURFACE-CONDITION W0 SMOOTH)
    (PAINTED W0 YELLOW)
    (HAS-HOLE W0 THREE BACK) (lasthole W0 THREE BACK) (linked W0 nowidth noorient THREE BACK)
    (TEMPERATURE W0 COLD)
    (SHAPE Z0 CYLINDRICAL)
    (SURFACE-CONDITION Z0 ROUGH)
    (PAINTED Z0 BLUE)
    (HAS-HOLE Z0 THREE BACK) (lasthole Z0 THREE BACK) (linked Z0 nowidth noorient THREE BACK)
    (TEMPERATURE Z0 COLD)
    (SHAPE A1 CYLINDRICAL)
    (SURFACE-CONDITION A1 POLISHED)
    (PAINTED A1 YELLOW)
    (HAS-HOLE A1 THREE FRONT) (lasthole A1 THREE FRONT) (linked A1 nowidth noorient THREE FRONT)
    (TEMPERATURE A1 COLD)
    (SHAPE B1 OBLONG)
    (SURFACE-CONDITION B1 ROUGH)
    (PAINTED B1 RED)
    (HAS-HOLE B1 TWO FRONT) (lasthole B1 TWO FRONT) (linked B1 nowidth noorient TWO FRONT)
    (TEMPERATURE B1 COLD)
    (SHAPE C1 OBLONG)
    (SURFACE-CONDITION C1 SMOOTH)
    (PAINTED C1 BLUE)
    (HAS-HOLE C1 ONE BACK) (lasthole C1 ONE BACK) (linked C1 nowidth noorient ONE BACK)
    (TEMPERATURE C1 COLD)
    (SHAPE D1 CIRCULAR)
    (SURFACE-CONDITION D1 POLISHED)
    (PAINTED D1 BLUE)
    (HAS-HOLE D1 ONE BACK) (lasthole D1 ONE BACK) (linked D1 nowidth noorient ONE BACK)
    (TEMPERATURE D1 COLD)
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
    (PAINTED L0 BLUE)
    (SHAPE B1 CYLINDRICAL)
    (SURFACE-CONDITION C0 ROUGH)
    (PAINTED A0 BLACK)
    (SHAPE A0 CYLINDRICAL)
    (PAINTED B1 YELLOW)
    (PAINTED W0 RED)
    (SURFACE-CONDITION D1 ROUGH)
    (PAINTED Z0 YELLOW)
    (SURFACE-CONDITION M0 ROUGH)
    (SHAPE F0 CYLINDRICAL)
    (PAINTED F0 BLACK)
    (SHAPE E0 CYLINDRICAL)
    (SURFACE-CONDITION A1 SMOOTH)
    (SHAPE I0 CYLINDRICAL)
    (SHAPE L0 CYLINDRICAL)
    (SURFACE-CONDITION Q0 SMOOTH)
    (SURFACE-CONDITION P0 POLISHED)
    (PAINTED D0 YELLOW)
    (PAINTED V0 YELLOW)
    (SURFACE-CONDITION V0 SMOOTH)
    (SHAPE U0 CYLINDRICAL)
    (PAINTED H0 RED)
    (PAINTED B0 BLACK)
    (PAINTED N0 RED)
    (SHAPE D1 CYLINDRICAL)
    (SHAPE C1 CYLINDRICAL)
)))
