function [ Tday, Tanom_fcb, Tanom_ifcb ] = get_Tanom_node( year_fcb, year_ifcb )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


load c:\work\mvco\otherData\other03_04
load c:\work\mvco\otherData\other05
load c:\work\mvco\otherData\other06
load c:\work\mvco\otherData\other07
load c:\work\mvco\otherData\other08
load c:\work\mvco\otherData\other09
load c:\work\mvco\otherData\other10
load c:\work\mvco\otherData\other11
load c:\work\mvco\otherData\other12

yd_ocn2003 = [yd_ocn2003; yd_seacat2003];
Temp2003 = [Temp2003; temp_seacat2003];
yd_ocn2004 = [yd_ocn2004; yd_seacat2004];
Temp2004 = [Temp2004; temp_seacat2004];

yearall = (2003:2012);
Tday = NaN(length(yd),length(yearall));
for count = 1:length(yearall),    
    eval(['yd_ocn = yd_ocn' num2str(yearall(count)) ';'])
    eval(['Temp = Temp' num2str(yearall(count)) ';'])
    for day = 1:366,
        ii = find(floor(yd_ocn) == day);
        Tday(day,count) = nanmean(Temp(ii));
    end;
end;
[~,~,ii] = intersect(year_fcb,yearall);
Tmean_fcb = nanmean(Tday(:,ii),2);
Tanom_fcb = Tday(:,ii) - repmat(Tmean_fcb,1,length(year_fcb));
[~,~,ii] = intersect(year_ifcb,yearall);
Tmean = nanmean(Tday(:,ii),2);
Tanom_ifcb = Tday(:,ii) - repmat(Tmean,1,length(year_ifcb));

end

