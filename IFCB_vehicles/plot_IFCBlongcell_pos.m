%Taylor 21 Nov 2014
%plot long cells to check position in x/y pos to make sure nothing's wrong
%are cells triggering in reasonable xpos? i.e. core good pos?
%how many long cells getting cut off
%can specify roi file, will find all rois length>850. will additionally
%denote which are 'cut off' as found by xpos plus length of roi = 1378
%which is last pix in FOV. 
%could also adjust script to plot all rois that got cutoff, regarless of
%length of image


%{
filename = 'IFCB5_2014_325_170425';
inds = [2714 3124 2773 1464 2283 4615 609 2848]; 
otherinds = [5526 2763]; 
%}

filename = 'IFCB5_2014_325_172714';
inds = [2119 6181 302 1859 5914 7105 794]; 
otherinds = [5571 3362];
%}

filename = 'IFCB5_2014_325_203315';
inds = [5004 655]; 
otherinds = [3951 4961 3448 5073 3537 4662 5659 24];
%}

filename = 'IFCB5_2014_328_005729';
inds = [4590 5384 4205 620 5596 1731 7217 4488 7840 7004 4414 1208 5116 853]; 
otherinds = [4884 5529 2650 3724 2765 6535 2397];
%}
long_imgs_cut = find((tempdata(inds,10) + tempdata(inds,12)) == 1378);
long_imgs_cut2 = find((tempdata(otherinds,10) + tempdata(otherinds,12)) == 1378);

tempdata = load(['\\demi\ifcbnew\' filename(1:14) '\' filename '.adc']);
figure
plot(tempdata(inds,10),tempdata(inds,11),'bx','linewidth',2) %plot pluerosigma manually chosen from dashboard x/ypos from adc file (bottom left corner of roi)
hold on
plot(tempdata(otherinds,10),tempdata(otherinds,11),'rx','linewidth',2) %plot other "long cells" manually chosen from dashboard for comparison
plot(tempdata(inds(long_imgs_cut),10),tempdata(inds(long_imgs_cut),11),'ko','linewidth',2) 
plot(tempdata(otherinds(long_imgs_cut2),10),tempdata(otherinds(long_imgs_cut2),11),'ko','linewidth',2) 
axis([0 1378 0 1034]) %full pixel size FOV
title([filename(1:5) '-' filename(7:10) '-' filename(12:14) '-' filename(16:21) ' pleurosigma, n = ' num2str(length(inds)) ', other "long cells", n = ' num2str(length(long_imgs_cut))])
xlabel('xpos'); ylabel('ypos')
legend('pleurosigma','other "long cells"','cut off')
for count = 1:length(inds)
    plot([tempdata(inds(count),10) (tempdata(inds(count),10) + tempdata(inds(count),12))],[tempdata(inds(count),11) tempdata(inds(count),11)],'b')
end
for count = 1:length(otherinds)
    plot([tempdata(otherinds(count),10) (tempdata(otherinds(count),10) + tempdata(otherinds(count),12))],[tempdata(otherinds(count),11) tempdata(otherinds(count),11)],'r')
end
line([min(tempdata(inds,10)) min(tempdata(inds,10))], [0 1000])
set(gca,'children','color','k','linestyle','--')
line([min(tempdata(inds,10)) min(tempdata(inds,10))], [0 1000])



filename = 'IFCB5_2014_325_211939';
filename = 'IFCB5_2014_325_142131';
%filename = 'IFCB5_2014_325_132928';
filename = 'IFCB5_2014_326_181819';
filename = 'IFCB5_2014_326_175528';
filename = 'IFCB5_2014_328_005729';
filename = 'IFCB5_2014_329_150337';
tempdata = load(['\\demi\ifcbnew\' filename(1:14) '\' filename '.adc']);
inds = find(tempdata(:,12) > 850);
long_imgs_cut = find((tempdata(inds,10) + tempdata(inds,12)) == 1378);

figure
plot(tempdata(inds,10),tempdata(inds,11),'rx','markersize',8) 
hold on
plot(tempdata(inds(long_imgs_cut),10),tempdata(inds(long_imgs_cut),11),'ko') 
axis([0 1378 0 1000])
legend('length > 850pix','end pos edge FOV')
title([filename(1:5) '-' filename(7:10) '-' filename(12:14) '-' filename(16:21) ' long cells, n = ' num2str(length(inds)) ', rois cut off, n = ' num2str(length(long_imgs_cut))])
xlabel('xpos'); ylabel('ypos')
for count = 1:length(inds)
    plot([tempdata(inds(count),10) (tempdata(inds(count),10) + tempdata(inds(count),12))],[tempdata(inds(count),11) tempdata(inds(count),11)],'b')
end


%plot all cells from file that have ending length position of pixel 1378
%which infurs that the picture of the cell is incopmlete/cut off
%filename = 'IFCB5_2014_328_005729';

%define if double trigger when cut off. trigger number longer than 1
tempdata = load(['\\demi\ifcbnew\' filename(1:14) '\' filename '.adc']);
inds     = find((tempdata(:,10) + tempdata(:,12)) == 1378);
figure
plot(tempdata(inds,10),tempdata(inds,11),'rx','markersize',8) 
hold on
axis([0 1378 0 1000])
title([filename(1:5) '-' filename(7:10) '-' filename(12:14) '-' filename(16:21) ' cut off rois, n = ' num2str(length(inds))])
xlabel('xpos'); ylabel('ypos')
for count = 1:length(inds)
    plot([tempdata(inds(count),10) (tempdata(inds(count),10) + tempdata(inds(count),12))],[tempdata(inds(count),11) tempdata(inds(count),11)],'b')
end
