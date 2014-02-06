%resultpath = '\\mellon\saltpond\manualclassify\';
resultpath = '\\queenrose\IFCB014_OkeanosExplorerAug2013\data\Manual_fromClass\Alt\';
%resultpath = 'C:\Users\Emily Fay\Documents\Ciliate_Code\IFCB_14\Van\results\alt\';
%resultpath = 'C:\Users\Emily Fay\Documents\Ciliate_Code\IFCB_14\Van\results\normal\';
%urlbase = 'http://ifcb-data.whoi.edu/saltpond/';
urlbase = 'http://ifcb-data.whoi.edu/OkeanosExplorerAug2013_IFCB014/';
%basepath = 'C:\Users\Emily Fay\Documents\Ciliate_Code\IFCB_14\Van\';
filelist = dir([resultpath 'D*.mat']);
basepath = '\\queenrose\IFCB014_OkeanosExplorerAug2013\data\';

%calculate date
matdate_lowgreen = IFCB_file2date({filelist.name});

load([resultpath filelist(1).name]) %read first file to get classes
numclass1 = length(class2use_manual);
numclass2 = length(class2use_sub4);
numclass = numclass1 + numclass2;
class2use_manual_first = class2use_manual;
class2use_first_sub = class2use_sub4;
class2use_here = [class2use_manual_first class2use_sub4];
classcount = NaN(length(filelist),numclass);  %initialize output
ml_analyzed_lowgreen = NaN(length(filelist),1);



for filecount = 2:16,
%for filecount = 1:length(filelist),
    filename = filelist(filecount).name;
    disp(filename)
    hdrname = [basepath regexprep(filename, 'mat', 'hdr')]; 
    adcname = [basepath regexprep(filename, 'mat', 'adc')];
   ml_analyzed_lowgreen(filecount) = IFCB_volume_analyzed(hdrname);
    load([resultpath filename])
    adcdata = load(adcname);
    
    
    %refline(0.28 ,-1.8)
    %refline(0.4 ,-1.5)
    %refline(0.028,0.0023);
    %refline(0.20 ,-2.05)
    chl = log10(adcdata(:,5)); green = log10(adcdata(:,4));
    %low_green_ind = find(green > (chl-0.0015)/0.25);%bad
    %low_green_ind = find(green < ((chl-0.0023)/0.028));%bad
    %low_green_ind = find(green < ((chl+1.8)/0.28)); %for lowlow green
    %low_green_ind = find(green >= ((chl+1.8)/0.28)); %for highhigh green
    %low_green_ind = find(green >= ((chl+1.5)/0.4)); %for high green
    %low_green_ind = find(green < ((chl+1.5)/0.4)); %for low green
    low_green_ind = find(green < ((chl+2.05)/0.20)); %for lowlowlow green
    %low_green_ind = find(green >= ((chl+2.05)/0.20)); %for highhighhigh green
    
    classlist=classlist(low_green_ind,1:4);
    
       
    temp = zeros(1,numclass);
    for classnum = 1:numclass1,
                temp(classnum) = size(find(classlist(:,2) == classnum | (isnan(classlist(:,2)) & classlist(:,3) == classnum)),1);
    end;
       
            for classnum = 1:numclass2,
                temp(classnum+numclass1) = size(find(classlist(:,4) == classnum),1);
            end;
       
        classcount((filecount),:) = temp;
        
    end;
    
    classcount_lowgreen=classcount;
    filelist_lowgreen=filelist;

clear class2use_manual class2use_auto class2use_sub* classlist classcount filelist
class2use = class2use_here;
if ~exist([resultpath 'summary\'], 'dir')
    mkdir([resultpath 'summary\'])
end;
datestr = date; datestr = regexprep(datestr,'-','');
save([resultpath 'summary\count_manual_lowlow2_green' datestr], 'matdate_lowgreen', 'ml_analyzed_lowgreen', 'classcount_lowgreen', 'filelist_lowgreen', 'class2use')


% load '\\queenrose\IFCB010_OkeanosExplorerAug2013\data\Manual_fromClass\summary\count_manual_15Jan2014.mat'
% figure %example
% classnum = 72; %90 for tintinnid
% plot(matdate, classcount(:,classnum)./ml_analyzed, '.-')
% datetick('x')
% ylabel([class2use{classnum} ' (mL^{-1})'])
% hold on
% 
% load '\\queenrose\IFCB014_OkeanosExplorerAug2013\data\Manual_fromClass\summary\count_manual_15Jan2014.mat'
% 
% classnum = 72; %90 for tintinnid
% plot(matdate, classcount(:,classnum)./ml_analyzed, 'r.-')
% legend('IFCB10','IFCB14 stained ');
% 
% % figure %example
% % classnum = 1;
% % plot(matdate, classcount(:,classnum)./ml_analyzed, '.-')
% % datetick('x')
% % ylabel([class2use{classnum} ' (mL^{-1})'])

load '\\queenrose\IFCB014_OkeanosExplorerAug2013\data\Manual_fromClass\Alt\summary\count_manual_low_green23Jan2014.mat'
figure %example
classnum = 72; %90 for tintinnid
plot(matdate, classcount(:,classnum)./ml_analyzed, '.-')
datetick('x')
ylabel([class2use{classnum} ' (mL^{-1})'])
hold on

load '\\queenrose\IFCB010_OkeanosExplorerAug2013\data\Manual_fromClass\summary\count_manual_19Jan2014.mat'

classnum = 72; %90 for tintinnid
plot(matdate, classcount(:,classnum)./ml_analyzed, 'r.-')
legend('IFCB14 low green','IFCB10  ');



