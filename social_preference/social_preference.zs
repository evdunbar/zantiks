DEFINE acclimation_time 300 # 5 minutes
DEFINE bin_length 1         # 1 second
DEFINE num_bins 1800        # 30 minutes total experiment time

SET(TARGET_SIZE, 2)
SET(DETECTOR_THRESHOLD, 6)

SET(AUTOREF_MODE, MOVEMENT)
SET(AUTOREF_TIMEOUT, 60)

TARGETMARKER(0, 0, 0)

SET(THERMOSTAT, 28)

LOAD(ARENAS, "social_preference_arenas.bmp")
LOAD(ZONES, "social_preference_zones.bmp")

LOGFILE(2, "xy_position")
SET(LOG_STREAM_PERFRAME, 2)

ACTION MAIN

    LOGCREATE("TEXT:TIME|TEXT:BIN_NUMBER")
    LOGAPPEND("TEXT:T.A1.Z1|TEXT:T.A1.Z2|TEXT:T.A1.Z3|TEXT:T.A1.Z4|TEXT:T.A1.Z5")
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

    # Set up position tracking
    SET(LOG_STREAM, 2)
    LOGCREATE("TEXT:RUNTIME|TEXT:X_A1|TEXT:Y_A1|TEXT:X_A2|TEXT:Y_A2")
    LOGAPPEND("TEXT:X_A3|TEXT:Y_A3|TEXT:X_A4|TEXT:Y_A4")
    LOGAPPEND("TEXT:X_A5|TEXT:Y_A5|TEXT:X_A6|TEXT:Y_A6")
    LOGAPPEND("TEXT:X_A7|TEXT:Y_A7|TEXT:X_A8|TEXT:Y_A8")
    LOGAPPEND("TEXT:X_A9|TEXT:Y_A9|TEXT:X_A10|TEXT:Y_A10")
    LOGRUN()
    LOGCREATE("RUNTIME|RAW_XY:A1-10")

    LIGHTS(ALL, OFF)
    AUTOREFERENCE()
    WAIT(acclimation_time)
    SET(LOG_PERFRAME, ON)
    SET(COUNTER1, COUNTER_ZERO)
    VIDEO(99999999999, "social_preference_tracking")
    LIGHTS(ALL, ON)

    INVOKE(SAMPLE, num_bins)

    SET(LOG_PERFRAME, OFF)
    VIDEOSTOP()

COMPLETE


ACTION SAMPLE

    SET(COUNTER1, COUNTER_INC) # Starts time bin counter

    LOGDATA(DATA_SNAPSHOT, "begin") # Starts a snapshot of data

    WAIT(bin_length)
    LOGDATA(DATA_SNAPSHOT, "end")
    LOGDATA(DATA_SELECT, "begin")
    LOGDATA(DATA_DELTA, "end")

    # The following commands specifies what processed data will be reported
    SET(LOG_STREAM, 0)
    LOGCREATE("RUNTIME|COUNTER1")
    LOGAPPEND("ZONE_TIMERS:A1-10 Z1-5")
    LOGRUN()

COMPLETE

# vim: ft=zanscript
