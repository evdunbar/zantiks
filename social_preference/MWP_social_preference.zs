# The following script provides a demonstration of how the social preference test might work for larval zebrafish. 
# Animals are acclimated for 5 minutes in the dark (focal fish cannot see consepcifics) followed by a 10 minutes of tracking in the light.
# This script is to demonstrate how to use the Zantiks MWP system to run an experimnt and collect some data, Zantiks do not take responsibility 
# for how you want experiments to run. This demo script can be readily adapted to match your experimental needs. 

SET(THERMOSTAT, 28) # Sets temperature of the system in °C

DEFINE VIDEO_LENGTH 9999999999999999 	#very long video length so can use VIDEO stop to end video										

DEFINE ACCLIMATION 300 	# Defines acclimation time in seconds

DEFINE TIME_BIN 1		# Defines the time bins in seconds (1sec useful for circadian rhythms etc.) 
DEFINE NUM_SAMPLES 600 	# Defines the interval time in seconds 

#the following set commands are used for tracking 
SET(TARGET_SIZE,2) # radius of animal in mm
SET(DETECTOR_THRESHOLD,6) # sensitivity threshold

# takes an autoreference required for tracking 
SET(AUTOREF_MODE,MOVEMENT)   			
SET(AUTOREF_TIMEOUT,60)

# Sets the data output counter to begin at 0. The counter is used to label the data in numerical order
SET(COUNTER1,COUNTER_ZERO) 

# The ACTION MAIN is the whole experiment outline. The actions listed here are further explained below
ACTION MAIN    		 

	INVOKE(DARK)
    LOAD(OVERLAY_TEXT,"1,1:Acclimation") 
    WAIT(ACCLIMATION)
    LOAD(OVERLAY_CLEAR,"")

	INVOKE(DATA_HEADINGS) # invokes action at bottom of script for writing heading & loading assets

	INVOKE(LIGHT)
	AUTOREFERENCE() # Takes an autoreference to begin tracking   

	VIDEO(VIDEO_LENGTH,"zebrafish_social")
    VIDEOSKIP(29)
    
    INVOKE(SAMPLE, NUM_SAMPLES)
    
	VIDEOSTOP()
    
COMPLETE  # Signals the system that the ACTION MAIN is complete. Every action must end with a COMPLETE


ACTION SAMPLE            
    
	SET(COUNTER1,COUNTER_INC) # Starts time bin counter 

	LOGDATA(DATA_SNAPSHOT,"begin") # Starts a snapshot of data

    WAIT(TIME_BIN) # Waits time (in sec) DEFINEd as BIN at the top of the script        

# The following 3 commands ends the snapshot and processes the data collected in that time bin			
	LOGDATA(DATA_SNAPSHOT,"end")  
	LOGDATA(DATA_SELECT,"begin") 		
	LOGDATA(DATA_DELTA,"end")  

# The following commands specifies what processed data will be reported
    LOGCREATE("RUNTIME|TEMPERATURE1|COUNTER1|ARENA_DISTANCES*")
	LOGAPPEND("ZONE_DISTANCES:A1-10 Z1-5|ZONE_COUNTERS:A1-10 Z1-5|ZONE_TIMERS:A1-10 Z1-5")         
	LOGRUN()
    
COMPLETE             	


ACTION DARK

	SET(GPO6,0) 
	SET(GPO7,0) 
	SET(GPO8,0)
    
COMPLETE


ACTION LIGHT

	SET(GPO6,1) 
	SET(GPO7,1) 
	SET(GPO8,1)
    
COMPLETE


