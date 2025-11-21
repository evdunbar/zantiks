# builds assets for 15 YMaze plate 

define SHOWTIME 0.1

DEFINE X_VIDEOSTILL 30014
define X_SECTOR_ANGLE 30015 # Dev. implementation: set sector angle when drawing disks

# Geometric definition for plate
define X_OFFSET 16.6        # to centre of X
define Y_OFFSET 11.25       # to centre of Y
define X_STEP 23.74            # Spacing between Ys, X
define Y_STEP 28.195        # Spacing between Ys, Y
define END_RADIUS 2.5        # Radius of end of Y
define CENTRE_T    3
DEFINE HEIGHT_VRECT    13
DEFINE WIDTH_VRECT    4
DEFINE HEIGHT_HRECT    9
DEFINE WIDTH_HRECT    12
DEFINE WITHIN_X    9.5
DEFINE WITHIN_Y_SHORT 5
DEFINE WITHIN_Y_LONG 12


DEFINE ENDX    100
DEFINE ENDY 101
DEFINE ARENA_NUM 102
DEFINE X_PLACE 103
DEFINE Y_PLACE 104
DEFINE ARENASorZONES 105


ACTION MAIN
#    LOAD(X_VIDEOSTILL,"captureYmazedot10")

    set(5679,1)                    # Beta: Enable geometrics
    Set(DrawOrigin,TopLeft)        # Set our origin
    Set(DrawUnits,MM)            # Set drawing units
    @ARENASorZONES = 1            # 1 for Arenas
    INVOKE(DRAW15,1)
    wait(3)
    @ARENASorZONES = 0            # 1 for Arenas
    INVOKE(DRAW15,1)
    
COMPLETE


ACTION TESTZ

    set(DRAWZONE,1)
    ShapeType(RECTANGLE,WIDTH_VRECT,HEIGHT_VRECT)
    ShapeDraw(X_OFFSET - 2,Y_OFFSET + 2.5)

    set(DRAWZONE,2)
    ShapeType(RECTANGLE,WIDTH_HRECT,HEIGHT_HRECT)
    ShapeDraw(X_OFFSET,Y_OFFSET - 7)

    set(DRAWZONE,3)
    ShapeType(RECTANGLE,WIDTH_HRECT,HEIGHT_HRECT)
    ShapeDraw(X_OFFSET - WIDTH_HRECT,Y_OFFSET -7)

    set(DRAWZONE,4)
    ShapeType(DISC,CENTRE_T)
    ShapeDraw(X_OFFSET,Y_OFFSET)

    SaveDrawing("ymaze_15_zones")
    wait(showtime)

COMPLETE


ACTION DRAW15

    @ARENA_NUM = 1 #arena number
    @X_PLACE = X_OFFSET
    @Y_PLACE = Y_OFFSET
    INVOKE(A_DRAW_UP,1)

    @ARENA_NUM = 2 #arena number
    @X_PLACE = X_OFFSET + X_STEP
    @Y_PLACE = Y_OFFSET
    INVOKE(A_DRAW_DOWN,1)

    @ARENA_NUM = 3 #arena number
    @X_PLACE = X_OFFSET + X_STEP + X_STEP
    @Y_PLACE = Y_OFFSET
    INVOKE(A_DRAW_UP,1)

    @ARENA_NUM = 4 #arena number
    @X_PLACE = X_OFFSET + X_STEP + X_STEP + X_STEP
    @Y_PLACE = Y_OFFSET
    INVOKE(A_DRAW_DOWN,1)

    @ARENA_NUM = 5 #arena number
    @X_PLACE = X_OFFSET + X_STEP + X_STEP + X_STEP + X_STEP
    @Y_PLACE = Y_OFFSET
    INVOKE(A_DRAW_UP,1)

    @ARENA_NUM = 6 #arena number
    @X_PLACE = X_OFFSET
    @Y_PLACE = Y_OFFSET + Y_STEP
    INVOKE(A_DRAW_UP,1)

    @ARENA_NUM = 7 #arena number
    @X_PLACE = X_OFFSET + X_STEP
    @Y_PLACE = Y_OFFSET + Y_STEP
    INVOKE(A_DRAW_DOWN,1)

    @ARENA_NUM = 8 #arena number
    @X_PLACE = X_OFFSET + X_STEP + X_STEP
    @Y_PLACE = Y_OFFSET + Y_STEP
    INVOKE(A_DRAW_UP,1)

    @ARENA_NUM = 9 #arena number
    @X_PLACE = X_OFFSET + X_STEP + X_STEP + X_STEP
    @Y_PLACE = Y_OFFSET + Y_STEP
    INVOKE(A_DRAW_DOWN,1)

    @ARENA_NUM = 10 #arena number
    @X_PLACE = X_OFFSET + X_STEP + X_STEP + X_STEP + X_STEP
    @Y_PLACE = Y_OFFSET + Y_STEP
    INVOKE(A_DRAW_UP,1)

    @ARENA_NUM = 11 #arena number
    @X_PLACE = X_OFFSET
    @Y_PLACE = Y_OFFSET + Y_STEP + Y_STEP
    INVOKE(A_DRAW_UP,1)

    @ARENA_NUM = 12 #arena number
    @X_PLACE = X_OFFSET + X_STEP
    @Y_PLACE = Y_OFFSET + Y_STEP + Y_STEP
    INVOKE(A_DRAW_DOWN,1)

    @ARENA_NUM = 13 #arena number
    @X_PLACE = X_OFFSET + X_STEP + X_STEP
    @Y_PLACE = Y_OFFSET + Y_STEP + Y_STEP
    INVOKE(A_DRAW_UP,1)

    @ARENA_NUM = 14 #arena number
    @X_PLACE = X_OFFSET + X_STEP + X_STEP + X_STEP
    @Y_PLACE = Y_OFFSET + Y_STEP + Y_STEP
    INVOKE(A_DRAW_DOWN,1)

    @ARENA_NUM = 15 #arena number
    @X_PLACE = X_OFFSET + X_STEP + X_STEP + X_STEP + X_STEP
    @Y_PLACE = Y_OFFSET + Y_STEP + Y_STEP
    INVOKE(A_DRAW_UP,1)

