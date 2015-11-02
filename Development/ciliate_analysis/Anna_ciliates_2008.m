Ciliate_mix_2008=Ciliate_week_mat.Ciliate_mix(:,3);
Didinium_sp_2008=Ciliate_week_mat.Didinium_sp(:,3);
Euplotes_sp_2008=Ciliate_week_mat.Euplotes_sp(:,3);
Laboea_strobila_2008=Ciliate_week_mat.Laboea_strobila(:,3);
Leegaardiella_ovalis_2008=Ciliate_week_mat.Leegaardiella_ovalis(:,3);
Mesodinium_sp_2008=Ciliate_week_mat.Mesodinium_sp(:,3);
Pleuronema_sp_2008=Ciliate_week_mat.Pleuronema_sp(:,3);
Strobilidium_morphotype1_2008=Ciliate_week_mat.Strobilidium_morphotype1(:,3);
Strobilidium_morphotype2_2008=Ciliate_week_mat.Strobilidium_morphotype2(:,3);
Strombidium_capitatum_2008=Ciliate_week_mat.Strombidium_capitatum(:,3);
Strombidium_caudatum_2008=Ciliate_week_mat.Strombidium_caudatum(:,3);
Strombidium_conicum_2008=Ciliate_week_mat.Strombidium_conicum(:,3);
Strombidium_inclinatum_2008=Ciliate_week_mat.Strombidium_inclinatum(:,3);
Strombidium_morphotype1_2008=Ciliate_week_mat.Strombidium_morphotype1(:,3);
Strombidium_morphotype2_2008=Ciliate_week_mat.Strombidium_morphotype2(:,3);
Strombidium_oculatum_2008=Ciliate_week_mat.Strombidium_oculatum(:,3);
Strombidium_wulffi_2008=Ciliate_week_mat.Strombidium_wulffi(:,3);
Tiarina_fusus_2008=Ciliate_week_mat.Tiarina_fusus(:,3);
Tintinnid_2008=Ciliate_week_mat.Tintinnid(:,3);
Tontonia_appendiculariformis_2008=Ciliate_week_mat.Tontonia_appendiculariformis(:,3);
Tontonia_gracillima_2008=Ciliate_week_mat.Tontonia_gracillima(:,3);
%this makes 52x1 matrices out of the abundances in one year (2008) for each
%ciliate.
Ciliate_2008_flipped=[Ciliate_mix_2008';Didinium_sp_2008';Euplotes_sp_2008';Laboea_strobila_2008';Leegaardiella_ovalis_2008';Mesodinium_sp_2008';Pleuronema_sp_2008';Strobilidium_morphotype1_2008';Strobilidium_morphotype2_2008';Strombidium_capitatum_2008';Strombidium_caudatum_2008';Strombidium_conicum_2008';Strombidium_inclinatum_2008';Strombidium_morphotype1_2008';Strombidium_morphotype2_2008';Strombidium_oculatum_2008';Strombidium_wulffi_2008';Tiarina_fusus_2008';Tintinnid_2008';Tontonia_appendiculariformis_2008';Tontonia_gracillima_2008'];
Ciliate_2008_mat=Ciliate_2008_flipped';
%this makes a matrix of the weekly ciliate abundances for 2008
Ciliate_2008_mat(isnan(Ciliate_2008_mat))=0

 plot(yd_wk, Ciliate_2008_mat); 
 legend((ciliate_label), 'NorthEastOutside');
 datetick('x',4,'keeplimits');
 ylabel('Abundance (cell mL^{-1} \mum{-1})', 'fontsize', 12)
 
  Sum_ciliate_week=sum(Ciliate_2008_flipped)
 
 Sum_week_vector=Sum_ciliate_week';
 Percent_week_mat=Ciliate_2008_mat./repmat(Sum_week_vector,1,21);
 %creates a matrix of the percent of weekly abundance totals
 
  plot(yd_wk, Sum_week_vector); 
 legend((ciliate_label), 'NorthEastOutside');
 datetick('x',4,'keeplimits');
 ylabel('Abundance (cell mL^{-1} \mum{-1})', 'fontsize', 12)
 
bar((yd_wk),(Percent_week_mat),'stacked')
legend(ciliate_label)
datetick('x',4,'keeplimits')
ylabel('Proportion')
axis([-10 375 0 1])
 %makes a stacked bar graph of relative ciliate abundance
 
 for classcount=1:length(classes),
    [ Ciliate_day_mean.(classes{classcount}),Ciliate_day_std.(classes{classcount})] = smoothed_climatology( Ciliate_day_mat.(classes{classcount}),1);
 end 
 %smooth climatologies. can change to weeks if you want the weekly average.
 
for classcount=1:length(classes),
    [ Ciliate_week_mean.(classes{classcount}),Ciliate_week_std.(classes{classcount})] = smoothed_climatology( Ciliate_week_mat.(classes{classcount}),1);
 end 
 
 
 for classcount=1:length(classes);
   Ciliate_year_Struct.(classes{classcount})=(Ciliate_day_mat.(classes{classcount})(:,3));%indexes a certain year...in this case, 2008
   Ciliate_year_Struct.(classes{classcount})(isnan(Ciliate_year_Struct.(classes{classcount})))=0;
 end
 %to make a matrix of a certain year
plot(yd_wk,Ciliate_week_mean.Ciliate_mix(1,:))
hold on
 plot(yd_wk,(Ciliate_week_mean.Ciliate_mix(1,:)+Ciliate_week_std.Ciliate_mix(1,:)),'r');
plot(yd_wk,(Ciliate_week_mean.Ciliate_mix(1,:)-Ciliate_week_std.Ciliate_mix(1,:)),'r');
%to plot mean and standard deviations (error) of smoothed climatology. using weeks instead of day 

%to make smoothed climatology graph of all ciliate species: similar to just
%one year. Theoretically you use this matrix to do an ANOSIM.
Ciliate_mix=Ciliate_week_mean.Ciliate_mix;
Didinium_sp=Ciliate_week_mean.Didinium_sp;
Euplotes_sp=Ciliate_week_mean.Euplotes_sp;
Laboea_strobila=Ciliate_week_mean.Laboea_strobila;
Leegaardiella_ovalis=Ciliate_week_mean.Leegaardiella_ovalis;
Mesodinium_sp=Ciliate_week_mean.Mesodinium_sp;
Pleuronema_sp=Ciliate_week_mean.Pleuronema_sp;
Strobilidium_morphotype1=Ciliate_week_mean.Strobilidium_morphotype1;
Strobilidium_morphotype2=Ciliate_week_mean.Strobilidium_morphotype2;
Strombidium_capitatum=Ciliate_week_mean.Strombidium_capitatum;
Strombidium_caudatum=Ciliate_week_mean.Strombidium_caudatum;
Strombidium_conicum=Ciliate_week_mean.Strombidium_conicum;
Strombidium_inclinatum=Ciliate_week_mean.Strombidium_inclinatum;
Strombidium_morphotype1=Ciliate_week_mean.Strombidium_morphotype1;
Strombidium_morphotype2=Ciliate_week_mean.Strombidium_morphotype2;
Strombidium_oculatum=Ciliate_week_mean.Strombidium_oculatum;
Strombidium_wulffi=Ciliate_week_mean.Strombidium_wulffi;
Tiarina_fusus=Ciliate_week_mean.Tiarina_fusus;
Tintinnid=Ciliate_week_mean.Tintinnid;
Tontonia_appendiculariformis=Ciliate_week_mean.Tontonia_appendiculariformis;
Tontonia_gracillima=Ciliate_week_mean.Tontonia_gracillima;

Ciliate_week_flipped=[Ciliate_mix';Didinium_sp';Euplotes_sp';Laboea_strobila';Leegaardiella_ovalis';Mesodinium_sp';Pleuronema_sp';Strobilidium_morphotype1';Strobilidium_morphotype2';Strombidium_capitatum';Strombidium_caudatum';Strombidium_conicum';Strombidium_inclinatum';Strombidium_morphotype1';Strombidium_morphotype2';Strombidium_oculatum';Strombidium_wulffi';Tiarina_fusus';Tintinnid';Tontonia_appendiculariformis';Tontonia_gracillima'];
Ciliate_week_mean_mat=Ciliate_week_flipped';
plot(yd_wk,Ciliate_week_mean_mat)
legend((ciliate_label), 'NorthEastOutside');
 datetick('x',4,'keeplimits');
 ylabel('Abundance (cell mL^{-1} \mum{-1})', 'fontsize', 12)
 
 %Make a matrix of percent abundances - note same names as for each year in
 %above code.
 Sum_ciliate_week=sum(Ciliate_week_flipped);
 Sum_week_vector=Sum_ciliate_week';
 Percent_week_mat=Ciliate_week_mean_mat./repmat(Sum_week_vector,1,21); 

 %Make a bar graph of percent abundances
 Sum_ciliate_week=sum(Ciliate_week_flipped);
Sum_week_vector=Sum_ciliate_week';
 Percent_week_mat=Ciliate_week_mean_mat./repmat(Sum_week_vector,1,21);
figure
bar((yd_wk),(Percent_week_mat),'stacked')
legend(ciliate_label)
datetick('x',4,'keeplimits')
ylabel('Proportion')
axis([-10 375 0 1])

%make weekly matrix of temperature 
load Tall_day.mat
[Tall_week_mat, mdate_wkmat, yd_wk] =ydmat2weeklymat(Tday(:,4:11), yearlist);

%make matrix of different seasonal sequence to do individual simpers on
%each pair of seasons (summer, winter, fall, spring)
Seasonal_simper_mat_flipped=[Ciliate_week_mean_mat(27:39,:)' Ciliate_week_mean_mat(1:13,:)' Ciliate_week_mean_mat(40:52,:)' Ciliate_week_mean_mat(27:39,:)'];
Seasonal_simper_mat=Seasonal_simper_mat_flipped';

% Create legend- good legend position
legend1 = legend(axes1,'show');
set(legend1,...
    'Position',[0.800174943530306 0.0480343101642732 0.194618834080718 0.868347338935574]);

%make a matrix of ciliate abundances from all days (401x21)
Ciliate_mix=Ciliate_abundance_Struct.Ciliate_mix;
Didinium_sp=Ciliate_abundance_Struct.Didinium_sp;
Euplotes_sp=Ciliate_abundance_Struct.Euplotes_sp;
Laboea_strobila=Ciliate_abundance_Struct.Laboea_strobila;
Leegaardiella_ovalis=Ciliate_abundance_Struct.Leegaardiella_ovalis;
Mesodinium_sp=Ciliate_abundance_Struct.Mesodinium_sp;
Pleuronema_sp=Ciliate_abundance_Struct.Pleuronema_sp;
Strobilidium_morphotype1=Ciliate_abundance_Struct.Strobilidium_morphotype1;
Strobilidium_morphotype2=Ciliate_abundance_Struct.Strobilidium_morphotype2;
Strombidium_capitatum=Ciliate_abundance_Struct.Strombidium_capitatum;
Strombidium_caudatum=Ciliate_abundance_Struct.Strombidium_caudatum;
Strombidium_conicum=Ciliate_abundance_Struct.Strombidium_conicum;
Strombidium_inclinatum=Ciliate_abundance_Struct.Strombidium_inclinatum;
Strombidium_morphotype1=Ciliate_abundance_Struct.Strombidium_morphotype1;
Strombidium_morphotype2=Ciliate_abundance_Struct.Strombidium_morphotype2;
Strombidium_oculatum=Ciliate_abundance_Struct.Strombidium_oculatum;
Strombidium_wulffi=Ciliate_abundance_Struct.Strombidium_wulffi;
Tiarina_fusus=Ciliate_abundance_Struct.Tiarina_fusus;
Tintinnid=Ciliate_abundance_Struct.Tintinnid;
Tontonia_appendiculariformis=Ciliate_abundance_Struct.Tontonia_appendiculariformis;
Tontonia_gracillima=Ciliate_abundance_Struct.Tontonia_gracillima;

Ciliate_abundance_flipped=[Ciliate_mix';Didinium_sp';Euplotes_sp';Laboea_strobila';Leegaardiella_ovalis';Mesodinium_sp';Pleuronema_sp';Strobilidium_morphotype1';Strobilidium_morphotype2';Strombidium_capitatum';Strombidium_caudatum';Strombidium_conicum';Strombidium_inclinatum';Strombidium_morphotype1';Strombidium_morphotype2';Strombidium_oculatum';Strombidium_wulffi';Tiarina_fusus';Tintinnid';Tontonia_appendiculariformis';Tontonia_gracillima'];
Ciliate_abundance_mat=Ciliate_abundance_flipped';


%Not sure what is going on with ciliate_week_mean_mat but this works
Ciliate_mix=Ciliate_week_mean.Ciliate_mix';
Didinium_sp=Ciliate_week_mean.Didinium_sp';
Euplotes_sp=Ciliate_week_mean.Euplotes_sp';
Laboea_strobila=Ciliate_week_mean.Laboea_strobila';
Leegaardiella_ovalis=Ciliate_week_mean.Leegaardiella_ovalis';
Mesodinium_sp=Ciliate_week_mean.Mesodinium_sp';
Pleuronema_sp=Ciliate_week_mean.Pleuronema_sp';
Strobilidium_morphotype1=Ciliate_week_mean.Strobilidium_morphotype1';
Strobilidium_morphotype2=Ciliate_week_mean.Strobilidium_morphotype2';
Strombidium_capitatum=Ciliate_week_mean.Strombidium_capitatum';
Strombidium_caudatum=Ciliate_week_mean.Strombidium_caudatum';
Strombidium_conicum=Ciliate_week_mean.Strombidium_conicum';
Strombidium_inclinatum=Ciliate_week_mean.Strombidium_inclinatum';
Strombidium_morphotype1=Ciliate_week_mean.Strombidium_morphotype1';
Strombidium_morphotype2=Ciliate_week_mean.Strombidium_morphotype2';
Strombidium_oculatum=Ciliate_week_mean.Strombidium_oculatum';
Strombidium_wulffi=Ciliate_week_mean.Strombidium_wulffi';
Tiarina_fusus=Ciliate_week_mean.Tiarina_fusus';
Tintinnid=Ciliate_week_mean.Tintinnid';
Tontonia_appendiculariformis=Ciliate_week_mean.Tontonia_appendiculariformis';
Tontonia_gracillima=Ciliate_week_mean.Tontonia_gracillima';
Ciliate_week_flipped=[Ciliate_mix';Didinium_sp';Euplotes_sp';Laboea_strobila';Leegaardiella_ovalis';Mesodinium_sp';Pleuronema_sp';Strobilidium_morphotype1';Strobilidium_morphotype2';Strombidium_capitatum';Strombidium_caudatum';Strombidium_conicum';Strombidium_inclinatum';Strombidium_morphotype1';Strombidium_morphotype2';Strombidium_oculatum';Strombidium_wulffi';Tiarina_fusus';Tintinnid';Tontonia_appendiculariformis';Tontonia_gracillima'];
Ciliate_week_mean_mat=Ciliate_week_flipped';


Ciliate_week_flipped_nocm=[Didinium_sp';Euplotes_sp';Laboea_strobila';Leegaardiella_ovalis';Mesodinium_sp';Pleuronema_sp';Strobilidium_morphotype1';Strobilidium_morphotype2';Strombidium_capitatum';Strombidium_caudatum';Strombidium_conicum';Strombidium_inclinatum';Strombidium_morphotype1';Strombidium_morphotype2';Strombidium_oculatum';Strombidium_wulffi';Tiarina_fusus';Tintinnid';Tontonia_appendiculariformis';Tontonia_gracillima'];
Ciliate_week_mean_mat_nocm=Ciliate_week_flipped';
%Make a bar graph excluding Ciliate mix
Ciliate_week_mean_mat_nocm=Ciliate_week_mean_mat(:,2:21)
Percent_week_mat_nocm=Ciliate_week_mean_mat_nocm./repmat(Sum_week_vector_nocm,1,20); 
figure
bar((yd_wk),(Percent_week_mat_nocm),'stacked')
legend(ciliate_label(2:21))
datetick('x',4,'keeplimits')
ylabel('Proportion')
axis([-10 375 0 1])

%Fortnight matrix for LSA:

classes = fields(Ciliate_fortnight_mat); %goes through all elements of structure and makes two new structures (day and week binned matrices)
l = length(Ciliate_fortnight_mat.(classes{1})(:));
Ciliate_fortnight = NaN(length(classes),l);
for classcount=1:length(classes),
  %eval([classes{classcount} '= Ciliate_fortnight_mat.(classes{classcount})(:);'])
  Ciliate_fortnight(classcount,:) = Ciliate_fortnight_mat.(classes{classcount})(:)';
end;

% Ciliate_mix=Ciliate_fortnight_mat.Ciliate_mix(:)';
% Didinium_sp=Ciliate_fortnight_mat.Didinium_sp(:)';
% Euplotes_sp=Ciliate_fortnight_mat.Euplotes_sp(:)';
% Laboea_strobila=Ciliate_fortnight_mat.Laboea_strobila(:)';
% Leegaardiella_ovalis=Ciliate_fortnight_mat.Leegaardiella_ovalis(:)';
% Mesodinium_sp=Ciliate_fortnight_mat.Mesodinium_sp(:)';
% Pleuronema_sp=Ciliate_fortnight_mat.Pleuronema_sp(:)';
% Strobilidium_morphotype1=Ciliate_fortnight_mat.Strobilidium_morphotype1(:)';
% Strobilidium_morphotype2=Ciliate_fortnight_mat.Strobilidium_morphotype2(:)';
% Strombidium_capitatum=Ciliate_fortnight_mat.Strombidium_capitatum(:)';
% Strombidium_caudatum=Ciliate_fortnight_mat.Strombidium_caudatum(:)';
% Strombidium_conicum=Ciliate_fortnight_mat.Strombidium_conicum(:)';
% Strombidium_inclinatum=Ciliate_fortnight_mat.Strombidium_inclinatum(:)';
% Strombidium_morphotype1=Ciliate_fortnight_mat.Strombidium_morphotype1(:)';
% Strombidium_morphotype2=Ciliate_fortnight_mat.Strombidium_morphotype2(:)';
% Strombidium_oculatum=Ciliate_fortnight_mat.Strombidium_oculatum(:)';
% Strombidium_wulffi=Ciliate_fortnight_mat.Strombidium_wulffi(:)';
% Tiarina_fusus=Ciliate_fortnight_mat.Tiarina_fusus(:)';
% Tintinnid=Ciliate_fortnight_mat.Tintinnid(:)';
% Tontonia_appendiculariformis=Ciliate_fortnight_mat.Tontonia_appendiculariformis(:)';
% Tontonia_gracillima=Ciliate_fortnight_mat.Tontonia_gracillima(:)';
% Ciliate_fortnight=[Ciliate_mix;Didinium_sp;Euplotes_sp;Laboea_strobila;Leegaardiella_ovalis;Mesodinium_sp;Pleuronema_sp;Strobilidium_morphotype1;Strobilidium_morphotype2;Strombidium_capitatum;Strombidium_caudatum;Strombidium_conicum;Strombidium_inclinatum;Strombidium_morphotype1;Strombidium_morphotype2;Strombidium_oculatum;Strombidium_wulffi;Tiarina_fusus;Tintinnid;Tontonia_appendiculariformis;Tontonia_gracillima];
% 

%how to make environmental data for LSA (by fortnight/2 week period):
%average of all values within 2 week period.
load \\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\summary\Other_day.mat
Temp_fnyr=ydmat2fortnightmat(Temp,yearlist);
Temp_fn=Temp_fnyr(:);
Saln_fnyr=ydmat2fortnightmat(Saln,yearlist);
Saln_fn=Saln_fnyr(:);
Wspd_fnyr=ydmat2fortnightmat(Wspd,yearlist);
Wspd_fn=Wspd_fnyr(:);
Wdir_fnyr=ydmat2fortnightmat(Wdir,yearlist);
Wdir_fn=Wdir_fnyr(:);
DailySolar_fnyr=ydmat2fortnightmat(DailySolar,yearlist);
DailySolar_fn=DailySolar_fnyr(:);
vE_fnyr=ydmat2fortnightmat(vE,yearlist);
vE_fn=vE_fnyr(:);
vN_fnyr=ydmat2fortnightmat(vN,yearlist);
vN_fn=vN_fnyr(:);
wavep_swell_fnyr=ydmat2fortnightmat(wavep_swell,yearlist);
wavep_swell_fn=wavep_swell_fnyr(:);
wavep_windwave_fnyr=ydmat2fortnightmat(wavep_windwave,yearlist);
wavep_windwave_fn=wavep_windwave_fnyr(:);
waveh_windwave_fnyr=ydmat2fortnightmat(waveh_windwave,yearlist);
waveh_windwave_fn=waveh_windwave_fnyr(:);
waveh_swell_fnyr=ydmat2fortnightmat(waveh_swell,yearlist);
waveh_swell_fn=waveh_swell_fnyr(:);
synperml_fnyr=ydmat2fortnightmat(synperml,yearlist);
synperml_fn=synperml_fnyr(:);
env_mat=[Temp_fn';Saln_fn';Wspd_fn';Wdir_fn';DailySolar_fn';vE_fn';vN_fn';wavep_swell_fn';wavep_windwave_fn';waveh_swell_fn';waveh_windwave_fn';synperml_fn'];
%makes an 11x208 matrix
%labels: Temp, Saln Wspd, Wdir, DailySolar, vE, vN, wavep_swell, wavep_windwave,
%waveh_swell, waveh_windwave, Synperml

%make mats of environmental data:
 [ matdate_mat, vE_mat, yearlist, yd ] = timeseries2ydmat( mdate, vE );
%make graphs of environmental data: 
figure
for year = 1:length(yearlist)
plot(yd, vE_mat(:,year))
hold on
end

%8.12.13 Climatology graph for cool (or warm) season ciliates - first run
%Anna_data_analysis to get abundance structures
cool={'Euplotes_sp' 'Leegaardiella_ovalis' 'Pleuronema_sp' 'Strombidium_morphotype1' 'Strombidium_oculatum' 'Tintinnid' 'Tontonia_gracillima'}
plot(yd_wk,Ciliate_week_mean.Euplotes_sp,'.-',yd_wk,Ciliate_week_mean.Leegaardiella_ovalis,'.-',yd_wk,Ciliate_week_mean.Pleuronema_sp,'.-',yd_wk,Ciliate_week_mean.Strombidium_morphotype1,'.-',yd_wk,Ciliate_week_mean.Strombidium_oculatum,'.-',yd_wk,Ciliate_week_mean.Tintinnid, '.-',yd_wk,Ciliate_week_mean.Tontonia_gracillima, '.-')
 legend(cool)
datetick('x', 3, 'keeplimits');
set(gca,'xgrid','on');
 ylabel('Average Abundance (cell mL^{-1} \mum{-1})', 'fontsize', 12);
ylabel('Average Abundance (cell mL^{-1})', 'fontsize', 12);

warm={'Mesodinium_sp' 'Strombidium_inclinatum' 'S_wulffi' 'Tiarina_fusus'}
 plot(yd_wk,Ciliate_week_mean.Mesodinium_sp,'.-',yd_wk,Ciliate_week_mean.Strombidium_inclinatum,'.-',yd_wk,Ciliate_week_mean.Strombidium_wulffi,'.-',yd_wk,Ciliate_week_mean.Tiarina_fusus,'.-')
legend(warm)
datetick('x', 3, 'keeplimits');
set(gca,'xgrid','on');
 ylabel('Average Abundance (cell mL^{-1} \mum{-1})', 'fontsize', 12);
ylabel('Average Abundance (cell mL^{-1})', 'fontsize', 12);

%stepwise climatologies for final presentation
%warm group:
 figure
plot(yd_wk,Ciliate_week_mean.Strombidium_wulffi,'.-')
 axis([0,375,0,2])
datetick('x', 3, 'keeplimits');
set(gca,'xgrid','on');
 ylabel('Average Abundance (cell mL^{-1} \mum{-1})', 'fontsize', 12);
ylabel('Average Abundance (cell mL^{-1})', 'fontsize', 12);
legend('Strombidium wulffi')

figure
plot(yd_wk,Ciliate_week_mean.Strombidium_wulffi,'.-',yd_wk,Ciliate_week_mean.Strombidium_inclinatum,'.-')
axis([0,375,0,2])
datetick('x', 3, 'keeplimits');
set(gca,'xgrid','on');
 ylabel('Average Abundance (cell mL^{-1} \mum{-1})', 'fontsize', 12);
ylabel('Average Abundance (cell mL^{-1})', 'fontsize', 12);
legend('Strombidium wulffi' 'Strombidium inclinatum')

figure
plot(yd_wk,Ciliate_week_mean.Strombidium_wulffi,'.-',yd_wk,Ciliate_week_mean.Strombidium_inclinatum,'.-',yd_wk,Ciliate_week_mean.Tiarina_fusus,'.-')
axis([0,375,0,2])
datetick('x', 3, 'keeplimits');
set(gca,'xgrid','on');
 ylabel('Average Abundance (cell mL^{-1} \mum{-1})', 'fontsize', 12);
ylabel('Average Abundance (cell mL^{-1})', 'fontsize', 12);
legend('Strombidium wulffi', 'Strombidium inclinatum', 'Tiarina fusus')

figure
plot(yd_wk,Ciliate_week_mean.Strombidium_wulffi,'.-',yd_wk,Ciliate_week_mean.Strombidium_inclinatum,'.-',yd_wk,Ciliate_week_mean.Tiarina_fusus,'.-',yd_wk,Ciliate_week_mean.Mesodinium_sp,'.-')
axis([0,375,0,2])
datetick('x', 3, 'keeplimits');
set(gca,'xgrid','on');
 ylabel('Average Abundance (cell mL^{-1} \mum{-1})', 'fontsize', 12);
ylabel('Average Abundance (cell mL^{-1})', 'fontsize', 12);
legend('Strombidium wulffi', 'Strombidium inclinatum', 'Tiarina fusus', 'Mesodinium')

%cool group:
figure
plot(yd_wk,Ciliate_week_mean.Leegaardiella_ovalis,'.-',yd_wk,Ciliate_week_mean.Strombidium_morphotype1,'.-',yd_wk,Ciliate_week_mean.Strombidium_oculatum,'.-',yd_wk,Ciliate_week_mean.Tintinnid,'.-')
legend('Leegaardiella ovalis', 'Strombidium morphotype 1', 'Strombidium oculatum', 'Tintinnid')
datetick('x', 3, 'keeplimits');
set(gca,'xgrid','on');
 ylabel('Average Abundance (cell mL^{-1} \mum{-1})', 'fontsize', 12);
ylabel('Average Abundance (cell mL^{-1})', 'fontsize', 12);
axis([0,375,0,1.4])
figure
plot(yd_wk,Ciliate_week_mean.Leegaardiella_ovalis,'.-',yd_wk,Ciliate_week_mean.Strombidium_morphotype1,'.-',yd_wk,Ciliate_week_mean.Strombidium_oculatum,'.-',yd_wk,Ciliate_week_mean.Tintinnid,'.-',yd_wk,Ciliate_week_mean.Euplotes_sp,'.-')
datetick('x', 3, 'keeplimits');
set(gca,'xgrid','on');
 ylabel('Average Abundance (cell mL^{-1} \mum{-1})', 'fontsize', 12);
ylabel('Average Abundance (cell mL^{-1})', 'fontsize', 12);
axis([0,375,0,1.4])
legend('Leegaardiella ovalis', 'Strombidium morphotype 1', 'Strombidium oculatum', 'Tintinnid', 'Euplotes_sp')
figure
plot(yd_wk,Ciliate_week_mean.Leegaardiella_ovalis,'.-',yd_wk,Ciliate_week_mean.Strombidium_morphotype1,'.-',yd_wk,Ciliate_week_mean.Strombidium_oculatum,'.-',yd_wk,Ciliate_week_mean.Tintinnid,'.-',yd_wk,Ciliate_week_mean.Euplotes_sp,'.-',yd_wk,Ciliate_week_mean.Pleuronema_sp,'.-',yd_wk,Ciliate_week_mean.Tontonia_gracillima,'.-')
datetick('x', 3, 'keeplimits');
set(gca,'xgrid','on');
 ylabel('Average Abundance (cell mL^{-1} \mum{-1})', 'fontsize', 12);
ylabel('Average Abundance (cell mL^{-1})', 'fontsize', 12);
axis([0,375,0,1.4])
legend('Leegaardiella ovalis', 'Strombidium morphotype 1', 'Strombidium oculatum', 'Tintinnid', 'Euplotes', 'Pleuronema', 'Tontonia gracillima')
figure
plot(yd_wk,Ciliate_week_mean.Tiarina_fusus,'.-',yd_wk,Ciliate_week_mean.Mesodinium_sp,'.-',yd_wk,Ciliate_week_mean.Strombidium_wulffi,'.-',yd_wk,Ciliate_week_mean.Strombidium_inclinatum,'.-')
datetick('x', 3, 'keeplimits');
set(gca,'xgrid','on');
 ylabel('Average Abundance (cell mL^{-1} \mum{-1})', 'fontsize', 12);
ylabel('Average Abundance (cell mL^{-1})', 'fontsize', 12);
axis([0,375,0,1.4])
