DEFINE bin_length 60        # 1 minute
DEFINE num_bins 6           # 60 minutes total experiment time

# define the animal model tracking requirments (see website for other species)
SET(TARGET_SIZE,15)
SET(DETECTOR_THRESHOLD,5)

# settings for autoreference (required for tracking)
SET(AUTOREF_MODE,MOVEMENT)
SET(AUTOREF_TIMEOUT, 10)

# no tracking marker
TARGETMARKER(0, 0, 0)

SET(THERMOSTAT, 28)

# loads the arenas and zones
LOAD(ARENAS,"aMirror.bmp")
LOAD(DETECTORS, "zMirror.bmp")

# Set up position tracking
LOGFILE(2, "xy_position")
SET(LOG_STREAM_PERFRAME, 2)


ACTION MAIN

    INVOKE(DARK) # turns overhead light and screen off at the start of experiment

    SET(COUNTER1, COUNTER_ZERO) # sets the data output counter label to begin at 0

    # creates headers for columns in the data file
    SET(LOG_STREAM, 0)
    LOGCREATE("TEXT:RUNTIME|TEXT:TIME_BIN")
    LOGAPPEND("TEXT:D.A1.Z1|TEXT:D.A1.Z2|TEXT:D.A1.Z3") # D = Distance travelled in zone data
    LOGAPPEND("TEXT:D.A2.Z1|TEXT:D.A2.Z2|TEXT:D.A2.Z3")
    LOGAPPEND("TEXT:D.A3.Z1|TEXT:D.A3.Z2|TEXT:D.A3.Z3")
    LOGAPPEND("TEXT:D.A4.Z1|TEXT:D.A4.Z2|TEXT:D.A4.Z3")
    LOGAPPEND("TEXT:D.A5.Z1|TEXT:D.A5.Z2|TEXT:D.A5.Z3")
    LOGAPPEND("TEXT:D.A6.Z1|TEXT:D.A6.Z2|TEXT:D.A6.Z3")
    LOGAPPEND("TEXT:D.A7.Z1|TEXT:D.A7.Z2|TEXT:D.A7.Z3")
    LOGAPPEND("TEXT:D.A8.Z1|TEXT:D.A8.Z2|TEXT:D.A8.Z3")
    LOGAPPEND("TEXT:D.A9.Z1|TEXT:D.A9.Z2|TEXT:D.A9.Z3")
    LOGAPPEND("TEXT:D.A10.Z1|TEXT:D.A10.Z2|TEXT:D.A10.Z3")
    LOGAPPEND("TEXT:D.A11.Z1|TEXT:D.A11.Z2|TEXT:D.A11.Z3")
    LOGAPPEND("TEXT:D.A12.Z1|TEXT:D.A12.Z2|TEXT:D.A12.Z3")
    LOGAPPEND("TEXT:D.A13.Z1|TEXT:D.A13.Z2|TEXT:D.A13.Z3")
    LOGAPPEND("TEXT:D.A14.Z1|TEXT:D.A14.Z2|TEXT:D.A14.Z3")
    LOGAPPEND("TEXT:D.A15.Z1|TEXT:D.A15.Z2|TEXT:D.A15.Z3")
    LOGAPPEND("TEXT:D.A16.Z1|TEXT:D.A16.Z2|TEXT:D.A16.Z3")
    LOGAPPEND("TEXT:D.A17.Z1|TEXT:D.A17.Z2|TEXT:D.A17.Z3")
    LOGAPPEND("TEXT:D.A18.Z1|TEXT:D.A18.Z2|TEXT:D.A18.Z3")
    LOGAPPEND("TEXT:D.A19.Z1|TEXT:D.A19.Z2|TEXT:D.A19.Z3")
    LOGAPPEND("TEXT:D.A20.Z1|TEXT:D.A20.Z2|TEXT:D.A20.Z3")

    LOGAPPEND("TEXT:C.A1.Z1|TEXT:C.A1.Z2|TEXT:C.A1.Z3") # C = Count i.e. number of entries into zone
    LOGAPPEND("TEXT:C.A2.Z1|TEXT:C.A2.Z2|TEXT:C.A2.Z3")
    LOGAPPEND("TEXT:C.A3.Z1|TEXT:C.A3.Z2|TEXT:C.A3.Z3")
    LOGAPPEND("TEXT:C.A4.Z1|TEXT:C.A4.Z2|TEXT:C.A4.Z3")
    LOGAPPEND("TEXT:C.A5.Z1|TEXT:C.A5.Z2|TEXT:C.A5.Z3")
    LOGAPPEND("TEXT:C.A6.Z1|TEXT:C.A6.Z2|TEXT:C.A6.Z3")
    LOGAPPEND("TEXT:C.A7.Z1|TEXT:C.A7.Z2|TEXT:C.A7.Z3")
    LOGAPPEND("TEXT:C.A8.Z1|TEXT:C.A8.Z2|TEXT:C.A8.Z3")
    LOGAPPEND("TEXT:C.A9.Z1|TEXT:C.A9.Z2|TEXT:C.A9.Z3")
    LOGAPPEND("TEXT:C.A10.Z1|TEXT:C.A10.Z2|TEXT:C.A10.Z3")
    LOGAPPEND("TEXT:C.A11.Z1|TEXT:C.A11.Z2|TEXT:C.A11.Z3")
    LOGAPPEND("TEXT:C.A12.Z1|TEXT:C.A12.Z2|TEXT:C.A12.Z3")
    LOGAPPEND("TEXT:C.A13.Z1|TEXT:C.A13.Z2|TEXT:C.A13.Z3")
    LOGAPPEND("TEXT:C.A14.Z1|TEXT:C.A14.Z2|TEXT:C.A14.Z3")
    LOGAPPEND("TEXT:C.A15.Z1|TEXT:C.A15.Z2|TEXT:C.A15.Z3")
    LOGAPPEND("TEXT:C.A16.Z1|TEXT:C.A16.Z2|TEXT:C.A16.Z3")
    LOGAPPEND("TEXT:C.A17.Z1|TEXT:C.A17.Z2|TEXT:C.A17.Z3")
    LOGAPPEND("TEXT:C.A18.Z1|TEXT:C.A18.Z2|TEXT:C.A18.Z3")
    LOGAPPEND("TEXT:C.A19.Z1|TEXT:C.A19.Z2|TEXT:C.A19.Z3")
    LOGAPPEND("TEXT:C.A20.Z1|TEXT:C.A20.Z2|TEXT:C.A20.Z3")

    LOGAPPEND("TEXT:T.A1.Z1|TEXT:T.A1.Z2|TEXT:T.A1.Z3") # T = Time spent in zone data
    LOGAPPEND("TEXT:T.A2.Z1|TEXT:T.A2.Z2|TEXT:T.A2.Z3")
    LOGAPPEND("TEXT:T.A3.Z1|TEXT:T.A3.Z2|TEXT:T.A3.Z3")
    LOGAPPEND("TEXT:T.A4.Z1|TEXT:T.A4.Z2|TEXT:T.A4.Z3")
    LOGAPPEND("TEXT:T.A5.Z1|TEXT:T.A5.Z2|TEXT:T.A5.Z3")
    LOGAPPEND("TEXT:T.A6.Z1|TEXT:T.A6.Z2|TEXT:T.A6.Z3")
    LOGAPPEND("TEXT:T.A7.Z1|TEXT:T.A7.Z2|TEXT:T.A7.Z3")
    LOGAPPEND("TEXT:T.A8.Z1|TEXT:T.A8.Z2|TEXT:T.A8.Z3")
    LOGAPPEND("TEXT:T.A9.Z1|TEXT:T.A9.Z2|TEXT:T.A9.Z3")
    LOGAPPEND("TEXT:T.A10.Z1|TEXT:T.A10.Z2|TEXT:T.A10.Z3")
    LOGAPPEND("TEXT:T.A11.Z1|TEXT:T.A11.Z2|TEXT:T.A11.Z3")
    LOGAPPEND("TEXT:T.A12.Z1|TEXT:T.A12.Z2|TEXT:T.A12.Z3")
    LOGAPPEND("TEXT:T.A13.Z1|TEXT:T.A13.Z2|TEXT:T.A13.Z3")
    LOGAPPEND("TEXT:T.A14.Z1|TEXT:T.A14.Z2|TEXT:T.A14.Z3")
    LOGAPPEND("TEXT:T.A15.Z1|TEXT:T.A15.Z2|TEXT:T.A15.Z3")
    LOGAPPEND("TEXT:T.A16.Z1|TEXT:T.A16.Z2|TEXT:T.A16.Z3")
    LOGAPPEND("TEXT:T.A17.Z1|TEXT:T.A17.Z2|TEXT:T.A17.Z3")
    LOGAPPEND("TEXT:T.A18.Z1|TEXT:T.A18.Z2|TEXT:T.A18.Z3")
    LOGAPPEND("TEXT:T.A19.Z1|TEXT:T.A19.Z2|TEXT:T.A19.Z3")
    LOGAPPEND("TEXT:T.A20.Z1|TEXT:T.A20.Z2|TEXT:T.A20.Z3")
    LOGRUN()

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
    LOGRUN()
    LOGCREATE("RUNTIME|RAW_XY:A1-20")

    INVOKE(LIGHT)

    AUTOREFERENCE()
    SET(LOG_PERFRAME, ON)
    VIDEO(9999999999, "mirrorbiting_tracking")

    INVOKE(SAMPLE, num_bins)

    SET(LOG_PERFRAME, OFF)
    VIDEOSTOP()

COMPLETE


ACTION DARK

    LIGHTS(ALL,OFF)

    SET(GPO6,0)
    SET(GPO7,0)
    SET(GPO8,0)

COMPLETE


ACTION LIGHT

    LIGHTS(ALL,ON)

    SET(GPO6,1)
    SET(GPO7,1)
    SET(GPO8,1)

COMPLETE


ACTION SAMPLE

    SET(COUNTER1,COUNTER_INC)

    LOGDATA(DATA_SNAPSHOT,"begin")

    WAIT(bin_length)

    LOGDATA(DATA_SNAPSHOT,"end")
    LOGDATA(DATA_SELECT,"begin")
    LOGDATA(DATA_DELTA,"end")

    SET(LOG_STREAM, 0)
    LOGCREATE("RUNTIME|COUNTER1|ZONE_DISTANCES:A1-20 Z1-3|ZONE_COUNTERS:A1-20 Z1-3")
    LOGAPPEND("ZONE_TIMERS:A1-20 Z1-3")
    LOGRUN()

COMPLETE

# vim: ft=zanscript
