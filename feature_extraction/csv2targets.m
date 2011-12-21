function [ targets ] = csv2targets ( csv_data )
% Parse the .csv format bin and return a struct representing targets

[headers, pos] = textscan(csv_data,'%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s',1,'Delimiter',',');
cols = textscan(csv_data(pos+1:end), '%d %n %n %n %n %n %n %n %n %d %d %d %d %d %n %q %q %d %d','Delimiter',',');

% wonky format conversion necessary.
keys = {};
n = length(headers);
for count = 1:n
    keys{end+1} = char(headers{count});
end

targets = cell2struct(cols,keys,2);

end

