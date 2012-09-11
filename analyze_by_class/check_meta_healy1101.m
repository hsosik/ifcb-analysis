load \\floatcoat\IFCBdata\IFCB8_HLY1101\metadata\ml_analyzed_detail

load \\floatcoat\IFCBdata\IFCB8_HLY1101\metadata\HLY1101metadata.mat
[~,b,c] = intersect(filelist, {metadata.filename}');
meta = metadata(c);
isgoodsample = ones(size(meta));
for ind = 1:length(meta),
    if strcmp(meta(ind).manual_flag, 'omit'),
        isgoodsample(ind) = 0;
    elseif strfind(meta(ind).automated_flag, 'emptyadc'),
        isgoodsample(ind) = 0;
    elseif strfind(meta(ind).automated_flag, 'emptyroi'),
        isgoodsample(ind) = 0;    
    elseif strcmp(meta(ind).samp_type, 'diags') || strcmp(meta(ind).samp_type, 'beads')  
        isgoodsample(ind) = 0;
    end;
end;

figure
plot(looktime(isgoodsample==1),looktime2(isgoodsample==1), '.')
line(xlim, xlim)

figure
plot(numtriggers(isgoodsample==1)./runtime(isgoodsample==1), looktime(isgoodsample==1)./looktime2(isgoodsample==1), '.')
line([xlim], [1 1]) 

figure
plot(numtriggers(isgoodsample==1)./runtime(isgoodsample==1), looktime(isgoodsample==1)./runtime(isgoodsample==1), '.')
hold on
plot(numtriggers(isgoodsample==1)./runtime(isgoodsample==1), looktime2(isgoodsample==1)./runtime(isgoodsample==1), 'r.')
plot(numtriggers(isgoodsample==1)./runtime(isgoodsample==1), looktime3(isgoodsample==1)./runtime(isgoodsample==1), 'g.')
plot(numtriggers(isgoodsample==1)./runtime(isgoodsample==1), looktime4(isgoodsample==1)./runtime(isgoodsample==1), 'm.')
ylabel('looktime/runtime'), xlabel('trigs per sec')

figure
plot(numtriggers(isgoodsample==1)./runtime(isgoodsample==1), rearms(isgoodsample==1)./runtime(isgoodsample==1), '.')
ylabel('rearms per sec'), xlabel('trigs per sec')
