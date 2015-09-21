resultpath = '\\Dq-cytobot-pc\IFCB\manual\'; %USER
roibasepath = '\\Dq-cytobot-pc\IFCB\data\'; %USER
%filelist = dir([resultpath 'D20150513*.mat']);
load([resultpath 'manual_list_TAMUG']) %load the manual list detailing annotate mode for each sample file

category_list = manual_list(1,2:end);
filelist = char(manual_list(2:end,1)); filelist = cellstr(filelist(:,1:end-4));
analyzed_flags_byfile = cell2mat(manual_list(2:end,2:end));
analyzed_flags_byfile(analyzed_flags_byfile == 0) = NaN;
    
%calculate date
matdate = IFCB_file2date(filelist);

load([resultpath filelist{1}]) %read first file to get classes
numclass = length(class2use_manual);
class2use_manual_first = class2use_manual;
class2use_here = class2use_manual;
classcount = NaN(length(filelist),numclass);  %initialize output
ml_analyzed = NaN(length(filelist),1);
for filecount = 1:length(filelist),
    filename = filelist{filecount};
    disp(filename)
    hdrname = [roibasepath filesep filename(1:5) filesep filename(1:9) filesep filename '.hdr']; 
    ml_analyzed(filecount) = IFCB_volume_analyzed(hdrname);
     
    load([resultpath filename])
    if ~isequal(class2use_manual, class2use_manual_first)
        [t,ii] = min([length(class2use_manual_first), length(class2use_manual)]);
        if ~isequal(class2use_manual(1:t), class2use_manual_first(1:t)),
            disp('class2use_manual does not match previous files!!!')
            keyboard
        else
            if ii == 1, class2use_manual_first = class2use_manual; end; %new longest list
        end;
    end;
    for classnum = 1:numclass,
            classcount(filecount,classnum) = size(find(classlist(:,2) == classnum | (isnan(classlist(:,2)) & classlist(:,3) == classnum)),1);
            %classcount(filecount,classnum) = size(find(classlist(:,2) == classnum),1); %manual only
    end;
    clear class2use_manual class2use_auto class2use_sub* classlist
end;
ml_analyzed_mat = repmat(ml_analyzed,1,length(class2use_here)).*analyzed_flags_byfile;

class2use = class2use_here;
if ~exist([resultpath 'summary\'], 'dir')
    mkdir([resultpath 'summary\'])
end;
datestr = date; datestr = regexprep(datestr,'-','');
save([resultpath 'summary\count_manual_' datestr], 'matdate', 'ml_analyzed_mat', 'classcount', 'filelist', 'class2use')

%create and save daily binned results
[matdate_bin, classcount_bin, ml_analyzed_mat_bin] = make_day_bins(matdate,classcount, ml_analyzed_mat);
save([resultpath 'summary\count_manual_' datestr '_day'], 'matdate_bin', 'classcount_bin', 'ml_analyzed_mat_bin', 'class2use')
save([resultpath 'summary\count_manual_current_day'], 'matdate_bin', 'classcount_bin', 'ml_analyzed_mat_bin', 'class2use')

return

% for example, get manual summary file to plot, load D:\IFCB\manual\summary\count_manual_28Jul2015

%use this section to reference tamug_table
load \\dq-cytobot-pc\IFCB\data\tamug_table.mat; %be sure to update tamug_table.mat first.
 row_numbers = find(tamug_table.sample_type2 == 'timeseries' |tamug_table.sample_type == 'timeseries'); % gives list of row numbers that meets criteria
filelist_table = tamug_table{row_numbers,{'filename'}}; %gives a list of files that meet the criteria
 filelistTBstr = cellstr(filelist_table);
 row_numbers = find(ismember(filelistTBstr, filelist)==1);
 
figure %example
classnum = 1;
plot(matdate(row_numbers), classcount(row_numbers,classnum)./ml_analyzed_mat(row_numbers,classnum), '.-')
datetick('x')
ylabel([class2use{classnum} ' (mL^{-1})'])

%use this section to plot without referencing tamug_table

figure %example
classnum = 1;
plot(matdate, classcount(:,classnum)./ml_analyzed_mat(:,classnum), 'r.-')
datetick('x')
ylabel([class2use{classnum} ' (mL^{-1})'])

