%Emily Peacock October 2016 writing to estimate
%volume analyzed for files that don't have look times due to DAQ errors
%First section is sometimes commented out, because it saved a file that does not need to be remade every time.
clear all;
data_dir = '\\sosiknas1\IFCB_data\IFCB101_GordonGunterJun2016\data\2016\';
daylist = dir(strcat(data_dir, '\D*'));
daylist = {daylist.name}';
temp=0;
for i = 1:length(daylist);
    roilist = dir(strcat(data_dir, char(daylist(i)), filesep, '*.roi'));
    ind4 = find(([roilist.bytes] >0));
    %adclist = dir(strcat(data_dir, char(daylist(i)), filesep, '*.adc'));
    temp2 = length(ind4);
    temp= temp+temp2;
end

volume_summary = zeros(temp,4);
filelist = cell(length(temp),1);

for i = 1:length(daylist);
    daylist(i)
    roilist = dir(strcat(data_dir, char(daylist(i)), filesep, '*.roi'));
    ind4 = find(([roilist.bytes] >0));
    adclist = dir(strcat(data_dir, char(daylist(i)), filesep, '*.adc'));
    adclist = {adclist(ind4).name}';
    hdrlist = dir(strcat(data_dir, char(daylist(i)), filesep, '*.hdr'));
    hdrlist = {hdrlist.name}';
    for j= 1:length(adclist);
    sum_temp = zeros(1,4);
    temp = load(strcat(data_dir, char(daylist(i)), filesep, char(adclist(j))));
    sum_temp(3) = (length(temp));
    sum_temp(4) = temp(end,end-1);
    %if a file has the last row of the last column of the adc file == 0,
    %put a NaN in the ml_analyzed column.
        if temp(end,end)==0;
            sum_temp(2) = (NaN);
     %if it is a good file, no DAQ errors, get the ml_analyzed, runtime and
     %inhibit time from the hdr file. 
        else
       [ml_analyzed, runtime, inhibittime] = IFCB_volume_analyzed_runtime(strcat(data_dir, char(daylist(i)), filesep, char(hdrlist(j))));
          sum_temp(2) = (ml_analyzed);
          sum_temp(4) = (runtime);
        end
    
    
    ind= find(volume_summary(:,2)==0);
    volume_summary(ind(1),1:4)= sum_temp;
    filelist(ind(1)) = adclist(j);
      
    end;
end;
summary_header = {'filename', 'ml_analyzed', 'adc_length', 'runtime'};



%ind1 = find(~isnan(volume_summary(:,2)) & (volume_summary(:,4) > 1173)); 
ind1 = find(~isnan(volume_summary(:,2)) & (volume_summary(:,4) > 1156)); 
mdl = fitlm(volume_summary(ind1,3),(volume_summary(ind1,2)), 'linear');
vol_est = mdl.Coefficients{2,1}*(volume_summary(:,3))+mdl.Coefficients{1,1};
ind2 = find(isnan(volume_summary(:,2)));
%ind3 = find(~isnan(volume_summary(:,2)) & (volume_summary(:,4) < 1173)); 
ind3 = find(~isnan(volume_summary(:,2)) & (volume_summary(:,4) < 1156)); 

save \\sosiknas1\IFCB_data\IFCB101_GordonGunterJun2016\metadata\volume_summary volume_summary filelist...
    summary_header ind1 ind2 ind3 mdl vol_est;

clear all;close all;
load \\sosiknas1\IFCB_data\IFCB101_GordonGunterJun2016\metadata\volume_summary.mat;
load('\\sosiknas1\IFCB_products\IFCB101_GordonGunterJun2016\class\summary\summary_biovol_allTB.mat');


figure
plot(mdl); hold on;

figure

hold on;
plot(volume_summary(ind1,3), vol_est(ind1), '.k');%files that have estimated and actual volumes
plot(volume_summary(ind2,3), vol_est(ind2), '.c');%files that have only estimated volumes

ml_analyzedTB_est = ml_analyzedTB;
ml_analyzedTB_est(ind2) = vol_est(ind2);
save \\sosiknas1\IFCB_products\IFCB101_GordonGunterJun2016\class\summary\ml_analyzedTB_est ml_analyzedTB_est;

figure
plot(ml_analyzedTB, '.')
hold on
plot(ml_analyzedTB_est, 'r.')






 
    
 