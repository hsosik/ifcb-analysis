function [ s ] = add_field( s, field )

% Adds a field to a structure, if the structure does not have that field
if not(isfield(s, field)),
    s.(field) = struct;
end;

end

