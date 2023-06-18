function [ targets ] = csv2targets ( csv_data )
% Parse the .csv format bin and return a struct representing targets

hlc = textscan(csv_data,'%s',1,'Delimiter','');
header_line = char(hlc{1});
headers = regexp(header_line,',','split');

if length(headers) == 26 % new format
  fmt = '%d %n %n %n %n %n %n %n %n %n %n %n %n %d %d %d %d %d %n %n %n %n %q %q %d %d';
else
  fmt = '%d %n %n %n %n %n %n %n %n %d %d %d %d %d %n %q %q %d %d';
end

[~, pos] = textscan(csv_data,'%s',1,'Delimiter','');
if pos < length(csv_data), %add else case to deal with instances with only headers 
    cols = textscan(csv_data(pos+1:end), fmt, 'Delimiter',',');
else
    cols = cell(1,length(headers));
end;
%%
%this section seems to do nothing? (Heidi)
% wonky format conversion necessary.
%keys = {};
%n = length(headers);
%for count = 1:n
%    keys{end+1} = char(headers{count});
%end

%%
keys = headers; %Heidi: instead of prev section

targets = cell2struct(cols,keys,2);

end

