%X=load('/var/ftp/pub/mvcodata/data/YSICTD_s/2001/2001_YSICTD_s.C09','ascii');
X=load('c:/work/mvco/otherdata/2002_YSICTD_s.C09','ascii');
Year=X(:,1);
yd_ysictd=X(:,2);
Month = X(:,3);
Day = X(:,4);
Hour = X(:,5);
Minute = X(:,6);
Second = X(:,7);

lrec_ysictd=X(:,8);

Tw_ysictd_mean=X(:,9);
Saln_ysictd_mean=X(:,10);
doxy_ysictd_mean=X(:,11);
dpth_ysictd_mean=X(:,12);
pH_ysictd_mean=X(:,13);
Orp_ysictd_mean=X(:,14);
Turb_ysictd_mean=X(:,15);
Ch_ysictd_mean=X(:,16);
pF_ysictd_mean=X(:,17);

Tw_ysictd_median=X(:,18);
Saln_ysictd_median=X(:,19);
doxy_ysictd_median=X(:,20);
dpth_ysictd_median=X(:,21);
pH_ysictd_median=X(:,22);
Orp_ysictd_median=X(:,23);
Turb_ysictd_median=X(:,24);
Ch_ysictd_median=X(:,25);
pF_ysictd_median=X(:,26);

Tw_ysictd_std=X(:,27);
Saln_ysictd_std=X(:,28);
doxy_ysictd_std=X(:,29);
dpth_ysictd_std=X(:,30);
pH_ysictd_std=X(:,31);
Orp_ysictd_std=X(:,32);
Turb_ysictd_std=X(:,33);
Ch_ysictd_std=X(:,34);
pF_ysictd_std=X(:,35);

Tw_ysictd_length=X(:,36);
Saln_ysictd_length=X(:,37);
doxy_ysictd_length=X(:,38);
dpth_ysictd_length=X(:,39);
pH_ysictd_length=X(:,40);
Orp_ysictd_length=X(:,41);
Turb_ysictd_length=X(:,42);
Ch_ysictd_length=X(:,43);
pF_ysictd_length=X(:,44);

clear X
