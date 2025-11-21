# Generate arenas, zone assets for the MWP mirror biting bioassay plate. Dimensions are in mm
# These assets can be found in your assets directory after running the script as a .bmp file
# This script will create two zones, Each arena is split equally in half. Zone one is the half with the mirror
# Zone 2 is the half without the mirror (i.e. control end).

DEFINE SHOWTIME 3
DEFINE DRAWDELAY 0.5

# Geometric definition for plate
DEFINE X_OFFSET 10	# x coordinate of centre of first well
DEFINE Y_OFFSET 24 	# y coordinate of centre of first well

DEFINE COL_STEP 12		# Spacing between wells, X
DEFINE ROW_STEP 38.25	# Spacing between wells, Y

DEFINE W 10		# Width of arena
DEFINE HT 35.5	# Height of arena

DEFINE zone_height 99
DEFINE zone_offset 98
@zone_height = HT / 3  	# Selects the number of zones you want the total arena length divided into
@zone_offset = @zone_height / 2 	# Defines the zone offset for two zones

# Variable names
DEFINE arena 110
DEFINE col 103
DEFINE arena_zone_index 200 
DEFINE x_position 100


# Generate arena and zone files
ACTION MAIN

    INVOKE(GS,1)		# Generate arena/zone files (repeatedly, for display)

COMPLETE


# Generate arena and zone files cont.
ACTION GS

	Invoke(GSA,1)		# Draw arenas
    wait(SHOWTIME)		# Delay for (auto) display of asset

	Invoke(GSZ,1)		# Draw zones
    wait(SHOWTIME)		# Delay for (auto) display of asset

COMPLETE


# Generate arenas
ACTION GSA

	ResetDrawing()				# Restore everything to default (ClearDrawing just clears the image)
    @arena_zone_index = 0					# Select arenas mode

    invoke(GS_DRAW,1)			# Generate arenas

    SaveDrawing("aMirror")		# Save result to disk

COMPLETE


# Generate zones per well (central/outer)
ACTION GSZ

	ResetDrawing()				# Restore everything to default (ClearDrawing just clears the image)

    invoke(GS_Z,1)				# Generate zones

    SaveDrawing("zMirror")		# Save result to disk

COMPLETE


# Generate 24-well arenas/zones (NUNC). Uses @arena_zone_index to select between arenas mode (if 0)
# and zones mode (in which case the variable contains the zone number).
ACTION GS_DRAW

	@102 = 0					# Row counter
	@101 = Y_OFFSET			# Y position
	@arena = 1					# Arena

	while @102 < 2				# While more rows to do...
		@col = 0				# Column
		@x_position = X_OFFSET		# X Position

		while @col < 10				# While more columns to do....

            if @arena_zone_index = 0				# Arena (0) or zones mode?
            Set(DrawArena,@arena)	# Arena
            ShapeType(RECTANGLE,W,HT)

            else

            Set(DrawZone,@arena_zone_index)	# Zone

			endif

			ShapeDraw(@x_position,@101)	# Put shape at current position
			SaveDrawing("TEMP")	   	# Save result to disk
            WAIT(DRAWDELAY)
            @x_position = @x_position + COL_STEP	# Update X
			@col = @col + 1			# Update Column
			@arena = @arena + 1			# Update arena counter
		endwhile	# ...columns

		@101 = @101 + ROW_STEP	# Update Y position
		@102 = @102 + 1			# Update row number



		if @arena_zone_index > 0.5
        @arena_zone_index = @arena_zone_index + 1

        endif


	endwhile

COMPLETE


ACTION GS_Z

	@arena_zone_index = 1	# Select zones mode
	@102 = 0				# Row counter
	@arena = 1				# Arena


	@col = 0				# Column
	@x_position = X_OFFSET	# X Position

    while @arena_zone_index < 4

		while @col < 10				# While more columns to do....

        Set(DrawZone,@arena_zone_index)
        ShapeType(RECTANGLE,W,@zone_height)

        if @arena_zone_index = 1
        	@101 = Y_OFFSET - @zone_offset
        endif

        if @arena_zone_index = 2
        	@101 = Y_OFFSET
        endif

        if @arena_zone_index = 3
            @101 = Y_OFFSET + @zone_offset
        endif

		ShapeDraw(@x_position,@101)	# Put shape at current position
		SaveDrawing("TEMP")	   	# Save result to disk
        WAIT(DRAWDELAY)
        @x_position = @x_position + COL_STEP	# Update X
		@col = @col + 1			# Update Column
		@arena = @arena + 1			# Update arena counter

		endwhile				# ...columns

    @col = 0
    @arena_zone_index = @arena_zone_index + 1
    @x_position = X_OFFSET

    endwhile

    @arena_zone_index = 1
	@col = 0				# Column
	@x_position = X_OFFSET			# X Position

    while @arena_zone_index < 3

		while @col < 10		# While more columns to do....

        Set(DrawZone,@arena_zone_index)
        ShapeType(RECTANGLE,W,@zone_height)

        if @arena_zone_index = 1
        	@101 = Y_OFFSET - @zone_offset
        endif

        if @arena_zone_index = 2
        	@101 = Y_OFFSET
        endif

        if @arena_zone_index = 3
            @101 = Y_OFFSET + @zone_offset
        endif

		ShapeDraw(@x_position,@101)	# Put shape at current position
		SaveDrawing("TEMP")	   	# Save result to disk
        WAIT(DRAWDELAY)
        @x_position = @x_position + COL_STEP	# Update X
		@col = @col + 1			# Update Column
		@arena = @arena + 1			# Update arena counter

		endwhile	# ...columns

    @col = 0
    @arena_zone_index = @arena_zone_index + 1
    @x_position = X_OFFSET

    endwhile

COMPLETE

# vim: ft=zanscript
