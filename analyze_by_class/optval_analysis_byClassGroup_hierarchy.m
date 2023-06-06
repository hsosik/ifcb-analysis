% accounting for hierarchical classification scheme in the optval analysis

clear; close all;

%% set some things up:
% designate your primary group:
primary_group = 'protist_tricho';

% and subgroups ("NanoFlagCocco" will be added below):
subgroups = {'Diatom_noDetritus', 'Dinoflagellate', 'Ciliate', 'NanoFlagCocco', 'Other_phyto'};

stat_path = ['\\sosiknas1\Lab_data\dylan_working\cnn_score_data_byClass\', primary_group, '\'];
% stat_path_end = '_adhoc_stat_table_groupmax.mat';
% count_path_end = '_adhoc_count_data_groupmax.mat';
stat_path_end = '_adhoc_stat_table_groupsum.mat';
count_path_end = '_adhoc_count_data_groupsum.mat';

fig_path = stat_path;
% fig_path_end = '_optval_figs_groupmax.png';
fig_path_end = '_optval_figs_groupsum.png';

%% analysis/plots

% primary group first:
pp = [stat_path, primary_group, stat_path_end];
pp2 = [stat_path, primary_group, count_path_end];
load(pp);

% oo = stat_table.threshold(stat_table.f1 == max(stat_table.f1));
oo = stat_table.threshold(abs(stat_table.precision - stat_table.recall) == min(abs(stat_table.precision - stat_table.recall)));
oo = min(oo);

FS = 12; % font size

if ~isempty(oo)
    figure(); hold on;
    % threshold vs. precision/recall
    subplot(1,3,1); hold on; box on;
    scatter(stat_table.threshold, stat_table.precision, 'k.');
    scatter(stat_table.threshold, stat_table.recall, 'r.');
    scatter(stat_table.threshold, stat_table.f1, 'b.');
    ax = gca; ax.FontSize = FS;
    tmpy = min(ax.YLim):0.1:max(ax.YLim);
    plot(repmat(oo, length(tmpy), 1), tmpy, 'k--');
    l = legend({'precision', 'recall', 'f1', 'opt thresh'});
    l.Orientation = 'vertical';
    l.Location = 'best';
%         l.Location = 'southwest';
    xlabel('threshold value');
    ylabel('statistic value');
    
    subplot(1,3,2); hold on; box on; title(primary_group);
    scatter(stat_table.recall, stat_table.precision, 'k.');
    s1 = scatter(stat_table.recall(stat_table.threshold==0),...
        stat_table.precision(stat_table.threshold==0), 'filled', 'bs');
    s2 = scatter(stat_table.recall(stat_table.threshold==0.5),...
        stat_table.precision(stat_table.threshold==0.5), 'filled', 'b^');
    s3 = scatter(stat_table.recall(stat_table.threshold==0.9),...
        stat_table.precision(stat_table.threshold==0.9), 'filled', 'bd');
    s4 = scatter(stat_table.recall(stat_table.threshold==oo),...
        stat_table.precision(stat_table.threshold==oo), 'rx');
    l = legend([s1, s2, s3, s4], {'thresh = 0', 'thresh = 0.5', 'thresh = 0.9', 'opt thresh'});
    l.Orientation = 'vertical';
    l.Location = 'best';
    xlabel('recall');
    ylabel('precision');
    ax = gca; ax.FontSize = FS;

    load(pp2);

    subplot(1,3,3); hold on; box on;
    scatter(man_counts, allcnn_counts(:, stat_table.threshold == 0), 'ko');
    scatter(man_counts, allcnn_counts(:, stat_table.threshold == oo), 'r.'); 
    l = legend({'thresh = 0', 'opt thresh'});
    l.Orientation = 'vertical';
    l.Location = 'best';
    l.AutoUpdate = 'off';
    ax = gca; ax.FontSize = FS;
    xlabel('Manual count (bin^-^1)');
    ylabel('CNN count (bin^-^1)');
    o2o = min([ax.XLim ax.YLim]):0.1:max([ax.XLim ax.YLim]);
    plot(o2o, o2o, 'k--');

    set(gcf, 'Units', 'inches', 'Position', [0 0 15 3.5])
    exportgraphics(gcf, [fig_path, primary_group, fig_path_end]);

end


for i = 1:length(subgroups)
    target = subgroups{i};
    
    pp = [stat_path, target, '\', target, stat_path_end];
    pp2 = [stat_path, target, '\', target, count_path_end];

    if isfile(pp)
        load(pp);

%         oo = stat_table.threshold(stat_table.f1 == max(stat_table.f1));
        oo = stat_table.threshold(abs(stat_table.precision - stat_table.recall) == min(abs(stat_table.precision - stat_table.recall)));
        oo = min(oo);
        
        if ~isempty(oo)
            figure(); hold on;
            % threshold vs. precision/recall
            subplot(1,3,1); hold on; box on;
            scatter(stat_table.threshold, stat_table.precision, 'k.');
            scatter(stat_table.threshold, stat_table.recall, 'r.');
            scatter(stat_table.threshold, stat_table.f1, 'b.');
            ax = gca; ax.FontSize = FS;
            tmpy = min(ax.YLim):0.1:max(ax.YLim);
            plot(repmat(oo, length(tmpy), 1), tmpy, 'k--');
            l = legend({'precision', 'recall', 'f1', 'opt thresh'});
            l.Orientation = 'vertical';
            l.Location = 'best';
    %         l.Location = 'southwest';
            xlabel('threshold value');
            ylabel('statistic value');
            
            subplot(1,3,2); hold on; box on; title(target);
            scatter(stat_table.recall, stat_table.precision, 'k.');
            s1 = scatter(stat_table.recall(stat_table.threshold==0),...
                stat_table.precision(stat_table.threshold==0), 'filled', 'bs');
            s2 = scatter(stat_table.recall(stat_table.threshold==0.5),...
                stat_table.precision(stat_table.threshold==0.5), 'filled', 'b^');
            s3 = scatter(stat_table.recall(stat_table.threshold==0.9),...
                stat_table.precision(stat_table.threshold==0.9), 'filled', 'bd');
            s4 = scatter(stat_table.recall(stat_table.threshold==oo),...
                stat_table.precision(stat_table.threshold==oo), 'rx');
            l = legend([s1, s2, s3, s4], {'thresh = 0', 'thresh = 0.5', 'thresh = 0.9', 'opt thresh'});
            l.Orientation = 'vertical';
            l.Location = 'best';
            xlabel('recall');
            ylabel('precision');
            ax = gca; ax.FontSize = FS;
    
            load(pp2);
    
            subplot(1,3,3); hold on; box on;
            scatter(man_counts, allcnn_counts(:, stat_table.threshold == 0), 'ko');
            scatter(man_counts, allcnn_counts(:, stat_table.threshold == oo), 'r.'); 
            l = legend({'thresh = 0', 'opt thresh'});
            l.Orientation = 'vertical';
            l.Location = 'best';
            l.AutoUpdate = 'off';
            ax = gca; ax.FontSize = FS;
            xlabel('Manual count (bin^-^1)');
            ylabel('CNN count (bin^-^1)');
            o2o = min([ax.XLim ax.YLim]):0.1:max([ax.XLim ax.YLim]);
            plot(o2o, o2o, 'k--');
    
            set(gcf, 'Units', 'inches', 'Position', [0 0 15 3.5])
            exportgraphics(gcf, [fig_path, target, '/', target, fig_path_end]);
    
        end

    else
        disp(['no stat table found for ', target]);
    end

    disp(['class ', num2str(i), ' of ', ...
        num2str(length(subgroups)), ' be done']);
    close all
end

