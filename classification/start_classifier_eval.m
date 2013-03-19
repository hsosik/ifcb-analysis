config.manual_path = 'C:\work\IFCB3LisaCampbell\testdataset_17dec12\manual_classify_results_merged_verified_remapped2\';
config.class_path = 'C:\work\IFCB3LisaCampbell\testdataset_17dec12\manual_classify_results_merged_verified_remapped2\classified_files_TB\';
config.remap_func = 'TAMU_trees_20Aug2012_map';
config.filelist = dir([ config.manual_path '*.mat']);
%config.TB2summarize = 'TBclass'; 
config.TB2summarize = 'TBclass_above_threshold'; %opt threshold
%config.TB2summarize = 'TBclass_above_adhoc_threshold'; %adhoc threshold
%config.adhoc_thre = 0.5; %OPTIONAL, specify adhoc cutoff score if using TBclass_above_adhoc_threshold

[config, output] = classifier_assessment(config);

%%
%example analysis and plotting
if ~isempty(output),
    numclass = length(output.class2use);
    confmat_proportion = output.confmat./repmat(output.total_known,1,numclass);
    confmat2plot = zeros(numclass+1); %pad with zeros so that pcolor graph shows all classes
    confmat2plot(1:numclass,1:numclass) = confmat_proportion;
    %confmat2plot(1:numclass,1:numclass) = output.confmat; %raw counts
    pcolor(confmat2plot)
    colorbar
    axis square, shading flat
    set(gca, 'tickdir', 'out', 'xtick', (1:numclass)+0.5, 'ytick', (1:numclass)+0.5, 'xaxislocation', 'top')
    set(gca,'yticklabel', output.class2use, 'xticklabel', [], 'fontsize',8) %output.class2use)
    %rotateXLabels(gca, 45)
    th = text(get(gca, 'xtick'), -1*ones(numclass,1), output.class2use, 'interpreter', 'none', 'fontsize', 8);
    set(th, 'rotation', 45, 'horizontalalignment', 'right')
    ylabel('Manual', 'fontsize', 20)
    xlabel('Predicted', 'fontsize', 20)
    tpos1 = get(gca, 'position');
    tpos1 = tpos1.*[1.3 1.5 .9 .9];
    set(gca, 'position', tpos1)
end;
%%
numclass = length(output.class2use);
cfmat1 = output.confmat;

total_known = sum(cfmat1,2); %should be same as output.total_known = tp+fn
total_pred = sum(cfmat1)'; %should be same as output.total_pred
tp = diag(cfmat1); %true pos
fp = total_pred-tp; %false pos
fn = total_known-tp; %false neg
tn = sum(total_known)-fp-fn-tp; %true neg

Pd = tp./total_known; %prob detection or recall
Pr = tp./total_pred; %precision
Sp = tn./(tn+fp); %specificity
Ac = (tp+tn)./(tp+tn+fp+fn); %accuracy

figure, bar([total_known tp fp])
legend('total in set', 'true pos', 'false pos')
set(gca, 'xtick', 1:numclass, 'xticklabel', [])
text_offset = .1;
text(1:numclass, -text_offset.*ones(size(output.class2use)), output.class2use, 'interpreter', 'none', 'horizontalalignment', 'right', 'rotation', 45) 
set(gca, 'position', [ 0.13 0.35 0.8 0.6])
figure, bar([Pd Pr])
set(gca, 'xtick', 1:numclass, 'xticklabel', [])
text(1:numclass, -text_offset.*ones(size(output.class2use)), output.class2use, 'interpreter', 'none', 'horizontalalignment', 'right', 'rotation', 45) 
set(gca, 'position', [ 0.13 0.35 0.8 0.6])
legend('Pd', 'Pr')
figure, bar([Sp Ac])
set(gca, 'xtick', 1:numclass, 'xticklabel', [])
text(1:numclass, -text_offset.*ones(size(output.class2use)), output.class2use, 'interpreter', 'none', 'horizontalalignment', 'right', 'rotation', 45) 
set(gca, 'position', [ 0.13 0.35 0.8 0.6])
legend('Sp', 'Ac')

%%

return
%skip unclassified
ii = strmatch('unclassified', output.class2use);
cfmat2 = output.confmat;
cfmat2(ii,:) = [];
cfmat2(:,ii) = [];
clear ii