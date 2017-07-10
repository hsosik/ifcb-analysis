function bin = ifcb_open_raw(path)
% Given the pathname of a raw data file (any file, .adc, .roi, or .hdr),
% return a structure with the following fields:
% - lid: the identifier of the file (path without directory or extension)
% - adc: the ADC data as a matrix (see ifcb_columns for column IDs)
% - images: a cell array of (unstitched) images

    [dir, lid, ~] = fileparts(path);
    abs_basepath = [dir filesep lid];

    adc_path = [abs_basepath '.adc'];
    roi_path = [abs_basepath '.roi'];

    cols = ifcb_columns(path);
    
    adc = csvread(adc_path);
    
    [len, ~] = size(adc);

    images = cell(len, 1);

    fin = fopen(roi_path);

    for n = 1:len
        w = adc(n, cols.ROI_WIDTH);
        h = adc(n, cols.ROI_HEIGHT);
        n_bytes = w * h;

        if n_bytes > 0
            start_byte = adc(n, cols.START_BYTE);

            fseek(fin, start_byte, 'bof');
            bytes = fread(fin, n_bytes);
            images{n} = uint8(reshape(bytes, w, h))';
        end
    end

    fclose(fin);
    
    bin = struct();
    bin.lid = lid;
    bin.adc = adc;
    bin.images = images;
end
