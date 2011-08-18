import os
import time

"""Utilities for reading and converting IFCB data"""

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
ADC_SCHEMA = [(TRIGGER, int),
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

# hdr values
TEMPERATURE = 'temperature'
HUMIDITY = 'humidity'
BINARIZE_THRESHOLD = 'binarizeThreshold'
SCATTERING_PMT_SETTING = 'scatteringPhotomultiplierSetting'
FLUORESCENCE_PMT_SETTING = 'fluorescencePhotomultiplierSetting'
BLOB_SIZE_THRESHOLD = 'blobSizeThreshold' 

HDR_SCHEMA = [(TEMPERATURE, float),
              (HUMIDITY, float),
              (BINARIZE_THRESHOLD, int),
              (SCATTERING_PMT_SETTING, float),
              (FLUORESCENCE_PMT_SETTING, float),
              (BLOB_SIZE_THRESHOLD, int)]
HDR_COLUMNS = ['Temp', 'Humidity', 'BinarizeThresh', 'PMT1hv(ssc)', 'PMT2hv(chl)', 'BlobSizeThresh']

CONTEXT = 'context'

ADC_EXT = 'adc'
ROI_EXT = 'roi'
HDR_EXT = 'hdr'

# other handy property names
TARGET_NUMBER = 'targetNumber' # 1-based index of ROI in bins
BIN_ID = 'binID' # bin ID
TARGET_ID = 'targetID' # target ID
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

ISO_8601_FORMAT = '%Y-%m-%dT%H:%M:%SZ'

class Timestamped:
    time_format = ISO_8601_FORMAT

    def time_string(self):
        return '1970-01-01T00:00:00Z'
        
    def time(self):
        return time.strptime(self.time_string(), self.time_format)
    
    def iso8601time(self):
        return time.strftime(ISO_8601_FORMAT,self.time())
