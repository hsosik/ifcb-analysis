%Emily Peacock October 2016 writing to estimate
%volume analyzed for files that don't have look times due to DAQ errors
%First section is commented out, because it saved a file that does not need to be remade every time.
clear all;
data_dir = '\\sosiknas1\IFCB_data\IFCB101_BigelowMay2015\data\2015\';
daylist = dir(strcat(data_dir, '\D*'));
daylist = {daylist.name}';

temp=0;
for i = 1:length(daylist);
    adclist = dir(strcat(data_dir, char(daylist(i)), filesep, '*.adc'));
    temp2 = length(adclist);
    temp= temp+temp2;
end

volume_summary = zeros(temp,6);
filelist = cell(length(temp),1);

for i = 1:length(daylist);

    adclist = dir(strcat(data_dir, char(daylist(i)), filesep, '*.adc'));
    adclist = {adclist.name}';
    hdrlist = dir(strcat(data_dir, char(daylist(i)), filesep, '*.hdr'));
    hdrlist = {hdrlist.name}';
    for j= 1:length(adclist);
    sum_temp = zeros(1,6);
    temp = load(strcat(data_dir, char(daylist(i)), filesep, char(adclist(j))));
    ROIwidth = temp(:,14);
    ROIheight = temp(:,15);
    total_area = sum(ROIwidth.*ROIheight);
    %sum_temp(1) = adclist(j);
    sum_temp(4) = total_area;
    sum_temp(3) = (length(temp));
        if temp(end,end)==0;
            sum_temp(2) = (NaN);
        else
          [ml_analyzed, runtime, inhibittime] = IFCB_volume_analyzed_runtime(strcat(data_dir, char(daylist(i)), filesep, char(hdrlist(j))));
          sum_temp(2) = (ml_analyzed);
          sum_temp(5) = (runtime);
          sum_temp(6) = (inhibittime);
        end
    ind= find(volume_summary(:,2)==0);
    volume_summary(ind(1),1:6)= sum_temp;
    filelist(ind(1)) = adclist(j);
      
    end;
end;
summary_header = {'filename', 'ml_analyzed', 'adc_length', 'total_ROI_area', 'runtime', 'inhibittime'};



ind1 = find(~isnan(volume_summary(:,2)) & (volume_summary(:,5) > 1174 & volume_summary(:,5) < 1175));
mdl = fitlm(volume_summary(ind1,3),(volume_summary(ind1,2)), 'linear');
vol_est = mdl.Coefficients{2,1}*(volume_summary(:,3))+mdl.Coefficients{1,1};
ind2 = find(isnan(volume_summary(:,2)));

save \\sosiknas1\IFCB_data\IFCB101_BigelowMay2015\metadata\volume_summary volume_summary filelist...
    summary_header ind1 ind2 mdl vol_est;

clear all;close all;
load \\sosiknas1\IFCB_data\IFCB101_BigelowMay2015\metadata\volume_summary.mat;


figure
plot(mdl); hold on;

figure
plot(volume_summary(ind2,3), vol_est(ind2), '.c');%files that have only estimated volumes
plot(volume_summary(ind1,3), vol_est(ind1), '.k');%files that have estimated and actual volumes











    %columns 14 and 15 are ROIwidth and ROIheight
    
    
 