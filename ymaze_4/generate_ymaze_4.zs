define SHOWTIME 0.1

DEFINE RADIUS 14.809 # Distance from centre of maze to centre of rectangular arm

DEFINE RECTANGLE_LENGTH 25
DEFINE RECTANGLE_WIDTH 8


# XY coordinates for centre of first Y-maze, in mm, within plate
DEFINE C1X 29.5
DEFINE C1Y 26.5

# XY coordinates for centre of 2nd Y-maze, in mm, within plate
DEFINE C2X 41.4
DEFINE C2Y 59.30

# Definitions to make script more readable
DEFINE YADJ 200 # Adjustment of Y coordinate required to get to centre of angled rectangle
DEFINE XADJ 201 # Adjustment of X coordinate required to get to centre of angled rectangle

# Calculations requried to calulate X and Y adjustments

@200 = RADIUS / 2
@201 = 1.732 * @200


ACTION MAIN

    @401 = 0 # 0 for arenas, 1 for zones

    INVOKE(YMAZE_ARENAS,1)
    @401 = 1
    INVOKE(YMAZE_ARENAS,1)

COMPLETE


ACTION YMAZE_ARENAS

    ClearDrawing()

    @301 = C1X #x for 1st Y in upper row of plate
    @302 = C1Y #y for 1st Y in upper row of plate

    @303 = C2X #x for 1st X in lower row of plate, i.e. 3rd Y in plate
    @304 = C2Y #y for 1st Y in lower row of plate, i.e. 3rd Y in plate

    @90 = 1

    @301 =  C1X #x for 1st in plate
    @303 =  C2X #x for 2nd in plate

    #   FIRST Pair of Y MAZE
    #    ZONE 1 ARM TO LEFT AT 30 DEGREES

    while @90 < 3

        if @401 = 0
            Set(DrawArena,@90)
        endif
        if @401 = 1
            Set(DrawZone,1)
        endif

        ShapeType(RECTANGLE,RECTANGLE_LENGTH,RECTANGLE_WIDTH)
        ShapeAngle(30.0)
        ShapeDraw(@301 - @XADJ,@302 - @YADJ)
        SaveDrawing("temp")
        WAIT(SHOWTIME)

        if @401 = 0
            Set(DrawArena,@90)
        endif
        if @401 = 1
            Set(DrawZone,2)
        endif

        ShapeType(RECTANGLE,RECTANGLE_LENGTH,RECTANGLE_WIDTH)
        ShapeAngle(150.0)
        ShapeDraw(@301 + @XADJ,@302 - @YADJ)
        SaveDrawing("temp")
        WAIT(SHOWTIME)

        if @401 = 0
            Set(DrawArena,@90)
        endif
        if @401 = 1
            Set(DrawZone,3)
        endif

        ShapeType(RECTANGLE,RECTANGLE_LENGTH,RECTANGLE_WIDTH)
        ShapeAngle(270.0)
        ShapeDraw(@301,@302 + RADIUS)
        SaveDrawing("temp")
        WAIT(SHOWTIME)

        if @401 = 0
            Set(DrawArena,@90)
        endif
        if @401 = 1
            Set(DrawZone,4)
        endif

        ShapeType(TRIANGLE,RECTANGLE_WIDTH)
        ShapeAngle(0.0)
        ShapeDraw(@301,@302)
        SaveDrawing("temp")
        WAIT(SHOWTIME)

        @400 = @400 + 1
        @301 = @301 + 56
        @90 = @90 + 1

    endwhile

    while @90 < 5


    #   SECOND Y MAZE
    #    ZONE 1 ARM UP

        if @401 = 0
            Set(DrawArena,@90)
        endif
        if @401 = 1
            Set(DrawZone,1)
        endif

        ShapeType(RECTANGLE,RECTANGLE_WIDTH,RECTANGLE_LENGTH)
        ShapeAngle(0.0)
        ShapeDraw(@303,@304 - RADIUS)
        SaveDrawing("temp")
        WAIT(SHOWTIME)

        if @401 = 0
            Set(DrawArena,@90)
        endif
        if @401 = 1
            Set(DrawZone,2)
        endif

        ShapeType(RECTANGLE,RECTANGLE_LENGTH,RECTANGLE_WIDTH)
        ShapeAngle(30.0)
        ShapeDraw(@303 + @XADJ,@304 + @YADJ)
        SaveDrawing("temp")
        WAIT(SHOWTIME)

        if @401 = 0
            Set(DrawArena,@90)
        endif
        if @401 = 1
            Set(DrawZone,3)
        endif

        ShapeType(RECTANGLE,RECTANGLE_LENGTH,RECTANGLE_WIDTH)
        ShapeAngle(150.0)
        ShapeDraw(@303 - @XADJ,@304 + @YADJ)
        SaveDrawing("temp")
        WAIT(SHOWTIME)

        if @401 = 0
            Set(DrawArena,@90)
        endif
        if @401 = 1
            Set(DrawZone,4)
        endif

        ShapeType(TRIANGLE,RECTANGLE_WIDTH)
        ShapeAngle(180.0)
        ShapeDraw(@303,@304)
        SaveDrawing("temp")
        WAIT(SHOWTIME)

        @400 = @400 + 1
        @303 = @303 + 56
        @90 = @90 + 1

    endwhile

    if @401 = 0
        SaveDrawing("ymaze_4_arenas") # Save output
    endif
    if @401 = 1
        SaveDrawing("ymaze_4_zones") # Save output
    endif

COMPLETE

# vim: ft=zanscript
