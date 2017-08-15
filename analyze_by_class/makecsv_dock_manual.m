resultpath = '\\sosiknas1\IFCB_products\IFCB14_Dock\Manual_fromClass\';

urlstr = 'http://ifcb-data.whoi.edu/IFCB14_Dock/'

outpath = [resultpath 'annotations_csv_Aug2017\'];
if ~exist(outpath, 'dir')
    mkdir(outpath)
end;

filelist = dir([resultpath 'D*.mat']);
filelist = {filelist.name}';
filelist = regexprep(filelist, '.mat', '');

load class2use_MVCOmanual6 %get the master list to start

class2use_manual_first = class2use;
numclass = length(class2use_manual_first);
ciliate_ind = get_ciliate_ind(class2use, class2use);
[~,rawROIskip] = intersect(class2use, {'other' 'unclassified'});

for filecount = 1:length(filelist)
    filename = filelist{filecount};
    disp(filename)
    load([resultpath filename])
    if ~isequal(class2use_manual, class2use_manual_first)
        disp('class2use_manual does not match previous files!!!')
   %     keyboard
    end;
    filetemp = []; roinumtemp = filetemp; labeltemp = filetemp; persontemp = filetemp;
    rawROIcase = isempty(find(~isnan(classlist(:,3))));
    for classnum = 1:numclass
        if ismember(classnum, ciliate_ind)
            ind = find(classlist(:,2) == classnum | (isnan(classlist(:,2)) & classlist(:,3) == classnum));
        elseif ~rawROIcase || (rawROIcase && ~ismember(classnum, rawROIskip)) %export only the manual instances for classes that are not ciliates, ,skipping default classes for raw ROI cases
            ind = find(classlist(:,2) == classnum);
        end
        roinumtemp = ind;
      if ~isempty(roinumtemp) 
        fid = fopen([outpath class2use_manual{classnum} '.csv'], 'a');
        for ii = 1:length(roinumtemp)
             %fprintf(fid, '%s,%s%05.0f\r\n', labeltemp, [urlstr filename '_'], roinumtemp(ii));
             fprintf(fid, '%s%05.0f\r\n', [urlstr filename '_'], roinumtemp(ii));
        end;
        fclose(fid);
      end
    end;

    clear class2use_manual class2use_auto class2use_sub* classlist *temp fid 
end;



