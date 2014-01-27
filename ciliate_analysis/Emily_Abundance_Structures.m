load 'C:\Users\Emily Fay\Documents\Ciliate_Code\count_manual_10Jun2013_day.mat'

[ ind_ciliate, class_label ] = get_ciliate_ind( class2use, class2use );
ciliate_classcount=(classcount_bin(:,ind_ciliate)./ml_analyzed_mat_bin(:,ind_ciliate)); 
ciliate_classcount(isnan(ciliate_classcount))=0; 
    
ciliate_label=class_label(ind_ciliate); %takes all ciliate data from ciliate_class count matrix and puts it into structures
for label=1:length(ciliate_label)
    Ciliate_abundance_Struct.(ciliate_label{label})=ciliate_classcount(:,label);
end

classes = fields(Ciliate_abundance_Struct); %goes through all elements of structure and makes two new structures (day and week binned matrices)
for classcount=1:length(classes),
    [mdate_mat, Ciliate_day_mat.(classes{classcount}), yearlist, yd ] = timeseries2ydmat( matdate_bin, Ciliate_abundance_Struct.(classes{classcount}));
    [Ciliate_week_mat.(classes{classcount}), Ciliate_weekstd.(classes{classcount}), mdate_wkmat, yd_wk] =ydmat2weeklymat(Ciliate_day_mat.(classes{classcount}), yearlist);
end
 
for classcount=1:length(classes);
   Ciliate_year_Struct.(classes{classcount})=(Ciliate_day_mat.(classes{classcount})(:,3));%indexes a certain year...in this case, 2008
%    for classcount=1:length(classes);
%        Ciliate_year_Struct.(classes{classcount})(isnan(Ciliate_year_Struct.(classes{classcount})))=0;
%    end
end

 for classcount=1:length(classes);
   Ciliate_year_Struct.(classes{classcount})=(Ciliate_day_mat.(classes{classcount})(:,3));%indexes a certain year...in this case, 2008
   Ciliate_year_Struct.(classes{classcount})(isnan(Ciliate_year_Struct.(classes{classcount})))=0;
 end
 
 for classcount=1:length(classes),
    [ Ciliate_day_mean.(classes{classcount}),Ciliate_day_std.(classes{classcount})] = smoothed_climatology( Ciliate_day_mat.(classes{classcount}),1);
 end
 
 for classcount=1:length(classes),
    [ Ciliate_week_mean.(classes{classcount}),Ciliate_day_std.(classes{classcount})] = smoothed_climatology( Ciliate_week_mat.(classes{classcount}),1);
 end
 
 Ciliate_week_mean_cell=struct2cell(Ciliate_week_mean);
 Ciliate_week_mean_mat=cell2mat(Ciliate_week_mean_cell);
 Ciliate_week_mean_mat=Ciliate_week_mean_mat';
 
 


resultpath = 'C:\Users\Emily Fay\Documents\Ciliate_Code\Summary\\';
datestr = date; datestr = regexprep(datestr,'-','');
save([resultpath 'ciliate_abundance_manual_' datestr],'Ciliate_abundance_Struct', 'Ciliate_week_mat','Ciliate_week_mean_mat', 'ciliate_label', 'Ciliate_week_mean')
