load FCB_N_biovol_1micron_summary

diambins = sizedist2003.diambins;
diam_ind.class0_2microns = find(diambins < 2); %diam < 2 microns
diam_ind.class2_5microns = find(diambins >= 2 & diambins < 5); %this will be 2>=diam<5
diam_ind.class5_10microns = find(diambins >= 5 & diambins < 10); %this will be 5>=diam<10

sizebinfields = fields(diam_ind);

for yrcount = 1:length(year_fcb),
    eval(['sizedist = sizedist' num2str(year_fcb(yrcount)) ';']);
    sizeclass.Nperml_syn = NaN(length(sizedist.ml_analyzed),length(sizebinfields));
    sizeclass.Nperml_euk = sizeclass.Nperml_syn;
    sizeclass.Nperml_crp = sizeclass.Nperml_syn;
    sizeclass.biovolperml_syn = sizeclass.Nperml_syn;
    sizeclass.biovolperml_euk = sizeclass.Nperml_syn;
    sizeclass.biovolperml_crp = sizeclass.Nperml_syn;
    for bincount = 1:length(sizebinfields)
        ind = diam_ind.(sizebinfields{bincount});
        sizeclass.Nperml_syn(:,bincount) = nansum(sizedist.Ndist_syn(ind,:))./sizedist.ml_analyzed;
        sizeclass.Nperml_euk(:,bincount) = nansum(sizedist.Ndist_euk(ind,:))./sizedist.ml_analyzed;
        sizeclass.Nperml_crp(:,bincount) = nansum(sizedist.Ndist_crp(ind,:))./sizedist.ml_analyzed;
        sizeclass.biovolperml_syn(:,bincount) = nansum(sizedist.biovoldist_syn(ind,:))./sizedist.ml_analyzed;
        sizeclass.biovolperml_euk(:,bincount) = nansum(sizedist.biovoldist_euk(ind,:))./sizedist.ml_analyzed;
        sizeclass.biovolperml_crp(:,bincount) = nansum(sizedist.biovoldist_crp(ind,:))./sizedist.ml_analyzed;
    end;
    sizeclass.sizebins = sizebinfields';
    sizeclass.mdate_day = sizedist.mdate_day';
    eval(['sizeclass' num2str(year_fcb(yrcount)) ' = sizeclass;']);
    clear sizeclass
    sizeclass.classnotes = 'crp = estimated cryptophytes - NEEDS WORK; crp and euk should be added together for total eukaryotes';
    sizeclass.unitsnotes = 'Nperml = cell abundance per mL; biovolperml = cubic microns per mL';
end;
clear ind yrcount bincount diambins diam_ind sizebinfields sizeclass

clear sizedist*