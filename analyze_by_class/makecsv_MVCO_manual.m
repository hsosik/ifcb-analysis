resultpath = '\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\';
load([resultpath 'manual_list']) %load the manual list detailing annotate mode for each sample file

outpath = [resultpath 'annotations_csv\'];
if ~exist(outpath, 'dir')
    mkdir(outpath)
end;

mode_list = manual_list(1,2:end-1); mode_list = [mode_list 'ciliate_ditylum' 'big_ciliate_ditylum'];
filelist_all = char(manual_list(2:end,1)); filelist_all = cellstr(filelist_all(:,1:end-4));

load([resultpath char(manual_list(2,1))]) %read first file to get classes
class2use_manual_first = class2use_manual;
class2use_first_sub = class2use_sub4; %this is specific for one sub case = ciliates
numclass1 = length(class2use_manual);
numclass2 = length(class2use_sub4);
numclass = numclass1 + numclass2;
class2use_here = [class2use_manual_first class2use_sub4];
ciliate_num = strmatch('ciliate', class2use_here, 'exact');
other_num = strmatch('other', class2use_here, 'exact');
for loopcount = 6:6, %1:length(mode_list),
    annotate_mode = char(mode_list(loopcount));
    switch annotate_mode
        case 'all categories'
            %use them all
            %class_cat = 1:numclass;
            [~, class_cat] = setdiff(class2use_here, {'ciliate'});
            manual_only = 0;
            list_col = strmatch(annotate_mode, manual_list(1,:));
            mode_ind = find(cell2mat(manual_list(2:end,list_col)));
        case 'ciliates'
            %[~, class_cat] = intersect(class2use_here, ['ciliate' class2use_first_sub]);
            [~, class_cat] = intersect(class2use_here, [class2use_first_sub]);
            manual_only = 0;
            list_col = strmatch(annotate_mode, manual_list(1,:));
            mode_ind = find(cell2mat(manual_list(2:end,list_col)) & ~cell2mat(manual_list(2:end,2)));
        case 'ditylum'
            [~, class_cat] = intersect(class2use_here, 'ditylum');
            manual_only = 0;
            list_col = strmatch(annotate_mode, manual_list(1,:));
            mode_ind = find(cell2mat(manual_list(2:end,list_col)) & ~cell2mat(manual_list(2:end,2)) & ~cell2mat(manual_list(2:end,strmatch('diatoms', mode_list)+1)));
        case 'diatoms'
            %all except mix, mix_elongated, and detritus
            [~, class_cat] = setdiff(class2use_here, {'mix' 'detritus' 'ciliate'});
            manual_only = 0;
            list_col = strmatch(annotate_mode, manual_list(1,:));
            mode_ind = find(cell2mat(manual_list(2:end,list_col)) & ~cell2mat(manual_list(2:end,2)));
        case 'big ciliates'
            [~, class_cat] = intersect(class2use_here, {'tintinnid' 'Laboea'});
            manual_only = 0;
            list_col = strmatch(annotate_mode, manual_list(1,:));
            mode_ind = find(cell2mat(manual_list(2:end,list_col)) & ~cell2mat(manual_list(2:end,2)) & ~cell2mat(manual_list(2:end,strmatch('ciliates', mode_list)+1)));
        case 'special big only'
            [~, class_cat] = intersect(class2use_here, {'Ceratium' 'Eucampia' 'Ephemera' 'bad' 'Dinophysis' 'Lauderia' 'Licmophora' 'Phaeocystis' 'Stephanopyxis' ...
                'Coscinodiscus' 'Odontella' 'Guinardia_striata' 'tintinnid' 'Laboea' 'Hemiaulus' 'Paralia' 'Guinardia_flaccida' 'Corethron' 'Dactyliosolen' 'Dictyocha'...
                'Dinobryon' 'Ditylum' 'Pleurosigma' 'Prorocentrum' 'Rhizosolenia' 'Thalassionema' 'clusterflagellate' 'kiteflagellates' 'Pyramimonas' 'ciliate_mix' 'Myrionecta'});
            manual_only = 1;
            list_col = strmatch(annotate_mode, manual_list(1,:));
            mode_ind = find(cell2mat(manual_list(2:end,list_col)) & ~cell2mat(manual_list(2:end,2)));
        case 'ciliate_ditylum'
            [~, class_cat] = intersect(class2use_here, ['Ditylum' class2use_first_sub]);
            manual_only = 0;
            mode_ind = find(~cell2mat(manual_list(2:end,2)) & cell2mat(manual_list(2:end,3)) & cell2mat(manual_list(2:end,4)) & ~cell2mat(manual_list(2:end,5)) & cell2mat(manual_list(2:end,6)));   
        case 'big_ciliate_ditylum'
            [~, class_cat] = intersect(class2use_here, {'Ditylum' 'tintinnid' 'Laboea'});
            manual_only = 0;
            mode_ind = find(~cell2mat(manual_list(2:end,2)) & ~cell2mat(manual_list(2:end,3)) & cell2mat(manual_list(2:end,4)) & ~cell2mat(manual_list(2:end,5)) & cell2mat(manual_list(2:end,6)));               
    end;
    filelist = cell2struct(manual_list(mode_ind+1,1),{'name'},2);
    for filecount = 1:length(filelist),
        filename = filelist(filecount).name;
        disp([annotate_mode ': ' filename])
        load([resultpath filename])
        if ~isequal(class2use_manual, class2use_manual_first)
            disp('class2use_manual does not match previous files!!!')
       %     keyboard
        end;
        filetemp = []; roinumtemp = filetemp; labeltemp = filetemp; persontemp = filetemp;
        for classnum = 1:numclass1,
            ind = [];
            if ismember(classnum, class_cat),
                if manual_only,
                    ind = find(classlist(:,2) == classnum);
                else
                    ind = find(classlist(:,2) == classnum | (isnan(classlist(:,2)) & classlist(:,3) == classnum));
                end;
            else
                if classnum ~= ciliate_num %skip ciliate since done as subdivide in all cases when ciliates exist
                    ind = find(classlist(:,2) == classnum); %case for "off task" annotations (consider manual only)
                end;
                if classnum == other_num & annotate_mode == 'special big only',
                    ind = [];
                end;
            end;
            roinumtemp = [roinumtemp; ind];
            labeltemp = [labeltemp; repmat(class2use_here(classnum), length(ind),1)];
        end;
        persontemp = repmat({'EPeacock'}, length(roinumtemp),1);
        if exist('class2use_sub4', 'var'),
             if ~isequal(class2use_sub4, class2use_first_sub)
                disp('class2use_sub4 does not match previous files!!!')
                keyboard
            end;
            for classnum = 1:numclass2,
                ind = find(classlist(:,4) == classnum);
                roinumtemp = [roinumtemp; ind];
                labeltemp = [labeltemp; repmat(class2use_here(classnum+numclass1), length(ind),1)];
            end;
        else
            disp('CHECK: no subdivide?')
            %keyboard
        end;
        filetemp = repmat(filename, length(roinumtemp),1);
        persontemp = [persontemp; repmat({'EBrownlee'}, length(roinumtemp),1)];
        fid = fopen([outpath filename(1:end-4) '.csv'], 'w');
        for ii = 1:length(roinumtemp),
            fprintf(fid, '%s,%05.0f,%s,%s\n', filetemp(ii,:), roinumtemp(ii), labeltemp{ii}, persontemp{ii,:});
        end;
        fclose(fid);
        clear class2use_manual class2use_auto class2use_sub* classlist *temp fid 
    end;
end;



