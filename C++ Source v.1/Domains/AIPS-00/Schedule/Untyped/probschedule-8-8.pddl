(define (problem schedule-8-8)
(:domain schedule)
(:objects
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
    (SHAPE A0 OBLONG)
    (SURFACE-CONDITION A0 POLISHED)
    (PAINTED A0 BLUE)
    (HAS-HOLE A0 THREE FRONT) (lasthole A0 THREE FRONT) (linked A0 nowidth noorient THREE FRONT)
    (TEMPERATURE A0 COLD)
    (SHAPE B0 CYLINDRICAL)
    (SURFACE-CONDITION B0 ROUGH)
    (PAINTED B0 BLACK)
    (HAS-HOLE B0 ONE FRONT) (lasthole B0 ONE FRONT) (linked B0 nowidth noorient ONE FRONT)
    (TEMPERATURE B0 COLD)
    (SHAPE C0 CIRCULAR)
    (SURFACE-CONDITION C0 POLISHED)
    (PAINTED C0 RED)
    (HAS-HOLE C0 THREE BACK) (lasthole C0 THREE BACK) (linked C0 nowidth noorient THREE BACK)
    (TEMPERATURE C0 COLD)
    (SHAPE D0 OBLONG)
    (SURFACE-CONDITION D0 POLISHED)
    (PAINTED D0 YELLOW)
    (HAS-HOLE D0 THREE FRONT) (lasthole D0 THREE FRONT) (linked D0 nowidth noorient THREE FRONT)
    (TEMPERATURE D0 COLD)
    (SHAPE E0 CIRCULAR)
    (SURFACE-CONDITION E0 POLISHED)
    (PAINTED E0 YELLOW)
    (HAS-HOLE E0 THREE BACK) (lasthole E0 THREE BACK) (linked E0 nowidth noorient THREE BACK)
    (TEMPERATURE E0 COLD)
    (SHAPE F0 OBLONG)
    (SURFACE-CONDITION F0 SMOOTH)
    (PAINTED F0 BLACK)
    (HAS-HOLE F0 ONE FRONT) (lasthole F0 ONE FRONT) (linked F0 nowidth noorient ONE FRONT)
    (TEMPERATURE F0 COLD)
    (SHAPE G0 CYLINDRICAL)
    (SURFACE-CONDITION G0 POLISHED)
    (PAINTED G0 BLUE)
    (HAS-HOLE G0 THREE FRONT) (lasthole G0 THREE FRONT) (linked G0 nowidth noorient THREE FRONT)
    (TEMPERATURE G0 COLD)
    (SHAPE H0 CYLINDRICAL)
    (SURFACE-CONDITION H0 ROUGH)
    (PAINTED H0 BLUE)
    (HAS-HOLE H0 TWO BACK) (lasthole H0 TWO BACK) (linked H0 nowidth noorient TWO BACK)
    (TEMPERATURE H0 COLD)
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
    (PAINTED G0 RED)
    (PAINTED H0 RED)
    (SURFACE-CONDITION A0 SMOOTH)
    (PAINTED E0 BLACK)
    (SHAPE C0 CYLINDRICAL)
    (SHAPE D0 CYLINDRICAL)
    (SURFACE-CONDITION G0 ROUGH)
    (PAINTED A0 RED)
)))
