DEFINE response_length 1 # 1 second
DEFINE num_trials 8
DEFINE inter_trial_interval_length 300 # 5 minutes

# variables
DEFINE do_prepulse 200
@do_prepulse = 0

# define the animal model tracking requirements (dependent on animal size)
SET(TARGET_SIZE,2)
SET(DETECTOR_THRESHOLD,6)

# define auto reference tracking requirements
SET(AUTOREF_MODE,MOVEMENT)
SET(AUTOREF_TIMEOUT,30)

#information about the marker type to track the fish
TARGETMARKER(0, 0, 0)

# define temperature
SET(THERMOSTAT,28)

LOAD(ARENAS, "a48.bmp")

# setting up xy coordinate exporting
LOGFILE(1,"XY_data")
SET(LOG_STREAM_PERFRAME,1)


ACTION MAIN

    LOGFILE(0,"DATA_OUTPUT")
    LOGCREATE("TEXT:RUNTIME|TEXT:TEMPERATURE|TEXT:PHASE")
    LOGAPPEND("TEXT:A1|TEXT:A2|TEXT:A3|TEXT:A4|TEXT:A5|TEXT:A6")
    LOGAPPEND("TEXT:A7|TEXT:A8|TEXT:A9|TEXT:A10|TEXT:A11|TEXT:A12")
    LOGAPPEND("TEXT:A13|TEXT:A14|TEXT:A15|TEXT:A16|TEXT:A17|TEXT:A18")
    LOGAPPEND("TEXT:A19|TEXT:A20|TEXT:A21|TEXT:A22|TEXT:A23|TEXT:A24")
    LOGAPPEND("TEXT:A25|TEXT:A26|TEXT:A27|TEXT:A28|TEXT:A29|TEXT:A30")
    LOGAPPEND("TEXT:A31|TEXT:A32|TEXT:A33|TEXT:A34|TEXT:A35|TEXT:A36")
    LOGAPPEND("TEXT:A37|TEXT:A38|TEXT:A39|TEXT:A40|TEXT:A41|TEXT:A42")
    LOGAPPEND("TEXT:A43|TEXT:A44|TEXT:A45|TEXT:A46|TEXT:A47|TEXT:A48")
    LOGRUN()

    SET(LOG_STREAM,1)
    LOGCREATE("TEXT:RUNTIME|TEXT:X_A1|TEXT:Y_A1|TEXT:X_A2|TEXT:Y_A2")
    LOGAPPEND("TEXT:X_A3|TEXT:Y_A3|TEXT:X_A4|TEXT:Y_A4")
    LOGAPPEND("TEXT:X_A5|TEXT:Y_A5|TEXT:X_A6|TEXT:Y_A6")
    LOGAPPEND("TEXT:X_A7|TEXT:Y_A7|TEXT:X_A8|TEXT:Y_A8")
    LOGAPPEND("TEXT:X_A9|TEXT:Y_A9|TEXT:X_A10|TEXT:Y_A10")
    LOGAPPEND("TEXT:X_A11|TEXT:Y_A11|TEXT:X_A12|TEXT:Y_A12")
    LOGAPPEND("TEXT:X_A13|TEXT:Y_A13|TEXT:X_A14|TEXT:Y_A14")
    LOGAPPEND("TEXT:X_A15|TEXT:Y_A15|TEXT:X_A16|TEXT:Y_A16")
    LOGAPPEND("TEXT:X_A17|TEXT:Y_A17|TEXT:X_A18|TEXT:Y_A18")
    LOGAPPEND("TEXT:X_A19|TEXT:Y_A19|TEXT:X_A20|TEXT:Y_A20")
    LOGAPPEND("TEXT:X_A21|TEXT:Y_A21|TEXT:X_A22|TEXT:Y_A22")
    LOGAPPEND("TEXT:X_A23|TEXT:Y_A23|TEXT:X_A24|TEXT:Y_A24")
    LOGAPPEND("TEXT:X_A25|TEXT:Y_A25|TEXT:X_A26|TEXT:Y_A26")
    LOGAPPEND("TEXT:X_A27|TEXT:Y_A27|TEXT:X_A28|TEXT:Y_A28")
    LOGAPPEND("TEXT:X_A29|TEXT:Y_A29|TEXT:X_A30|TEXT:Y_A30")
    LOGAPPEND("TEXT:X_A31|TEXT:Y_A31|TEXT:X_A32|TEXT:Y_A32")
    LOGAPPEND("TEXT:X_A33|TEXT:Y_A33|TEXT:X_A34|TEXT:Y_A34")
    LOGAPPEND("TEXT:X_A35|TEXT:Y_A35|TEXT:X_A36|TEXT:Y_A36")
    LOGAPPEND("TEXT:X_A37|TEXT:Y_A37|TEXT:X_A38|TEXT:Y_A38")
    LOGAPPEND("TEXT:X_A39|TEXT:Y_A39|TEXT:X_A40|TEXT:Y_A40")
    LOGAPPEND("TEXT:X_A41|TEXT:Y_A41|TEXT:X_A42|TEXT:Y_A42")
    LOGAPPEND("TEXT:X_A43|TEXT:Y_A43|TEXT:X_A44|TEXT:Y_A44")
    LOGAPPEND("TEXT:X_A45|TEXT:Y_A45|TEXT:X_A46|TEXT:Y_A46")
    LOGAPPEND("TEXT:X_A47|TEXT:Y_A47|TEXT:X_A48|TEXT:Y_A48")
    LOGRUN()
    LOGCREATE("RUNTIME|RAW_XY:A1-48")

    SET(LOG_STREAM,0)
    INVOKE(LIGHTS_OFF)
    AUTOREFERENCE()
    SET(LOG_PERFRAME,ON)
    VIDEO(99999999999, "startle_response_tracking")

    INVOKE(trial, num_trials)

    SET(LOG_PERFRAME,OFF)
    VIDEOSTOP()

