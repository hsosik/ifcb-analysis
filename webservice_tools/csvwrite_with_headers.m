function [ ] = csvwrite_with_headers( filename, m, headers )
% filename = output file name
% m = some matrix
% headers = cell array of header names, same width as matrix

header_string = headers{1};
for i = 2:length(headers)
    header_string = [header_string,',',headers{i}];
end

% write headers
fid = fopen(filename,'w');
fprintf(fid,'%s\r\n',header_string);
fclose(fid);

% append CSV representation of matrix
dlmwrite(filename, m,'-append','delimiter',',', 'precision', 10);
end

