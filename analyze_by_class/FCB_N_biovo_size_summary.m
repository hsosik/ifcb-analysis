year_fcb = 2003:2012;
load \\queenrose\mvco\MVCO_may2003\code_misc\sizedist_1micron  %read file produced by sizedist1micron_save and size1micron_daily on queenrose
Ndist_crp2003 = Ndist_crp;
Ndist_euk2003 = Ndist_euk;
Ndist_syn2003 = Ndist_syn;
biovoldist_crp2003 = biovoldist_crp;
biovoldist_euk2003 = biovoldist_euk;
biovoldist_syn2003 = biovoldist_syn;
mdate_day2003 = mdate_day;
ml_analyzed2003 = ml_analyzed;
load \\queenrose\mvco\MVCO_sep2003\code_misc\sizedist_1micron
Ndist_crp2003 = [Ndist_crp2003 Ndist_crp];
Ndist_euk2003 = [Ndist_euk2003 Ndist_euk];
Ndist_syn2003 = [Ndist_syn2003 Ndist_syn];
biovoldist_crp2003 = [biovoldist_crp2003 biovoldist_crp];
biovoldist_euk2003 = [biovoldist_euk2003 biovoldist_euk];
biovoldist_syn2003 = [biovoldist_syn2003 biovoldist_syn];
mdate_day2003 = [mdate_day2003 mdate_day];
ml_analyzed2003 = [ml_analyzed2003 ml_analyzed];
load \\queenrose\mvco\MVCO_apr2004\code_misc\sizedist_1micron
Ndist_crp2004 = Ndist_crp;
Ndist_euk2004 = Ndist_euk;
Ndist_syn2004 = Ndist_syn;
biovoldist_crp2004 = biovoldist_crp;
biovoldist_euk2004 = biovoldist_euk;
biovoldist_syn2004 = biovoldist_syn;
mdate_day2004 = mdate_day;
ml_analyzed2004 = ml_analyzed;
load \\queenrose\mvco\MVCO_apr2005\code_misc\sizedist_1micron
Ndist_crp2005 = Ndist_crp;
Ndist_euk2005 = Ndist_euk;
Ndist_syn2005 = Ndist_syn;
biovoldist_crp2005 = biovoldist_crp;
biovoldist_euk2005 = biovoldist_euk;
biovoldist_syn2005 = biovoldist_syn;
mdate_day2005 = mdate_day;
ml_analyzed2005 = ml_analyzed;
load \\queenrose\mvco\MVCO_may2006\code_misc\sizedist_1micron
Ndist_crp2006 = Ndist_crp;
Ndist_euk2006 = Ndist_euk;
Ndist_syn2006 = Ndist_syn;
biovoldist_crp2006 = biovoldist_crp;
biovoldist_euk2006 = biovoldist_euk;
biovoldist_syn2006 = biovoldist_syn;
mdate_day2006 = mdate_day;
ml_analyzed2006 = ml_analyzed;
load \\queenrose\mvco\MVCO_mar2007\code_misc\sizedist_1micron
Ndist_crp2007 = Ndist_crp;
Ndist_euk2007 = Ndist_euk;
Ndist_syn2007 = Ndist_syn;
biovoldist_crp2007 = biovoldist_crp;
biovoldist_euk2007 = biovoldist_euk;
biovoldist_syn2007 = biovoldist_syn;
mdate_day2007 = mdate_day;
ml_analyzed2007 = ml_analyzed;
load \\queenrose\mvco\MVCO_jan2008\code_misc\sizedist_1micron
Ndist_crp2008 = Ndist_crp;
Ndist_euk2008 = Ndist_euk;
Ndist_syn2008 = Ndist_syn;
biovoldist_crp2008 = biovoldist_crp;
biovoldist_euk2008 = biovoldist_euk;
biovoldist_syn2008 = biovoldist_syn;
mdate_day2008 = mdate_day;
ml_analyzed2008 = ml_analyzed;
load \\queenrose\mvco\MVCO_jan2009\code_misc\sizedist_1micron
Ndist_crp2009 = Ndist_crp;
Ndist_euk2009 = Ndist_euk;
Ndist_syn2009 = Ndist_syn;
biovoldist_crp2009 = biovoldist_crp;
biovoldist_euk2009 = biovoldist_euk;
biovoldist_syn2009 = biovoldist_syn;
mdate_day2009 = mdate_day;
ml_analyzed2009 = ml_analyzed;
load \\queenrose\mvco\MVCO_jan2010\code_misc\sizedist_1micron
Ndist_crp2010 = Ndist_crp;
Ndist_euk2010 = Ndist_euk;
Ndist_syn2010 = Ndist_syn;
biovoldist_crp2010 = biovoldist_crp;
biovoldist_euk2010 = biovoldist_euk;
biovoldist_syn2010 = biovoldist_syn;
mdate_day2010 = mdate_day;
ml_analyzed2010 = ml_analyzed;
load \\queenrose\mvco\MVCO_jan2011\code_misc\sizedist_1micron
Ndist_crp2011 = Ndist_crp;
Ndist_euk2011 = Ndist_euk;
Ndist_syn2011 = Ndist_syn;
biovoldist_crp2011 = biovoldist_crp;
biovoldist_euk2011 = biovoldist_euk;
biovoldist_syn2011 = biovoldist_syn;
mdate_day2011 = mdate_day;
ml_analyzed2011 = ml_analyzed;
load \\queenrose\mvco\MVCO_jan2012\code_misc\sizedist_1micron
Ndist_crp2012 = Ndist_crp;
Ndist_euk2012 = Ndist_euk;
Ndist_syn2012 = Ndist_syn;
biovoldist_crp2012 = biovoldist_crp;
biovoldist_euk2012 = biovoldist_euk;
biovoldist_syn2012 = biovoldist_syn;
mdate_day2012 = mdate_day;
ml_analyzed2012 = ml_analyzed;

clear Ndist_crp Ndist_euk Ndist_syn biovoldist_crp biovoldist_euk biovoldist_syn mdate_day ml_analyzed

save FCB_N_biovol_1micron_summary

