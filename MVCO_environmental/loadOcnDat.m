%X=load ('c:\work\mvco\otherdata\2011_OcnDat_s.C99','ascii');
clear Hs Tbar theta_w Uc Uc_dir%added by heidi for case of existing workspace from load of previous year
%X=load('/var/ftp/pub/mvcodata/data/OcnDat_s/2001/2001_OcnDat_s.C99','ascii');
yd_ocn=X(:,2);
Year = X(:,1);
Month = X(:,3);
Day = X(:,4);
Hour = X(:,5);
Minute = X(:,6);
Second = X(:,7);

Hs(:,1)=X(:,8);
Tbar(:,1)=X(:,9);
theta_w(:,1)=X(:,10);

Temp_adcp=X(:,11);

nbins=2;
ns=12;
for nb=1:nbins(1)
    Uc(:,nb)=X(:,ns);
    Uc_dir(:,nb)=X(:,ns+1);
    ns=ns+2;
end

Tide=X(:,16);
Temp=X(:,17);
Saln=X(:,18);

Hs(:,2:3)=X(:,19:20);
Tbar(:,2:3)=X(:,21:22);
theta_w(:,2:3)=X(:,23:24);
    
clear X nbins ns n2 
