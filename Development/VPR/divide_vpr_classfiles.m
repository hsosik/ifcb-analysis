

classpath = '\\sosiknas1\Lab_data\VPR\NBP1201\vpr8\class_RossSea_Trees_30Oct2015_seven_classes\';
classpath_div = [classpath, filesep, 'classpath_div', filesep];

if ~exist(classpath_div, 'dir'),
    mkdir(classpath_div)
end;


temp = dir([classpath 'd*.mat']);


for ii = 1:length(temp);
load([classpath temp(ii).name]);
  TBclass_orig = TBclass;
    TBclass_above_threshold_orig =  TBclass_above_threshold;
    TBscores_orig = TBscores;
    roinum_orig = roinum;
    
for i = 1:length(TBclass_orig)./5000;
    TBclass = TBclass_orig(((i-1)*5000+1):i*5000);
    TBclass_above_threshold =  TBclass_above_threshold_orig(((i-1)*5000+1):i*5000);
    TBscores = TBscores_orig([((i-1)*5000+1):i*5000],:);
    roinum = roinum_orig(((i-1)*5000+1):i*5000);
    
    file_section_blank = char('00');
    file_section = char({num2str(i)});
    file_section_blank((end-length(file_section)+1):length(file_section_blank)) = file_section;
    name = temp(ii).name;
    name = name(1:16);
    file_path =cellstr([classpath_div name file_section_blank char('.mat')]);
    save ([classpath_div name file_section_blank char('.mat')] , 'class2useTB', 'classifierName', 'TBclass', 'TBclass_above_threshold', 'TBscores', 'roinum');
end
end
