

normal_ciliate_bin=[46 164 1 0];
normal_ciliate_ml = 38.97;
[normal_ci] = poisson_count_ci(normal_ciliate_bin, 0.95);
normal_ci_perml=normal_ci./normal_ciliate_ml;
normal_conc=normal_ciliate_bin./normal_ciliate_ml;

alt_ciliate_bin=[14 7 2 0];
alt_ciliate_ml = 36.96;
[alt_ci] = poisson_count_ci(alt_ciliate_bin, 0.95);
alt_ci_perml=alt_ci./alt_ciliate_ml;
alt_conc=alt_ciliate_bin./alt_ciliate_ml;


microscope_ciliate_bin = [20 15 1 0]; %ciliate_mix, tintinnid, myrionecta, laboea
microscope_ml = 36/5.12;
[microscope_ci] = poisson_count_ci(microscope_ciliate_bin, 0.95);
microscope_ci_perml=microscope_ci./microscope_ml;
microscope_conc=microscope_ciliate_bin./microscope_ml;

lower_ci=[normal_conc'-normal_ci_perml(:,1) alt_conc'-alt_ci_perml(:,1) microscope_conc'-microscope_ci_perml(:,1)];
upper_ci=[normal_ci_perml(:,2)-normal_conc' alt_ci_perml(:,2)-alt_conc' microscope_ci_perml(:,2)-microscope_conc'];

b = [normal_conc alt_conc microscope_conc]';
xaxis=[1 2 3 4 5 6 7 8 9 10 11 12];

lower_ci_vec=[lower_ci(:,1); lower_ci(:,2); lower_ci(:,3)];
upper_ci_vec=[upper_ci(:,1); upper_ci(:,2); upper_ci(:,3)];


figure
h = bar( b);
set(gca, 'linewidth', 2, 'fontsize', 12)
hold on
plot(xaxis,b,'b.','markersize', 0.5)
errorbar(xaxis, b, lower_ci_vec, upper_ci_vec, 'r', 'Marker', 'none', 'LineStyle', 'none', 'Linewidth', 1 , 'color' ,[0 0 0]);
%set(gca, 'xticklabel', {'Ciliate_mix', 'Mesodinium', 'tintinnid','Ciliate_mix', 'Mesodinium', 'tintinnid','Ciliate_mix', 'Mesodinium', 'tintinnid'})
set(gca, 'xticklabel', {'C_mix', 'Meso', 'tin',' ','C_mix', 'Meso', 'tin', ' ','Cmix', 'Meso', 'tin',' '})
ylabel('Cell (mL^{-1})')


xdata = get(h,'XData');
sizz = size(b);

%determine the number of bars and groups
NumGroups = sizz(1);
SizeGroups = sizz(2);
NumBars = SizeGroups * NumGroups;

% Use the Indices of Non Zero Y values to get both X values 
% for each bar. xb becomes a 2 by NumBars matrix of the X values.
INZY = [1 3];
xb = [];

for i = 1:SizeGroups
for j = 1:NumGroups
xb = [xb xdata{i}(INZY, j)];
end
end

%find the center X value of each bar.
for i = 1:NumBars
centerX(i) = (xb(1,i) + xb(2,i))/2;
end

% To place the error bars - use the following:
hold on;
%eh = errorbar(centerX,b,errdata); If you are using MATLAB 6.5 (R13)
%eh = errorbar('v6',centerX,b,errdata);
eh = errorbar('v6',centerX,b,errdata(1,:), errdata(2,:));

set(eh(1),'linewidth',2); % This changes the thickness of the errorbars
set(eh(1),'color','k'); % This changes the color of the errorbars
set(eh(2),'linestyle','none'); % This removes the connecting line
ylabel('Cell concentration (mL^{-1})')
lh = legend('Imaging FlowCytobot', 'Manual microscopy');
set(lh, 'box', 'off')