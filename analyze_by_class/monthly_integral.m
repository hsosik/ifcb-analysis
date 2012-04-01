load '\\raspberry\d_work\ifcb1\ifcb_data_mvco_jun06\manual_fromClass\summary\count_biovol_manual_20Mar2012_day'
ii = find(floor(matdate_bin) == datenum('2-9-2010')); %skip this day with one partial sample
classbiovol_bin(ii,:) = []; classcount_bin(ii,:) = []; ml_analyzed_mat_bin(ii,:) = []; matdate_bin(ii) = [];

class_dino = {'Ceratium' 'dino30' 'Dinophysis' 'Gyrodinium' 'Prorocentrum' 'Gonyaulax'};
class_nonphyto = {'Thalassiosira_dirty' 'bad' 'ciliate' 'detritus' 'not_ciliate' 'ciliate_mix' 'tintinnid' 'Myrionecta' 'Laboea'};
class_mix = {'mix' 'clusterflagellate' 'crypto' 'Euglena' 'flagellate' 'kiteflagellates' 'Phaeocystis' 'Pyramimonas' 'roundCell' 'mix_elongated'};
class_diatom = {'Asterionellopsis' 'Cerataulina' 'Chaetoceros' 'Corethron' 'Coscinodiscus' 'Cylindrotheca' 'DactFragCerataul' 'Dactyliosolen'... 
    'Ditylum' 'Ephemera' 'Eucampia' 'Guinardia' 'Guinardia_flaccida' 'Guinardia_striata' 'Hemiaulus' 'Lauderia' 'Leptocylindrus' 'Licmophora'...
    'Odontella' 'Paralia' 'Pleurosigma' 'Pseudonitzschia' 'Rhizosolenia' 'Skeletonema' 'Stephanopyxis' 'Thalassionema' 'Thalassiosira' 'pennate'};
class_ciliate = {'ciliate' 'ciliate_mix' 'tintinnid' 'Myrionecta' 'Laboea'};
%skip: 'Eucampia_groenlandica' 'Tropidoneis' 'dino10'
%'other' 'bad'
[~,ind_diatoms] = intersect(class2use, class_diatom);
[~,ind_dino] = intersect(class2use, class_dino);
[~,ind_mix] = intersect(class2use, class_mix);
[~,ind_ciliate] = intersect(class2use, class_ciliate); ind_ciliate = sort(ind_ciliate);

class_label = class2use;
class_label(strmatch('Leptocylindrus', class_label, 'exact')) = {'\itLeptocylindrus \rmspp.'};
class_label(strmatch('Guinardia', class_label, 'exact')) = {'\itGuinardia delicatula'};
class_label(strmatch('Rhizosolenia', class_label, 'exact')) = {'\itRhizosolenia \rmspp.'};
class_label(strmatch('Chaetoceros', class_label, 'exact')) = {'\itChaetoceros \rmspp.'};
class_label(strmatch('Eucampia_groenlandica', class_label, 'exact')) = {'\itEucampia groenlandica'};
class_label(strmatch('Thalassiosira', class_label, 'exact')) = {'\itThalassiosira \rmspp.'};
class_label(strmatch('DactFragCerataul', class_label, 'exact')) = {'\itDactyliosolen fragilissimus'};
class_label(strmatch('Asterionellopsis', class_label, 'exact')) = {'\itAsterionellopsis glacialis'};
class_label(strmatch('Skeletonema', class_label, 'exact')) = {'\itSkeletonema \rmspp.'};
class_label(strmatch('Ditylum', class_label, 'exact')) = {'\itDitylum brightwellii'};
class_label(strmatch('Thalassionema', class_label, 'exact')) = {'\itThalassionema \rmspp.'};
class_label(strmatch('Dactyliosolen', class_label, 'exact')) = {'\itDactyliosolen blavyanus'};
class_label(strmatch('Corethron', class_label, 'exact')) = {'\itCorethron hystrix'};
class_label(strmatch('Guinardia_striata', class_label, 'exact')) = {'\itGuinardia striata'};
class_label(strmatch('Cylindrotheca', class_label, 'exact')) = {'\itCylindrotheca \rmspp.'};
class_label(strmatch('Pleurosigma', class_label, 'exact')) = {'\itPleurosigma \rmspp.'};
class_label(strmatch('Pseudonitzschia', class_label, 'exact')) = {'\itPseudonitzschia \rmspp.'};
class_label(strmatch('Guinardia_flaccida', class_label, 'exact')) = {'\itGuinardia flaccida'};
class_label(strmatch('Ephemera', class_label, 'exact')) = {'\itEphemera \rmspp.'};
class_label(strmatch('Eucampia', class_label, 'exact')) = {'\itEucampia cornuta'};
class_label(strmatch('Ephemera', class_label, 'exact')) = {'\itEphemera \rmspp.'};
class_label(strmatch('pennate', class_label, 'exact')) = {'pennate, misc.'};
class_label(strmatch('Lauderia', class_label, 'exact')) = {'\itLauderia annulata'};
class_label(strmatch('Licmophora', class_label, 'exact')) = {'\itLicmophora \rmspp.'};
class_label(strmatch('Stephanopyxis', class_label, 'exact')) = {'\itStephanopyxis \rmspp.'};
class_label(strmatch('Cerataulina', class_label, 'exact')) = {'\itCerataulina pelagica'};
class_label(strmatch('Odontella', class_label, 'exact')) = {'\itOdontella \rmspp.'};
class_label(strmatch('Coscinodiscus', class_label, 'exact')) = {'\itCoscinodiscus \rmspp.'};
class_label(strmatch('Paralia', class_label, 'exact')) = {'\itParalia sulcata'};


yd_ifcb = datevec(matdate_bin);
yd_ifcb = matdate_bin-datenum(yd_ifcb(:,1),0,0);

x = sum(classbiovol_bin(:,ind_diatoms)./ml_analyzed_mat_bin(:,ind_diatoms),2); indall = find(~isnan(x));
x = classbiovol_bin(indall,ind_diatoms)./ml_analyzed_mat_bin(indall,ind_diatoms); %class specific biomass/mL for cases with all diatom classes counted
xsum = sum(x,2);
matdate_int = (matdate_bin(1):matdate_bin(end));
dsum_int = interp1(matdate_bin(indall), xsum, matdate_int);

[yint, mint, dint] = datevec(matdate_int);

dsum_month_integral = NaN(9,12);
for yii = 2003:2011,
    for mii = 1:12,
        ind = find(yint == yii & mint == mii);
        dsum_month_integral(yii-2002,mii) = nansum(dsum_int(ind));
    end;
end;