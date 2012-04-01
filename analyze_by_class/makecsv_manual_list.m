resultpath = '\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\';
load([resultpath 'manual_list']) %load the manual list detailing annotate mode for each sample file

outpath = [resultpath 'annotations_csv\'];
if ~exist(outpath, 'dir')
    mkdir(outpath)
end;

mode_list = manual_list(1,2:end-1); %mode_list = [mode_list 'ciliate_ditylum' 'big_ciliate_ditylum'];
filelist_all = char(manual_list(2:end,1)); filelist_all = cellstr(filelist_all(:,1:end-4));
mode_mat = cell2mat(manual_list(2:end,2:end-1));

load([resultpath char(manual_list(2,1))]) %read first file to get classes
class2use_manual_first = class2use_manual;
class2use_first_sub = class2use_sub4; %this is specific for one sub case = ciliates
numclass1 = length(class2use_manual);
numclass2 = length(class2use_sub4);
numclass = numclass1 + numclass2;
class2use_here = [class2use_manual_first class2use_sub4];

class_done = zeros(length(filelist_all),length(class2use_here));
for filecount = 1:length(filelist_all),
    disp(filelist_all{filecount})
    for loopcase = 1:length(mode_list),
        %annotate_mode = mode_list(loopcase);
        if loopcase == 1, % 'all categories'
                class_cat = 1:numclass; %[~, class_cat] = setdiff(class2use_here, {'ciliate'});
        elseif loopcase == 2, %'ciliates'
                [~, class_cat] = intersect(class2use_here, ['ciliate' class2use_first_sub]);
                %[~, class_cat] = intersect(class2use_here, [class2use_first_sub]);
        elseif loopcase == 3 % 'ditylum'
                [~, class_cat] = intersect(class2use_here, 'Ditylum');
        elseif loopcase == 4 % 'diatoms'
                %all except mix, mix_elongated, and detritus
                [~, class_cat] = setdiff(class2use_here, {'mix' 'detritus'});
        elseif loopcase == 5, % 'big ciliates'
                [~, class_cat] = intersect(class2use_here, {'tintinnid' 'Laboea'});
        elseif loopcase == 6, %'special big only'
                [~, class_cat] = intersect(class2use_here, {'Ceratium' 'Eucampia' 'Ephemera' 'bad' 'Dinophysis' 'Lauderia' 'Licmophora' 'Phaeocystis' 'Stephanopyxis' ...
                    'Coscinodiscus' 'Odontella' 'Guinardia_striata' 'tintinnid' 'Laboea' 'Hemiaulus' 'Paralia' 'Guinardia_flaccida' 'Corethron' 'Dactyliosolen' 'Dictyocha'...
                    'Dinobryon' 'Ditylum' 'Pleurosigma' 'Prorocentrum' 'Rhizosolenia' 'Thalassionema' 'clusterflagellate' 'kiteflagellates' 'Pyramimonas' 'ciliate_mix' 'Myrionecta' 'not_ciliate' 'ciliate'});
        end;
        if mode_mat(filecount,loopcase),
            class_done(filecount,class_cat) = 1;
        end;
    end;
end;

mat2check(:,1) = filelist_all;
mat2check(:,2:length(class2use_here)+1) = num2cell(class_done);
mat2check = [['filename' class2use_here]; mat2check];
save([outpath 'mat2check'], 'mat2check')

person = 'EPeacock';
fid = fopen([outpath  'manual_list.csv'], 'w');
for ii = 1:length(filelist_all),
    for iii = 1:length(class2use_here),
        if class_done(ii,iii),
            fprintf(fid, '%s,%s,%s\n', filelist_all{ii}, class2use_here{iii}, person);
        end;
    end;
end;
fclose(fid);

