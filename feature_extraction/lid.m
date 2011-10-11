function [ lid ] = lid( pid )
% given a "pid" (e.g., http://ifcb-data.whoi.edu/IFCB1_2011_270_193351),
% return the local ID part (e.g., IFCB1_2011_270_193351)

lid = regexprep(pid,'^.*/','');

end

