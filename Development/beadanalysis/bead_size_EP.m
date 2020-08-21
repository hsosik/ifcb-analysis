clear all;
feature_dir = '\\sosiknas1\IFCB_products\Attune_size_calibration_July2018\features\';
filenames = {'D20180912T180514_IFCB109'
    'D20180912T184408_IFCB109'
    'D20180910T192633_IFCB109'
    'D20180912T182854_IFCB109'
    'D20180912T175556_IFCB109'
    'D20180910T200642_IFCB109'
    'D20180910T193853_IFCB109'
    'D20180912T191958_IFCB109'
    'D20180912T193143_IFCB109'
    'D20180910T184250_IFCB109'
    'D20180910T195042_IFCB109'
    'D20180912T181647_IFCB109'
    'D20180910T191129_IFCB109'
    'D20180912T174517_IFCB109'
    'D20180918T211219_IFCB109'
    'D20180918T205333_IFCB109'
    'D20180918T204251_IFCB109'}; % List of bead files for calibration
    
bead_label = [2.02 3.79 5.11 5.11 5.86 5.86 6 6 9 9 9.72 9.72 19.69 19.69...
    20.31 39.06 46.99]; % List sizes of beads as advertized
dashboard_path = 'https://ifcb-data.whoi.edu/Attune_size_calibration_July2018/';

for k = 1:length(filenames); % Do the whole operation on each file

featurefile= strcat(feature_dir,filenames(k), '_fea_v2.csv');
featurefile= char(featurefile);
featurefile %print out current file. 
features_temp = csvread(featurefile, 1, 0); % load the feature file just to get all of the ROI numbers
roi_nums = features_temp(:,1);
%roi_nums = num2str(roi_nums);

for i = 1:length(roi_nums); % For the list of ROI numbers
    roi_temp = num2str(roi_nums(i));
    if length(roi_temp)==1; %this section is broken up just because I didn't know how to accomodated the ROI numbers
        %being listed without zeros in front of them. I'm sure there is a
        %better way! Then the section also gets the whole string for the
        %png or the outline.
        png = strcat(dashboard_path, filenames(k), '_0000', roi_temp, '.png');
        outline = strcat(dashboard_path, filenames(k), '_0000', roi_temp, '_blob_outline.png');
    elseif length(roi_temp)==2;
        png = strcat(dashboard_path, filenames(k), '_000', roi_temp, '.png');
        outline = strcat(dashboard_path, filenames(k), '_000', roi_temp, '_blob_outline.png');
    elseif length(roi_temp)==3;
        png = strcat(dashboard_path, filenames(k), '_00', roi_temp, '.png');
        outline = strcat(dashboard_path, filenames(k), '_00', roi_temp, '_blob_outline.png');
    elseif length(roi_temp)==4;
        png = strcat(dashboard_path, filenames(k), '_0', roi_temp, '.png');
        outline = strcat(dashboard_path, filenames(k), '_0', roi_temp, '_blob_outline.png');
    end
    
        png = char(png);
        outline = char(outline);
        b = imread(png); %read in the png from the dashboard to use in calculations.
        out = imread(outline);%read in the outline from the dashboard, just in case display is desired. 
        dark_x = sum(b,1); % sum the valuies from the png to find the bead. A plot of this in google doc. 
        for j = 1:(length(dark_x)-1); temp(j) = dark_x(j+1)-dark_x(j); end
        change = abs(temp); %find the value of how much the sum changed from one column to the next. 
        [p, loc]= findpeaks(change, 'MinPeakHeight', 50); %Find peaks in the change
        peak_loc = [p' loc'];
        peaks_sorted = sortrows(peak_loc,-1); %Sort the peaks
        edges = [peaks_sorted(1,2) peaks_sorted(2,2)]; %define the two biggest peaks as the edges. 
        
       % clf
        imshow(out)
        line([edges(1),edges(1)], [150, -150], 'LineWidth', 2, 'LineStyle', '-.')
        line([edges(end),edges(end)], [150, -150], 'LineWidth', 2, 'LineStyle', '-.')
        size(i) = edges(1)-edges(2);
        size_ave(k) = mean(abs(size));
        clear temp dark_x;
end
  
   beads(k).size = size;
   clear size  
end



for i = 1:17;
    bead_mode(i) = mode(abs(beads(i).size));
end


figure
plot(bead_label, bead_mode, 'x', 'MarkerSize', 10)
xlabel('bead size as advertized (um)')
ylabel('measured pixel size')

figure
for i = 1:length(beads)
    t = beads(i).size;
    subplot(4,5,i); 
    histogram(abs(t), 'BinWidth', 5, 'BinLimits',[0,150])
    line([bead_mode(i),bead_mode(i)], [0, 1500], 'LineWidth', 2, 'LineStyle', '-.')
end

lm = fitlm(bead_label, bead_mode);

figure
for i = 1:length(beads)
    t = ((beads(i).size)./2.7243)-0.4905;
    subplot(4,5,i); 
    histogram(abs(t), 'BinWidth', 1, 'BinLimits',[0,50],  'Normalization', 'probability')
    line([bead_label(i),bead_label(i)], [0, 1], 'LineWidth', 1.5, 'LineStyle', '-', 'Color', 'r')
    legend(num2str(bead_label(i)))
end
