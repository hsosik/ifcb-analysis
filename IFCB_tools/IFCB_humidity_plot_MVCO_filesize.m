% reads IFCB hdr files on demi (from MVCO) and plots temperature and
% humidity
clear
close all
start = '21 Nov 2013';
start = '29 May 2014';
stop = now; %'23 Nov 2013';
instr = 'IFCB1';
%dirpath = '\\128.128.108.93\data\D2014\';
dirpath = '\\demi\vol1\';
d = dir([dirpath '\' instr '*']);
isub = [d(:).isdir]; %# returns logical vector
d = d(isub); % only folders

startdate =  datenum(start);
stopdate =  datenum(stop);
dirname = struct2cell(d);
dirname = dirname(1,:); %names of dirs as cell array
dirlist = [];
for i=1:length(dirname)
    t = char(dirname(i));
    dirdate = doy2date(str2num(t(12:14)), str2num(t(7:10)));
    if dirdate >= startdate & dirdate <= stopdate
        t = yearday(dirdate);
        doy = num2str(t(2));
        while length(doy) < 3
            doy = ['0' doy];
        end
        dirlist = [dirlist; find(strcmp([instr '_' num2str(t(1)) '_' doy], dirname))];
%         disp(char(dirname(i)))
    end
end
dirlist = unique(dirlist);

figure(1)
clf
hold on
tim = [];
humidity = [];
temperature = [];
for j=1:length(dirlist)
    hdrdir = dir([dirpath dirname{dirlist(j)} '\*.hdr']);
    disp([dirname{dirlist(j)}])
    for i = 1:length(hdrdir)
        if hdrdir(i).bytes > 0 &  ~strcmp( hdrdir(i).name, 'IFCB5_2014_001_002145.hdr') % ignore year-turnover fluke?
            fid = fopen([dirpath hdrdir(i).name(1:14) '\' hdrdir(i).name]);
            count = 0;
            if fid == -1 % sometimes it can't open the file on demi, so try some more
                while count < 4
                    count = count+1
                    fid = fopen([dirpath hdrdir(i).name(1:14) '\' hdrdir(i).name]);
                    if count == 3
                        disp([' cannot open ' dirpath hdrdir(i).name(1:14) '\' hdrdir(i).name]);
                    end
                end
            end
            a = fscanf(fid,'%c');
            commapos = findstr(a,',');
            quotepos = findstr(a,'"');
            temperature = [temperature; str2num(a(quotepos(11)+2:quotepos(12)-1))];
            humidity = [humidity; str2num(a(quotepos(13)+2:quotepos(14)-1))];
            fclose(fid);
            tod = (str2num(hdrdir(i).name(16:17))/24 + str2num(hdrdir(i).name(18:19))/(24*60) +  str2num(hdrdir(i).name(20:21))/(24*3600));
            tim = [tim; doy2date(str2num(hdrdir(i).name(12:14))+tod, str2num(hdrdir(i).name(7:10)))];
        end
    end
end

%******************* adding to plot filesize
basepath = '\\demi\vol1\'; %choose data directory
templist = dir ([basepath 'IFCB1_2014*']);
daylist_char = char({templist.name});
dirlist = cellstr(daylist_char(:,1:14));

%featurefile_list = dir(['\\QUEENROSE\g_work_ifcb1\ifcb_data_mvco_jun06\features2014_v2\IFCB*']);
%featurefile_list = char({featurefile_list.name});
%featurefile_list = cellstr(featurefile_list(:,1:21));
%no_featurefile_list = '';
 file_size_list = '';   

for i = 1:length(templist);  

temp = char(dirlist(i));
    templist = dir([basepath temp '\' temp '*.roi']); %choose which hour(s) to take from each day
    for ii= 1:length(templist);
    templist_bytes = templist(ii).bytes;
    templist_datenum = templist(ii).datenum;
    %templist = cellstr(templist(:,1:21));
    %templist_char = char(templist);
   
          if isempty(file_size_list);
                file_size_list = templist(ii).bytes;
                else file_size_list = cat(2, file_size_list, templist(ii).bytes);
          end
         
          
 
              
    end
   
    
    
end

file_size_list = file_size_list';


%******************* adding to plot bead files
basepath = '\\demi\vol1\'; %choose data directory
beadlist = dir ([basepath 'beads\IFCB1_2014*.roi']);
daylist_char = char({beadlist.name});
dirlist = cellstr(daylist_char(:,1:14));
beadlist_bytes ='';
%featurefile_list = dir(['\\QUEENROSE\g_work_ifcb1\ifcb_data_mvco_jun06\features2014_v2\IFCB*']);
%featurefile_list = char({featurefile_list.name});
%featurefile_list = cellstr(featurefile_list(:,1:21));
%no_featurefile_list = '';
 %beadfile_size_list = '';   

for i = 1:length(beadlist);  


  
    
    if isempty(beadlist_bytes);
                beadlist_bytes = beadlist(i).bytes;
                else beadlist_bytes = cat(2, beadlist_bytes, beadlist(i).bytes);
          end
    %templist = cellstr(templist(:,1:21));
    %templist_char = char(templist);
         
end
   
  
    


beadlist_bytes = beadlist_bytes';
date = [];
tempday = daylist_char(:,12:14);
tempyr = daylist_char(:,7:10);
hr = str2double(cellstr(daylist_char(:,16:17)));
min = str2double(cellstr(daylist_char(:,18:19)));
sec = str2double(cellstr(daylist_char(:,20:21)));
for i = 1: length(tempday);
    x = str2double(cellstr(tempyr(i,:)));
    y = str2double(cellstr(tempday(i,:)));
date(i) = yearday(x, y);
end

wholedate = datevec(date);
wholedate(:,[4 5 6]) = [hr min sec];
date = datenum(wholedate);

%************************* end of added part

plot(datenum(tim),temperature,'r.')
hold on
plot(datenum(tim),humidity,'.')
ylim([-20 90])
legend('Temperature', 'Humidity',3)
datetick
xlabel('Date')
ylabel('Temperature (C) or Humidity (%)')
title(instr)

figure
plot(datenum(tim),file_size_list(1:end-1))
hold on
plot(datenum(tim),file_size_list(1:end-1),'g.')
plot(date, beadlist_bytes, 'r.')
datetick
xlabel('Date')
ylabel('filesize')
title(instr)
