p = '\\sosiknas1\IFCB_products\MVCO\Manual_fromClass\annotations_csv_Aug2017\';
%p = '\\sosiknas1\IFCB_products\MVCO\Manual_fromClass\train_fromcsv_Sep2017\test_validation_split\';
pfea3 = '\\sosiknas1\IFCB_dev\features_v3_test\features\';
pfea2 = '\\sosiknas1\IFCB_products\MVCO\features\';
pout2 = '\\sosiknas1\IFCB_products\MVCO\Manual_fromClass\annotations_csv_Aug2017\features_v2\';
pout3 = '\\sosiknas1\IFCB_products\MVCO\Manual_fromClass\annotations_csv_Aug2017\features_v3\';


l = dir([p '*.csv']);
l = {l.name};
%features2006_v2
missing = [];
for count = 1:length(l)
    [roinum,bin] = xlsread([p l{count}]);
    pid = cellstr([char(bin) num2str(roinum,'_%05.0f')]);
    [~, featitles] = roi_features(pid{1}); %assume all have same fea_titles
    [fea2use] = setdiff(featitles, {'summedBiovolume'}');
    featitles2 = fea2use';
    
    bin = regexprep(bin, 'http://ifcb-data.whoi.edu/mvco/', '');
    unqfiles = unique(bin);
    year = datevec(IFCB_file2date(unqfiles)); year = num2str(year(:,1));
   % fea2 = nan(length(bin),236);
    fea3 = nan(length(bin),241);
    for c2 = 1:length(unqfiles)
        if exist([pfea3 unqfiles{c2} '_fea_v3.csv'], 'file')
            fea = importdata([pfea3 unqfiles{c2} '_fea_v3.csv']);
            ii = strmatch(unqfiles(c2), bin);
            if ~isempty(ii)
                [~,iit] = intersect(fea.data(:,1), roinum(ii));
                fea3(ii,:) = fea.data(iit,:);
            end
         %   fea = importdata([pfea2 'features' year(c2,:) '_v2' filesep unqfiles{c2} '_fea_v2.csv']);
         %   ii = strmatch(unqfiles(c2), bin);
         %   if ~isempty(ii)
         %       [~,iit] = intersect(fea.data(:,1), roinum(ii));
         %       fea2(ii,:) = fea.data(iit,:);
         %   end
        else
            missing = [missing unqfiles(c2)];
        end
    end
    featitles3 = fea.textdata;   
    fea2 = get_features_roilist_webservices( pid, fea2use );
    f = regexprep(l{count},'.csv', '');
    fea = fea2;
    save([pout2 f], 'fea', 'featitles2', 'pid')
    fea = fea3;
    save([pout3 f], 'fea', 'featitles3', 'pid')
    
end

