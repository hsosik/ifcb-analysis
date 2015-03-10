
function start_manual_classify_VPR(varargin)

%[]=start_manual_classify(FILENUM2START, BATCH_CLASS_INDEX) 
%where inputs are optional
%inputs:
%FILENUM2START is the starting index of the file to process while the 
%BATCH_CLASS_INDEX refers to the index of the species to look at in batch mode

if nargin ==2
    MCconfig=struct('batchmode','yes');
    MCconfig.batch_class_index=varargin{2};
    MCconfig.filenum2start=varargin{1};
elseif nargin ==1  
    MCconfig=struct('batchmode','no');
    MCconfig.filenum2start=varargin{1}; 
elseif nargin ==0
    MCconfig=struct('batchmode', 'no'); %All options are set in get_MCconfig
    MCconfig.filenum2start = 1; %default if not passed in as argument
end

MCconfig = get_MCconfig(MCconfig); %COMMON FOR ALL USERS, add cases for new situations

if isempty(MCconfig.filelist),
    disp('No files found. Check paths or file specification in get_MCconfig.')    
    return
end;

manual_classify_4_0_VPR( MCconfig);



