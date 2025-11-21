# constants
DEFINE NUM_ROWS 2
DEFINE NUM_COLS 2

DEFINE ROW_1_X 29.5
DEFINE ROW_1_Y 26.5
DEFINE ROW_2_X 41.4
DEFINE ROW_2_Y 59.30

DEFINE MAZE_RADIUS 14.809
DEFINE RECTANGLE_LENGTH 25
DEFINE RECTANGLE_WIDTH 8
DEFINE COL_DELTA 56

DEFINE PAUSE_SECONDS 0.1


# variable definitions
DEFINE doing_zones 401

DEFINE current_arena 90
DEFINE my_current_zone 91
DEFINE current_row 95
DEFINE current_col 96

DEFINE x 301
DEFINE y 302
DEFINE x_adjustment 200
DEFINE y_adjustment 201


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

    @current_row = 1
    while @current_row <= NUM_ROWS

        # starting points for each row
        if @current_row = 1
            @x = ROW_1_X
            @y = ROW_1_Y
        elseif @current_row = 2
            @x = ROW_2_X
            @y = ROW_2_Y
        endif

        @current_col = 1
        while @current_col <= NUM_COLS

            @my_current_zone = 1
            while @my_current_zone <= 4

                if @doing_zones = TRUE
                    Set(DrawZone, @my_current_zone)
                else
                    Set(DrawArena, @current_arena)
                endif

                if @current_row = 1
                    if @my_current_zone < 4 # arms
                        ShapeType(RECTANGLE, RECTANGLE_LENGTH, RECTANGLE_WIDTH)
                        if @my_current_zone = 1
                            ShapeAngle(30.0)
                            ShapeDraw(@x - @x_adjustment, @y - @y_adjustment)
                        elseif @my_current_zone = 2
                            ShapeAngle(150.0)
                            ShapeDraw(@x + @x_adjustment, @y - @y_adjustment)
                        else
                            ShapeAngle(270.0)
                            ShapeDraw(@x, @y + MAZE_RADIUS)
                        endif
                    elseif @my_current_zone = 4 # center
                        ShapeType(TRIANGLE, RECTANGLE_WIDTH)
                        ShapeAngle(0.0)
                        ShapeDraw(@x, @y)
                    endif
                else
                    if @my_current_zone < 4 # arms
                        ShapeType(RECTANGLE, RECTANGLE_LENGTH, RECTANGLE_WIDTH)
                        if @my_current_zone = 1
                            ShapeAngle(90.0)
                            ShapeDraw(@x, @y - MAZE_RADIUS)
                        elseif @my_current_zone = 2
                            ShapeAngle(30.0)
                            ShapeDraw(@x + @x_adjustment, @y + @y_adjustment)
                        else
                            ShapeAngle(150.0)
                            ShapeDraw(@x - @x_adjustment, @y + @y_adjustment)
                        endif
                    elseif @my_current_zone = 4 # center
                        ShapeType(TRIANGLE, RECTANGLE_WIDTH)
                        ShapeAngle(180.0)
                        ShapeDraw(@x, @y)
                    endif
                endif

                SaveDrawing("temp")
                WAIT(PAUSE_SECONDS)

                @my_current_zone = @my_current_zone + 1

            endwhile

            @x = @x + COL_DELTA
            @current_arena = @current_arena + 1
            @current_col = @current_col + 1

        endwhile

        @current_row = @current_row + 1

    endwhile

    if @doing_zones = TRUE
        SaveDrawing("y4z_r2")
    else
        SaveDrawing("y4a_r2")
    endif

COMPLETE

# vim: ft=zanscript
