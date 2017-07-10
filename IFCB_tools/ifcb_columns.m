function cols = ifcb_columns(path)
% Given a path or URL of an IFCB raw data file, return a structure
% with constants identifying the ADC columns of that data.

    s1 = struct();
    s1.TRIGGER = 1;
    s1.PROCESSING_END_TIME = 2;
    s1.FLUORESCENCE_LOW = 3;
    s1.FLUORESCENCE_HIGH = 4;
    s1.SCATTERING_LOW = 5;
    s1.SCATTERING_HIGH = 6;
    s1.COMPARATOR_PULSE = 7;
    s1.TRIGGER_OPEN_TIME = 8;
    s1.FRAME_GRAB_TIME = 9;
    s1.ROI_X = 10;
    s1.ROI_Y = 11;
    s1.ROI_WIDTH = 12;
    s1.ROI_HEIGHT = 13;
    s1.START_BYTE = 14;
    s1.VALVE_STATUS = 15;

    s2 = struct();
    s2.TRIGGER = 1;
    s2.ADC_TIME = 2;
    s2.PMT_A = 3;
    s2.PMT_B = 4;
    s2.PMT_C = 5;
    s2.PMT_D = 6;
    s2.PEAK_A = 7;
    s2.PEAK_B = 8;
    s2.PEAK_C = 9;
    s2.PEAK_D = 10;
    s2.TIME_OF_FLIGHT = 11;
    s2.GRAB_TIME_START = 12;
    s2.GRAB_TIME_END = 13;
    s2.ROI_X = 14;
    s2.ROI_Y = 15;
    s2.ROI_WIDTH = 16;
    s2.ROI_HEIGHT = 17;
    s2.START_BYTE = 18;
    s2.COMPARATOR_OUT = 19;
    s2.START_POINT = 20;
    s2.SIGNAL_LENGTH = 21;
    s2.STATUS = 22;
    s2.RUN_TIME = 23;
    s2.INHIBIT_TIME = 24;

    [~, basepath, ~] = fileparts(path);

    if basepath(1) == 'I'
        cols = s1;
    else
        cols = s2;
    end
end