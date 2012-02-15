load '\\raspberry\d_work\ifcb1\ifcb_data_mvco_jun06\manual_fromClass\summary\ciliate_manual_05Feb2012.mat'
ii = find(floor(matdate) == datenum('2-9-2010')); %skip this day with one partial sample
matdate(ii) = []; filelist(ii) = [];
fnames = fields(biovol);
for fcount = 1:length(fnames),
    disp(fcount)
    biovol.(fnames{fcount})(ii) = [];
    eqdiam.(fnames{fcount})(ii) = [];
    ml_analyzed_struct.(fnames{fcount})(ii) = [];
end;
clear ii fnames

day = floor(matdate);
unqday = unique(day);
classes = fields(ml_analyzed_struct);
for classcount = 1:length(classes),
    [biovol_day(1:length(unqday)).(classes{classcount})] = deal([]);
    [ml_day(1:length(unqday)).(classes{classcount})] = deal(NaN);
end;
N_day = ml_day;
N0_20 = N_day; N20_30 = N_day; N30_inf = N_day;
biovol0_20 = N_day; biovol20_30 = N_day; biovol30_inf = N_day;
eqdiam_day = biovol_day;
for daycount = 1:length(unqday),
    disp(datestr(unqday(daycount)))
    ii = find(day == unqday(daycount));
    for classcount = 1:length(classes),
        biovol_day(daycount).(classes{classcount}) = cat(1,biovol.(classes{classcount}){ii});
        eqdiam_day(daycount).(classes{classcount}) = cat(1,eqdiam.(classes{classcount}){ii});
        ml = nansum(ml_analyzed_struct.(classes{classcount})(ii));
        if ml ~= 0,
            ml_day(daycount).(classes{classcount}) = ml;
            N_day(daycount).(classes{classcount}) = length(biovol_day(daycount).(classes{classcount})); 
        end;
    end;
end;

clear classcount biovol daycount eqdiam filelist ii matdate ml ml_analyzed_struct day

%for ii = 1:length(unqday), hist(log10(biovol_day(ii).ciliate_mix),2:.04:6), line([3.5 3.5], ylim), title(datestr(unqday(ii))), xlim([2 6]), pause, clf, end;
%for ii = 1:length(unqday), hist(log10(eqdiam_day(ii).ciliate_mix),1:.01:2), line([1.3 1.3], ylim), title(datestr(unqday(ii))), xlim([1 2]), pause, clf, end;

for daycount = 1:length(unqday),
    disp(datestr(unqday(daycount)))
    for classcount = 1:length(classes),
        iii = find(eqdiam_day(daycount).(classes{classcount}) < 20);
        if ~isempty(iii),
            N0_20(daycount).(classes{classcount}) = length(iii);
            biovol0_20(daycount).(classes{classcount}) = nansum(biovol_day(daycount).(classes{classcount})(iii));
        end;
        iii = find(eqdiam_day(daycount).(classes{classcount}) >= 20 & eqdiam_day(daycount).(classes{classcount}) < 30);
        if ~isempty(iii),
            N20_30(daycount).(classes{classcount}) = length(iii);
            biovol20_30(daycount).(classes{classcount}) = nansum(biovol_day(daycount).(classes{classcount})(iii));
        end;
        iii = find(eqdiam_day(daycount).(classes{classcount}) >= 30);
        if ~isempty(iii),
            N30_inf(daycount).(classes{classcount}) = length(iii);
            biovol30_inf(daycount).(classes{classcount}) = nansum(biovol_day(daycount).(classes{classcount})(iii));
        end;
    end;
end;

ci = find(~isnan([N_day.ciliate]));

t = [ [N0_20.ciliate_mix]; [N20_30.ciliate_mix]; [N30_inf.ciliate_mix]]';
s = t./repmat(sum(t,2),1,3);  

t2 = [ [biovol0_20.ciliate_mix]; [biovol20_30.ciliate_mix]; [biovol30_inf.ciliate_mix]]';
s2 = t2./repmat(sum(t2,2),1,3);

t3 = [ [N0_20.Myrionecta]; [N20_30.Myrionecta]; [N30_inf.Myrionecta]]';
s3 = t3./repmat(sum(t3,2),1,3);

t4 = [ [N0_20.ciliate]; [N20_30.ciliate]; [N30_inf.ciliate]]';
s4 = t./repmat(sum(t4,2),1,3);

t5 = [ [biovol0_20.ciliate]; [biovol20_30.ciliate]; [biovol30_inf.ciliate]]';
s5 = t5./repmat(sum(t2,2),1,3);

[yd, year] = datenum2yearday(unqday);
yd = floor(yd);
win = 15;
%y = t./repmat([ml_day.ciliate_mix]',1,3);
%y = nansum(t5,2)./[ml_day.ciliate]';
y = s;
clear ysm
for dcount = 1:366,
    ii = find(yd >= dcount-win & yd <= dcount + win);
    ysm(dcount,:) = nanmean(y(ii,:));
end;

figure
plot(yd(ci), y(ci,1), '.'), hold on
plot(yd(ci), sum(y(ci,2:3),2), 'r^', 'markerfacecolor', 'r', 'markersize', 5)
legend('< 20 \mum', '> 20 \mum')
plot(1:366, smooth(ysm(:,1),15), 'b-', 'linewidth', 2)
plot(1:366, smooth(sum(ysm(:,[2:3]),2),15), 'r-', 'linewidth', 2)
datetick('x', 3)

figure
plot(yd(ci), y(ci,1), '.'), hold on
plot(yd(ci), y(ci,2), 'g*', 'markersize', 5)
plot(yd(ci), y(ci,3), 'r^', 'markerfacecolor', 'r', 'markersize', 5)
lh = legend('< 20 \mum', '20-30 \mum', '> 30 \mum');
plot(1:366, smooth(ysm(:,1),15), 'b-', 'linewidth', 2)
plot(1:366, smooth(ysm(:,2),15), 'g-', 'linewidth', 2)
plot(1:366, smooth(ysm(:,3),15), 'r-', 'linewidth', 2)
set(gca, 'ytick', 0:.2:1)
set(gca, 'xtick', datenum(0,1:13,0)+1)
xlim([1 367]), ylim([0 1])
datetick('x', 4,'keeplimits', 'keepticks')
%ylabel('Total ciliate (proportion)', 'fontsize', 16)
ylabel('Mixed ciliate abundance fraction', 'fontsize', 16)
set(gca, 'fontsize', 14)
