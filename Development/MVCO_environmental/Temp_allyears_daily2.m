datadir = '\\sosiknas1\Lab_data\MVCO\EnvironmentalData\';
load([datadir 'other2001'])
load([datadir 'other2002'])
load([datadir 'other2003_04'])
load([datadir 'other2005'])
load([datadir 'other2006'])
load([datadir 'other2007'])
load([datadir 'other2008'])
load([datadir 'other2009'])
load([datadir 'other2010'])
load([datadir 'other2011'])
load([datadir 'other2012'])
load([datadir 'other2013'])
load([datadir 'other2014'])
load([datadir 'other2015'])
load([datadir 'other2016'])

%this will lead to averaging of seacat and node temps for overlap days
yd_ocn2003 = [yd_ocn2003; yd_seacat2003];
Temp2003 = [Temp2003; temp_seacat2003];
yd_ocn2004 = [yd_ocn2004; yd_seacat2004];
Temp2004 = [Temp2004; temp_seacat2004];

yd = (1:366)';
%year = (2003:2016);
year = (2001:2016);
Tday = NaN(length(yd),length(year));
for count = 1:length(year),    
    eval(['yd_ocn = yd_ocn' num2str(year(count)) ';'])
    eval(['Temp = Temp' num2str(year(count)) ';'])
    for day = 1:366,
        ii = find(floor(yd_ocn) == day);
        Tday(day,count) = nanmean(Temp(ii));
    end;
end;

mdate_year = datenum(year,0,0);
mdate = repmat(yd,1,length(year))+repmat(mdate_year,length(yd),1);

Tday2 = Tday(:);
mdate2 = mdate(:);

%omit the double 1 Jan after non-leap years
ii = find(diff(mdate2)==0);
mdate2(ii) = [];
Tday2(ii) = [];
Tday(ii) = NaN;
mdate(ii) = NaN;

%mdate = mdate2; Tday = Tday2;
save([datadir 'Tall_day'], 'mdate2', 'Tday2', 'mdate', 'Tday', 'year', 'yd')