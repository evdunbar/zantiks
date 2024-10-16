# length of one light or dark period
DEFINE half_cycle_length 600 # 10 minutes
DEFINE num_cycles 3          # number of light dark cycles to run

# variables
DEFINE current_cycle 200
@current_cycle = 0

# tracking settings for larval zebrafish
SET(TARGET_SIZE,2) # radius of animal in mm
SET(DETECTOR_THRESHOLD,6) # sensitivity threshold

# takes an autoreference required for tracking
SET(AUTOREF_MODE,MOVEMENT)
SET(AUTOREF_TIMEOUT,60)

# DEFINE X_LOGDATA_TRACKS 799            # Development setting: log track lengths (total)
# DEFINE X_DRAWTRACKS 30011           # Development setting: enable track drawing

SET(THERMOSTAT,28)

# Sets the data output counter label to begin at 0, labels data in numerical order
SET(COUNTER1,COUNTER_ZERO)

LOAD(ARENAS,"a48.bmp")        # this bitmap is required in your assets directory

LOGFILE(2, "xy_position")
SET(LOG_STREAM_PERFRAME, 2)


ACTION MAIN

    LOGCREATE("TEXT:TIME|TEXT:VARIABLE|TEXT:CONDITION|TEXT:BIN_NUM")
    LOGAPPEND("TEXT:A1|TEXT:A2|TEXT:A3|TEXT:A4|TEXT:A5|TEXT:A6")
    LOGAPPEND("TEXT:A7|TEXT:A8|TEXT:A9|TEXT:A10|TEXT:A11|TEXT:A12")
    LOGAPPEND("TEXT:A13|TEXT:A14|TEXT:A15|TEXT:A16|TEXT:A17|TEXT:A18")
    LOGAPPEND("TEXT:A19|TEXT:A20|TEXT:A21|TEXT:A22|TEXT:A23|TEXT:A24")
    LOGAPPEND("TEXT:A25|TEXT:A26|TEXT:A27|TEXT:A28|TEXT:A29|TEXT:A30")
    LOGAPPEND("TEXT:A31|TEXT:A32|TEXT:A33|TEXT:A34|TEXT:A35|TEXT:A36")
    LOGAPPEND("TEXT:A37|TEXT:A38|TEXT:A39|TEXT:A40|TEXT:A41|TEXT:A42")
    LOGAPPEND("TEXT:A43|TEXT:A44|TEXT:A45|TEXT:A46|TEXT:A47|TEXT:A48")
    LOGRUN()

    # Set up position tracking
    SET(LOG_STREAM, 2)
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
    LOGCREATE("RUNTIME|RAW_XY:A1-15")

    INVOKE(DARK, 1)
    AUTOREFERENCE()
    VIDEO(99999999999, "light_dark_transition_tracking")

    WHILE @current_cycle < num_cycles

        INVOKE(LIGHT, 1)
        INVOKE(MMLIGHT, 1)

        INVOKE(DARK, 1)
        INVOKE(MMDARK, 1)

        @current_cycle = @current_cycle + 1

    ENDWHILE

    SET(LOG_PERFRAME, OFF)
    VIDEOSTOP()

COMPLETE


ACTION MMDARK

    SET(COUNTER1,COUNTER_INC)

    LOGDATA(DATA_SNAPSHOT,"begin")

    WAIT(half_cycle_length)

    LOGDATA(DATA_SNAPSHOT,"end")
    LOGDATA(DATA_SELECT,"begin")
    LOGDATA(DATA_DELTA,"end")

    LOGCREATE("RUNTIME|TEXT:DARK|COUNTER1")
    LOGAPPEND("ARENA_DISTANCES:*")
    LOGRUN()

COMPLETE


ACTION MMLIGHT

    SET(COUNTER1,COUNTER_INC)

    LOGDATA(DATA_SNAPSHOT,"begin")

    WAIT(half_cycle_length)

    LOGDATA(DATA_SNAPSHOT,"end")
    LOGDATA(DATA_SELECT,"begin")
    LOGDATA(DATA_DELTA,"end")

    LOGCREATE("RUNTIME|TEXT:BRIGHT|COUNTER1")
    LOGAPPEND("ARENA_DISTANCES:*")
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

# vim: ft=zanscript
