
FCB_size_budget


Total_2006_sizeclass1 = sizeclass2006.biovolperml_euk(:,1)+sizeclass2006.biovolperml_syn(:,1)+sizeclass2006.biovolperml_crp(:,1);
Total_2007_sizeclass1 = sizeclass2007.biovolperml_euk(:,1)+sizeclass2007.biovolperml_syn(:,1)+sizeclass2007.biovolperml_crp(:,1);
Total_2008_sizeclass1 = sizeclass2008.biovolperml_euk(:,1)+sizeclass2008.biovolperml_syn(:,1)+sizeclass2008.biovolperml_crp(:,1);
Total_2009_sizeclass1 = sizeclass2009.biovolperml_euk(:,1)+sizeclass2009.biovolperml_syn(:,1)+sizeclass2009.biovolperml_crp(:,1);
Total_2010_sizeclass1 = sizeclass2010.biovolperml_euk(:,1)+sizeclass2010.biovolperml_syn(:,1)+sizeclass2010.biovolperml_crp(:,1);
Total_2011_sizeclass1 = sizeclass2011.biovolperml_euk(:,1)+sizeclass2011.biovolperml_syn(:,1)+sizeclass2011.biovolperml_crp(:,1);
Total_2012_sizeclass1 = sizeclass2012.biovolperml_euk(:,1)+sizeclass2012.biovolperml_syn(:,1)+sizeclass2012.biovolperml_crp(:,1);

Total_all_sizeclass1 = [Total_2006_sizeclass1; Total_2007_sizeclass1; Total_2008_sizeclass1; Total_2009_sizeclass1; Total_2010_sizeclass1; Total_2011_sizeclass1; Total_2012_sizeclass1];
Total_all_mdate = [sizeclass2006.mdate_day;sizeclass2007.mdate_day;sizeclass2008.mdate_day;sizeclass2009.mdate_day;sizeclass2010.mdate_day;sizeclass2011.mdate_day;sizeclass2012.mdate_day]; 
[mdate_mat, Total_all_sizeclass1_mat] = timeseries2ydmat(Total_all_mdate, Total_all_sizeclass1 );

Total_2006_sizeclass2 = sizeclass2006.biovolperml_euk(:,2)+sizeclass2006.biovolperml_syn(:,2)+sizeclass2006.biovolperml_crp(:,2);
Total_2007_sizeclass2 = sizeclass2007.biovolperml_euk(:,2)+sizeclass2007.biovolperml_syn(:,2)+sizeclass2007.biovolperml_crp(:,2);
Total_2008_sizeclass2 = sizeclass2008.biovolperml_euk(:,2)+sizeclass2008.biovolperml_syn(:,2)+sizeclass2008.biovolperml_crp(:,2);
Total_2009_sizeclass2 = sizeclass2009.biovolperml_euk(:,2)+sizeclass2009.biovolperml_syn(:,2)+sizeclass2009.biovolperml_crp(:,2);
Total_2010_sizeclass2 = sizeclass2010.biovolperml_euk(:,2)+sizeclass2010.biovolperml_syn(:,2)+sizeclass2010.biovolperml_crp(:,2);
Total_2011_sizeclass2 = sizeclass2011.biovolperml_euk(:,2)+sizeclass2011.biovolperml_syn(:,2)+sizeclass2011.biovolperml_crp(:,2);
Total_2012_sizeclass2 = sizeclass2012.biovolperml_euk(:,2)+sizeclass2012.biovolperml_syn(:,2)+sizeclass2012.biovolperml_crp(:,2);

Total_all_sizeclass2 = [Total_2006_sizeclass2; Total_2007_sizeclass2; Total_2008_sizeclass2; Total_2009_sizeclass2; Total_2010_sizeclass2; Total_2011_sizeclass2; Total_2012_sizeclass2];
[mdate_mat, Total_all_sizeclass2_mat] = timeseries2ydmat(Total_all_mdate, Total_all_sizeclass2 );

Total_2006_sizeclass3 = sizeclass2006.biovolperml_euk(:,3)+sizeclass2006.biovolperml_syn(:,3)+sizeclass2006.biovolperml_crp(:,3);
Total_2007_sizeclass3 = sizeclass2007.biovolperml_euk(:,3)+sizeclass2007.biovolperml_syn(:,3)+sizeclass2007.biovolperml_crp(:,3);
Total_2008_sizeclass3 = sizeclass2008.biovolperml_euk(:,3)+sizeclass2008.biovolperml_syn(:,3)+sizeclass2008.biovolperml_crp(:,3);
Total_2009_sizeclass3 = sizeclass2009.biovolperml_euk(:,3)+sizeclass2009.biovolperml_syn(:,3)+sizeclass2009.biovolperml_crp(:,3);
Total_2010_sizeclass3 = sizeclass2010.biovolperml_euk(:,3)+sizeclass2010.biovolperml_syn(:,3)+sizeclass2010.biovolperml_crp(:,3);
Total_2011_sizeclass3 = sizeclass2011.biovolperml_euk(:,3)+sizeclass2011.biovolperml_syn(:,3)+sizeclass2011.biovolperml_crp(:,3);
Total_2012_sizeclass3 = sizeclass2012.biovolperml_euk(:,3)+sizeclass2012.biovolperml_syn(:,3)+sizeclass2012.biovolperml_crp(:,3);

