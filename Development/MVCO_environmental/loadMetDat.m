%X=load('c:\work\mvco\otherdata\2007_MetDat_s.C99','ascii');

yd_met=X(:,2);
Year = X(:,1);
Month = X(:,3);
Day = X(:,4);
Hour = X(:,5);
Minute = X(:,6);
Second = X(:,7);

Wspd_son3D_mean=X(:,8);
Wdir_son3D_mean=X(:,9);
Tair_vai_mean=X(:,10);
RH_vai_mean=X(:,11);
Pressure_vai_mean=X(:,12);
IR_campmt_median=X(:,13);
Solar_campmt_median=X(:,14);
Rain_campmt=X(:,15);
Tson_son3D_mean=X(:,16);

Wspd_son3D_std=X(:,17);
v_son3D_std=X(:,18);
w_son3D_std=X(:,19);

uv_son3D_var=X(:,20);
uw_son3D_var=X(:,21);
vw_son3D_var=X(:,22);

wTv_son3D_var=X(:,23);
wTv_son3DVaiPTU_var=X(:,24);
wT_son3DVaiPTU_var=X(:,25);
wrhov_son3DVaiPTULicor_var=X(:,26);
wco2_son3DVaiPTULicor_var=X(:,27);

lrec_3d = X(:,26);
lrec_vai=X(:,29);
lrec_li=X(:,30);
lrec_camp=X(:,31);

clear X ans n2
