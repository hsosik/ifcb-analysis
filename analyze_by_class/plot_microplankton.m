load \\queenrose\IFCB12\ifcb_data_mvco_jun06\biovolume\summary\count_biovol_27Jan2012_day.mat

%major detritus day?
ii = find(floor(matdate_bin) >= datenum('8-11-10') & floor(matdate_bin) <= datenum('8-20-10'));
biovol_bin(ii,:) = NaN;
count_bin(ii,:) = NaN;

ii = find(diff(matdate_bin) > 4);
while ~isempty(ii),
    ii = ii(1);
    matdate_bin = [matdate_bin(1:ii); NaN; matdate_bin(ii+1:end)];
    biovol_bin = [biovol_bin(1:ii,:); [NaN NaN NaN]; biovol_bin(ii+1:end,:)];
    count_bin = [count_bin(1:ii,:); [NaN NaN NaN]; count_bin(ii+1:end,:)];
    ml_analyzed_mat_bin = [ml_analyzed_mat_bin(1:ii,:); [NaN NaN NaN]; ml_analyzed_mat_bin(ii+1:end,:)];
    ii = find(diff(matdate_bin) > 4);
end;

plot(matdate_bin, biovol_bin(:,3)./ml_analyzed_mat_bin(:,3)/1e6)
datetick('x')
set(gca, 'xgrid', 'on')
ylim([0 20])

[yd, year] = datenum2yearday(matdate_bin); 
ii = find(isnan(year)); year(ii) = year(ii+1); %keep the NaN values for gaps

yy = unique(year);
cstr = 'krgcmb';
figure, hold on
for count = 1:length(yy),
    ii = find(year == yy(count));
    plot(yd(ii),biovol_bin(ii,3)./ml_analyzed_mat_bin(ii,3)/1e6, ['-' cstr(count)], 'linewidth', 2)
end;
datetick('x',3)
lh = legend(num2str(yy), 'location', 'north');
ylim([0 5])
set(lh, 'box', 'off')
set(gca, 'fontsize', 16, 'fontname', 'arial')
set(gcf, 'position', [360 278 750 375])
ylabel('Biovolume (mm^3 mL^{-1})', 'fontsize', 16)
text(200, 4.5, 'Microplankton', 'fontsize', 16)