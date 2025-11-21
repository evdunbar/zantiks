DEFINE cycle_length 300 # 5 minutes
DEFINE num_cycles 3     # number of light dark cycles to run

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


ACTION MAIN

    LOGCREATE("TEXT:TIME|TEXT:VARIABLE|TEXT:CONDITION|TEXT:BIN_NUM")
    LOGAPPEND("TEXT:A1|TEXT:A2|TEXT:A3|TEXT:A4|TEXT:A5|TEXT:A6")
    LOGAPPEND("TEXT:A7|TEXT:A8")
    LOGAPPEND("TEXT:B1|TEXT:B2|TEXT:B3|TEXT:B4|TEXT:B5|TEXT:B6")
    LOGAPPEND("TEXT:B7|TEXT:B8")
    LOGAPPEND("TEXT:C1|TEXT:C2|TEXT:C3|TEXT:C4|TEXT:C5|TEXT:C6")
    LOGAPPEND("TEXT:C7|TEXT:C8")
    LOGAPPEND("TEXT:D1|TEXT:D2|TEXT:D3|TEXT:D4|TEXT:D5|TEXT:D6")
    LOGAPPEND("TEXT:D7|TEXT:D8")
    LOGAPPEND("TEXT:E1|TEXT:E2|TEXT:E3|TEXT:E4|TEXT:E5|TEXT:E6")
    LOGAPPEND("TEXT:E7|TEXT:E8")
    LOGAPPEND("TEXT:F1|TEXT:F2|TEXT:F3|TEXT:F4|TEXT:F5|TEXT:F6")
    LOGAPPEND("TEXT:F7|TEXT:F8")
    LOGRUN()

    # Set up position tracking
    LOGFILE(2, "xy_position")
    SET(LOG_STREAM_PERFRAME, 2)
    LOGCREATE("RUNTIME|RAW_XY:A1-15")

    INVOKE(DARK, 1)
    AUTOREFERENCE()
    # SET(X_DRAWTRACKS,1)
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

    WAIT(cycle_length)

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

    WAIT(cycle_length)

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
