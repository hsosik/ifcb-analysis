import os
import time
import calendar

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
# note that "width" means x and "height" means y.
# however, images returned from the image endpoint are rotated 90 degrees.
# see ifcb.io.convert for details

# TODO define each schema element
# TODO units of measure
# adc column name and type pairs
ADC_SCHEMA = [(TRIGGER, int),
          (PROCESSING_END_TIME, float),
          (FLUORESCENCE_LOW, float),
          (FLUORESENCE_HIGH, float),
          (SCATTERING_LOW, float),
          (SCATTERING_HIGH, float),
          (COMPARATOR_PULSE, float),
          (TRIGGER_OPEN_TIME, float),
          (FRAME_GRAB_TIME, float),
          (BOTTOM, int),
          (LEFT, int),
          (HEIGHT, int),
          (WIDTH, int),
          (BYTE_OFFSET, int),
          (VALVE_STATUS, float)]
ADC_COLUMNS = [col for (col,ignore) in ADC_SCHEMA]

# hdr attributes. these are camel-case, mapped to column names below
TEMPERATURE = 'temperature'
HUMIDITY = 'humidity'
BINARIZE_THRESHOLD = 'binarizeThreshold'
SCATTERING_PMT_SETTING = 'scatteringPhotomultiplierSetting'
FLUORESCENCE_PMT_SETTING = 'fluorescencePhotomultiplierSetting'
BLOB_SIZE_THRESHOLD = 'blobSizeThreshold' 

# column name / type pairs
HDR_SCHEMA = [(TEMPERATURE, float),
              (HUMIDITY, float),
              (BINARIZE_THRESHOLD, int),
              (SCATTERING_PMT_SETTING, float),
              (FLUORESCENCE_PMT_SETTING, float),
              (BLOB_SIZE_THRESHOLD, int)]
# hdr column names
HDR_COLUMNS = ['Temp', 'Humidity', 'BinarizeThresh', 'PMT1hv(ssc)', 'PMT2hv(chl)', 'BlobSizeThresh']

CONTEXT = 'context'

# file extensions
ADC_EXT = 'adc'
ROI_EXT = 'roi'
HDR_EXT = 'hdr'

# levels of detail
DETAIL_FULL = 'full' # complete
DETAIL_SHORT = 'short' # summary
DETAIL_HEAD = 'head' # shorter than "short"; just the header

# other handy property names
TARGET_NUMBER = 'targetNumber' # 1-based index of ROI in bins
BIN_ID = 'binID' # bin ID
TARGET_ID = 'targetID' # target ID
PID = 'pid'

TARGET_INFO = ADC_COLUMNS + [TARGET_NUMBER, BIN_ID, PID]

# path functions
def ext_path(id, ext, dir='.'):
    """Generate a path for a given local ID and extension"""
    return os.path.join(dir,id) + '.' + ext

def adc_path(id,dir='.'):
    """Generate the ADC file path for a given local ID"""
    return ext_path(id,ADC_EXT,dir)
def roi_path(id,dir='.'):
    """Generate the ROI file path for a given local ID"""
    return ext_path(id,ROI_EXT,dir)
def hdr_path(id,dir='.'):
    """Generate the HDR file path for a given local ID"""
    return ext_path(id,HDR_EXT,dir)

# standard time formats, suitable for rendering and parsing UTC times only
ISO_8601_FORMAT = '%Y-%m-%dT%H:%M:%SZ'
RFC_822_FORMAT = '%a, %d %b %Y %H:%M:%S +0000'

class Timestamped(object):
    """Base class for entities with timestamps derived from a string in some format, stored in the time_string property.
    To set the time, set the time_string property."""
    time_format = ISO_8601_FORMAT
    time_string = '1970-01-01T00:00:00Z'

    """Parse the time string"""
    @property
    def time(self):
        return time.strptime(self.time_string, self.time_format)
    
    """Render the time in ISO 8601"""
    @property
    def iso8601time(self):
        return time.strftime(ISO_8601_FORMAT,self.time)
    
    """Render the time in RFC 822"""
    @property
    def rfc822time(self):
        return time.strftime(RFC_822_FORMAT,self.time)
    
    """ Return the time as milliseconds since the *NIX epoch"""
    @property
    def epoch_time(self):
        return calendar.timegm(self.time)