COMPLETE


#The following lines of code outline the sequence of commands for each BLOCK
ACTION trial

    IF @do_prepulse = 0

        INVOKE(startle, 1)
        @do_prepulse = 1

    ELSE

        INVOKE(prepulse, 1)
        @do_prepulse = 0

    ENDIF

    INVOKE(inter_trial_interval, 1)

COMPLETE


ACTION startle

    LOGDATA(DATA_SNAPSHOT,"beginVIB")

    # U0 step size of 1
    # D1176 ~= 200Hz
    # M+-1 single steps in alternating directions
    ZCOMMAND("U0 D1176 M1 M-1 M1 M-1")

    WAIT(response_length)

    LOGDATA(DATA_SNAPSHOT,"endVIB")
    LOGDATA(DATA_SELECT,"beginVIB")
    LOGDATA(DATA_DELTA,"endVIB")

    LOGCREATE("RUNTIME|TEMPERATURE1|TEXT:STARTLE")
    LOGAPPEND("ARENA_DISTANCES:*")
    LOGRUN()

COMPLETE


ACTION prepulse

    LOGDATA(DATA_SNAPSHOT,"beginVIB")

    # U3 is 1/8 step size for prepulse
    # P300 is 300 ms pause between prepulse and startle vibrations
    ZCOMMAND("U3 D1176 M1 M-1 M1 M-1 P300 U0 D1176 M1 M-1 M1 M-1")

    WAIT(response_length)

    LOGDATA(DATA_SNAPSHOT,"endVIB")
    LOGDATA(DATA_SELECT,"beginVIB")
    LOGDATA(DATA_DELTA,"endVIB")

    LOGCREATE("RUNTIME|TEMPERATURE1|TEXT:PREPULSE")
    LOGAPPEND("ARENA_DISTANCES:*")
    LOGRUN()

COMPLETE


#The following action for collects data in 1 second time bins for the inter trial time (period between vibrations)
ACTION inter_trial_interval

    LOGDATA(DATA_SNAPSHOT,"beginITI")

    WAIT(inter_trial_interval_length)

    LOGDATA(DATA_SNAPSHOT,"endITI")
    LOGDATA(DATA_SELECT,"beginITI")
    LOGDATA(DATA_DELTA,"endITI")

    LOGCREATE("RUNTIME|TEMPERATURE1|TEXT:ITI")
    LOGAPPEND("ARENA_DISTANCES:*")
    LOGRUN()

COMPLETE


ACTION LIGHTS_OFF

    SET(GPO6,0)
    SET(GPO7,0)
    SET(GPO8,0)

COMPLETE

# vim: ft=zanscript
