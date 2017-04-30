%FCB analysis
%read files produced by sizedist_save2 and sizedist_daily

inpath = '\\sosiknas1\Lab_data\MVCO\FCB\summary\';
flist = dir([inpath 'sizedist_daily*']);

FCB_Ndist = [];
FCB_mdate_day = [];
FCB_ml = [];
for ii = 1:length(flist),
    [~,fn] = fileparts(flist(ii).name);
    %eval([t ' = load([''' inpath t ''']);'])
    t = load([inpath fn]);
    FCB_Ndist = [FCB_Ndist t.Ndist_syn+t.Ndist_euk+t.Ndist_crp];
    FCB_mdate_day = [FCB_mdate_day t.mdate_day];
    FCB_ml = [FCB_ml t.ml_analyzed];
end
FCB_diambins = t.diambins;
save FCB_N_biovol_1micron_summary

