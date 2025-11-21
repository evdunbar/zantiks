# This sample script is a light-dark assay which should be used with the light dark inserts. 

# Zantiks Ltd cannot guarantee this is how you want to run your experiments, 
# this script is offered only to demonstrate the capabilities of the system 
# and assist you in learning how to script for your research.


# define experiment requirements
DEFINE ACCLIMATION 10	        
DEFINE TIME_BIN 60   
DEFINE REPEATS 10

# define the animal model tracking requirments (dependent on animal size)
SET(TARGET_SIZE,15) 
SET(DETECTOR_THRESHOLD,5)

# takes an autoreference required for tracking 
SET(AUTOREF_MODE,MOVEMENT)   			
SET(AUTOREF_TIMEOUT,30)

# load detector asset
LOAD(ZONES,"arena_LiDa_640x480.bmp")

SET(COUNTER1,COUNTER_ZERO)         


ACTION MAIN   
	
    LOGCREATE("TEXT:TIME|TEXT:TIME_BIN|TEXT:TOTAL_ARENA_DISTANCES")
    LOGAPPEND("TEXT:ZONE1_LIGHT_DISTANCE|TEXT:ZONE2_DARK_DISTANCE")
	LOGAPPEND("TEXT:ZONE1_LIGHT_TIME|TEXT:ZONE2_DARK_TIME")
    LOGAPPEND("TEXT:ZONE1_LIGHT_ENTRIES|TEXT:ZONE2_DARK_ENTRIES")
	LOGRUN()

	LIGHTS(ALL,OFF)
    WAIT(ACCLIMATION) 
 
	AUTOREFERENCE()  
	INVOKE(TEST,REPEATS)            

COMPLETE  


ACTION TEST

    SET(COUNTER1,COUNTER_INC)   
	LIGHTS(LIGHT16,WHITE)    

	LOGDATA(DATA_SNAPSHOT,"BEGIN")     
    
    WAIT(TIME_BIN)                      
	LOGDATA(DATA_SNAPSHOT,"END")  
	LOGDATA(DATA_SELECT,"BEGIN")     
	LOGDATA(DATA_DELTA,"END")     

    LOGCREATE("RUNTIME|COUNTER1|ARENA_DISTANCES:A1")
    LOGAPPEND("ZONE_DISTANCES:Z1-2|ZONE_TIMERS:Z1-2|ZONE_COUNTERS:Z1-2")
	LOGRUN()
    
COMPLETE                                   

# vim: ft=zanscript