Total_all_sizeclass3 = [Total_2006_sizeclass3; Total_2007_sizeclass3; Total_2008_sizeclass3; Total_2009_sizeclass3; Total_2010_sizeclass3; Total_2011_sizeclass3; Total_2012_sizeclass3];
[mdate_mat, Total_all_sizeclass3_mat] = timeseries2ydmat(Total_all_mdate, Total_all_sizeclass3 );

Total_2006_sizeclass4 = sizeclass2006.biovolperml_euk(:,4)+sizeclass2006.biovolperml_syn(:,4)+sizeclass2006.biovolperml_crp(:,4);
Total_2007_sizeclass4 = sizeclass2007.biovolperml_euk(:,4)+sizeclass2007.biovolperml_syn(:,4)+sizeclass2007.biovolperml_crp(:,4);
Total_2008_sizeclass4 = sizeclass2008.biovolperml_euk(:,4)+sizeclass2008.biovolperml_syn(:,4)+sizeclass2008.biovolperml_crp(:,4);
Total_2009_sizeclass4 = sizeclass2009.biovolperml_euk(:,4)+sizeclass2009.biovolperml_syn(:,4)+sizeclass2009.biovolperml_crp(:,4);
Total_2010_sizeclass4 = sizeclass2010.biovolperml_euk(:,4)+sizeclass2010.biovolperml_syn(:,4)+sizeclass2010.biovolperml_crp(:,4);
Total_2011_sizeclass4 = sizeclass2011.biovolperml_euk(:,4)+sizeclass2011.biovolperml_syn(:,4)+sizeclass2011.biovolperml_crp(:,4);
Total_2012_sizeclass4 = sizeclass2012.biovolperml_euk(:,4)+sizeclass2012.biovolperml_syn(:,4)+sizeclass2012.biovolperml_crp(:,4);

Total_all_sizeclass4 = [Total_2006_sizeclass4; Total_2007_sizeclass4; Total_2008_sizeclass4; Total_2009_sizeclass4; Total_2010_sizeclass4; Total_2011_sizeclass4; Total_2012_sizeclass4];
[mdate_mat, Total_all_sizeclass4_mat] = timeseries2ydmat(Total_all_mdate, Total_all_sizeclass4 );
Total_all_sizeclass4_mat_added = Total_all_sizeclass4_mat + biovol10_20phyto_mat;

Total_2006_sizeclass5 = sizeclass2006.biovolperml_euk(:,5)+sizeclass2006.biovolperml_syn(:,5)+sizeclass2006.biovolperml_crp(:,5);
Total_2007_sizeclass5 = sizeclass2007.biovolperml_euk(:,5)+sizeclass2007.biovolperml_syn(:,5)+sizeclass2007.biovolperml_crp(:,5);
Total_2008_sizeclass5 = sizeclass2008.biovolperml_euk(:,5)+sizeclass2008.biovolperml_syn(:,5)+sizeclass2008.biovolperml_crp(:,5);
Total_2009_sizeclass5 = sizeclass2009.biovolperml_euk(:,5)+sizeclass2009.biovolperml_syn(:,5)+sizeclass2009.biovolperml_crp(:,5);
Total_2010_sizeclass5 = sizeclass2010.biovolperml_euk(:,5)+sizeclass2010.biovolperml_syn(:,5)+sizeclass2010.biovolperml_crp(:,5);
Total_2011_sizeclass5 = sizeclass2011.biovolperml_euk(:,5)+sizeclass2011.biovolperml_syn(:,5)+sizeclass2011.biovolperml_crp(:,5);
Total_2012_sizeclass5 = sizeclass2012.biovolperml_euk(:,5)+sizeclass2012.biovolperml_syn(:,5)+sizeclass2012.biovolperml_crp(:,5);

Total_all_sizeclass5 = [Total_2006_sizeclass5; Total_2007_sizeclass5; Total_2008_sizeclass5; Total_2009_sizeclass5; Total_2010_sizeclass5; Total_2011_sizeclass5; Total_2012_sizeclass5];
[mdate_mat, Total_all_sizeclass5_mat] = timeseries2ydmat(Total_all_mdate, Total_all_sizeclass5 );

