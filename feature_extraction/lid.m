function [ lid ] = lid( pid )

lid = regexprep(pid,'^.*/','');

end

