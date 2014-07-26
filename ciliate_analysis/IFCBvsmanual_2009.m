

load ciliates_Data_Emily

IFCBciu = poissinv(.975,ciliate_bin);
IFCBcil = poissinv(.025,ciliate_bin);

microscope_count = [39 12 8 0]; %ciliate_mix, tintinnid, myrionecta, laboea
microscope_ml = 59/14;
mciu = poissinv(.975,microscope_count);
mcil = poissinv(.025,microscope_count);

b = [ciliate_bin./ml_analyzed_bin; microscope_count./microscope_ml]';
errdata1 = [b(:,1)'-IFCBcil./ml_analyzed_bin; IFCBciu./ml_analyzed_bin-b(:,1)']';
errdata2 = [b(:,2)'-mcil./microscope_ml; mciu./microscope_ml-b(:,2)']'; 
errdata = [errdata1' errdata2'];
figure
h = bar('v6', b);
set(gca, 'linewidth', 2, 'fontsize', 18,'fontname', 'arial')
set(gca, 'xticklabel', class2use','fontsize', 18, 'fontname', 'arial');
set(gca,'fontsize',18, 'fontname', 'arial')

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
ylabel('Cell concentration (mL^{-1})','fontsize', 18, 'fontname', 'arial');
lh = legend('Imaging FlowCytobot', 'Manual microscopy');
set(lh, 'box', 'off')