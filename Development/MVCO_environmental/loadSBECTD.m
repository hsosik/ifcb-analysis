%X=load('/var/ftp/pub/mvcodata/data/SBECTD_s/2002/2002_SBECTD_s.C07','ascii');
X=load('c:\work\mvco\otherdata\2005_SBECTD_s.C07','ascii');

Year=X(:,1);
yd_sbectd=X(:,2);
Month = X(:,3);
Day = X(:,4);
Hour = X(:,5);
Minute = X(:,6);
Second = X(:,7);

lrec_sbectd=X(:,8);

Tw_sbectd_mean=X(:,9);
Saln_sbectd_mean=X(:,10);
dpth_sbectd_mean=X(:,11);

Tw_sbectd_median=X(:,12);
Saln_sbectd_median=X(:,13);
dpth_sbectd_median=X(:,14);

Tw_sbectd_std=X(:,15);
Saln_sbectd_std=X(:,16);
dpth_sbectd_std=X(:,17);

Tw_sbectd_length=X(:,18);
Saln_sbectd_length=X(:,19);
dpth_sbectd_length=X(:,20);

%clear X
