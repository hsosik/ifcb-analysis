 N0_10_mat = squeeze(cell2mat(struct2cell(N0_10)))'./ml_day_mat; N0_10sum = sum(N0_10_mat,2);
N10_30_mat = squeeze(cell2mat(struct2cell(N10_30)))'./ml_day_mat; N10_30sum = sum(N10_30_mat,2);
N30_60_mat = squeeze(cell2mat(struct2cell(N30_60)))'./ml_day_mat; N30_60sum = sum(N30_60_mat,2);
N30_40_mat = squeeze(cell2mat(struct2cell(N30_40)))'./ml_day_mat; N30_40sum = sum(N30_40_mat,2);
N60_inf_mat = squeeze(cell2mat(struct2cell(N60_inf)))'./ml_day_mat; N60_infsum = sum(N60_inf_mat,2);

[ind_ciliate] = get_ciliate_ind(classes,classes);
ciliate_flag = zeros(size(classes));

N0_10ciliate_tintinnid = sum(N0_10_mat(:,ind_ciliate(19)),2);
N10_30ciliate_tintinnid = sum(N10_30_mat(:,ind_ciliate(19)),2);
N30_60ciliate_tintinnid = sum(N30_60_mat(:,ind_ciliate(19)),2);
N30_40ciliate_tintinnid = sum(N30_40_mat(:,ind_ciliate(19)),2);
N60_infciliate_tintinnid = sum(N60_inf_mat(:,ind_ciliate(19)),2);

[ Cmdate_mat, N0_10ciliate_tintinnid_mat, yearlist, yd ] = timeseries2ydmat( unqday, N0_10ciliate_tintinnid );
[ Cmdate_mat, N10_30ciliate_tintinnid_mat, yearlist, yd ] = timeseries2ydmat( unqday, N10_30ciliate_tintinnid );
[ Cmdate_mat, N30_60ciliate_tintinnid_mat, yearlist, yd ] = timeseries2ydmat( unqday, N30_60ciliate_tintinnid );
[ Cmdate_mat, N30_40ciliate_tintinnid_mat, yearlist, yd ] = timeseries2ydmat( unqday, N30_40ciliate_tintinnid );
[ Cmdate_mat, N60_infciliate_tintinnid_mat, yearlist, yd ] = timeseries2ydmat( unqday, N60_infciliate_tintinnid );

clear N30_40ciliate_tintinnid_mat N30_40ciliate_tintinnid

 
resultpath = 'C:\Users\Emily Fay\Documents\Ciliate_Code\tintinnid\';
datestr = date; datestr = regexprep(datestr,'-','');
save([resultpath 'tintinnid_size_manual_' datestr],'yearlist', 'Cmdate_mat','yd', 'N0_10ciliate_tintinnid_mat', 'N10_30ciliate_tintinnid_mat', 'N30_60ciliate_tintinnid_mat', 'N60_infciliate_tintinnid_mat')

load C:\Users\Emily Fay\Documents\Ciliate_Code\tintinnid\tintinnid_size_manual_07Aug2013.mat