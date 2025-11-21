# Zanscript y-maze for tracking arm changes of animals over 30 minutes
# Ensure you have the correct assets loaded, the correct tracking settings for you model organism &
# the correct headings for data export (delete accordingly)

# This is a sample script that illustrates how zanscript can be written to run an experiment and deliver some example data. 
# Zantiks Ltd cannot guarantee this is how you want to run your experiments. This script is offered only to demonstrate the
# capabilities of the system and assist you in learning how to script for your research.


# define experiment time in seconds
DEFINE BIN_TIME 5
DEFINE NUM_BINS 6

# animal model tracking requirements (dependent on animal size)
# these settings are for zebrafish larvae, see website for examples of other model organisms
SET(TARGET_SIZE,15)
SET(DETECTOR_THRESHOLD,4)


# define auto reference tracking requirements
SET(AUTOREF_MODE,MOVEMENT)
SET(AUTOREF_TIMEOUT,10)


# settings for drawing track traces behind animals
DEFINE X_LOGDATA_TRACKS 799                  # development setting: log track lengths (total)
DEFINE X_DRAWTRACKS 30011       # development setting: enable track drawing


# Generates totals data as a separate data file 
LOGFILE(1,"data_totals")
# Tells the system that we are referring to the searate data file for the following lines of code
SET(LOG_STREAM,1)

# Set up column names for the processed data file.
# 4 zones = 3 arms plus middle zone
# This is set up for a 15 YMazes, delete headings as appropriate.
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

# Tells the system that we are referring to the arm changes data file for the following lines of code
SET(LOG_STREAM,0)

ACTION MAIN

# Loads arena and detector assets
	LOAD(ARENAS,"ay15.bmp")
	LOAD(ZONES,"zy15.bmp")

# Generate column headings for arm changes data
	LOGCREATE("TEXT:TIME|TEXT:|TEXT:")
	LOGAPPEND("TEXT:ARENA|TEXT:ACTION|TEXT:ZONE")
	LOGRUN()

	LIGHTS(ALL,OFF)                                                                                
	
    AUTOREFERENCE()    

	SET(X_DRAWTRACKS, 1)

	VIDEO(99999999999,"YMaze_tracking")
	VIDEOSKIP(29)

	INVOKE(YMAZE,NUM_BINS)

COMPLETE

 
ACTION YMAZE

	@200 = @200 + 1

	LOGDATA(DATA_SNAPSHOT,"BEGIN")                                                          
	LOAD(ZONECHANGES,"ON")      # records every zone change into log stream 0                                                                                    

	WAIT(BIN_TIME)                                    

	LOGDATA(DATA_SNAPSHOT,"END")         
	LOGDATA(DATA_SELECT,"BEGIN")                                                                
	LOGDATA(DATA_DELTA,"END")                       

	INVOKE(WRITE_DATA,1)

COMPLETE


# The following action writes the processed data to a separate data file 
ACTION WRITE_DATA

	SET(LOG_STREAM,1)
	LOGCREATE("RUNTIME|@200|TEXT:TOTAL_DISTANCE_IN_ZONE|ZONE_DISTANCES:A* Z1-4")            
	LOGRUN()

	LOGCREATE("RUNTIME|@200|TEXT:TOTAL_ENTRIES_IN_ZONE|ZONE_COUNTERS:A* Z1-4")                  
	LOGRUN()   

	LOGCREATE("RUNTIME|@200|TEXT:TOTAL_TIME_SPENT_IN_ZONE|ZONE_TIMERS:A* Z1-4")                  
	LOGRUN()

	SET(LOG_STREAM,0)

COMPLETE

# vim: ft=zanscript
