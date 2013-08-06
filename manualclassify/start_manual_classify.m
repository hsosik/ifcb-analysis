
function start_manual_classify(varargin)

%[]=start_manual_classify(BATCH_CLASS_INDEX,FILENUM2START) 
%where all inputs are optional
%inputs BATCHMODE can be wether 'yes' or 'no' and refers to wether or not we want to run through the classified images per class
%BATCH_CLASS_INDEX refers to the index of the species to look at in batch mode
%FILENUM2START is the starting index of the file to process while the 


if nargin ==2
    MCconfig.batch_class_index=varargin{1};
    MCconfig.filenum2start=varargin{2};
    MCconfig=struct('batchmode','yes');
elseif nargin ==1  
    MCconfig=struct('batchmode','yes');
    MCconfig.batch_class_index=varargin{1};
    MCconfig.filenum2start=1; %assumes the user wants to start at the first file
elseif nargin ==0
    MCconfig=struct([]); %All options are set in get_MCconfig
end


%MVCO sets
%MCconfig = get_MCconfigMVCO;
%[MCconfig, filelist, classfiles, stitchfiles] = get_MCfilelistMVCO(MCconfig);

%Other sets
MCconfig = get_MCconfig(MCconfig);

[MCconfig, filelist, classfiles] = get_MCfilelist(MCconfig);
stitchfiles = [];

if isempty(filelist),
    disp('No files found. Check paths or file specification in get_MCconfig.')
    
    return
end;

manual_classify_4_0( MCconfig, filelist, classfiles, stitchfiles );



