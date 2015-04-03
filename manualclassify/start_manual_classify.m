
function start_manual_classify(varargin)

%[]=start_manual_classify(CONFIGURATION_CASE, FILENUM2START, BATCH_CLASS_INDEX) 
%where inputs 2 and 3 are optional
%inputs:
%CONFIGURATION case (label in get_MCconfig), e.g., 'MVCO'
%FILENUM2START is the starting index of the file to process while the 
%BATCH_CLASS_INDEX refers to the index (or label) of one class to display
%at in batch mode (i.e., other classes will be skipped

if nargin ==3
    %MCconfig=struct('batchmode','yes');
    MCconfig.batch_class_index=varargin{3};
    MCconfig.filenum2start=varargin{2};
elseif nargin ==2  
    %MCconfig=struct('batchmode','no');
    MCconfig.filenum2start=varargin{2}; 
elseif nargin ==1
    %MCconfig=struct('batchmode', 'no'); %All options are set in get_MCconfig
    MCconfig.filenum2start = 1; %default if not passed in as argument
elseif nargin ==0
    disp('You must specify a configuration case, e.g., start_manual_classify(''MVCO'')')
    return
end

MCconfig.group = varargin{1};
MCconfig = get_MCconfig(MCconfig); %COMMON FOR ALL USERS, add cases for new situations

if isfield(MCconfig, 'filelist')
    if isempty(MCconfig.filelist),
        disp('No files found. Check paths or file specification in get_MCconfig.')    
        return
    end
else
    return
end;

manual_classify_4_1( MCconfig);



