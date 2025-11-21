# define experiment time in seconds
DEFINE bin_length 60 # 1 minute
DEFINE num_bins 60   # 60 minutes total experiment time

# variables
DEFINE current_bin 200

# animal model tracking requirements (dependent on animal size)
SET(TARGET_SIZE, 2)
SET(DETECTOR_THRESHOLD, 5)

# define auto reference tracking requirements
SET(AUTOREF_MODE, MOVEMENT)
SET(AUTOREF_TIMEOUT, 10)

# no tracking marker
TARGETMARKER(0, 0, 0)

# heatmap generation
DEFINE MAKEMAP 5682
DEFINE COLOURMAP 5683
DEFINE SUMSIZE 20
SET(COLOURMAP, 1) # berkeley inferno

# settings for drawing track traces behind animals
DEFINE X_LOGDATA_TRACKS 799 # development setting: log track lengths (total)
# DEFINE X_DRAWTRACKS 30011   # development setting: enable track drawing

# Loads arena and detector assets
LOAD(ARENAS, "ymaze_15_arenas.bmp")
LOAD(ZONES, "ymaze_15_zones.bmp")

# Set up position tracking
LOGFILE(2, "xy_position")
SET(LOG_STREAM_PERFRAME, 2)
LOGCREATE("RUNTIME|RAW_XY:A1-15")


ACTION MAIN

    # Set up column names for the processed data file.
    # 4 zones = 3 arms plus middle zone
    # Generates bin data as a separate data file 
    LOGFILE(1, "binned_data")
    SET(LOG_STREAM, 1)
    LOGCREATE("TEXT:TIME|TEXT:BIN_NUM|TEXT:ENDPOINT")
    LOGAPPEND("TEXT:A1_Z1|TEXT:A1_Z2|TEXT:A1_Z3|TEXT:A1_Z4")
    LOGAPPEND("TEXT:A2_Z1|TEXT:A2_Z2|TEXT:A2_Z3|TEXT:A2_Z4")
    LOGAPPEND("TEXT:A3_Z1|TEXT:A3_Z2|TEXT:A3_Z3|TEXT:A3_Z4")
    LOGAPPEND("TEXT:A4_Z1|TEXT:A4_Z2|TEXT:A4_Z3|TEXT:A4_Z4")
    LOGAPPEND("TEXT:A5_Z1|TEXT:A5_Z2|TEXT:A5_Z3|TEXT:A5_Z4")
    LOGAPPEND("TEXT:A6_Z1|TEXT:A6_Z2|TEXT:A6_Z3|TEXT:A6_Z4")
    LOGAPPEND("TEXT:A7_Z1|TEXT:A7_Z2|TEXT:A7_Z3|TEXT:A7_Z4")
    LOGAPPEND("TEXT:A8_Z1|TEXT:A8_Z2|TEXT:A8_Z3|TEXT:A8_Z4")
    LOGAPPEND("TEXT:A9_Z1|TEXT:A9_Z2|TEXT:A9_Z3|TEXT:A9_Z4")
    LOGAPPEND("TEXT:A10_Z1|TEXT:A10_Z2|TEXT:A10_Z3|TEXT:A10_Z4")
    LOGAPPEND("TEXT:A11_Z1|TEXT:A11_Z2|TEXT:A11_Z3|TEXT:A11_Z4")
    LOGAPPEND("TEXT:A12_Z1|TEXT:A12_Z2|TEXT:A12_Z3|TEXT:A12_Z4")
    LOGAPPEND("TEXT:A13_Z1|TEXT:A13_Z2|TEXT:A13_Z3|TEXT:A13_Z4")
    LOGAPPEND("TEXT:A14_Z1|TEXT:A14_Z2|TEXT:A14_Z3|TEXT:A14_Z4")
    LOGAPPEND("TEXT:A15_Z1|TEXT:A15_Z2|TEXT:A15_Z3|TEXT:A15_Z4")
    LOGRUN()

    # Generate column headings for arm changes data
    # Tells the system that we are referring to the arm changes data file for the following lines of code
    SET(LOG_STREAM, 0)
	LOGCREATE("TEXT:TIME|TEXT:|TEXT:")
	LOGAPPEND("TEXT:ARENA|TEXT:ACTION|TEXT:ZONE")
	LOGRUN()

	LIGHTS(ALL, OFF)                                                                                
    AUTOREFERENCE()    
    SET(LOG_PERFRAME, ON)
	# SET(X_DRAWTRACKS, 1)
	VIDEO(99999999999, "ymaze_tracking")

	INVOKE(YMAZE, num_bins)

    SET(LOG_PERFRAME, OFF)
    VIDEOSTOP()
    SET(MAKEMAP, SUMSIZE)

COMPLETE


ACTION YMAZE

	@current_bin = @current_bin + 1

	LOGDATA(DATA_SNAPSHOT, "BEGIN")
	LOAD(ZONECHANGES, "ON")      # records every zone change into log stream 0 

	WAIT(bin_length)                                    

	LOGDATA(DATA_SNAPSHOT, "END")         
	LOGDATA(DATA_SELECT, "BEGIN")                                                                
	LOGDATA(DATA_DELTA, "END")                       

	INVOKE(WRITE_DATA, 1)

COMPLETE


# The following action writes the processed data to a separate data file 
ACTION WRITE_DATA

	SET(LOG_STREAM, 1)
	LOGCREATE("RUNTIME|@200|TEXT:TOTAL_DISTANCE_IN_ZONE|ZONE_DISTANCES:A* Z1-4")            
	LOGRUN()

	LOGCREATE("RUNTIME|@200|TEXT:TOTAL_ENTRIES_IN_ZONE|ZONE_COUNTERS:A* Z1-4")                  
	LOGRUN()   

	LOGCREATE("RUNTIME|@200|TEXT:TOTAL_TIME_SPENT_IN_ZONE|ZONE_TIMERS:A* Z1-4")                  
	LOGRUN()

	SET(LOG_STREAM, 0)

COMPLETE

# vim: ft=zanscript
