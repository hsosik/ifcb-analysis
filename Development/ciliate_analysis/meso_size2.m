%load '/Users/markmiller/Documents/Experiments/count_biovol_size_manual_10Feb2014.mat'
%load '/Volumes/d_work/IFCB1/ifcb_data_mvco_jun06/Manual_fromClass/summary/count_biovol_size_manual_11Jun2014.mat'
load '/Volumes/d_work/IFCB1/ifcb_data_mvco_jun06/Manual_fromClass/summary/count_biovol_size_manual_current.mat'

%load '/Users/markmiller/Documents/Experiments/count_biovol_size_manual_14May2013.mat'
Mesodinium_size_structure=eqdiam.Mesodinium_sp;
Mesodinium_ml_analyzed=ml_analyzed_struct.Mesodinium_sp;
% Mesodinium_size_structure{1,:} gives me the cell for that bin



for i=1:length(Mesodinium_size_structure);
    ind=find(Mesodinium_size_structure{1,i} > 19);
    percent=length(ind)/length(Mesodinium_size_structure{1,i});
    Mesodinium_percent(i)=percent;
end

Mesodinium_ml_analyzed=Mesodinium_ml_analyzed';
Mesodinium_percent=Mesodinium_percent*100;
Mesodinium_percent=Mesodinium_percent';

meso_ind=find(~isnan(Mesodinium_percent));
matdate_meso=matdate(meso_ind);

% figure
% plot(matdate_meso,Mesodinium_percent(meso_ind))
% 

% 
[matdate_bin, eqdiam_bin, ml_analyzed_mat_bin] = make_day_bins_emily(matdate,Mesodinium_percent, Mesodinium_ml_analyzed);
%[matdate_bin, Mesodinium_bin, ml_analyzed_mat_bin] = make_day_bins(matdate,Mesodinium_size_structure, Mesodinium_ml_analyzed);

eqdiam_ind=find(~isnan(eqdiam_bin));
%%
% figure
% plot(matdate_bin(eqdiam_ind),eqdiam_bin(eqdiam_ind),'.-','linewidth',1)
% datetick
% set(gca,'xgrid','on');
% hold on

 load '/Users/markmiller/Documents/code_svn/Tall_day.mat'
%%
figure
ph = plotyy(matdate_bin(eqdiam_ind),eqdiam_bin(eqdiam_ind),mdate(1097:end),Tday(1097:end));

%set(ph(2), 'ylim', [-22 45], 'ytick', 0:5:25)
ylabel('Percent large (> 19 \mum)', 'fontsize', 24)
datetick('x', 12)
%set(ph, 'linewidth', 2, 'fontsize', 18)
set(ph, 'linewidth', 2, 'fontsize', 18,'ylim', [-20 120])
set(ph(2), 'ylim', [-6 27], 'ytick', 0:5:25)
set(ph(2), 'xlim', get(ph(1), 'xlim'), 'xtick', [], 'ycolor', 'r')
set(ph, 'linewidth', 2, 'fontsize', 24, 'xgrid', 'on')
set(get(ph(2), 'ylabel'), 'string', 'Temperature (\circC)', 'fontsize', 24, 'color', 'r')
set(get(ph(1), 'children'), 'linewidth', 2, 'marker', '.', 'markersize', 14)
set(get(ph(2), 'children'), 'linewidth', 2, 'color', 'r')
tx = xlim;
%lh = line([tx], [5 5]);
y1 = get(ph(1), 'ylim');
y2 = get(ph(2), 'ylim');
t = (5-y2(1))/(y2(2)-y2(1))*(y1(2)-y1(1))-y1(1); %find eqv of T = 5 on axis ph(1)
lh = line([tx], [t t]);
set(lh, 'color', 'k', 'linestyle', '--', 'linewidth', 2)




%%

%histogram of eqdiam
% numNeighbors = cellfun(@numel,Mesodinium_size_structure);
% hist(numNeighbors,unique(numNeighbors))

%pulls out Meso sizes for histogram
% Mesodinium_size_structure(isnan(ciliate_classcount))=0;
% h_3=Mesodinium_size_structure{1,:};
% for i=1:6306;
%     h=Mesodinium_size_structure{:,i};
%     h=h';
%     h_3=[h_3 h];
%     clear h
% end
% 
% diambins=(1:1:60)
% hist(h_3,diambins)
    

    