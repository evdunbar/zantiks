# Generate arenas, zone assets for the MWP social bioassay plate. Dimensions are in mm 
# These assets can be found in your assets directory after running the script as a .bmp file

DEFINE SHOWTIME 3
DEFINE DRAWDELAY 0.5

# Geometric definition for plate
define X_OFFSET 9.5   		# Adjusts horizontal plane 
define Y_OFFSET 42.5 	# Adjusts vertical plane 
define COL_STEP 12.0		# Spacing between wells, X
define ROW_STEP 36.55 #12	# Spacing between wells, Y

DEFINE W 9.4
DEFINE HT 57.5

@99 = HT / 5  #selects the number of zones you want the total arena length divided into  

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
    @200 = 0					# Select arenas mode 

    invoke(GS_DRAW,1)			# Generate arenas
    
    SaveDrawing("aSocial")		# Save result to disk
    
COMPLETE


# Generate zones per well (central/outer)
ACTION GSZ

	ResetDrawing()				# Restore everything to default (ClearDrawing just clears the image)

    invoke(GS_Z,1)				# Generate zones

    SaveDrawing("zSocial")		# Save result to disk
    
COMPLETE


# Generate 24-well arenas/zones (NUNC). Uses @200 to select between arenas mode (if 0)
# and zones mode (in which case the variable contains the zone number).
ACTION GS_DRAW

	@102 = 0					# Row counter
	@101 = Y_OFFSET			# Y position
	@110 = 1					# Arena
    
	while @102 < 1				# While more rows to do...
		@103 = 0				# Column
		@100 = X_OFFSET		# X Position

		while @103 < 10				# While more columns to do....

            if @200 = 0				# Arena (0) or zones mode?				
                Set(DrawArena,@110)	# Arena
                ShapeType(RECTANGLE,W,HT)

            else

                Set(DrawZone,@200)	# Zone

			endif

			ShapeDraw(@100,@101)	# Put shape at current position
			SaveDrawing("TEMP")	   	# Save result to disk
            WAIT(DRAWDELAY)
            @100 = @100 + COL_STEP	# Update X 
			@103 = @103 + 1			# Update Column
			@110 = @110 + 1			# Update arena counter
		endwhile	# ...columns

		@101 = @101 + ROW_STEP	# Update Y position
		@102 = @102 + 1			# Update row number

		if @200 > 0.5        
            @200 = @200 + 1

        endif 


	endwhile

COMPLETE


ACTION GS_Z

	@200 = 1					# Select zones mode
	@102 = 0					# Row counter
	@101 = Y_OFFSET  + ROW_STEP	# Y position
	@110 = 1					# Arena

	while @102 < 5				# While more rows to do...
		@103 = 0				# Column
		@100 = X_OFFSET			# X Position

		while @103 < 10				# While more columns to do....

            Set(DrawZone,@200)       
            ShapeType(RECTANGLE,W,@99)

            if @200 = 1
                @101 = Y_OFFSET - @99 - @99
            endif

            if @200 = 2
                @101 = Y_OFFSET - @99
            endif

            if @200 = 3
                @101 = Y_OFFSET
            endif

            if @200 = 4
                @101 = Y_OFFSET + @99
            endif

            if @200 = 5
                @101 = Y_OFFSET + @99 + @99
            endif

            ShapeDraw(@100,@101)	# Put shape at current position
            SaveDrawing("TEMP")	   	# Save result to disk
            WAIT(DRAWDELAY)
            @100 = @100 + COL_STEP	# Update X 
            @103 = @103 + 1			# Update Column
            @110 = @110 + 1			# Update arena counter

		endwhile	# ...columns

	@101 = @101 + ROW_STEP	# Update Y position
	@102 = @102 + 1			# Update row number
	@200 = @200 + 1

	endwhile

COMPLETE

# vim: ft=zanscript
