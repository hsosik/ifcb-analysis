function [ targets ] = get_targets( bin_pid )

url = [char(bin_pid) '.csv'];
[content, ~] = urlread(url);
[headers, pos] = textscan(content,'%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s',1,'Delimiter',',');
cols = textscan(content(pos+1:end), '%d %n %n %n %n %n %n %n %n %d %d %d %d %d %n %q %q %d','Delimiter',',');

% wonky format conversion necessary.
keys = {};
n = length(headers);
for count = 1:n
    keys{end+1} = char(headers{count});
end

targets = cell2struct(cols,keys,2);

end

