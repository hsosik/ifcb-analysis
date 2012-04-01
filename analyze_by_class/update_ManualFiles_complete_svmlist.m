%inpath = '\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\';
%outpath = '\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass_newsvm\';

inpath = 'c:\work\ifcb\\ifcb_data_mvco_jun06\Manual_fromClass\';
outpath = 'c:\work\ifcb\\ifcb_data_mvco_jun06\Manual_fromClass_newsvm\';
load([inpath 'manual_list']) %load the manual list detailing annotate mode for each sample file
catflags = cell2mat(manual_list(2:end,2:end-1));

newclasspathbase = '\\queenrose\ifcb12\ifcb_data_mvco_jun06\classXXXX_24may07_revDec11\';
newclasspathbase = 'c:\work\ifcb\ifcb_data_mvco_jun06\classXXXX_24may07_revDec11\';

class_appstr = '_class_24May07_revDec11';
filelist = dir([inpath 'IFCB*.mat']);

flag1cat = 1:28;%all categories
flag2cat = 25; %ciliate
flag3cat = 10;  %Ditylum
flag4cat = [1:28]; flag4cat([26 28]) = [];  %"diatoms" = all but mix and detritus
flag5cat = 25; %big ciliate
%special big only, intersect with original: 'Ceratium' 'Corethron' 'Dactyliosolen' 'Dictyocha' 'Dinobryon' 'Ditylum' 'Ephemera' 'Eucampia' 'Guinardia_flaccida' 'Pleurosigma' 'Rhizosolenia'  'Thalassionema' 'bad')
flag6cat =  [2 4 7 8 9 10 11 12 15 17 19 21 24];

for count = 4500:length(filelist),
    [~,fname] = fileparts(filelist(count).name); disp(fname);
    
    classpath = newclasspathbase; classpath = regexprep(classpath,'XXXX', fname(7:10));
    in = load([inpath fname]);
    load([classpath fname class_appstr], 'PreLabels');
    PreLabels(PreLabels(:,1) == 13,1) = 47; %reassign Eucampia_groenlandica to Cerataulina
    SVMfromManual = in.classlist(:,3);
    Manual = in.classlist(:,2);
    oldNaN_flag = zeros(size(Manual));
    forceManual2other_flag = oldNaN_flag;
    nonNaNdiff_flag = oldNaN_flag;
    ii = find(isnan(SVMfromManual) & ~isnan(PreLabels(:,1))); %cases with NaN in old, but not in new
    oldNaN_flag(ii) = 1;
    ii = find(isnan(SVMfromManual) & ~isnan(PreLabels(:,1)) & isnan(Manual)); %cases with NaN in manual and old, but not in new
    ii = find(~isnan(SVMfromManual) & ~isnan(PreLabels(:,1)) & PreLabels(:,1) ~= SVMfromManual); %cases with non-NaN difference betw old and new
    nonNaNdiff_flag(ii) = 1;
%     if ~isempty(ii),
%         temp = cell(1,length(ii)); iii = find(~isnan(Manual(ii))); 
%         temp(iii) = in.class2use_manual(Manual(ii(iii)));
%         [temp; in.class2use_manual(PreLabels(ii,1)); in.class2use_manual(SVMfromManual(ii))]'
%         %pause
%         clear temp
%     end;
    
    %out = in; out.classlist(:,3) = newLabels;
    %save([outpath fname], '-struct', 'out')
    %clear PreLabels Labels_fromManual in out
end;



