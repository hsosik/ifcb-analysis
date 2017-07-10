function path = ifcb_find_raw(root_dir, lid)
% Given a directory and a sample bin lid (e.g., IFCB1_2006_001_010101)
% search the directory structure for a raw data file corresponding to
% that sample bin. This assumes that intermediate directories have names
% that correspond to parts of the LID (e.g., 2006). The resulting raw
% data path can be passed to ifcb_open_raw.

    dirwalk(root_dir);
    
    function dirwalk(name) 
        directory = dir(name); 
        for i = 1:length(directory)
            basepath = directory(i).name;
            abspath = [name filesep basepath];
            if(~strcmp(basepath,'.') && ~strcmp(basepath,'..')) 
                if(directory(i).isdir)
                    if strfind(lid, basepath)
                        dirwalk(abspath); 
                    end
                else
                    [~, base, ~] = fileparts(basepath);
                    if strcmp(base,lid)
                        path = abspath;
                        return;
                    end
                end 
            end
        end
    end 

end