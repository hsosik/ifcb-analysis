feapath = 'C:\work\IFCB\ifcb_data_MVCO_jun06\features_test\';
%manual_path = 'C:\work\IFCB\ifcb_data_MVCO_jun06\Manual_fromClass\';
manual_path = '\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\';
load([manual_path 'manual_list']) %load the manual list detailing annotate mode for each sample file
load class2use_MVCOmanual5 %get the master list to start
class2use_main = class2use;
numclasses = length(class2use_main);
micron_factor = 1/3.4; %microns per pixel

[ classes_byfile, classes_bymode ] = get_annotated_classesMVCO( class2use, manual_list);
iphyto = get_phyto_ind(class2use, class2use);
t = find(sum(classes_byfile.classes_checked(:,iphyto),2) == length(iphyto)); 
files_phyto = classes_byfile.filelist(t); clear t %files that are complete for phyto

filelist = dir([feapath 'I*.csv']);
filelist = {filelist.name}';
filelist_man = regexprep(filelist, '_fea_v3test.csv', '');

[~,ia,ib] = intersect(filelist_man, files_phyto);
filelist = filelist(ia);
filelist_man = filelist_man(ia);

matdate = IFCB_file2date(filelist_man);
fileday = floor(matdate);
unqday = unique(fileday);
fea = importdata([feapath filelist{1}]);
%man = load([manual_path filelist_man{1}]);
iPA = strmatch('summedArea', fea.textdata);
iSA = strmatch('summedSurfaceArea', fea.textdata);
iBV = strmatch('summedBiovolume', fea.textdata);
iED = strmatch('EquivDiameter', fea.textdata);
imaxF = strmatch('summedFeretDiameter', fea.textdata);
%for count = 1:length(filelist)
EDbins = 5:100;
FDbins = 10:10:500;
SAbins = 150:100:10050;
BVbins = logspace(2.2,5,100);
SA_BVbins = .2:.1:10;
ndays = length(unqday);
N = NaN(ndays,1);
EDhist = NaN(ndays,length(EDbins));
FDhist = NaN(ndays,length(FDbins));
SAhist = NaN(ndays,length(SAbins));
BVhist = NaN(ndays,length(BVbins));
SA_BVhist = NaN(ndays,length(SA_BVbins));
EDstats = NaN(ndays,4);
FDstats = EDstats;
SAstats = EDstats;
BVstats = EDstats;
SA_BVstats  = EDstats;
for count = 1:length(unqday)
    ifile = find(fileday == unqday(count));
    feadata = [];
    for count2 = 1:length(ifile)
        fea = importdata([feapath filelist{ifile(count2)}]);
        man = load([manual_path filelist_man{ifile(count2)}]);
        t = min([length(man.class2use_manual) numclasses]);
        if ~isequal(man.class2use_manual(1:t), class2use_main(1:t))
            disp('problem: class2use does not match')
            keyboard
        end 
        class = man.classlist(fea.data(:,1),2:3); %just take the ones with ROIs
        temp = find(isnan(class(:,1))); %find cases with no manual (NaN)
        class(temp,1) = class(temp,2); class(:,2) = []; %if no manual, take auto
        ind = ismember(class,iphyto); %phyto indices in list of classes for ROIs, these are indices into fea.data rows
        feadata = [feadata; fea.data(ind,:)]; %just the phyto rows
    end
    summedED = sqrt(feadata(:,iPA)/pi)*2;
    ind = find(summedED*micron_factor>=7);
    feadata = feadata(ind,:); %just the cases with equiv diameter >= 7 microns
    N(count) = length(ind);
    x = summedED(ind).*micron_factor;
    xbins = EDbins;
    EDstats(count,:) = [mean(x) 10.^(mean(log10(x))) mode(x) median(x)];
    EDhist(count,:) = hist(x, xbins);
    x = feadata(:,imaxF).*micron_factor;
    xbins = FDbins;
    FDstats(count,:) = [mean(x) 10.^(mean(log10(x))) mode(x) median(x)];
    FDhist(count,:) = hist(x, xbins);
    x = feadata(:,iSA).*micron_factor^2; xbins = SAbins;
    SAstats(count,:) = [mean(x) 10.^(mean(log10(x))) mode(x) median(x)];
    SAhist(count,:) = hist(x, xbins);
    x = feadata(:,iBV).*micron_factor^3; xbins = BVbins;
    BVstats(count,:) = [mean(x) 10.^(mean(log10(x))) mode(x) median(x)];
    BVhist(count,:) = hist(x, xbins);
    x = feadata(:,iSA)./feadata(:,iBV)./micron_factor; xbins = SA_BVbins;
    SA_BVstats(count,:) = [mean(x) 10.^(mean(log10(x))) mode(x) median(x)];
    SA_BVhist(count,:) = hist(x, xbins);
    if 0
        figure(1), loglog(SA_BVbins, SA_BVhist(count,:), '.-'), xlim(SA_BVbins([1,end])), ylim([.9 inf])
        figure(2), loglog(feadata(:,iSA)./feadata(:,iBV)./micron_factor,  feadata(:,imaxF).*micron_factor, '.'), xlim([.1 20]), ylim([5 100])
        hold on, fplot('6/x', xlim), hold off %limit for sphere
        %loglog(BVbins, BVhist(count,:), '.-'), xlim(BVbins([1,end])), ylim([.9 inf])
        %loglog(SAbins, SAhist(count,:), '.-'), xlim(SAbins([1,end])), ylim([.9 inf])
        %loglog(EDbins, EDhist(count,:)), xlim(EDbins([1,end])
        title(datestr(unqday(count)))
        pause
    end
end

mdate = unqday;
clear count* x* i*
save('compiled_results', 'filelist_man', '*hist', '*bins', 'N', 'mdate', '*stats')

return
plot(fea.data(ind,imaxF), (fea.data(ind,iSA)./fea.data(ind,iBV)), '.')
plot(fea.data(ind,iED), (fea.data(ind,iSA)./fea.data(ind,iBV)), '.')
hold on
fplot('3/x*2',xlim) 
ylim([0 1])