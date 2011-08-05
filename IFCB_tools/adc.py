#!/usr/bin/python
import csv

# define constants for use with ROI structs

# columns, 0-based. "x" is horizontal, "y" is vertical, x left to right, y bottom to top
TRIGGER = 'trigger'
PROCESSING_END_TIME = 'processingEndTime'
FLUORESENCE_HIGH = 'fluorescenceHigh'
FLUORESCENCE_LOW = 'fluorescenceLow'
SCATTERING_HIGH = 'scatteringHigh'
SCATTERING_LOW = 'scatteringLow'
COMPARATOR_PULSE = 'comparatorPulse'
TRIGGER_OPEN_TIME = 'triggerOpenTime'
FRAME_GRAB_TIME = 'frameGrabTime'
# location of ROI in camera field in pixels
BOTTOM = 'bottom'
LEFT = 'left'
# ROI extent in pixels
HEIGHT = 'height'
WIDTH = 'width'
# ROI byte offset
BYTE_OFFSET = 'byteOffset'
VALVE_STATUS = 'valveStatus'

schema = [(TRIGGER, int),
          (PROCESSING_END_TIME, float),
          (FLUORESENCE_HIGH, float),
          (FLUORESCENCE_LOW, float),
          (SCATTERING_HIGH, float),
          (SCATTERING_LOW, float),
          (COMPARATOR_PULSE, float),
          (TRIGGER_OPEN_TIME, float),
          (FRAME_GRAB_TIME, float),
          (BOTTOM, int),
          (LEFT, int),
          (HEIGHT, int),
          (WIDTH, int),
          (BYTE_OFFSET, int),
          (VALVE_STATUS, float)]

# useful functions

# load the ROI's as structs; this is a generator so may need to be wrapped in a call to list()
def all_rois(file):
    reader = csv.reader(open(file,'rb'))
    for row in reader:
        roi = {}
        for (name, cast), value in zip(schema, row):
            roi[name] = cast(value)
        yield roi

# efficiently retrieve the nth ROI from an ADC file (0-based!)
def nth_roi(file,n):
    rois = load_adc(file)
    while(n > 0):
        rois.next()
        n = n - 1
    return rois.next()

def length(file):
    count = 0
    for roi in load_adc(file):
        count = count + 1
    return count