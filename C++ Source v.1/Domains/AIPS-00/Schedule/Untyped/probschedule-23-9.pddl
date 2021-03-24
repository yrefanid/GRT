(define (problem schedule-23-9)
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
    (SHAPE A0 CIRCULAR)
    (SURFACE-CONDITION A0 ROUGH)
    (PAINTED A0 RED)
    (HAS-HOLE A0 TWO FRONT) (lasthole A0 TWO FRONT) (linked A0 nowidth noorient TWO FRONT)
    (TEMPERATURE A0 COLD)
    (SHAPE B0 CIRCULAR)
    (SURFACE-CONDITION B0 ROUGH)
    (PAINTED B0 YELLOW)
    (HAS-HOLE B0 ONE FRONT) (lasthole B0 ONE FRONT) (linked B0 nowidth noorient ONE FRONT)
    (TEMPERATURE B0 COLD)
    (SHAPE C0 CIRCULAR)
    (SURFACE-CONDITION C0 POLISHED)
    (PAINTED C0 YELLOW)
    (HAS-HOLE C0 ONE FRONT) (lasthole C0 ONE FRONT) (linked C0 nowidth noorient ONE FRONT)
    (TEMPERATURE C0 COLD)
    (SHAPE D0 OBLONG)
    (SURFACE-CONDITION D0 SMOOTH)
    (PAINTED D0 YELLOW)
    (HAS-HOLE D0 THREE BACK) (lasthole D0 THREE BACK) (linked D0 nowidth noorient THREE BACK)
    (TEMPERATURE D0 COLD)
    (SHAPE E0 CYLINDRICAL)
    (SURFACE-CONDITION E0 ROUGH)
    (PAINTED E0 BLACK)
    (HAS-HOLE E0 THREE FRONT) (lasthole E0 THREE FRONT) (linked E0 nowidth noorient THREE FRONT)
    (TEMPERATURE E0 COLD)
    (SHAPE F0 OBLONG)
    (SURFACE-CONDITION F0 POLISHED)
    (PAINTED F0 BLUE)
    (HAS-HOLE F0 TWO FRONT) (lasthole F0 TWO FRONT) (linked F0 nowidth noorient TWO FRONT)
    (TEMPERATURE F0 COLD)
    (SHAPE G0 CIRCULAR)
    (SURFACE-CONDITION G0 POLISHED)
    (PAINTED G0 YELLOW)
    (HAS-HOLE G0 TWO BACK) (lasthole G0 TWO BACK) (linked G0 nowidth noorient TWO BACK)
    (TEMPERATURE G0 COLD)
    (SHAPE H0 CIRCULAR)
    (SURFACE-CONDITION H0 ROUGH)
    (PAINTED H0 BLUE)
    (HAS-HOLE H0 ONE FRONT) (lasthole H0 ONE FRONT) (linked H0 nowidth noorient ONE FRONT)
    (TEMPERATURE H0 COLD)
    (SHAPE I0 CIRCULAR)
    (SURFACE-CONDITION I0 POLISHED)
    (PAINTED I0 RED)
    (HAS-HOLE I0 THREE BACK) (lasthole I0 THREE BACK) (linked I0 nowidth noorient THREE BACK)
    (TEMPERATURE I0 COLD)
    (SHAPE J0 CYLINDRICAL)
    (SURFACE-CONDITION J0 ROUGH)
    (PAINTED J0 YELLOW)
    (HAS-HOLE J0 THREE BACK) (lasthole J0 THREE BACK) (linked J0 nowidth noorient THREE BACK)
    (TEMPERATURE J0 COLD)
    (SHAPE K0 CYLINDRICAL)
    (SURFACE-CONDITION K0 ROUGH)
    (PAINTED K0 BLUE)
    (HAS-HOLE K0 ONE BACK) (lasthole K0 ONE BACK) (linked K0 nowidth noorient ONE BACK)
    (TEMPERATURE K0 COLD)
    (SHAPE L0 CIRCULAR)
    (SURFACE-CONDITION L0 ROUGH)
    (PAINTED L0 BLUE)
    (HAS-HOLE L0 TWO FRONT) (lasthole L0 TWO FRONT) (linked L0 nowidth noorient TWO FRONT)
    (TEMPERATURE L0 COLD)
    (SHAPE M0 OBLONG)
    (SURFACE-CONDITION M0 POLISHED)
    (PAINTED M0 BLUE)
    (HAS-HOLE M0 TWO BACK) (lasthole M0 TWO BACK) (linked M0 nowidth noorient TWO BACK)
    (TEMPERATURE M0 COLD)
    (SHAPE N0 OBLONG)
    (SURFACE-CONDITION N0 SMOOTH)
    (PAINTED N0 RED)
    (HAS-HOLE N0 TWO FRONT) (lasthole N0 TWO FRONT) (linked N0 nowidth noorient TWO FRONT)
    (TEMPERATURE N0 COLD)
    (SHAPE O0 CYLINDRICAL)
    (SURFACE-CONDITION O0 ROUGH)
    (PAINTED O0 BLACK)
    (HAS-HOLE O0 ONE BACK) (lasthole O0 ONE BACK) (linked O0 nowidth noorient ONE BACK)
    (TEMPERATURE O0 COLD)
    (SHAPE Q0 CYLINDRICAL)
    (SURFACE-CONDITION Q0 ROUGH)
    (PAINTED Q0 BLACK)
    (HAS-HOLE Q0 THREE BACK) (lasthole Q0 THREE BACK) (linked Q0 nowidth noorient THREE BACK)
    (TEMPERATURE Q0 COLD)
    (SHAPE P0 OBLONG)
    (SURFACE-CONDITION P0 POLISHED)
    (PAINTED P0 BLACK)
    (HAS-HOLE P0 THREE FRONT) (lasthole P0 THREE FRONT) (linked P0 nowidth noorient THREE FRONT)
    (TEMPERATURE P0 COLD)
    (SHAPE R0 OBLONG)
    (SURFACE-CONDITION R0 ROUGH)
    (PAINTED R0 BLUE)
    (HAS-HOLE R0 THREE BACK) (lasthole R0 THREE BACK) (linked R0 nowidth noorient THREE BACK)
    (TEMPERATURE R0 COLD)
    (SHAPE S0 CYLINDRICAL)
    (SURFACE-CONDITION S0 POLISHED)
    (PAINTED S0 BLUE)
    (HAS-HOLE S0 THREE FRONT) (lasthole S0 THREE FRONT) (linked S0 nowidth noorient THREE FRONT)
    (TEMPERATURE S0 COLD)
    (SHAPE U0 CYLINDRICAL)
    (SURFACE-CONDITION U0 SMOOTH)
    (PAINTED U0 BLACK)
    (HAS-HOLE U0 THREE BACK) (lasthole U0 THREE BACK) (linked U0 nowidth noorient THREE BACK)
    (TEMPERATURE U0 COLD)
    (SHAPE V0 CIRCULAR)
    (SURFACE-CONDITION V0 ROUGH)
    (PAINTED V0 BLUE)
    (HAS-HOLE V0 THREE FRONT) (lasthole V0 THREE FRONT) (linked V0 nowidth noorient THREE FRONT)
    (TEMPERATURE V0 COLD)
    (SHAPE W0 CIRCULAR)
    (SURFACE-CONDITION W0 SMOOTH)
    (PAINTED W0 BLACK)
    (HAS-HOLE W0 TWO FRONT) (lasthole W0 TWO FRONT) (linked W0 nowidth noorient TWO FRONT)
    (TEMPERATURE W0 COLD)
    (SHAPE Z0 CYLINDRICAL)
    (SURFACE-CONDITION Z0 POLISHED)
    (PAINTED Z0 RED)
    (HAS-HOLE Z0 THREE BACK) (lasthole Z0 THREE BACK) (linked Z0 nowidth noorient THREE BACK)
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
    (PAINTED J0 RED)
    (PAINTED Q0 RED)
    (SHAPE N0 CYLINDRICAL)
    (SURFACE-CONDITION J0 SMOOTH)
    (PAINTED O0 RED)
    (SHAPE L0 CYLINDRICAL)
    (PAINTED H0 RED)
    (SURFACE-CONDITION U0 ROUGH)
    (PAINTED G0 BLUE)
    (PAINTED F0 YELLOW)
    (PAINTED M0 BLACK)
    (SHAPE A0 CYLINDRICAL)
    (SURFACE-CONDITION P0 SMOOTH)
    (PAINTED B0 RED)
    (SHAPE G0 CYLINDRICAL)
    (SURFACE-CONDITION V0 SMOOTH)
    (SURFACE-CONDITION N0 POLISHED)
    (PAINTED K0 BLACK)
    (PAINTED A0 BLACK)
    (SHAPE H0 CYLINDRICAL)
    (PAINTED V0 BLACK)
    (PAINTED P0 BLUE)
    (PAINTED R0 BLACK)
)))