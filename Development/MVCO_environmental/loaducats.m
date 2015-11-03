% read in ucat density array summary data
%X=load('2005_ucats_s.S99','ascii');
%X=load('2006_ucats_s.S99','ascii');
%X=load('2007_ucats_s.S99','ascii');
%X=load('2008_ucats_s.S99','ascii');
%X=load('2008_ucats_s.M99','ascii');
X=load('2009_ucats_s.M99','ascii');

Year=X(:,1);
yd_ucats=X(:,2);
Month = X(:,3);
Day = X(:,4);
Hour = X(:,5);
Minute = X(:,6);
Second = X(:,7);

Tw_ucats_mean(:,3)=X(:,10);
Tw_ucats_mean(:,2)=X(:,9);
Tw_ucats_mean(:,1)=X(:,8);

Saln_ucats_mean(:,3)=X(:,13);
Saln_ucats_mean(:,2)=X(:,12);
Saln_ucats_mean(:,1)=X(:,11);

Cond_ucats_mean(:,3)=X(:,16);
Cond_ucats_mean(:,2)=X(:,15);
Cond_ucats_mean(:,1)=X(:,14);

dpth_ucats_mean(:,3)=X(:,19);
dpth_ucats_mean(:,2)=X(:,18);
dpth_ucats_mean(:,1)=X(:,17);

air_press_corectn = X(:,20);
%clear X
