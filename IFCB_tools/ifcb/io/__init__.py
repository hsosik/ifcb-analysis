import os

# define constants for use with ROI structs

# adc columns, 0-based. "x" is horizontal, "y" is vertical, x left to right, y bottom to top
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

# TODO define each schema element
# TODO units of measure
adc_schema = [(TRIGGER, int),
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

ADC_EXT = 'adc'
ROI_EXT = 'roi'
HDR_EXT = 'hdr'

# other handy property names
ROI_NUMBER = 'roiNumber' # 1-based index of ROI in bins
BIN_ID = 'binID' # bin ID
ROI_ID = 'roiID' # roi ID
PID = 'pid'

# useful functions
def ext_path(id, ext, dir='.'):
    return os.path.join(dir,id) + '.' + ext

def adc_path(id,dir='.'):
    return ext_path(id,ADC_EXT,dir)
def roi_path(id,dir='.'):
    return ext_path(id,ROI_EXT,dir)
def hdr_path(id,dir='.'):
    return ext_path(id,HDR_EXT,dir)

