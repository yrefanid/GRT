(define (problem schedule-18-1)
(:domain schedule)
(:objects
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
    (PAINTED A0 BLUE)
    (HAS-HOLE A0 ONE BACK) (lasthole A0 ONE BACK) (linked A0 nowidth noorient ONE BACK)
    (TEMPERATURE A0 COLD)
    (SHAPE B0 CIRCULAR)
    (SURFACE-CONDITION B0 ROUGH)
    (PAINTED B0 YELLOW)
    (HAS-HOLE B0 TWO FRONT) (lasthole B0 TWO FRONT) (linked B0 nowidth noorient TWO FRONT)
    (TEMPERATURE B0 COLD)
    (SHAPE C0 CIRCULAR)
    (SURFACE-CONDITION C0 ROUGH)
    (PAINTED C0 BLACK)
    (HAS-HOLE C0 THREE BACK) (lasthole C0 THREE BACK) (linked C0 nowidth noorient THREE BACK)
    (TEMPERATURE C0 COLD)
    (SHAPE D0 CIRCULAR)
    (SURFACE-CONDITION D0 SMOOTH)
    (PAINTED D0 YELLOW)
    (HAS-HOLE D0 TWO BACK) (lasthole D0 TWO BACK) (linked D0 nowidth noorient TWO BACK)
    (TEMPERATURE D0 COLD)
    (SHAPE E0 CIRCULAR)
    (SURFACE-CONDITION E0 SMOOTH)
    (PAINTED E0 BLACK)
    (HAS-HOLE E0 TWO BACK) (lasthole E0 TWO BACK) (linked E0 nowidth noorient TWO BACK)
    (TEMPERATURE E0 COLD)
    (SHAPE F0 CIRCULAR)
    (SURFACE-CONDITION F0 SMOOTH)
    (PAINTED F0 RED)
    (HAS-HOLE F0 THREE FRONT) (lasthole F0 THREE FRONT) (linked F0 nowidth noorient THREE FRONT)
    (TEMPERATURE F0 COLD)
    (SHAPE G0 CIRCULAR)
    (SURFACE-CONDITION G0 SMOOTH)
    (PAINTED G0 RED)
    (HAS-HOLE G0 ONE FRONT) (lasthole G0 ONE FRONT) (linked G0 nowidth noorient ONE FRONT)
    (TEMPERATURE G0 COLD)
    (SHAPE H0 CIRCULAR)
    (SURFACE-CONDITION H0 ROUGH)
    (PAINTED H0 YELLOW)
    (HAS-HOLE H0 ONE FRONT) (lasthole H0 ONE FRONT) (linked H0 nowidth noorient ONE FRONT)
    (TEMPERATURE H0 COLD)
    (SHAPE I0 OBLONG)
    (SURFACE-CONDITION I0 POLISHED)
    (PAINTED I0 BLUE)
    (HAS-HOLE I0 THREE FRONT) (lasthole I0 THREE FRONT) (linked I0 nowidth noorient THREE FRONT)
    (TEMPERATURE I0 COLD)
    (SHAPE J0 CIRCULAR)
    (SURFACE-CONDITION J0 POLISHED)
    (PAINTED J0 YELLOW)
    (HAS-HOLE J0 TWO BACK) (lasthole J0 TWO BACK) (linked J0 nowidth noorient TWO BACK)
    (TEMPERATURE J0 COLD)
    (SHAPE K0 OBLONG)
    (SURFACE-CONDITION K0 SMOOTH)
    (PAINTED K0 RED)
    (HAS-HOLE K0 ONE FRONT) (lasthole K0 ONE FRONT) (linked K0 nowidth noorient ONE FRONT)
    (TEMPERATURE K0 COLD)
    (SHAPE L0 OBLONG)
    (SURFACE-CONDITION L0 SMOOTH)
    (PAINTED L0 BLUE)
    (HAS-HOLE L0 ONE BACK) (lasthole L0 ONE BACK) (linked L0 nowidth noorient ONE BACK)
    (TEMPERATURE L0 COLD)
    (SHAPE M0 CIRCULAR)
    (SURFACE-CONDITION M0 SMOOTH)
    (PAINTED M0 YELLOW)
    (HAS-HOLE M0 TWO FRONT) (lasthole M0 TWO FRONT) (linked M0 nowidth noorient TWO FRONT)
    (TEMPERATURE M0 COLD)
    (SHAPE N0 OBLONG)
    (SURFACE-CONDITION N0 POLISHED)
    (PAINTED N0 BLUE)
    (HAS-HOLE N0 THREE FRONT) (lasthole N0 THREE FRONT) (linked N0 nowidth noorient THREE FRONT)
    (TEMPERATURE N0 COLD)
    (SHAPE O0 CIRCULAR)
    (SURFACE-CONDITION O0 ROUGH)
    (PAINTED O0 BLACK)
    (HAS-HOLE O0 TWO BACK) (lasthole O0 TWO BACK) (linked O0 nowidth noorient TWO BACK)
    (TEMPERATURE O0 COLD)
    (SHAPE Q0 CYLINDRICAL)
    (SURFACE-CONDITION Q0 POLISHED)
    (PAINTED Q0 YELLOW)
    (HAS-HOLE Q0 ONE FRONT) (lasthole Q0 ONE FRONT) (linked Q0 nowidth noorient ONE FRONT)
    (TEMPERATURE Q0 COLD)
    (SHAPE P0 CYLINDRICAL)
    (SURFACE-CONDITION P0 ROUGH)
    (PAINTED P0 RED)
    (HAS-HOLE P0 TWO FRONT) (lasthole P0 TWO FRONT) (linked P0 nowidth noorient TWO FRONT)
    (TEMPERATURE P0 COLD)
    (SHAPE R0 CIRCULAR)
    (SURFACE-CONDITION R0 SMOOTH)
    (PAINTED R0 BLACK)
    (HAS-HOLE R0 ONE FRONT) (lasthole R0 ONE FRONT) (linked R0 nowidth noorient ONE FRONT)
    (TEMPERATURE R0 COLD)
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
    (SURFACE-CONDITION O0 POLISHED)
    (PAINTED A0 BLACK)
    (PAINTED B0 BLACK)
    (PAINTED M0 RED)
    (SURFACE-CONDITION A0 SMOOTH)
    (SHAPE N0 CYLINDRICAL)
    (SHAPE C0 CYLINDRICAL)
    (SHAPE J0 CYLINDRICAL)
    (SHAPE H0 CYLINDRICAL)
    (PAINTED D0 BLACK)
    (PAINTED G0 BLUE)
    (SURFACE-CONDITION K0 POLISHED)
    (SURFACE-CONDITION B0 SMOOTH)
    (PAINTED R0 BLUE)
    (PAINTED O0 BLUE)
    (PAINTED J0 BLACK)
    (SURFACE-CONDITION G0 POLISHED)
    (SHAPE O0 CYLINDRICAL)
)))