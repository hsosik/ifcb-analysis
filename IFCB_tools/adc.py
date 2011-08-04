#!/usr/bin/python

# define constants for use with .adc files

# columns, 0-based. "x" is horizontal, "y" is vertical, x left to right, y bottom to top
TRIGGER_NUMBER = 0
PROCESSING_END_TIME = 1
FLUORESENCE_HIGH = 2
FLUORESCENCE_LOW = 3
SCATTERING_HIGH = 4
SCATTERING_LOW = 5
COMPARATOR_PULSE = 6
TRIGGER_OPEN_TIME = 7
FRAME_GRAB_TIME = 8
# location of ROI in camera field in pixels
BOTTOM = 9
LEFT = 10
# ROI extent in pixels
HEIGHT = 11
WIDTH = 12
# ROI byte offset
BYTE_OFFSET = 13
VALVE_STATUS = 14

ROW_TYPES = [int,float,float,float,float,float,float,float,float,int,int,int,int,int,float]