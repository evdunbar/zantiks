DEFINE acclimation_length 300 # 5 minutes
# length of one light or dark period
DEFINE half_cycle_length 600  # 10 minutes
DEFINE num_cycles 3           # number of light dark cycles to run

# variables
DEFINE current_cycle 200
@current_cycle = 0

# tracking settings for larval zebrafish
SET(TARGET_SIZE,2) # radius of animal in mm
SET(DETECTOR_THRESHOLD,5) # sensitivity threshold

# takes an autoreference required for tracking
SET(AUTOREF_MODE,MOVEMENT)
SET(AUTOREF_TIMEOUT,60)

# no tracking marker
TARGETMARKER(0, 0, 0)

SET(THERMOSTAT,28)

# Sets the data output counter label to begin at 0, labels data in numerical order
SET(COUNTER1,COUNTER_ZERO)

LOAD(ARENAS,"a48.bmp")
LOAD(ZONES,"dz48.bmp")

LOGFILE(2, "xy_position")
SET(LOG_STREAM_PERFRAME, 2)


ACTION MAIN

    SET(LOG_STREAM, 0)
    LOGCREATE("TEXT:TIME|TEXT:VARIABLE|TEXT:CONDITION|TEXT:BIN_NUM")
    LOGAPPEND("TEXT:A1_Z1|TEXT:A1_Z2|TEXT:A2_Z1|TEXT:A2_Z2|TEXT:A3_Z1|TEXT:A3_Z2")
    LOGAPPEND("TEXT:A4_Z1|TEXT:A4_Z2|TEXT:A5_Z1|TEXT:A5_Z2|TEXT:A6_Z1|TEXT:A6_Z2")
    LOGAPPEND("TEXT:A7_Z1|TEXT:A7_Z2|TEXT:A8_Z1|TEXT:A8_Z2|TEXT:A9_Z1|TEXT:A9_Z2")
    LOGAPPEND("TEXT:A10_Z1|TEXT:A10_Z2|TEXT:A11_Z1|TEXT:A11_Z2|TEXT:A12_Z1|TEXT:A12_Z2")
    LOGAPPEND("TEXT:A13_Z1|TEXT:A13_Z2|TEXT:A14_Z1|TEXT:A14_Z2|TEXT:A15_Z1|TEXT:A15_Z2")
    LOGAPPEND("TEXT:A16_Z1|TEXT:A16_Z2|TEXT:A17_Z1|TEXT:A17_Z2|TEXT:A18_Z1|TEXT:A18_Z2")
    LOGAPPEND("TEXT:A19_Z1|TEXT:A19_Z2|TEXT:A20_Z1|TEXT:A20_Z2|TEXT:A21_Z1|TEXT:A21_Z2")
    LOGAPPEND("TEXT:A22_Z1|TEXT:A22_Z2|TEXT:A23_Z1|TEXT:A23_Z2|TEXT:A24_Z1|TEXT:A24_Z2")
    LOGAPPEND("TEXT:A25_Z1|TEXT:A25_Z2|TEXT:A26_Z1|TEXT:A26_Z2|TEXT:A27_Z1|TEXT:A27_Z2")
    LOGAPPEND("TEXT:A28_Z1|TEXT:A28_Z2|TEXT:A29_Z1|TEXT:A29_Z2|TEXT:A30_Z1|TEXT:A30_Z2")
    LOGAPPEND("TEXT:A31_Z1|TEXT:A31_Z2|TEXT:A32_Z1|TEXT:A32_Z2|TEXT:A33_Z1|TEXT:A33_Z2")
    LOGAPPEND("TEXT:A34_Z1|TEXT:A34_Z2|TEXT:A35_Z1|TEXT:A35_Z2|TEXT:A36_Z1|TEXT:A36_Z2")
    LOGAPPEND("TEXT:A37_Z1|TEXT:A37_Z2|TEXT:A38_Z1|TEXT:A38_Z2|TEXT:A39_Z1|TEXT:A39_Z2")
    LOGAPPEND("TEXT:A40_Z1|TEXT:A40_Z2|TEXT:A41_Z1|TEXT:A41_Z2|TEXT:A42_Z1|TEXT:A42_Z2")
    LOGAPPEND("TEXT:A43_Z1|TEXT:A43_Z2|TEXT:A44_Z1|TEXT:A44_Z2|TEXT:A45_Z1|TEXT:A45_Z2")
    LOGAPPEND("TEXT:A46_Z1|TEXT:A46_Z2|TEXT:A47_Z1|TEXT:A47_Z2|TEXT:A48_Z1|TEXT:A48_Z2")
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
    LOGCREATE("RUNTIME|RAW_XY:A1-48")

    SET(LOG_STREAM, 0)
    INVOKE(DARK, 1)
    AUTOREFERENCE()
    WAIT(acclimation_length)
    SET(LOG_PERFRAME, ON)
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

    SET(LOG_STREAM, 0)
    LOGCREATE("RUNTIME|TEXT:DARK|COUNTER1")
    LOGAPPEND("ZONE_DISTANCES:A* Z1-2")
    LOGRUN()

COMPLETE


ACTION MMLIGHT

    SET(COUNTER1,COUNTER_INC)

    LOGDATA(DATA_SNAPSHOT,"begin")

    WAIT(half_cycle_length)

    LOGDATA(DATA_SNAPSHOT,"end")
    LOGDATA(DATA_SELECT,"begin")
    LOGDATA(DATA_DELTA,"end")

    SET(LOG_STREAM, 0)
    LOGCREATE("RUNTIME|TEXT:BRIGHT|COUNTER1")
    LOGAPPEND("ZONE_DISTANCES:A* Z1-2")
    LOGRUN()

COMPLETE


ACTION DARK

    # overhead lights
    SET(GPO6,0)
    SET(GPO7,0)
    SET(GPO8,0)

COMPLETE


ACTION LIGHT

    # overhead lights
    SET(GPO6,1)
    SET(GPO7,1)
    SET(GPO8,1)

COMPLETE

# vim: ft=zanscript
