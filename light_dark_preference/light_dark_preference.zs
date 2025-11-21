# define experiment requirements
DEFINE bin_length 60 # 1 minute
DEFINE num_bins 6    # 6 minutes total experiment time

# define the animal model tracking requirments (dependent on animal size)
SET(TARGET_SIZE, 15) 
SET(DETECTOR_THRESHOLD, 5)

# takes an autoreference required for tracking 
SET(AUTOREF_MODE, MOVEMENT)   			
SET(AUTOREF_TIMEOUT, 30)

# load detector asset
LOAD(ZONES, "arena_LiDa_640x480.bmp")


ACTION MAIN   
	
    LOGCREATE("TEXT:TIME|TEXT:BIN_NUMBER|TEXT:TOTAL_ARENA_DISTANCES")
    LOGAPPEND("TEXT:ZONE1_LIGHT_DISTANCE|TEXT:ZONE2_DARK_DISTANCE")
	LOGAPPEND("TEXT:ZONE1_LIGHT_TIME|TEXT:ZONE2_DARK_TIME")
    LOGAPPEND("TEXT:ZONE1_LIGHT_ENTRIES|TEXT:ZONE2_DARK_ENTRIES")
	LOGRUN()

    # Set up position tracking
    LOGFILE(2, "xy_position")
    SET(LOG_STREAM_PERFRAME, 2)
    LOGCREATE("RUNTIME|RAW_XY:A1-15")

    # set up for experiments
	LIGHTS(ALL, OFF)
	AUTOREFERENCE()  
	LIGHTS(LIGHT16, WHITE)    
    SET(LOG_PERFRAME, ON)
    SET(COUNTER1, COUNTER_ZERO)         
	VIDEO(99999999999, "light_dark_preference_video")

	INVOKE(TEST, num_bins)            

    SET(LOG_PERFRAME, OFF)
    VIDEOSTOP()

COMPLETE  


ACTION TEST

    SET(COUNTER1, COUNTER_INC)   

	LOGDATA(DATA_SNAPSHOT, "BEGIN")     
    
    WAIT(bin_length)                      
	LOGDATA(DATA_SNAPSHOT, "END")  
	LOGDATA(DATA_SELECT, "BEGIN")     
	LOGDATA(DATA_DELTA, "END")     

    LOGCREATE("RUNTIME|COUNTER1|ARENA_DISTANCES:A1")
    LOGAPPEND("ZONE_DISTANCES:Z1-2|ZONE_TIMERS:Z1-2|ZONE_COUNTERS:Z1-2")
	LOGRUN()
    
COMPLETE                                   

# vim: ft=zanscript
