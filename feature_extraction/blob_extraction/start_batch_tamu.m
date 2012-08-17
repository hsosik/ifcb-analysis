%start_batch_tamu.m
%configure and initiate batch processing for blob extractiom

in_url = 'http://ifcb-data.whoi.edu/saltpond/'; %USER web services to access data
out_base_dir = 'G:\work\test\blobs\'; %USER main blob output location
year = 2012; %USER

final_day = 365;
%check for leap year
temp = datenum(year,0,366); temp = datevec(temp);
if temp(1) == year, final_day = 366; end;

%loop over all possible days in year
for daycount = 1:final_day,
    daystr = datestr([year,0,daycount,0,0,0],29);
    bins = list_day(daystr,in_dir);
    if ~isempty(bins),
        [~,f] = fileparts(bins{1})
        if f(1) = 'D', %case for new data system IFCB7 and later
            day_dir = daystr; daystr([5,8]) = [];
        else %presume old data system
            day_dir = [num2str(year) '_' num2str(daycount)];
        end;
        out_dir = [out_base_dir num2str(year) filesep day_dir filesep];
        if ~exist(out_dir, 'dir'),
            mkdir(out_dir)
        end;
        bins2 = dir([out_dir 'D*']);
        bins = regexprep({bins.name}, '.adc', ''); 
        bins2 = regexprep({bins2.name}, '_blobs_v2.zip', '');
        [~,ii] = setdiff(bins, bins2);
        bins = bins(ii);
        batch_blobs(in_url, out_dir, bins);
    end;
end;
    