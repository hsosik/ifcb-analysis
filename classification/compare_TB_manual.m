load c:\work\ifCB\code_svn\classification\summary_manualTB
load c:\work\ifcb\ifcb_data_MVCO_jun06\manual_fromClass\summary\count_manual_28Jun2012

%WATCH OUT - here recomputing mix as sum of mix, flag, crypto and round...
[~,mixallind] = intersect(class2use, {'mix', 'flagellate', 'crypto', 'roundCell'});
mixind = strmatch('mix', class2use, 'exact');
classcount(:,mixind) = sum(classcount(:,mixallind),2);
whichstats = {'beta', 'mse', 'rsquare'};
classcountTB_above_thresh = classcountTB_above_adhocthresh;
if isequal(filelist, filelistTB),
    for ii = 1:length(class2useTB),
            disp(class2useTB(ii))
            mind = strmatch(class2useTB(ii), class2use, 'exact');
            nnan = ~isnan(classcount(:,mind));
        if ~isempty(mind),
            x = classcount(:,mind);
            y1 = classcountTB(:,ii);
            y2 = classcountTB_above_optthresh(:,ii);
            y3 = classcountTB_above_adhocthresh(:,ii);
            [b1(ii,:),bint] = regress(y1,[x ones(size(x))]);
            b1int1(ii,:) = bint(1,:); b1int2(ii,:) = bint(2,:);
            [b2(ii,:),bint] = regress(y2,[x ones(size(x))]);
            b2int1(ii,:) = bint(1,:); b2int2(ii,:) = bint(2,:);
            [b3(ii,:),bint] = regress(y3,[x ones(size(x))]);
            b3int1(ii,:) = bint(1,:); b3int2(ii,:) = bint(2,:);
            stats1(ii) = regstats(y1,x,'linear', whichstats);
            stats2(ii) = regstats(y2,x,'linear', whichstats);
            stats3(ii) = regstats(y3,x,'linear', whichstats);
            if 1,
                figure(ii), clf
                subplot(2,1,1)
                plot(mdateTB(nnan), classcountTB(nnan,ii)./ml_analyzedTB(nnan), '.g', 'markersize', 4)
                hold on
                plot(mdateTB(nnan), classcountTB_above_thresh(nnan,ii)./ml_analyzedTB(nnan), 'ro', 'markersize', 4)
                plot(matdate(nnan), classcount(nnan,mind)./ml_analyzed_mat(nnan,mind), '.-')
                ylim([0 inf]), datetick('x'), title(class2useTB(ii))
                legend('TBall', 'TB>thr', 'manual')
                subplot(2,3,4)
                plot(x, y1, '.'), xl = xlim;
                line([0 xl(2)], [0 xl(2)])
                axis square
                ylabel('Count, TB winner')
                subplot(2,3,5)
                plot(x,y2, '.'), xl = xlim;
                line([0 xl(2)], [0 xl(2)])
                xlabel('Manual count')
                ylabel('Count > opt thr')
                axis square
                subplot(2,3,6)
                plot(x, y3, '.'), xl = xlim;
                line([0 xl(2)], [0 xl(2)])
                axis square
                ylabel(['Count > adhoc thr = ' num2str(adhocthresh)])
            end;
        end;
    end;
end;


[stats1.mse]
beta1 = [stats1.beta]';
beta2 = [stats2.beta]';
beta3 = [stats3.beta]';
figure
errorbar(1:length(class2useTB)-1, b1(:,1), b1int1(:,1)-b1(:,1), b1int1(:,2)-b1(:,1) ,'.')
hold on
errorbar(1:length(class2useTB)-1, b2(:,1), b2int1(:,1)-b2(:,1), b2int1(:,2)-b2(:,1) ,'ro')
errorbar(1:length(class2useTB)-1, b3(:,1), b3int1(:,1)-b3(:,1), b3int1(:,2)-b3(:,1) ,'g*')

figure
semilogy([stats1.mse], '.')
hold on
semilogy([stats2.mse], 'ro')
semilogy([stats3.mse], 'g*')