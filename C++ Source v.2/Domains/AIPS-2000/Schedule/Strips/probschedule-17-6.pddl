(define (problem schedule-17-6)
(:domain schedule)
(:objects
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
    (HAS-HOLE A0 THREE BACK) (lasthole A0 THREE BACK) (linked A0 nowidth noorient THREE BACK)
    (TEMPERATURE A0 COLD)
    (SHAPE B0 CIRCULAR)
    (SURFACE-CONDITION B0 POLISHED)
    (PAINTED B0 RED)
    (HAS-HOLE B0 ONE FRONT) (lasthole B0 ONE FRONT) (linked B0 nowidth noorient ONE FRONT)
    (TEMPERATURE B0 COLD)
    (SHAPE C0 CIRCULAR)
    (SURFACE-CONDITION C0 SMOOTH)
    (PAINTED C0 YELLOW)
    (HAS-HOLE C0 TWO FRONT) (lasthole C0 TWO FRONT) (linked C0 nowidth noorient TWO FRONT)
    (TEMPERATURE C0 COLD)
    (SHAPE D0 CYLINDRICAL)
    (SURFACE-CONDITION D0 POLISHED)
    (PAINTED D0 YELLOW)
    (HAS-HOLE D0 ONE BACK) (lasthole D0 ONE BACK) (linked D0 nowidth noorient ONE BACK)
    (TEMPERATURE D0 COLD)
    (SHAPE E0 OBLONG)
    (SURFACE-CONDITION E0 ROUGH)
    (PAINTED E0 YELLOW)
    (HAS-HOLE E0 ONE FRONT) (lasthole E0 ONE FRONT) (linked E0 nowidth noorient ONE FRONT)
    (TEMPERATURE E0 COLD)
    (SHAPE F0 CIRCULAR)
    (SURFACE-CONDITION F0 POLISHED)
    (PAINTED F0 BLUE)
    (HAS-HOLE F0 THREE FRONT) (lasthole F0 THREE FRONT) (linked F0 nowidth noorient THREE FRONT)
    (TEMPERATURE F0 COLD)
    (SHAPE G0 OBLONG)
    (SURFACE-CONDITION G0 SMOOTH)
    (PAINTED G0 YELLOW)
    (HAS-HOLE G0 THREE FRONT) (lasthole G0 THREE FRONT) (linked G0 nowidth noorient THREE FRONT)
    (TEMPERATURE G0 COLD)
    (SHAPE H0 CYLINDRICAL)
    (SURFACE-CONDITION H0 SMOOTH)
    (PAINTED H0 YELLOW)
    (HAS-HOLE H0 ONE FRONT) (lasthole H0 ONE FRONT) (linked H0 nowidth noorient ONE FRONT)
    (TEMPERATURE H0 COLD)
    (SHAPE I0 OBLONG)
    (SURFACE-CONDITION I0 POLISHED)
    (PAINTED I0 YELLOW)
    (HAS-HOLE I0 THREE FRONT) (lasthole I0 THREE FRONT) (linked I0 nowidth noorient THREE FRONT)
    (TEMPERATURE I0 COLD)
    (SHAPE J0 OBLONG)
    (SURFACE-CONDITION J0 SMOOTH)
    (PAINTED J0 BLUE)
    (HAS-HOLE J0 TWO FRONT) (lasthole J0 TWO FRONT) (linked J0 nowidth noorient TWO FRONT)
    (TEMPERATURE J0 COLD)
    (SHAPE K0 CIRCULAR)
    (SURFACE-CONDITION K0 SMOOTH)
    (PAINTED K0 RED)
    (HAS-HOLE K0 TWO BACK) (lasthole K0 TWO BACK) (linked K0 nowidth noorient TWO BACK)
    (TEMPERATURE K0 COLD)
    (SHAPE L0 CIRCULAR)
    (SURFACE-CONDITION L0 SMOOTH)
    (PAINTED L0 RED)
    (HAS-HOLE L0 THREE BACK) (lasthole L0 THREE BACK) (linked L0 nowidth noorient THREE BACK)
    (TEMPERATURE L0 COLD)
    (SHAPE M0 CIRCULAR)
    (SURFACE-CONDITION M0 POLISHED)
    (PAINTED M0 BLACK)
    (HAS-HOLE M0 THREE BACK) (lasthole M0 THREE BACK) (linked M0 nowidth noorient THREE BACK)
    (TEMPERATURE M0 COLD)
    (SHAPE N0 CYLINDRICAL)
    (SURFACE-CONDITION N0 SMOOTH)
    (PAINTED N0 BLUE)
    (HAS-HOLE N0 ONE BACK) (lasthole N0 ONE BACK) (linked N0 nowidth noorient ONE BACK)
    (TEMPERATURE N0 COLD)
    (SHAPE O0 CIRCULAR)
    (SURFACE-CONDITION O0 SMOOTH)
    (PAINTED O0 YELLOW)
    (HAS-HOLE O0 TWO FRONT) (lasthole O0 TWO FRONT) (linked O0 nowidth noorient TWO FRONT)
    (TEMPERATURE O0 COLD)
    (SHAPE Q0 OBLONG)
    (SURFACE-CONDITION Q0 ROUGH)
    (PAINTED Q0 YELLOW)
    (HAS-HOLE Q0 ONE FRONT) (lasthole Q0 ONE FRONT) (linked Q0 nowidth noorient ONE FRONT)
    (TEMPERATURE Q0 COLD)
    (SHAPE P0 CYLINDRICAL)
    (SURFACE-CONDITION P0 SMOOTH)
    (PAINTED P0 BLUE)
    (HAS-HOLE P0 THREE FRONT) (lasthole P0 THREE FRONT) (linked P0 nowidth noorient THREE FRONT)
    (TEMPERATURE P0 COLD)
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
    (SURFACE-CONDITION C0 POLISHED)
    (PAINTED M0 RED)
    (PAINTED D0 BLUE)
    (SURFACE-CONDITION Q0 POLISHED)
    (SHAPE E0 CYLINDRICAL)
    (SURFACE-CONDITION H0 ROUGH)
    (SURFACE-CONDITION L0 ROUGH)
    (SURFACE-CONDITION P0 POLISHED)
    (PAINTED G0 BLUE)
    (SURFACE-CONDITION O0 POLISHED)
    (PAINTED I0 BLUE)
    (PAINTED Q0 RED)
    (SURFACE-CONDITION D0 SMOOTH)
    (SHAPE B0 CYLINDRICAL)
    (PAINTED E0 BLUE)
    (SURFACE-CONDITION N0 POLISHED)
    (PAINTED N0 RED)
)))
