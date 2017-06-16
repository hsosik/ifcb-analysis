matdate = zeros(length(Date),1);
for i = 1:length(Date)
temp = [Date{i}, ' ', Time{i}];
matdate(i) = datenum(temp);
end;
