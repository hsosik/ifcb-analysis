function [ s3 ] = merge_structs( s1, s2 )
% combine two structs, if s2 shares any fields with s1, s2's values for
% those fields override s1's values

s3 = s1;

fields = fieldnames(s2);
for i = 1:length(fields),
    field = char(fields(i));
    s3.(field) = s2.(field);
end

end

