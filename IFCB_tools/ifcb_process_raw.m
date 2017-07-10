function ifcb_process_raw(root_dir, callback)
% find all ADC files in the root dir or any subdirectory
% and call the callback for each one, passing it the absolute
% path to that ADC file

    dirwalk(root_dir);
    
    function dirwalk(name) 
        directory = dir(name); 
        for i = 1:length(directory)
            basepath = directory(i).name;
            abspath = [name filesep basepath];
            if(~strcmp(basepath,'.') && ~strcmp(basepath,'..')) 
                if(directory(i).isdir)
                    dirwalk(abspath);
                else
                    [~, ~, ext] = fileparts(basepath);
                    if strcmp(ext,'.adc')
                        callback(abspath);
                    end
                end 
            end
        end
    end
end