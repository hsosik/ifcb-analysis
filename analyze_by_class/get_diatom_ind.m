function [ ind_out, class_label ] = get_diatom_ind( class2use, class_label )
%function [ ind_out, class_label ] = get_diatom_ind( class2use, class_label )
% MVCO class list specific to return of indices that correspond to diatom taxa
% this case also revises some labels
%  Heidi M. Sosik, Woods Hole Oceanographic Institution, March 2013

class2get = {'Asterionellopsis' 'Cerataulina' 'Chaetoceros' 'Corethron' 'Coscinodiscus' 'Cylindrotheca' 'DactFragCerataul' 'Dactyliosolen'... 
    'Ditylum' 'Ephemera' 'Eucampia' 'Guinardia' 'Guinardia_flaccida' 'Guinardia_striata' 'Hemiaulus' 'Lauderia' 'Leptocylindrus' 'Licmophora'...
    'Odontella' 'Paralia' 'Pleurosigma' 'Pseudonitzschia' 'Rhizosolenia' 'Skeletonema' 'Stephanopyxis' 'Thalassionema' 'Thalassiosira' 'pennate' 'mix_elongated'...
    'Delphineis' 'pennates_on_diatoms' 'Leptocylindrus_mediterraneus' 'Bacillaria' 'Bidulphia' 'pennate_morphotype1' 'Cerataulina_flagellate'...
    'Chaetoceros_flagellate' 'diatom_flagellate' 'Chaetoceros_didymus_flagellate'};

[~,ind_out1] = intersect(class2use, class2get);
ind_out2 = get_Chaetoceros_ind( class2use, class_label );
ind_out3 = get_G_delicatula_ind( class2use, class_label );
ind_out4 = get_Cerataulina_ind(  class2use, class_label );
ind_out5 = get_ditylum_ind(  class2use, class_label );

ind_out = union(ind_out1, [ind_out2; ind_out3; ind_out4; ind_out5]);
ind_out = sort(ind_out);

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
class_label(strmatch('mix_elongated', class_label, 'exact')) = {'misc. small diatoms'};

end

