
TB = load('D:\IFCB\class_TAMUG_Trees_15Jul2015\summary\summary_allTB')
man =load('D:\IFCB\manual\summary\count_manual_28Jul2015') % made it equal t to better keep track of variables

class2show = 'Flagellate_MIX';
cindTB = strmatch(class2show, TB.class2useTB); % use to find which number of class2use is chosen class for TB
cindman = strmatch(class2show, man.class2use); %for manual

figure
plot(man.matdate, man.classcount(:,cindman)./man.ml_analyzed_mat(:,cindman), 'g*') % plot manual results %ml_analyzed is matrix
hold on
plot(TB.mdateTB, TB.classcountTB_above_optthresh(:,cindTB)./TB.ml_analyzedTB, 'r.-') %plot TB counts with optimum threshold
plot(TB.mdateTB, TB.classcountTB(:,cindTB)./TB.ml_analyzedTB, '.-') %plot TB counts with no threshold
plot(TB.mdateTB, TB.classcountTB_above_adhocthresh(:,cindTB)./TB.ml_analyzedTB, 'c.-') %plot TB counts with adhoc threshold

datetick
title(class2show)