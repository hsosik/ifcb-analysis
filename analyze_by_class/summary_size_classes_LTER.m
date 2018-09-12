%load 'c:\work\IFCB\ifcb_data_mvco_jun06\Manual_fromClass\summary\count_biovol_size_manual_24Jan2014.mat'
resultpath = '\\sosiknas1\IFCB_products\NESLTER_transect\summary\';
load([resultpath 'count_biovol_size_manual_14Aug2018'])
micron_factor = 1/3.4; %microns per pixel

classes_fields = fields(summary.count);
classes = regexprep(classes_fields, '__', '-');
classes = regexprep(classes_fields,'_', ' ');
  
% [ind_diatom] = get_diatom_ind(classes,classes);
% diatom_flag = zeros(size(classes));
% diatom_flag(ind_diatom) = 1;
% [ind_ciliate] = get_ciliate_ind(classes,classes);

for filecount = 1:length(filelist),
    disp(filelist(filecount))
    for classcount = 1:length(classes),
        iii = find(summary.eqdiam.(classes_fields{classcount}){filecount} < 10/micron_factor);
        if ~isempty(iii),
            N0_10.(classes_fields{classcount})(filecount) = length(iii);
            biovol0_10.(classes_fields{classcount})(filecount) = nansum(summary.biovol.(classes_fields{classcount}){filecount}(iii)*micron_factor^3);
        else
            N0_10.(classes_fields{classcount})(filecount) = 0;
            biovol0_10.(classes_fields{classcount})(filecount) = 0;
        end;
        iii = find(summary.eqdiam.(classes_fields{classcount}){filecount} >= 10/micron_factor & summary.eqdiam.(classes_fields{classcount}){filecount} < 20/micron_factor);
        if ~isempty(iii),
            N10_20.(classes_fields{classcount})(filecount) = length(iii);
            biovol10_20.(classes_fields{classcount})(filecount) = nansum(summary.biovol.(classes_fields{classcount}){filecount}(iii)*micron_factor^3);
        else
            N10_20.(classes_fields{classcount})(filecount) = 0;
            biovol10_20.(classes_fields{classcount})(filecount) = 0;    
        end;
        iii = find(summary.eqdiam.(classes_fields{classcount}){filecount} >= 20/micron_factor);
        if ~isempty(iii),
            N20_inf.(classes_fields{classcount})(filecount) = length(iii);
            biovol20_inf.(classes_fields{classcount})(filecount) = nansum(summary.biovol.(classes_fields{classcount}){filecount}(iii)*micron_factor^3);
        else
            N20_inf.(classes_fields{classcount})(filecount) = 0;, 
            biovol20_inf.(classes_fields{classcount})(filecount) = 0;    
        end;
    end;
end;
clear daycount classcount iii cellC

non_phyto = {'camera_spot' 'zooplankton' 'bead' 'bubble' 'bad' 'detritus'};
[~,phyto_ind] = setdiff(classes_fields, non_phyto);

N0_10_phyto = zeros(size(filelist));
N10_20_phyto = N0_10_phyto;
N20_inf_phyto = N0_10_phyto;
biovol0_10_phyto = N0_10_phyto;
biovol10_20_phyto = N0_10_phyto;
biovol20_inf_phyto = N0_10_phyto;
for classcount = 1:length(phyto_ind)
    N0_10_phyto = N0_10_phyto + N0_10.(classes_fields{phyto_ind(classcount)})';
    N10_20_phyto = N10_20_phyto + N10_20.(classes_fields{phyto_ind(classcount)})';
    N20_inf_phyto = N20_inf_phyto + N20_inf.(classes_fields{phyto_ind(classcount)})';
    biovol0_10_phyto = biovol0_10_phyto + biovol0_10.(classes_fields{phyto_ind(classcount)})';
    biovol10_20_phyto = biovol10_20_phyto + biovol10_20.(classes_fields{phyto_ind(classcount)})';
    biovol20_inf_phyto = biovol20_inf_phyto + biovol20_inf.(classes_fields{phyto_ind(classcount)})';    
end

Notes1 = 'Output from summary_size_classes_LTER.m';
Notes2 = 'Biovolume in cubic microns per ml';
datestr = date; datestr = regexprep(datestr,'-','');
save([ resultpath 'IFCB_biovolume_size_classes_manual_' datestr], 'matdate', 'N*', 'biovol*', 'filelist', 'classes', 'Notes*', 'micron_factor', 'ml_analyzed')

