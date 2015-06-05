csvpath = '\\raspberry\d_work\IFCB1\ifcb_data_mvco_jun06\Manual_fromClass\annotations_csv_June2015\';
outpath = '\\sosiknas1\IFCB_products\MVCO\WHOI_Plankton\';

csvlist = dir(csvpath);
csvlist = csvlist(~[csvlist.isdir]);
catlabel = regexprep({csvlist.name}', '.csv', ''); 

for y = 2006:2015
for ii = 1:length(catlabel)
    tdir = [outpath num2str(y) filesep catlabel{ii}];
    if ~exist(tdir, 'dir')
        mkdir(tdir)
    end
end
end

for ii = 1:length(catlabel)
    csvname = fullfile(csvpath, csvlist(ii).name)
    t = importdata(csvname, ',');
    urllist = regexprep(t, [catlabel{ii} ','], '');
    for iii = 1:length(urllist)
        urlnow = [urllist{iii} '.png'];
        [~,file] = fileparts(urlnow);
        yrstr = file(7:10);
        p = [outpath yrstr filesep catlabel{ii} filesep];
        s = 0;
        try 
            urlwrite(urlnow, [p file '.png']);
        catch
            disp(['error, try again'])
            urlwrite(urlnow, [p file '.png']);
        end    
%         while ~s
%             [~,s] = urlwrite(urlnow, [p file '.png']);x
%             if ~isequal(s,1),
%                 disp(['error: ' s 'try again'])
%             end
%         end
    end
end
    