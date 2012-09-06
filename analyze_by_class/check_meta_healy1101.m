load \\floatcoat\IFCBdata\IFCB8_HLY1101\metadata\HLY1101metadata.mat

load \\floatcoat\IFCBdata\IFCB8_HLY1101\data\ml_analyzed
[~,b,c] = intersect(regexprep({filelist.name}', '.adc', ''), {metadata.filename}');
meta = metadata(c);
isgoodsample = ones(size(meta));
for ind = 1:length(meta),
    if strcmp(meta(ind).manual_flag, 'omit'),
        isgoodsample(ind) = 0;
    elseif strcmp(meta(ind).samp_type, 'diags') | strcmp(meta(ind).samp_type, 'beads')
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
plot(numtriggers(isgoodsample==1)./runtime(isgoodsample==1), looktime2(isgoodsample==1)./runtime(isgoodsample==1), 'ro')

