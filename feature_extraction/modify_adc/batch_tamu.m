addpath('/home/hsosik/ifcbcode/webservice_tools/');
addpath('/home/hsosik/ifcbcode/feature_extraction/');
yr = 2007;
%adcmodbase = 'C:\work\IFCB3LisaCampbell\data\adcmod\';
adcmodbase = '/scratch5/ifcb/tamu/adcmod/';
if ~exist(adcmodbase, 'dir'),
    mkdir(adcmodbase)
end;
in_dir = 'http://toast.tamu.edu/ifcb3/'; %USER web services to access data
matlabpool
for day = 345:366,
    filelist = list_day(datestr(datenum(yr,0,day),29), in_dir);
    disp(['processing ' num2str(length(filelist)) ' files'])
    if ~isempty(filelist),
        parfor ii = 1:length(filelist),
            [~,filename] = fileparts(filelist{ii});
            disp(filename)
            adcmodpath = [adcmodbase filename(1:14), filesep];
            adcmodfilename = [adcmodpath filename '.adc.mod'];
            if ~exist(adcmodfilename, 'file'),
                [filestr1,status] = urlwrite([filelist{ii} '.adc'], [adcmodbase filename '.adc']);
                adcdata = importdata(filestr1);
                if ~isempty(adcdata),
                    ind_test1 = find(~diff(adcdata(:,1)) & ~diff(adcdata(:,10)) & ~diff(adcdata(:,11))); %check to see if problem exists
                    ind_test2 = find(~diff(adcdata(:,1)));
                    if ~isempty(ind_test1) & ~(length(ind_test1) < length(ind_test2))
                        [filestr2,status] = urlwrite([filelist{ii} '.roi'], [adcmodbase filename '.roi']);
                        [stitch_info] = create_stitch_info(adcdata, filestr2);
                        if ~exist(adcmodpath, 'dir'),
                            mkdir(adcmodpath)
                        end;
                        disp(['writing ' adcmodfilename])
                        status = write_adcmod (adcdata, stitch_info, adcmodfilename);
                        delete(filestr2)
                    else
                        disp('no mod needed')
                    end;
                end;
                delete(filestr1)
            else
                disp('already done')
            end;
        end;
    end;
end;
matlabpool close