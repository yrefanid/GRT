(define (problem schedule-7-1)
(:domain schedule)
(:objects
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
    (PAINTED A0 YELLOW)
    (HAS-HOLE A0 THREE BACK) (lasthole A0 THREE BACK) (linked A0 nowidth noorient THREE BACK)
    (TEMPERATURE A0 COLD)
    (SHAPE B0 CYLINDRICAL)
    (SURFACE-CONDITION B0 POLISHED)
    (PAINTED B0 RED)
    (HAS-HOLE B0 ONE BACK) (lasthole B0 ONE BACK) (linked B0 nowidth noorient ONE BACK)
    (TEMPERATURE B0 COLD)
    (SHAPE C0 CIRCULAR)
    (SURFACE-CONDITION C0 ROUGH)
    (PAINTED C0 YELLOW)
    (HAS-HOLE C0 THREE FRONT) (lasthole C0 THREE FRONT) (linked C0 nowidth noorient THREE FRONT)
    (TEMPERATURE C0 COLD)
    (SHAPE D0 OBLONG)
    (SURFACE-CONDITION D0 POLISHED)
    (PAINTED D0 RED)
    (HAS-HOLE D0 TWO BACK) (lasthole D0 TWO BACK) (linked D0 nowidth noorient TWO BACK)
    (TEMPERATURE D0 COLD)
    (SHAPE E0 CYLINDRICAL)
    (SURFACE-CONDITION E0 POLISHED)
    (PAINTED E0 BLUE)
    (HAS-HOLE E0 TWO FRONT) (lasthole E0 TWO FRONT) (linked E0 nowidth noorient TWO FRONT)
    (TEMPERATURE E0 COLD)
    (SHAPE F0 OBLONG)
    (SURFACE-CONDITION F0 POLISHED)
    (PAINTED F0 BLACK)
    (HAS-HOLE F0 TWO BACK) (lasthole F0 TWO BACK) (linked F0 nowidth noorient TWO BACK)
    (TEMPERATURE F0 COLD)
    (SHAPE G0 CIRCULAR)
    (SURFACE-CONDITION G0 POLISHED)
    (PAINTED G0 BLACK)
    (HAS-HOLE G0 ONE FRONT) (lasthole G0 ONE FRONT) (linked G0 nowidth noorient ONE FRONT)
    (TEMPERATURE G0 COLD)
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
    (PART G0) (unscheduled G0)
    (PART F0) (unscheduled F0)
    (PART E0) (unscheduled E0)
    (PART D0) (unscheduled D0)
    (PART C0) (unscheduled C0)
    (PART B0) (unscheduled B0)
    (PART A0) (unscheduled A0)
)
(:goal (and
    (SURFACE-CONDITION B0 ROUGH)
    (PAINTED C0 BLUE)
    (PAINTED G0 YELLOW)
    (PAINTED E0 BLACK)
    (PAINTED F0 YELLOW)
    (SHAPE G0 CYLINDRICAL)
    (SURFACE-CONDITION E0 SMOOTH)
)))