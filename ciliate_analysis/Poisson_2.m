
Lysotracker_conc = [233.3333333 1562.5 4054.166667 1400 3183.333333 3033.333333 3520.833333 100 300 841.6666667 1875 3404.166667 3008.333333 2862.5];
Lysotracker_count = [5.6 37.5 97.3 33.6 76.4 72.8 84.5 2.4 7.2 20.2 45 81.7 72.2 68.7]

[Lysotracker_ci] = poisson_count_ci( Lysotracker_count, 0.95);

% Lysotracker_ciu = poissinv(.975,Lysotracker_count);
% Lysotracker_cil = poissinv(.025,Lysotracker_count);

FDA_conc = [175 1625 4262.5 1966.666667 3258.333333 3291.666667 3812.5 145.8333333 370.8333333 791.6666667 1950 3429.166667 3087.5 2883.333333]; %ciliate_mix, tintinnid, myrionecta, laboea
FDA_count = [4.2 39 102.3 47.2 78.2 79 91.5 3.5 8.9 19 46.8 82.3 74.1 69.2]

[FDA_ci] = poisson_count_ci(FDA_count, 0.95);
FDA_ci=FDA_ci';
% FDA_ciu = poissinv(.975,FDA_count);
% FDA_cil = poissinv(.025,FDA_count);

Lysotracker_ci=Lysotracker_ci';

b = [Lysotracker_conc; FDA_conc];
% errdata1 = [b(:,1)'-Lysotracker_ci(1,:); Lysotracker_ciu-b(2,:)']';
% errdata2 = [b(:,2)'-FDA_cil; FDA_ciu-b(:,2)']'; 
% errdata = [errdata1' errdata2'];
% figure
% h = bar('v6', b);
% set(gca, 'linewidth', 2, 'fontsize', 18)
%set(gca, 'xticklabel', class2use')


Lyso_Er1 = b(1,:)-Lysotracker_ci(1,:);
Lyso_Er2 = b(1,:)+Lysotracker_ci(2,:);

FDA_Er1 = b(2,:)-FDA_ci(1,:);
FDA_Er2 = b(2,:)+FDA_ci(2,:);




figure;
plot( Lysotracker_conc, FDA_conc, 'r*')% 'markersize', 10);
hold on
%errorbar( Lysotracker_conc, FDA_conc, FDA_ci(1,:), FDA_ci(2,:), 'r', 'Marker', 'none', 'LineStyle', 'none' );
%herrorbar(Lysotracker_conc,FDA_conc,Lysotracker_ci(1,:),Lysotracker_ci(2,:), '+r') 
axis square
set(gca,'XTick',[0 1000 2000 3000 4000 5000],'YTick',[0 1000 2000 3000 4000 5000], 'fontsize', 14 )


p = polyfit(Lysotracker_conc,FDA_conc,1);   % p returns 2 coefficients fitting r = a_1 * x + a_2
r = p(1) .* Lysotracker_conc + p(2); % compute a new vector r that has matching datapoints in x
hold on
plot(Lysotracker_conc,r, 'k');
xlabel('Lysotracker count (mL^{-1})', 'fontsize', 14, 'fontname', 'arial')
ylabel('FDA count (mL^{-1})', 'fontsize', 14, 'fontname', 'arial')
refline(1,0);








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
eh = errorbar(centerX,b,errdata(1,:), errdata(2,:));

set(eh(1),'linewidth',2); % This changes the thickness of the errorbars
set(eh(1),'color','k'); % This changes the color of the errorbars
set(eh(2),'linestyle','none'); % This removes the connecting line
ylabel('Cell concentration (mL^{-1})')
lh = legend('LysoTracker Count', 'FDA_count');
set(lh, 'box', 'off')