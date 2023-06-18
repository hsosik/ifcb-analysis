load '\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\summary\count_biovol_manual_current_day'
load \\SOSIKNAS1\Lab_data\MVCO\EnvironmentalData\Tall_day %run Temp_allyears_daily2 to update

[ ind_classes, class_label ] = get_diatom_ind( class2use, class2use );

x = classbiovol_bin(:,ind_classes)./ml_analyzed_mat_bin(:,ind_classes);

%c = 23; %7 ditylum
for c = 1:length(ind_classes)
d = x(:,c);
%above75 = find((d>prctile(d,75)));
%below50 = find((d<=prctile(d,50)));
upper = prctile(d(d>0),75);
lower = prctile(d(d>0),50);
above = find(d>upper);
below = find(d<=lower);
event = zeros(size(d));
start = 0;
stop = 0;
num = 0;
length_d = length(d);
while stop < length_d
    num = num + 1;
    trigger = find(above>stop); 
    if ~isempty(trigger)
        trigger = above(trigger(1));
        temp = find(below<trigger);
        if ~isempty(temp)
            start = below(temp(end));
            if start == stop  
                num = num - 1;
            end
            if length(below) > temp(end)
                stop = below(temp(end)+1);
            else
                stop = length_d;
            end
        else
            start = trigger;
            temp = find(below>trigger);
            stop = below(temp(1));
        end
        %combine events if new start shared with previous stop
        event(start:stop) = num;
    else %no more events
        stop = length_d;
    end
end

for count = 1:max(event);
    ind = find(event == count);
    start_date{c}(count) = matdate_bin(ind(1));
    stop_date{c}(count) = matdate_bin(ind(end));
    a = find(~isnan(d(ind)));
    integral{c}(count) = trapz(matdate_bin(ind(a)), d(ind(a)));
    [peak{c}(count) peak_ind] = max(d(ind));
    peak_date{c}(count) = matdate_bin(ind(peak_ind));
    tind = find(mdate2>=start_date{c}(count) & mdate2<=stop_date{c}(count));
    meanT{c}(count) = nanmean(Tday2(tind));
    minT{c}(count) = min(Tday2(tind));
    maxT{c}(count) = max(Tday2(tind));
end
duration{c} = stop_date{c} - start_date{c};
middle_date{c} = (start_date{c}+stop_date{c})/2;

figure(1), clf
in = find(~isnan(d));
plot(matdate_bin(in), d(in))
hold on
plot(matdate_bin(above), d(above), 'g.')
plot(matdate_bin(below), d(below), 'r.')
ind = find(event);
th = text(matdate_bin(ind), d(ind), num2str(event(ind)));
line(xlim, [1 1]*lower)
line(xlim, [1 1]*upper)
datetick
set(gca, 'xgrid', 'on')
title(class2use(ind_classes(c)))

%figure(2), clf
%plot(datenum2yearday(matdate_bin), d, '.')
%title(class2use(ind_diatoms(c)))
%line([120 120], ylim)
pause
end