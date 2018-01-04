p = '\\sosiknas1\IFCB_products\MVCO\Manual_fromClass\train_fromcsv_Sep2017_new\pngs\';
%pfea = '\\sosiknas1\IFCB_dev\features_v3_test\features\';
pfea_base = '\\sosiknas1\IFCB_products\MVCO\features\featuresXXXX_v2\';
pfeaout = '\\sosiknas1\IFCB_products\MVCO\Manual_fromClass\train_fromcsv_Sep2017_new\features_v2\';

l = dir([p]);
l = {l.name};
class2use = regexprep(l, '_train.mat', '')';
class2use(strmatch('.', class2use)) = []; %get rid of . and ..
start = 31;
stop = 110;
for count = start:stop %1:length(class2use)
    disp(class2use(count))
    temp = dir([p class2use{count} filesep '*.png']);
    temp = {temp.name}';
    temp = regexprep(temp, '.png', '');
    targets{count} = temp;
    ttemp = char(temp); ii = find(ttemp(:,1) == 'D');
    tbin = cellstr(ttemp(:,1:21));
    troinum = cellstr(ttemp(:,23:27)); %roi numbers
    if ~isempty(ii)
        troinum(ii) = cellstr(ttemp(ii,26:30));
        tbin(ii) = cellstr(ttemp(ii,1:24));
    end
    bin{count} = tbin;
    roinum{count} = str2num(char(troinum));
    c(count) = length(temp); %how many in each class
    feacell{count} = NaN(length(temp),236);
end
clear tbin temp troinum ttemp count ii

unqbin = [];
for count = start:stop %1:length(class2use)
    unqbin = [unqbin; unique(bin{count})]; 
end
unqbin = unique(unqbin);

for count = 1:length(unqbin)
    bin_name = unqbin{count};
    if bin_name(1) =='I'
        ystr = bin_name(7:10);
    else
        ystr = bin_name(2:5);
    end
    pfea = regexprep(pfea_base, 'XXXX', ystr);
    filename = [pfea bin_name '_fea_v2.csv'];
%         if ~exist(filename, 'file')
             disp(filename)
%             missing = [missing; unqfiles(c2)];
%         end
         fea = importdata([pfea bin_name '_fea_v2.csv']);
         %exclude summedBiovolume if exists, since some files are missingit
         ii = strmatch('summedBiovolume', fea.textdata );
         if ~isempty(ii)
            fea.textdata(ii) = [];
            fea.data(:,ii) = [];
         end
         for class = start:stop %1:length(class2use)
            ii = strmatch(unqbin(count), bin{class});
            if ~isempty(ii)
                 [~,iit,iia] = intersect(fea.data(:,1), roinum{class}(ii));
                 feacell{class}(ii(iia),:) = fea.data(iit,:);
             end
         end
end
featitles2 = fea.textdata;
    
for count = start:stop %1:length(class2use)
    fea = feacell{count};
    pid = targets{count};
    save([pfeaout class2use{count}], 'fea', 'featitles2', 'pid')
end