ACTION DATA_HEADINGS # The following lines write the headings for the data output.

    LOAD(ARENAS,"aSocial.bmp") 		# Loads the arenas bitmap (must be in the asset directory)
	LOAD(ZONES,"zSocial.bmp") 	# Loads the zones bitmap (must be in the asset directory)

    LOGCREATE("TEXT:RUNTIME|TEXT:TEMPERATURE|TEXT:TIME_BIN")

	LOGAPPEND("TEXT:A1|TEXT:A2|TEXT:A3|TEXT:A4|TEXT:A5") #distance travelled for arenas
    LOGAPPEND("TEXT:A6|TEXT:A7|TEXT:A8|TEXT:A9|TEXT:A10")
    
	LOGAPPEND("TEXT:D.A1.Z1|TEXT:D.A1.Z2|TEXT:D.A1.Z3|TEXT:D.A1.Z4|TEXT:D.A1.Z5") # D for distance travelled  
    LOGAPPEND("TEXT:D.A2.Z1|TEXT:D.A2.Z2|TEXT:D.A2.Z3|TEXT:D.A2.Z4|TEXT:D.A2.Z5")     
	LOGAPPEND("TEXT:D.A3.Z1|TEXT:D.A3.Z2|TEXT:D.A3.Z3|TEXT:D.A3.Z4|TEXT:D.A3.Z5")
	LOGAPPEND("TEXT:D.A4.Z1|TEXT:D.A4.Z2|TEXT:D.A4.Z3|TEXT:D.A4.Z4|TEXT:D.A4.Z5")
	LOGAPPEND("TEXT:D.A5.Z1|TEXT:D.A5.Z2|TEXT:D.A5.Z3|TEXT:D.A5.Z4|TEXT:D.A5.Z5")
	LOGAPPEND("TEXT:D.A6.Z1|TEXT:D.A6.Z2|TEXT:D.A6.Z3|TEXT:D.A6.Z4|TEXT:D.A6.Z5")
	LOGAPPEND("TEXT:D.A7.Z1|TEXT:D.A7.Z2|TEXT:D.A7.Z3|TEXT:D.A7.Z4|TEXT:D.A7.Z5")
	LOGAPPEND("TEXT:D.A8.Z1|TEXT:D.A8.Z2|TEXT:D.A8.Z3|TEXT:D.A8.Z4|TEXT:D.A8.Z5") 
	LOGAPPEND("TEXT:D.A9.Z1|TEXT:D.A9.Z2|TEXT:D.A9.Z3|TEXT:D.A9.Z4|TEXT:D.A9.Z5") 
	LOGAPPEND("TEXT:D.A10.Z1|TEXT:D.A10.Z2|TEXT:D.A10.Z3|TEXT:D.A10.Z4|TEXT:D.A10.Z5")    
    
	LOGAPPEND("TEXT:C.A1.Z1|TEXT:C.A1.Z2|TEXT:C.A1.Z3|TEXT:C.A1.Z4|TEXT:C.A1.Z5") # C for counts of visits   
	LOGAPPEND("TEXT:C.A2.Z1|TEXT:C.A2.Z2|TEXT:C.A2.Z3|TEXT:C.A2.Z4|TEXT:C.A2.Z5")    
	LOGAPPEND("TEXT:C.A3.Z1|TEXT:C.A3.Z2|TEXT:C.A3.Z3|TEXT:C.A3.Z4|TEXT:C.A3.Z5")
	LOGAPPEND("TEXT:C.A4.Z1|TEXT:C.A4.Z2|TEXT:C.A4.Z3|TEXT:C.A4.Z4|TEXT:C.A4.Z5")
	LOGAPPEND("TEXT:C.A5.Z1|TEXT:C.A5.Z2|TEXT:C.A5.Z3|TEXT:C.A5.Z4|TEXT:C.A5.Z5")
	LOGAPPEND("TEXT:C.A6.Z1|TEXT:C.A6.Z2|TEXT:C.A6.Z3|TEXT:C.A6.Z4|TEXT:C.A6.Z5")
	LOGAPPEND("TEXT:C.A7.Z1|TEXT:C.A7.Z2|TEXT:C.A7.Z3|TEXT:C.A7.Z4|TEXT:C.A7.Z5")
	LOGAPPEND("TEXT:C.A8.Z1|TEXT:C.A8.Z2|TEXT:C.A8.Z3|TEXT:C.A8.Z4|TEXT:C.A8.Z5")
	LOGAPPEND("TEXT:C.A9.Z1|TEXT:C.A9.Z2|TEXT:C.A9.Z3|TEXT:C.A9.Z4|TEXT:C.A9.Z5")
	LOGAPPEND("TEXT:C.A10.Z1|TEXT:C.A10.Z2|TEXT:C.A10.Z3|TEXT:C.A10.Z4|TEXT:C.A10.Z5")     

	LOGAPPEND("TEXT:T.A1.Z1|TEXT:T.A1.Z2|TEXT:T.A1.Z3|TEXT:T.A1.Z4|TEXT:T.A1.Z5") # T for time spent     
	LOGAPPEND("TEXT:T.A2.Z1|TEXT:T.A2.Z2|TEXT:T.A2.Z3|TEXT:T.A2.Z4|TEXT:T.A2.Z5")    
	LOGAPPEND("TEXT:T.A3.Z1|TEXT:T.A3.Z2|TEXT:T.A3.Z3|TEXT:T.A3.Z4|TEXT:T.A3.Z5")      
	LOGAPPEND("TEXT:T.A4.Z1|TEXT:T.A4.Z2|TEXT:T.A4.Z3|TEXT:T.A4.Z4|TEXT:T.A4.Z5")    
	LOGAPPEND("TEXT:T.A5.Z1|TEXT:T.A5.Z2|TEXT:T.A5.Z3|TEXT:T.A5.Z4|TEXT:T.A5.Z5")    
	LOGAPPEND("TEXT:T.A6.Z1|TEXT:T.A6.Z2|TEXT:T.A6.Z3|TEXT:T.A6.Z4|TEXT:T.A6.Z5") 
	LOGAPPEND("TEXT:T.A7.Z1|TEXT:T.A7.Z2|TEXT:T.A7.Z3|TEXT:T.A7.Z4|TEXT:T.A7.Z5")    
	LOGAPPEND("TEXT:T.A8.Z1|TEXT:T.A8.Z2|TEXT:T.A8.Z3|TEXT:T.A8.Z4|TEXT:T.A8.Z5") 
	LOGAPPEND("TEXT:T.A9.Z1|TEXT:T.A9.Z2|TEXT:T.A9.Z3|TEXT:T.A9.Z4|TEXT:T.A9.Z5")  
	LOGAPPEND("TEXT:T.A10.Z1|TEXT:T.A10.Z2|TEXT:T.A10.Z3|TEXT:T.A10.Z4|TEXT:T.A10.Z5")

    LOGRUN()

COMPLETE

# vim: ft=zanscript
