classpath_generic = '\\queenrose\g_work_ifcb1\ifcb_data_mvco_jun06\classxxxx_v1\';

classfiles = [];
for yr = 2012, %:2012,
    classpath = regexprep(classpath_generic, 'xxxx', num2str(yr));
    temp = dir([classpath 'I*.mat']);
    pathall = repmat(classpath, length(temp),1);
    classfiles = [classfiles; cellstr([pathall char(temp.name)])];
    clear temp pathall classpath
end;
num2dostr = num2str(length(classfiles));

badflag = zeros(size(classfiles));
for filecount = 1:length(classfiles)
    if ~rem(filecount,10), disp(['reading ' num2str(filecount) ' of ' num2dostr]), end;
    try
        load(classfiles{filecount})
    catch
        badflag(filecount) = 1; 
    end;
end;