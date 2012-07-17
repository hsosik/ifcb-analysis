year_fcb = 2003:2012;
%read files produced by sizedist1micron_save and size1micron_daily on queenrose

sizedist2003 = load('\\queenrose\mvco\MVCO_sep2003\code_misc\sizedist_1micron'); %includes results from may2003
sizedist2004 = load('\\queenrose\mvco\MVCO_apr2004\code_misc\sizedist_1micron');
sizedist2005 = load('\\queenrose\mvco\MVCO_apr2005\code_misc\sizedist_1micron');
sizedist2006 = load('\\queenrose\mvco\MVCO_may2006\code_misc\sizedist_1micron');
sizedist2007 = load('\\queenrose\mvco\MVCO_mar2007\code_misc\sizedist_1micron');
sizedist2008 = load('\\queenrose\mvco\MVCO_jan2008\code_misc\sizedist_1micron');
sizedist2009 = load('\\queenrose\mvco\MVCO_jan2009\code_misc\sizedist_1micron');
sizedist2010 = load('\\queenrose\mvco\MVCO_jan2010\code_misc\sizedist_1micron');
sizedist2011 = load('\\queenrose\mvco\MVCO_jan2011\code_misc\sizedist_1micron');
sizedist2012 = load('\\queenrose\mvco\MVCO_jan2012\code_misc\sizedist_1micron');

save FCB_N_biovol_1micron_summary

