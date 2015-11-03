%start_batch_tamu.m
%configure and initiate batch processing for blob extractiom

in_url = 'http://ifcb-data.whoi.edu/Healy1101/'; %USER web services to access data
out_base_dir = 'G:\work\Healy1101\blobs\'; %USER main blob output location
out_base_dir = '\\floatcoat\IFCBdata\IFCB8_HLY1101\blobs\'; 
year = 2011; %USER

final_day = 365;
%check for leap year
temp = datenum(year,0,366); temp = datevec(temp);
if temp(1) == year, final_day = 366; end;

%loop over all possible days in year
for daycount = 183:final_day,
    daystr = datestr([year,0,daycount,0,0,0],29);
    bins = list_day(daystr,in_url);
    if ~isempty(bins),
        [p,f] = fileparts(bins{1});
        bins = regexprep(bins,[p '/'], '')';
        if f(1) == 'D', %case for new data system IFCB7 and later
            day_dir = daystr; day_dir([5,8]) = [];
        else %presume old data system
            day_dir = [num2str(year) '_' num2str(daycount)];
        end;
        out_dir = [out_base_dir num2str(year) filesep day_dir filesep];
        if ~exist(out_dir, 'dir'),
            mkdir(out_dir)
        end;
        bins2 = dir([out_dir 'D*']);
        bins2 = regexprep({bins2.name}, '_blobs_v2.zip', '');
        [~,ii] = setdiff(bins, bins2);
        bins = bins(ii);        
        batch_blobs(in_url, out_dir, bins);
    else
        disp(['no bins on ' daystr])
    end;
end;
