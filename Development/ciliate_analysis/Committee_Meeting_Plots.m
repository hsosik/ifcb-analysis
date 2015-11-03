Ciliate_Abundance

close all

Strombidium_oculatum_climatology=smoothed_climatology(Strombidium_oculatum_week, yd_wk);
figure
plot(yd_wk, Strombidium_oculatum_week, '.')
hold on
plot(yd_wk, Strombidium_oculatum_climatology, '-')
title('Strombidium oculatum')
datetick('x', 3, 'keeplimits');
ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
set(gca,'xgrid','on');

Mesodinium_sp_climatology=smoothed_climatology(Mesodinium_sp_week, yd_wk);
figure
plot(yd_wk, Mesodinium_sp_week, '.')
hold on
plot(yd_wk, Mesodinium_sp_climatology, '-')
title('Mesodinium sp')
datetick('x', 3, 'keeplimits');
ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
set(gca,'xgrid','on');

Strombidium_morphotype1_climatology=smoothed_climatology(Strombidium_morphotype1_week, yd_wk);
figure
plot(yd_wk, Strombidium_morphotype1_week, '.')
hold on
plot(yd_wk, Strombidium_morphotype1_climatology, '-')
title('Strombidium morphotype1')
datetick('x', 3, 'keeplimits');
ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
set(gca,'xgrid','on');



Leegaardiella_ovalis_climatology=smoothed_climatology(Leegaardiella_ovalis_week, yd_wk);
figure
plot(yd_wk, Leegaardiella_ovalis_week, '.')
hold on
plot(yd_wk, Leegaardiella_ovalis_climatology, '-')
title('Leegaardiella ovalis')
datetick('x', 3, 'keeplimits');
ylabel('Abundance (cell mL^{-1})', 'fontsize', 12);
set(gca,'xgrid','on');