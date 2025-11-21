# This script generates arenas, and dual zone assets for a 12-well plate. 
# Dimensions are in mm. Assets can be found as .bmp files in assets directory after running the script  
# For this script to work you must have first run the calibration script with your black 96-well calibration plate

DEFINE SHOWTIME 2
DEFINE X_SECTOR_ANGLE 30015 	# required for drawing semi circles

# Geometric definion for 12-well plate
DEFINE X_OFFSET  27.94  	# Moves across horizontal plane 
DEFINE Y_OFFSET  18.79		# Moves vertical plane

DEFINE COL_STEP 24.01		# Spacing between wells, X
DEFINE ROW_STEP 24.01		# Spacing between wells, Y
DEFINE RADIUS 10.4			# Radius of well
DEFINE RADIUS_DZ 8.5		# Radius of inner zone


# Generate arena and zone files
ACTION MAIN

    INVOKE(G12,1)		# Generate arena/zone files
    
COMPLETE


# Generate arena and zone files cont.
ACTION G12

	INVOKE(G12A,1)		# Draw arenas
    WAIT(SHOWTIME)		# Delay for display of asset

	INVOKE(G12DZ,1)		# Draw zones (central/outer)
  	WAIT(SHOWTIME)		# Delay for display of asset
    
    INVOKE(G12LDZ,1)	# Draw zones (upper/lower)
    WAIT(SHOWTIME)		# Delay for display of asset
    
COMPLETE   


# Generate arenas 
ACTION G12A

	ResetDrawing()			# Restore everything to default
	ShapeType(DISC,RADIUS)	# Shape template radius
    @200 = 0				# Select arenas mode
    INVOKE(G12_DRAW,1)		# Generate arenas
    SaveDrawing("a12")		# Save result to disk
    
COMPLETE


# Generate dual zones per well (central/outer)
ACTION G12DZ

	ResetDrawing()				# Restore everything to default
	ShapeType(DISC,RADIUS)	   	# Shape template radius 
    @200 = 1					# Zone 1 (outer)
    INVOKE(G12_DRAW,1)			# Generate zones
	ShapeType(DISC,RADIUS_DZ)   # Shape template radius
    @200 = 2					# Zone 2 (central)
    INVOKE(G12_DRAW,1)			# Generate zones
    SaveDrawing("dz12")			# Save result to disk
    
COMPLETE


# Generate dual zones per well (top/bottom)
ACTION G12LDZ

	ResetDrawing()				# Restore everything to default

	ShapeAngle(0.0)
    @200 = 1					# Zone 1 (bottom)
    SET(X_SECTOR_ANGLE,0.0)		# draws a full circle 
	ShapeType(DISC,RADIUS)	   	# Shape template radius
	INVOKE(G12_DRAW,1)			# Generate zones	

	ShapeAngle(0.0)
    @200 = 2					# Zone 2 (top)
    SET(X_SECTOR_ANGLE,180.0)	# draws a semi-circle
	ShapeType(DISC,RADIUS)	   	# Shape template radius
	INVOKE(G12_DRAW,1)			# Generate zones	

    SaveDrawing("ldz12")		# Save result to disk

COMPLETE


# Generate 12-well arenas/zones.
ACTION G12_DRAW

	@102 = 0					# Row counter
	@101 = Y_OFFSET				# Y position
	@110 = 1					# Arena
	while @102 < 3				# While more rows to do...
		@103 = 0				# Column
		@100 = X_OFFSET			# X Position
		while @103 < 4			# While more columns to do....
        	if @200 = 0			# Arena or zones mode?
				SET(DrawArena,@110)	# Arena
            else
				SET(DrawZone,@200)	# Zone
			endif
			ShapeDraw(@100,@101)	# Put shape at current position
            
            SaveDrawing("TEMP")
            WAIT(0.3)
            
			@100 = @100 + COL_STEP 	# Update X 
			@103 = @103 + 1		# Update Column
			@110 = @110 + 1		# Update arena counter
		endwhile				
		@101 = @101 + ROW_STEP  # Update Y position
		@102 = @102 + 1			# Update row number
	endwhile					
    
COMPLETE

# vim: ft=zanscript
