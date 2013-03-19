function [ config, output ] = classifier_assessment( config )
%function [ config, output ] = classifier_assessment( config )

filelist = config.filelist;
for ii = 1:length(filelist),
    [~,fname] = fileparts(filelist(ii).name);
    disp(fname)
    t1 = load([config.manual_path fname]);
    t2 = load([config.class_path fname '_class_v1']); 
    
    %next line: KLUDGE TO CORRECT SPECIAL CASE in remapped TAMU data with extra classes in class2useTB (not really part of classifier)
    t2.class2useTB = t2.class2useTB(1:54); 
    
    [ classlist_str, classlist_num ] = classlist2classstr( t1.classlist, t1.class2use_manual );
    classlist_in = classlist_str;
    
    if exist(config.remap_func), 
        eval(['[ classlist_out ] = ' config.remap_func '( classlist_in, t2.class2useTB );'])
    else
        classlist_out = classlist_in;
    end;

    if strmatch('TBclass_above_adhoc_threshold', config.TB2summarize),
        if isfield(config, 'adhoc_thre'),
            t2.TBclass_above_adhoc_threshold = apply_TBthreshold(t2.class2useTB, t2.TBscores, config.adhoc_thre);
        else
            disp('You must specify config.adhoc_thre if you want to analyze TBclass_above_adhoc_threshold')
            output = [];
            return
        end
    end;
    eval(['TBclass_now = t2.' config.TB2summarize ';']);  
    
    confmat_increment = confusionmat(classlist_out(t2.roinum), TBclass_now,'order',t2.class2useTB);
    if exist('confmat', 'var')
        confmat = confmat + confmat_increment;
    else
        confmat = confmat_increment;
    end;
end;

output.total_known = sum(confmat,2);
output.total_predicted = sum(confmat);
output.confmat = confmat;
output.class2use = t2.class2useTB;
