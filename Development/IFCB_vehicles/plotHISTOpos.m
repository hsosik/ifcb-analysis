%edits T Crockford Dec2014
%org code written M Brosnahan Nov2014 - redmine IFCB_forVehicles Task#3259
%tool to compare horz vs vert ifcb
%make histogram plot over time of x/ypos to see if core moves around
%sort of like heat map, includes missed rois at bottom (pos zero)
%assumes only using "new" IFCB adc file format. Both adc formats are listed

clear all

%%%%%%%%%%%%%%%%%%%%%%%%
%make_pathfile2load.m - prompts question of what you'd like to plot 
%set path to data, start & end file, name for saved mat file
%%%%%%%%%%%%%%%%%%%%%%%%
make_pathfiles2load

%get files between start/end from specified dir
startday  = str2num([startfile(2:9) startfile(11:16)]);
endday    = str2num([endfile(2:9) endfile(11:16)]);
allfiles  = dir([dirpath 'D2014*.adc']);%get all files from set dir
allfiles  = {allfiles.name}';
temp      = char(allfiles);
temp      = [temp(:,2:9) temp(:,11:16)];
%make matdate for each adc file
matdate   = datenum(temp(:,:),'yyyymmddHHMMSS'); %get matdate from filenames
temp      = str2num(temp);
%only use files of interest - start/end day set above
ind       = find(temp>=startday & temp<=endday);
files     = allfiles(ind); 
matdate   = matdate(ind);
clear temp ind allfiles startfile endfile


% initialize vars
xpos=[]; ypos=[]; roisizeX = []; roisizeY = []; mattime=[];
%compile adcdata xpos, ypox, date
for count=1:length(files),
    adcdata = load([dirpath char(files(count))]);
    if size(adcdata,1)>1,
    xpos    = [xpos; adcdata(:,14)]; 
    ypos    = [ypos; adcdata(:,15)];
    roisizeX = [roisizeX; adcdata(:,16)];
    roisizeY = [roisizeY; adcdata(:,17)];
    mattime  = [mattime; matdate(count)*ones(size(adcdata,1),1)];
    end
end

% get times of non-empty adc files
unq_matdate = unique(mattime);

% initialize var for histc POS counts
hypos = NaN(length(unq_matdate),length(0:8:1023)); 
hxpos = NaN(length(unq_matdate),length(0:8:1380)); 
for count=1:length(unq_matdate)
    hi              = find(mattime==unq_matdate(count)); 
    hypos(count,:)  = histc(ypos(hi),[0:8:1023]);
    hxpos(count,:)  = histc(xpos(hi),[0:8:1380]);
end

% hypos = NaN(length(unq_matdate),length(0:8:200)); 
% hxpos = NaN(length(unq_matdate),length(0:8:1380)); 
% for count=1:length(unq_matdate)
%     hi              = find(mattime==unq_matdate(count)); 
%     hypos(count,:)  = histc(ypos(hi),[0:8:1023]);
%     hxpos(count,:)  = histc(xpos(hi),[0:8:1380]);
% end



%plot histo with time on x-axis
figure('position',[204 147 1293 905]) 
subplot(2,1,1);
pcolor(unq_matdate,[0:8:1023],hypos');
shading flat
caxis([0 prctile(hypos(:),95)]) %set colorbar range - without max concentrations get washed out
datetick('x','mm/dd HH:MM','keepticks')
xlabel('Time','fontweight','bold');ylabel('ypos','fontweight','bold');title(['YPOS - ' savefilename ' color max 95%'])
colorbar

%plot histo with time on x-axis
% figure; 
subplot(2,1,2)
pcolor(unq_matdate,[0:8:1380],hxpos');
shading flat
caxis([0 prctile(hxpos(:),95)]) %set colorbar range - without max concentrations get washed out
datetick('x','mm/dd HH:MM','keepticks')
xlabel('Time','fontweight','bold');ylabel('xpos','fontweight','bold');title(['XPOS - ' savefilename ' color max 95%'])
colorbar

%not done.
% % initialize var for histc area and size counts
% harea = NaN(length(unq_matdate),length(0:8:1023)); 
% % hyarea = NaN(length(unq_matdate),length(0:8:1023)); 
% % hxarea = NaN(length(unq_matdate),length(0:8:1380)); 
% for count=1:length(unq_matdate)
%     hi              = find(mattime==unq_matdate(count)); 
%     harea(count,:)  = histc(roisizeY(hi),[0:8:1023]);
% %     hyarea(count,:)  = histc(roisizeY(hi),[0:8:1023]);
% %     hxarea(count,:)  = histc(roisizeX(hi),[0:8:1380]);
% end
% 
% %plot histo with time on x-axis
% figure; pcolor(unq_matdate,[0:8:1380],hxarea');
% caxis([0 prctile(hxarea(:),95)]) %set colorbar range - without max concentrations get washed out
% datetick('x','mm/dd HH:MM','keepticks')
% xlabel('Time','fontweight','bold');ylabel('xpos','fontweight','bold');title(['XPOS - ' savefilename ' color max 95%'])
% colorbar
% 

