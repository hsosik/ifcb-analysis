resultpath = '\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\';
load([resultpath 'manual_list']) %load the manual list detailing annotate mode for each sample file

urlstr = 'http://ifcb-data.whoi.edu/mvco/'

outpath = [resultpath 'annotations_csv_June2015\'];
if ~exist(outpath, 'dir')
    mkdir(outpath)
end;

%mode_list = manual_list(1,2:end-1); mode_list = [mode_list 'ciliate_ditylum' 'big_ciliate_ditylum'];
%filelist_all = char(manual_list(2:end,1)); filelist_all = cellstr(filelist_all(:,1:end-4));

load class2use_MVCOmanual4 %get the master list to start
[ classes_byfile, classes_bymode ] = get_annotated_classesMVCO( class2use, manual_list);

class2use_manual_first = class2use;
numclass = length(class2use_manual_first);
filelist = classes_byfile.filelist;
analyzed_flag = classes_byfile.classes_checked;

for filecount = 1:length(filelist),
    filename = filelist{filecount};
    disp(filename)
    load([resultpath filename])
    if ~isequal(class2use_manual, class2use_manual_first)
        disp('class2use_manual does not match previous files!!!')
   %     keyboard
    end;
    filetemp = []; roinumtemp = filetemp; labeltemp = filetemp; persontemp = filetemp;
    for classnum = 1:numclass,
        ind = [];
        if analyzed_flag(filecount,classnum),
            ind = find(classlist(:,2) == classnum | (isnan(classlist(:,2)) & classlist(:,3) == classnum));
%        else %export only the manual instances for classes that are not fully analyzed according to manual_list
%            ind = find(classlist(:,2) == classnum);
        end;
  %      roinumtemp = [roinumtemp; ind];
  %      labeltemp = [labeltemp; repmat(class2use_manual(classnum), length(ind),1);];
        roinumtemp = ind;
        labeltemp = class2use_manual{classnum};
        fid = fopen([outpath class2use_manual{classnum} '.csv'], 'a');
        for ii = 1:length(roinumtemp),
             fprintf(fid, '%s,%s%05.0f\r\n', labeltemp, [urlstr filename '_'], roinumtemp(ii));
        end;
        fclose(fid);
    end;
 %   %persontemp = repmat({'EPeacock'}, length(roinumtemp),1);
 %   fid = fopen([outpath filename '.csv'], 'w');
 %   for ii = 1:length(roinumtemp),
 %       fprintf(fid, '%s,%s%05.0f\r\n', labeltemp{ii}, [urlstr filename '_'], roinumtemp(ii));
 % %      fprintf(fid, '%s,%05.0f,%s,%s\n', filetemp(ii,:), roinumtemp(ii), labeltemp{ii}, persontemp{ii,:});
 %   end;
 %   fclose(fid);
    clear class2use_manual class2use_auto class2use_sub* classlist *temp fid 
end;



