% reads IFCB hdr files on demi (from MVCO) and plots temperature and
% humidity
clear
close all
start = '27 Apr 2015';
% start = '12 Mar 2015';
stop = now; %'23 Nov 2013';
instr = 'IFCB1';
%dirpath = '\\128.128.108.93\data\D2014\';
dirpath = '\\sosiknas1\IFCB_data\MVCO\data\2015\';
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
        if hdrdir(i).bytes > 0 &  ~strcmp( hdrdir(i).name, 'IFCB1_2014_001_002145.hdr') % ignore year-turnover fluke?
%         if hdrdir(i).bytes > 0 &  ~strcmp( hdrdir(i).name, 'IFCB5_2014_001_002145.hdr') % ignore year-turnover fluke?
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


plot(datenum(tim),temperature,'r.')
hold on
plot(datenum(tim),humidity,'.')
ylim([-20 90])
legend('Temperature', 'Humidity',3)
datetick
xlabel('Date')
ylabel('Temperature (C) or Humidity (%)')
title(instr)