COMPLETE


ACTION A_DRAW_UP

    if     @ARENASorZONES = 1            # 1 for Arenas
    set(DRAWARENA,@ARENA_NUM)
    endif

    if     @ARENASorZONES = 0            # 0 for zones
    set(DRAWZONE,1)
    endif
    
    ShapeType(RECTANGLE,WIDTH_VRECT,HEIGHT_VRECT)
    ShapeDraw(@X_PLACE - 2,@Y_PLACE + 1.28)

    if     @ARENASorZONES = 0            # 0 for zones
    set(DRAWZONE,3)
    endif


    ShapeType(RECTANGLE,WIDTH_HRECT,HEIGHT_HRECT)
    ShapeDraw(@X_PLACE,@Y_PLACE - HEIGHT_HRECT +1.28)

    if     @ARENASorZONES = 0            # 0 for zones
    set(DRAWZONE,2)
    endif


    ShapeType(RECTANGLE,WIDTH_HRECT,HEIGHT_HRECT)
    ShapeDraw(@X_PLACE - WIDTH_HRECT,@Y_PLACE - HEIGHT_HRECT +1.28)

    if     @ARENASorZONES = 0            # 0 for zones
    set(DRAWZONE,4)
    endif


    ShapeType(DISC,CENTRE_T)
    ShapeDraw(@X_PLACE,@Y_PLACE)

    if     @ARENASorZONES = 1            # 1 for Arenas
    SaveDrawing("ymaze_15_arenas")
    wait(showtime)
    endif

    if     @ARENASorZONES = 0            # 0 for zones
    SaveDrawing("ymaze_15_zones")
    wait(showtime)
    endif

    SaveDrawing("ymaze_15_zones")

COMPLETE


ACTION A_DRAW_DOWN

    if     @ARENASorZONES = 1            # 1 for Arenas
    set(DRAWARENA,@ARENA_NUM)
    endif

    if     @ARENASorZONES = 0            # 0 for zones
    set(DRAWZONE,1)
    endif

    ShapeType(RECTANGLE,WIDTH_VRECT,HEIGHT_VRECT)
    ShapeDraw(@X_PLACE - 2,@Y_PLACE - 8)

    if     @ARENASorZONES = 0            # 0 for zones
    set(DRAWZONE,2)
    endif
    

    ShapeType(RECTANGLE,WIDTH_HRECT,HEIGHT_HRECT)
    ShapeDraw(@X_PLACE,@Y_PLACE +5)

    if     @ARENASorZONES = 0            # 0 for zones
    set(DRAWZONE,3)
    endif


    ShapeType(RECTANGLE,WIDTH_HRECT,HEIGHT_HRECT)
    ShapeDraw(@X_PLACE - WIDTH_HRECT,@Y_PLACE +5)

    if     @ARENASorZONES = 0            # 0 for zones
    set(DRAWZONE,4)
    endif

    ShapeType(DISC,CENTRE_T)
    ShapeDraw(@X_PLACE,@Y_PLACE+6)

    if     @ARENASorZONES = 1            # 1 for Arenas
    SaveDrawing("ymaze_15_arenas")
    wait(showtime)
    endif

    if     @ARENASorZONES = 0            # 0 for zones
    SaveDrawing("ymaze_15_zones")
    wait(showtime)
    endif

COMPLETE

# vim: ft=zanscript
