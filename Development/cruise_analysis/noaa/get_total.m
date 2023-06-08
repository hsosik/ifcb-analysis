temp = dir('\\sosiknas1\IFCB_products\IFCB010_OkeanosExplorerAug2013\class\class2013_v1\*.mat');

list = {temp.name}';
total = 0;
for i = 1:length(temp);
    load(temp(i).name);
    num = length(TBclass);
    total = total + num;
end

total_OEAug2013 = total;

temp = dir('\\sosiknas1\IFCB_products\IFCB102_PiscesNov2014\class\*.mat');

list = {temp.name}';
total = 0;
for i = 16:length(temp);
    load(temp(i).name);
    num = length(TBclass);
    total = total + num;
end

total_piscesNov2014 = total;


temp = dir('\\SOSIKNAS1\IFCB_products\IFCB101_BigelowMay2015\class\class2015_v1\*.mat');

list = {temp.name}';
total = 0;
% for i = ([44:442 444:length(temp)]);
for i = 1:length(temp);
    load(temp(i).name);
    num = length(TBclass);
    total = total + num;
end

total_BigelowMay2015 = total;


temp = dir('\\SOSIKNAS1\IFCB_products\IFCB101_OkeanosExplorerNov2013\class\*.mat');

list = {temp.name}';
total = 0;
for i = 1:length(temp);
    load(temp(i).name);
    num = length(TBclass);
    total = total + num;
end

total_OENov2013 = total;

temp = dir('\\SOSIKNAS1\IFCB_products\IFCB101_GordonGunterOct2015\class\*.mat');

list = {temp.name}';
total = 0;
for i = 1:length(temp);
    load(temp(i).name);
    num = length(TBclass);
    total = total + num;
end

total_GordonGunterOct2015 = total;

temp = dir('\\SOSIKNAS1\IFCB_products\IFCB101_BigelowNov2015\class\class2015_v1\*.mat');

list = {temp.name}';
total = 0;
for i = 1:length(temp);
    load(temp(i).name);
    num = length(TBclass);
    total = total + num;
end

total_BigelowNov2015 = total;