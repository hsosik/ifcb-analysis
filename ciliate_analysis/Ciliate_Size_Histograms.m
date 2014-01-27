
%load 'C:\Users\Emily Fay\Documents\Ciliate_Code\count_biovol_size_manual_01May2013.mat'

ii = find(floor(matdate) == datenum('2-9-2010')); %skip this day with one partial sample
matdate(ii) = []; filelist(ii) = [];
fnames = fields(biovol);
for fcount = 1:length(fnames),
%    disp(fcount)
    biovol.(fnames{fcount})(ii) = [];
    eqdiam.(fnames{fcount})(ii) = [];
    ml_analyzed_struct.(fnames{fcount})(ii) = [];
end;
clear ii fnames fcount

day = floor(matdate);
unqday = unique(day);
classes = fields(ml_analyzed_struct);
for classcount = 1:length(classes),
    [biovol_day(1:length(unqday)).(classes{classcount})] = deal([]);
    [ml_day(1:length(unqday)).(classes{classcount})] = deal(NaN);
end;
%C_day = biovol_day;
N_day = ml_day;
eqdiam_day = biovol_day;
for daycount = 1:length(unqday),
    disp(datestr(unqday(daycount)))
    %ii = find(day == unqday(daycount));
    for classcount = 1:length(classes),
        ii = find(day == unqday(daycount) & ~isnan(ml_analyzed_struct.(classes{classcount})'));
        biovol_day(daycount).(classes{classcount}) = cat(1,biovol.(classes{classcount}){ii});
        eqdiam_day(daycount).(classes{classcount}) = cat(1,eqdiam.(classes{classcount}){ii});
        ml = nansum(ml_analyzed_struct.(classes{classcount})(ii));
        if ml ~= 0,
            ml_day(daycount).(classes{classcount}) = ml;
            N_day(daycount).(classes{classcount}) = length(biovol_day(daycount).(classes{classcount}));
        end;
    end;
end;


diambins = 0:2:150;
year_list=2006:2012;
dv = datevec(unqday);


%creating 3D matrix for diameter bins of every month for every year
%(151x12x7)(number of bins x month x year)
for year_count=1:length(year_list);%loops over each year
for month=1:12 %in each year loops over each month
ind = find(dv(:,1) == year_list(year_count) & dv(:,2) == month & ~isnan([ml_day.ciliate]')); %finds years and months
%ind = find(dv(:,1) == year_list(year_count) & dv(:,2) == month & ~isnan([ml_day.tintinnid]')); %finds years and months
h=nan(length(diambins),length(ind));%creates an empty 3D matrix to accomadate for the amount of bins, months, and years
for j=1:length(ind)% loops over every individual month and year
    day_index = ind(j);%the amount of individual days found in each month and year
    h(:,j)=hist(eqdiam_day(day_index).ciliate, diambins)./ml_day(day_index).ciliate; %stores a histogram amount of cells in each diameter bin/ml for each day
    %h(:,j)=hist(eqdiam_day(day_index).tintinnid, diambins)./ml_day(day_index).tintinnid;
end
meanh(:,month,year_count) = mean(h,2); %average all bins across days of each month
end
end

    
    
    