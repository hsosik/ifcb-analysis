[log_smoothclimatology_ciliate_all_fraction10_20_weekly, log_std_ciliate_all_fraction10_20_weekly] = smoothed_climatology(log10(ciliate_all_biovol_fraction10_20_week), 1);
[log_smoothclimatology_ciliate_all_fraction20_30_weekly, log_std_ciliate_all_fraction20_30_weekly] = smoothed_climatology(log10(ciliate_all_biovol_fraction20_30_week), 1);
[log_smoothclimatology_ciliate_all_fraction30_40_weekly, log_std_ciliate_all_fraction30_40_weekly] = smoothed_climatology(log10(ciliate_all_biovol_fraction30_40_week), 1);
[log_smoothclimatology_ciliate_all_fraction40_inf_weekly, log_std_ciliate_all_fraction40_inf_weekly] = smoothed_climatology(log10(ciliate_all_biovol_fraction40_inf_week), 1);

C=0.04;
[log_smoothclimatology_ciliate_all_fraction30_40_weekly_C, log_std_ciliate_all_fraction30_40_weekly_C] = smoothed_climatology(log10(ciliate_all_biovol_fraction30_40_week+ C), 1);
[log_smoothclimatology_ciliate_all_fraction40_inf_weekly_C, log_std_ciliate_all_fraction40_inf_weekly_C] = smoothed_climatology(log10(ciliate_all_biovol_fraction40_inf_week + C), 1);

figure  %stacked bar of ciliate size fractions
bar(yd_wk+7, [(10.^log_smoothclimatology_ciliate_all_fraction10_20_weekly)',(10.^log_smoothclimatology_ciliate_all_fraction20_30_weekly)', ((10.^log_smoothclimatology_ciliate_all_fraction30_40_weekly_C)-C)', ((10.^log_smoothclimatology_ciliate_all_fraction40_inf_weekly_C)-C)'], 'stacked')
%title('All Ciliate Fraction - bi-weekly bins')
ylabel('fraction of biovolume', 'fontsize', 14)
datetick ('x', 3)
xlim([0 370]);
legend( '10-20', '20-30', '30-40', '40-180')
set(gca,'fontsize',14)

x= log10(ciliate_all_biovol_fraction10_20_week)

[maxfreq maxvalue]=max(x);

mode = x(maxvalue)