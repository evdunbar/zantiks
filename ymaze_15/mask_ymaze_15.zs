# constants
DEFINE NUM_ROWS 3
DEFINE NUM_COLS 5

DEFINE X_OFFSET 16.6
DEFINE Y_OFFSET 12.5
DEFINE X_STEP 23.74
DEFINE Y_STEP 27.6

DEFINE MAZE_RADIUS 5.4
DEFINE END_OF_ARM_RADIUS 2.3
DEFINE RECTANGLE_LENGTH 9
DEFINE RECTANGLE_WIDTH 3.5
DEFINE UPSIDE_DOWN_OFFSET 4.3

DEFINE PAUSE_SECONDS 0.1


# variables
DEFINE doing_zones 401

DEFINE current_arena 90
DEFINE my_current_zone 91
DEFINE current_row 95
DEFINE current_col 96

DEFINE x 301
DEFINE y 302
DEFINE x_adjustment 200
DEFINE y_adjustment 201

DEFINE is_odd_col 500


# calulate X and Y adjustments
@y_adjustment = MAZE_RADIUS / 2
@x_adjustment = 1.732 * @y_adjustment


ACTION MAIN

    @doing_zones = FALSE # 0 for arenas, 1 for zones
    INVOKE(DRAW_YMAZE, 1)
    @doing_zones = TRUE
    INVOKE(DRAW_YMAZE, 1)

COMPLETE


ACTION DRAW_YMAZE

    ClearDrawing()
    @current_arena = 1

    @y = Y_OFFSET

    @current_row = 1
    WHILE @current_row <= NUM_ROWS

        @x = X_OFFSET

        @current_col = 1
        WHILE @current_col <= NUM_COLS

            INVOKE(SET_IS_ODD_COL)
            @my_current_zone = 1
            WHILE @my_current_zone <= 4

                IF @doing_zones = TRUE
                    Set(DrawZone, @my_current_zone)
                ELSE
                    Set(DrawArena, @current_arena)
                ENDIF

                IF @is_odd_col = TRUE # Y shape
                    IF @my_current_zone < 4 # arms
                        # rectangle part of arm
                        ShapeType(RECTANGLE, RECTANGLE_LENGTH, RECTANGLE_WIDTH)
                        IF @my_current_zone = 1
                            ShapeAngle(30.0)
                            ShapeDraw(@x - @x_adjustment, @y - @y_adjustment)
                        ELSEIF @my_current_zone = 2
                            ShapeAngle(150.0)
                            ShapeDraw(@x + @x_adjustment, @y - @y_adjustment)
                        ELSE
                            ShapeAngle(270.0)
                            ShapeDraw(@x, @y + MAZE_RADIUS)
                        ENDIF

                        # circle at end of arms
                        ShapeType(DISC, END_OF_ARM_RADIUS)
                        IF @my_current_zone = 1
                            ShapeDraw(@x - @x_adjustment - @x_adjustment, @y - @y_adjustment - @y_adjustment)
                        ELSEIF @my_current_zone = 2
                            ShapeDraw(@x + @x_adjustment + @x_adjustment, @y - @y_adjustment - @y_adjustment)
                        ELSE
                            ShapeDraw(@x, @y + MAZE_RADIUS + MAZE_RADIUS)
                        ENDIF
                    ELSEIF @my_current_zone = 4 # center
                        ShapeType(TRIANGLE, RECTANGLE_WIDTH)
                        ShapeAngle(0.0)
                        ShapeDraw(@x, @y)
                    ENDIF
                ELSE # _|_ shape
                    IF @my_current_zone < 4 # arms
                        # rectangle part of arm
                        ShapeType(RECTANGLE, RECTANGLE_LENGTH, RECTANGLE_WIDTH)
                        IF @my_current_zone = 1
                            ShapeAngle(90.0)
                            ShapeDraw(@x, @y - MAZE_RADIUS + UPSIDE_DOWN_OFFSET)
                        ELSEIF @my_current_zone = 2
                            ShapeAngle(30.0)
                            ShapeDraw(@x + @x_adjustment, @y + @y_adjustment + UPSIDE_DOWN_OFFSET)
                        ELSE
                            ShapeAngle(150.0)
                            ShapeDraw(@x - @x_adjustment, @y + @y_adjustment + UPSIDE_DOWN_OFFSET)
                        ENDIF

                        # circle at end of arms
                        ShapeType(DISC, END_OF_ARM_RADIUS)
                        IF @my_current_zone = 1
                            ShapeDraw(@x, @y - MAZE_RADIUS - MAZE_RADIUS + UPSIDE_DOWN_OFFSET)
                        ELSEIF @my_current_zone = 2
                            ShapeDraw(@x + @x_adjustment + @x_adjustment, @y + @y_adjustment + @y_adjustment + UPSIDE_DOWN_OFFSET)
                        ELSE
                            ShapeDraw(@x - @x_adjustment - @x_adjustment, @y + @y_adjustment + @y_adjustment + UPSIDE_DOWN_OFFSET)
                        ENDIF
                    ELSEIF @my_current_zone = 4 # center
                        ShapeType(TRIANGLE, RECTANGLE_WIDTH)
                        ShapeAngle(180.0)
                        ShapeDraw(@x, @y + UPSIDE_DOWN_OFFSET)
                    ENDIF
                ENDIF

                SaveDrawing("temp")
                WAIT(PAUSE_SECONDS)

                @my_current_zone = @my_current_zone + 1

            ENDWHILE

            @x = @x + X_STEP
            @current_arena = @current_arena + 1
            @current_col = @current_col + 1

        ENDWHILE

        @y = @y + Y_STEP
        @current_row = @current_row + 1

    ENDWHILE

    IF @doing_zones = TRUE
        SaveDrawing("y15_mask_zones")
    ELSE
        SaveDrawing("y15_mask_arenas")
    ENDIF

COMPLETE

ACTION SET_IS_ODD_COL

    IF @current_col = 1
        @is_odd_col = TRUE
    ELSEIF @current_col = 2
        @is_odd_col = FALSE
    ELSEIF @current_col = 3
        @is_odd_col = TRUE
    ELSEIF @current_col = 4
        @is_odd_col = FALSE
    ELSEIF @current_col = 5
        @is_odd_col = TRUE
    ENDIF

COMPLETE

# vim: ft=zanscript
