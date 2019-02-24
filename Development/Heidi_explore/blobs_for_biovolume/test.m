    target.config = configure_test();
    % get the image
    %target.image = cell2mat(targets.image(i));
    %target.image = imread('https://ifcb-data.whoi.edu/mvco/D20190118T185117_IFCB010_01883.png');
    %target.image = imread('https://ifcb-data.whoi.edu/mvco/D20190118T185117_IFCB010_00071.png');
    target.image = imread('https://ifcb-data.whoi.edu/SPIROPA/D20180417T132207_IFCB127_00053.png');
  
    % compute the blob mask (result in target.blob_image)
    target = blob_test(target);

    
file = 'D20180417T132207_IFCB127';
file = 'D20180422T012412_IFCB014';
file = 'D20180418T210919_IFCB014';
    %bin_blobs_heidi_test('C:\work\SPIROPA\IFCB_data\', [file '.roi'], 'C:\work\SPIROPA\IFCB_data\products\');
    %batch_features( {'C:\work\SPIROPA\IFCB_data\'}, {file} , 'C:\work\SPIROPA\IFCB_data\products\', {'C:\work\SPIROPA\IFCB_data\products\'} , 0);    
    '\\sosiknas1\IFCB_data\SPIROPA\data\2018\', '\\sosiknas1\IFCB_products\SPIROPA\blobs_v4\2018\'
    bin_blobs_heidi_test(['\\sosiknas1\IFCB_data\SPIROPA\data\2018\' file(1:9) filesep], [file '.roi'], 'C:\work\SPIROPA\IFCB_data\products\')

    start_blob_batch('\\sosiknas1\IFCB_data\Attune_size_calibration_July2018\data\2018\', '\\sosiknas1\IFCB_products\Attune_size_calibration_July2018\blobs_v4\', true)
    start_feature_batch('\\sosiknas1\IFCB_data\Attune_size_calibration_July2018\data\2018\', '\\sosiknas1\IFCB_products\Attune_size_calibration_July2018\blobs_v4\', '\\sosiknas1\IFCB_products\Attune_size_calibration_July2018\features_v4\', 'true')
    
    start_blob_batch('\\sosiknas1\IFCB_data\SPIROPA\data\2018\', '\\sosiknas1\IFCB_products\SPIROPA\blobs_v4\2018\', true)
    start_feature_batch('\\sosiknas1\IFCB_data\SPIROPA\data\2018\', '\\sosiknas1\IFCB_products\SPIROPA\blobs_v4\2018\', '\\sosiknas1\IFCB_products\SPIROPA\features_v4\', true)
    
    
f = importdata(['\features_std\' file '_fea_v2.csv']);
f2 = importdata(['C:\work\SPIROPA\IFCB_data\products\' file '_fea_v2.csv']);

f = importdata(['\\sosiknas1\IFCB_products\SPIROPA\features\2018\' file '_fea_v2.csv']);
f2 = importdata(['\\sosiknas1\IFCB_products\SPIROPA\features_v4\2018\' file '_fea_v4.csv']);


figure
plot(f.data(:,9), f2.data(:,9), '.'), line(xlim, xlim-7)
figure
histogram(f.data(:,9)-f2.data(:,9), 500)
   
    load \\sosiknas1\Lab_data\Attune\cruise_data\20180414_AR29\Summary\Attune_uw_match
    good = find(Attune_uw_match.QC_flowrate_std<2 & Attune_uw_match.QC_flowrate_median<1.5); whos good
ifcb_mdate = IFCB_file2date(file);
ifcb_ml_analyzed = IFCB_volume_analyzed(['https://ifcb-data.whoi.edu/SPIROPA/' file '.hdr']);

diam_edges = 0:50;
ifcb_countdist = histcounts(f2.data(:,9)/2.5,diam_edges);
ifcb_countdist0 = histcounts(f.data(:,9)/2.5,diam_edges);
   
   [match_diff,n] =  min(abs(ifcb_mdate-datenum(Attune_uw_match.StartDate)));

   
  
%%

diamlist = [];
class = [];
ml_sum = 0;
for ii = -4:4
    %f = regexprep(Attune_uw_match.Filename{matchii(n)}, '25', num2str(25+ii));
    disp(Attune_uw_match.Filename{n+ii})
    t = load(['\\sosiknas1\Lab_data\Attune\cruise_data\20180414_AR29\Summary\class\' regexprep(Attune_uw_match.Filename{n+ii},'fcs', 'mat')]);
    diamlist = [diamlist; (t.volume/4*3/pi).^(1/3)*2];
    class = [class; t.class];
    ml_sum = ml_sum+Attune_uw_match.VolAnalyzed_ml(n+ii);
end

%countdist= histcounts(diamlist(find(t.class)),diam_edges);
countdist= histcounts(diamlist(find(class)),diam_edges);

figure(97), clf
%plot(diam_edges(2:end),countdist./Attune_uw_match.VolAnalyzed_ml(matchii(n)),'*-', 'linewidth', 2)
plot(diam_edges(2:end),countdist./ml_sum,'*-', 'linewidth', 2)
hold on
plot(diam_edges(2:end),ifcb_countdist./ifcb_ml_analyzed, '.-', 'linewidth', 2)
plot(diam_edges(2:end),ifcb_countdist0./ifcb_ml_analyzed, '.:')
ylabel('Cells ml^{-1} \mum^{-1}')
xlabel('Estimated diameter (\mum)')
legend('Attune', 'IFCB')
set(gca, 'yscale', 'log')
xlim([0 50])
title(datestr(Attune_uw_match.StartDate(n)))
