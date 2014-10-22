%X=load ('/var/ftp/pub/mvcodata/data/ADCP_s/2001/2001_ADCP_s.C11','ascii');
clear vE_mean vN_mean I_mean I_std c_mean See Dee %added by heidi to clear from workspace for reading multiple years in seq
%X=load ('c:\work\mvco\otherdata\2003_ADCP_s.C11','ascii');
year=X(:,1);
yd_adcp=X(:,2);
Month = X(:,3);
Day = X(:,4);
Hour = X(:,5);
Minute = X(:,6);
Second = X(:,7);

lrec_adcp=X(:,8);
yday_adcp=X(:,9);

Pressure_adcp_mean=X(:,10);
Temp_adcp_mean=X(:,11);
Pressure_adcp_median=X(:,12);
Temp_adcp_median=X(:,13);
Pressure_adcp_std=X(:,14);
Temp_adcp_std=X(:,15);
Pressure_adcp_length=X(:,16);
Temp_adcp_length=X(:,17);
Nbadchk=X(:,18);
Nshort=X(:,19);
Pbad=X(:,20:23);
wave_height_pressure=X(:,24);
wave_period_pressure=X(:,25);

wave_height=X(:,26:28);
wave_period=X(:,29:31);
wave_dir=X(:,32:34);

Urms=X(:,35);
Pitch=X(:,36);
Roll=X(:,37);
Heading=X(:,38);
Z0=X(:,39);
dZ=X(:,40);
ns=41;

zz=Z0(1);

for n=1:25
	vE_mean(:,n)=X(:,ns); vN_mean(:,n)=X(:,ns+1);
	I_mean(:,n) = X(:,ns+2); I_std(:,n) = X(:,ns+3);
	c_mean(:,n) = X(:,ns+4);
	z(n)=zz;
	zz=zz+dZ(1);
	ns=ns+5;
	end
	
% middle freqency of each defined theta_w, wave_var (+-0.02)

f = 0.03125:1/64:0.49;

for n=1:30
	See(:,n)=X(:,ns);
	ns=ns+1;
	end
for n=1:30
	Dee(:,n)=X(:,ns);
	ns=ns+1;
	end
%clear X ans
See=See./100^2;
%clegend4(log10(See'));
%ph=pcolor(yd_adcp,(f),log10(See'));set(ph,'edgecolor','none')

