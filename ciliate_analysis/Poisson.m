
Lysotracker_count = [233.3333333 1562.5 4054.166667 1400 3183.333333 3033.333333 3520.833333 100 300 841.6666667 1875 3404.166667 3008.333333 2862.5];

Lysotracker_ciu = poissinv(.975,Lysotracker_count);
Lysotracker_cil = poissinv(.025,Lysotracker_count);

FDA_count = [175 1625 4262.5 1966.666667 3258.333333 3291.666667 3812.5 145.8333333 370.8333333 791.6666667 1950 3429.166667 3087.5 2883.333333]; %ciliate_mix, tintinnid, myrionecta, laboea

FDA_ciu = poissinv(.975,FDA_count);
FDA_cil = poissinv(.025,FDA_count);

b = [Lysotracker_count; FDA_count]';
errdata1 = [b(:,1)'-Lysotracker_cil; Lysotracker_ciu-b(:,1)']';
errdata2 = [b(:,2)'-FDA_cil; FDA_ciu-b(:,2)']'; 
errdata = [errdata1' errdata2'];
figure
h = bar('v6', b);
set(gca, 'linewidth', 2, 'fontsize', 18)
%set(gca, 'xticklabel', class2use')


Lyso_Er1 = b(:,1)'-Lysotracker_cil;
Lyso_Er2 = Lysotracker_ciu-b(:,1)';

FDA_Er1 = b(:,2)'-FDA_cil;
FDA_Er2 = FDA_ciu-b(:,2)';


figure;
hold('on');
plot( Lysotracker_count, FDA_count, '*' );
errorbar( Lysotracker_count, FDA_count, FDA_Er1, F DA_Er1, 'r', 'Marker', 'none', 'LineStyle', 'none' );
herrorbar(Lysotracker_count,FDA_count,Lyso_Er1,Lyso_Er1, '+b') 

p = polyfit(Lysotracker_count,FDA_count,1);   % p returns 2 coefficients fitting r = a_1 * x + a_2
r = p(1) .* Lysotracker_count + p(2); % compute a new vector r that has matching datapoints in x
hold on
plot(Lysotracker_count,r, 'k-');
xlabel('Lysotracker Count (mL^{-1})')
ylabel('FDA Count (mL^{-1})')







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