(define (problem schedule-23-6)
(:domain schedule)
(:objects
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
    (SHAPE A0 CYLINDRICAL)
    (SURFACE-CONDITION A0 POLISHED)
    (PAINTED A0 RED)
    (HAS-HOLE A0 THREE FRONT) (lasthole A0 THREE FRONT) (linked A0 nowidth noorient THREE FRONT)
    (TEMPERATURE A0 COLD)
    (SHAPE B0 OBLONG)
    (SURFACE-CONDITION B0 POLISHED)
    (PAINTED B0 RED)
    (HAS-HOLE B0 ONE BACK) (lasthole B0 ONE BACK) (linked B0 nowidth noorient ONE BACK)
    (TEMPERATURE B0 COLD)
    (SHAPE C0 OBLONG)
    (SURFACE-CONDITION C0 POLISHED)
    (PAINTED C0 YELLOW)
    (HAS-HOLE C0 THREE FRONT) (lasthole C0 THREE FRONT) (linked C0 nowidth noorient THREE FRONT)
    (TEMPERATURE C0 COLD)
    (SHAPE D0 CIRCULAR)
    (SURFACE-CONDITION D0 SMOOTH)
    (PAINTED D0 RED)
    (HAS-HOLE D0 TWO FRONT) (lasthole D0 TWO FRONT) (linked D0 nowidth noorient TWO FRONT)
    (TEMPERATURE D0 COLD)
    (SHAPE E0 CIRCULAR)
    (SURFACE-CONDITION E0 ROUGH)
    (PAINTED E0 BLACK)
    (HAS-HOLE E0 THREE FRONT) (lasthole E0 THREE FRONT) (linked E0 nowidth noorient THREE FRONT)
    (TEMPERATURE E0 COLD)
    (SHAPE F0 CYLINDRICAL)
    (SURFACE-CONDITION F0 SMOOTH)
    (PAINTED F0 YELLOW)
    (HAS-HOLE F0 TWO BACK) (lasthole F0 TWO BACK) (linked F0 nowidth noorient TWO BACK)
    (TEMPERATURE F0 COLD)
    (SHAPE G0 CIRCULAR)
    (SURFACE-CONDITION G0 ROUGH)
    (PAINTED G0 RED)
    (HAS-HOLE G0 TWO BACK) (lasthole G0 TWO BACK) (linked G0 nowidth noorient TWO BACK)
    (TEMPERATURE G0 COLD)
    (SHAPE H0 OBLONG)
    (SURFACE-CONDITION H0 ROUGH)
    (PAINTED H0 RED)
    (HAS-HOLE H0 TWO FRONT) (lasthole H0 TWO FRONT) (linked H0 nowidth noorient TWO FRONT)
    (TEMPERATURE H0 COLD)
    (SHAPE I0 OBLONG)
    (SURFACE-CONDITION I0 SMOOTH)
    (PAINTED I0 BLUE)
    (HAS-HOLE I0 ONE FRONT) (lasthole I0 ONE FRONT) (linked I0 nowidth noorient ONE FRONT)
    (TEMPERATURE I0 COLD)
    (SHAPE J0 CYLINDRICAL)
    (SURFACE-CONDITION J0 POLISHED)
    (PAINTED J0 BLUE)
    (HAS-HOLE J0 TWO FRONT) (lasthole J0 TWO FRONT) (linked J0 nowidth noorient TWO FRONT)
    (TEMPERATURE J0 COLD)
    (SHAPE K0 CIRCULAR)
    (SURFACE-CONDITION K0 SMOOTH)
    (PAINTED K0 BLACK)
    (HAS-HOLE K0 ONE BACK) (lasthole K0 ONE BACK) (linked K0 nowidth noorient ONE BACK)
    (TEMPERATURE K0 COLD)
    (SHAPE L0 CYLINDRICAL)
    (SURFACE-CONDITION L0 ROUGH)
    (PAINTED L0 BLACK)
    (HAS-HOLE L0 ONE BACK) (lasthole L0 ONE BACK) (linked L0 nowidth noorient ONE BACK)
    (TEMPERATURE L0 COLD)
    (SHAPE M0 CYLINDRICAL)
    (SURFACE-CONDITION M0 ROUGH)
    (PAINTED M0 BLACK)
    (HAS-HOLE M0 ONE BACK) (lasthole M0 ONE BACK) (linked M0 nowidth noorient ONE BACK)
    (TEMPERATURE M0 COLD)
    (SHAPE N0 CIRCULAR)
    (SURFACE-CONDITION N0 SMOOTH)
    (PAINTED N0 BLUE)
    (HAS-HOLE N0 ONE FRONT) (lasthole N0 ONE FRONT) (linked N0 nowidth noorient ONE FRONT)
    (TEMPERATURE N0 COLD)
    (SHAPE O0 CYLINDRICAL)
    (SURFACE-CONDITION O0 ROUGH)
    (PAINTED O0 BLUE)
    (HAS-HOLE O0 TWO FRONT) (lasthole O0 TWO FRONT) (linked O0 nowidth noorient TWO FRONT)
    (TEMPERATURE O0 COLD)
    (SHAPE Q0 OBLONG)
    (SURFACE-CONDITION Q0 ROUGH)
    (PAINTED Q0 BLUE)
    (HAS-HOLE Q0 TWO FRONT) (lasthole Q0 TWO FRONT) (linked Q0 nowidth noorient TWO FRONT)
    (TEMPERATURE Q0 COLD)
    (SHAPE P0 OBLONG)
    (SURFACE-CONDITION P0 POLISHED)
    (PAINTED P0 YELLOW)
    (HAS-HOLE P0 TWO FRONT) (lasthole P0 TWO FRONT) (linked P0 nowidth noorient TWO FRONT)
    (TEMPERATURE P0 COLD)
    (SHAPE R0 CIRCULAR)
    (SURFACE-CONDITION R0 SMOOTH)
    (PAINTED R0 RED)
    (HAS-HOLE R0 THREE FRONT) (lasthole R0 THREE FRONT) (linked R0 nowidth noorient THREE FRONT)
    (TEMPERATURE R0 COLD)
    (SHAPE S0 OBLONG)
    (SURFACE-CONDITION S0 SMOOTH)
    (PAINTED S0 BLUE)
    (HAS-HOLE S0 THREE BACK) (lasthole S0 THREE BACK) (linked S0 nowidth noorient THREE BACK)
    (TEMPERATURE S0 COLD)
    (SHAPE U0 OBLONG)
    (SURFACE-CONDITION U0 ROUGH)
    (PAINTED U0 BLACK)
    (HAS-HOLE U0 ONE FRONT) (lasthole U0 ONE FRONT) (linked U0 nowidth noorient ONE FRONT)
    (TEMPERATURE U0 COLD)
    (SHAPE V0 CYLINDRICAL)
    (SURFACE-CONDITION V0 ROUGH)
    (PAINTED V0 YELLOW)
    (HAS-HOLE V0 THREE FRONT) (lasthole V0 THREE FRONT) (linked V0 nowidth noorient THREE FRONT)
    (TEMPERATURE V0 COLD)
    (SHAPE W0 CYLINDRICAL)
    (SURFACE-CONDITION W0 SMOOTH)
    (PAINTED W0 BLACK)
    (HAS-HOLE W0 TWO BACK) (lasthole W0 TWO BACK) (linked W0 nowidth noorient TWO BACK)
    (TEMPERATURE W0 COLD)
    (SHAPE Z0 CIRCULAR)
    (SURFACE-CONDITION Z0 POLISHED)
    (PAINTED Z0 YELLOW)
    (HAS-HOLE Z0 ONE FRONT) (lasthole Z0 ONE FRONT) (linked Z0 nowidth noorient ONE FRONT)
    (TEMPERATURE Z0 COLD)
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
    (SURFACE-CONDITION W0 ROUGH)
    (PAINTED R0 BLACK)
    (SURFACE-CONDITION R0 POLISHED)
    (SURFACE-CONDITION C0 SMOOTH)
    (SURFACE-CONDITION U0 SMOOTH)
    (PAINTED P0 RED)
    (SHAPE S0 CYLINDRICAL)
    (SHAPE K0 CYLINDRICAL)
    (SURFACE-CONDITION Z0 SMOOTH)
    (SURFACE-CONDITION V0 SMOOTH)
    (PAINTED I0 YELLOW)
    (SURFACE-CONDITION H0 SMOOTH)
    (SURFACE-CONDITION L0 SMOOTH)
    (SURFACE-CONDITION N0 POLISHED)
    (PAINTED A0 BLACK)
    (SURFACE-CONDITION B0 SMOOTH)
    (SURFACE-CONDITION K0 ROUGH)
    (PAINTED F0 BLUE)
    (SURFACE-CONDITION D0 POLISHED)
    (SURFACE-CONDITION I0 POLISHED)
    (SURFACE-CONDITION A0 ROUGH)
    (SURFACE-CONDITION M0 SMOOTH)
    (PAINTED S0 BLACK)
)))
