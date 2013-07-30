%7.10.13 PRELIMINARY ANOSIM TEST
%today: made dissimilarity matrix using dis_braycurtis and f_dis with the
%'bc' method. Results of ANOSIM were slightly different depending on which
%matrix was used. 
dis52=f_braycurtis(Ciliate_week_flipped); %makes bray-curtis dissimilarity matrix by using f_braycurtis function. Gives you a 52x52 matrix
[r,p] = f_anosim(dis52,[1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1 1 1],1,1000,1,0)%used default settings with basically random seasonal groupings (1=cold, 2=warm)

dis = f_dis(Ciliate_week_mean_mat,'bc',0,1);%makes bray-curtis using f_dis function, with default settings.
[r,p] = f_anosim(dis,[1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1 1 1],1,1000,1,0)%used default settings with basically random seasonal groupings (1=cold, 2=warm)

result = f_simper(Ciliate_week_mean_mat,[1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1 1 1]',1,classes) %SIMPER is used in Mironova 2012 to look at species contribution to community differences.

%compare seasons (split up by 13-week increments): SIMPER can only compare
%between groups of 2. 
result = f_simper(Ciliate_week_mean_mat(27:52,:),[1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 2 2 2]',1,classes)
%make matrix of different seasonal sequence to do individual simpers on
%each pair of seasons (summer, winter, fall, spring)
Seasonal_simper_mat_flipped=[Ciliate_week_mean_mat(27:39,:)' Ciliate_week_mean_mat(1:13,:)' Ciliate_week_mean_mat(40:52,:)' Ciliate_week_mean_mat(27:39,:)'];
Seasonal_simper_mat=Seasonal_simper_mat_flipped';

%do ANOSIM with monthly categories to determine which months are different
%from each other (takes a long time!)
dis2=f_braycurtis(Ciliate_abundance_flipped);
[r,p] = f_anosim(dis2,[6 6 6 6 7 7 7 7 7 7 7 8 8 8 9 9 9 10 10 10 10 10 10 10 11 11 11 12 12 12 12 1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 3 3 3 3 3 4 4 4 4 4 5 5 5 5 5 5 5 6 6 6 6 6 7 10 10 10 10 10 10 10 11 11 11 11 11 11 12 12 12 12 12 1 1 1 1 1 1 2 2 2 2 2 3 3 3 3 3 3 4 4 4 4 4 4 4 5 5 5 5 5 5 6 6 6 6 7 7 7 7 7 7 8 8 8 8 8 8 8 9 9 11 11 11 11 12 12 12 12 12 12 12 12 12 1 1 1 1 1 2 2 2 2 3 3 3 3 3 4 4 4 4 4 5 5 5 5 5 5 6 6 6 6 6 7 7 7 7 7 7 7 7 8 8 8 8 8 9 9 9 9 9 9 9 9 10 10 10 10 10 10 10 10 10 10 10 11 11 11 11 11 11 11 12 12 12 12 12 1 1 1 1 1 2 2 2 2 2 2 2 3 3 3 3 3 4 4 4 4 5 5 5 5 6 6 6 6 6 6 7 7 7 7 7 7 8 8 8 8 9 9 9 9 9 9 9 9 10 10 10 10 11 11 11 11 12 12 12 1 1 1 1 1 2 2 2 3 3 3 3 3 3 4 4 4 4 5 5 5 5 6 6 6 6 6 6 7 7 7 7 7 7 7 7 8 8 8 8 9 9 9 9 9 9 9 10 10 10 10 11 11 11 11 11 11 11 12 12 12 12 12 12 12 12 1 1 1 1 1 2 2 2 2 2 3 3 4 4 5 5 5 6 6 7 7 8 8 8 9 9 9 9 9 9 10 10 10 11 11 12 12 1 1 1 2 2 3 3 4 4 4 5 5],1,1000,1,0)
