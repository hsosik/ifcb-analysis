% % load('\\QUEENROSE\IFCB14_Dock\ditylum\data\D01\31July_D01_14DegC\manual\summary\count_manual_18Aug2014.mat');
% % bar(matdate, classcount(:,11)./ml_analyzed(1));
% 
%%
clear all;
close all;

%load ('\\QUEENROSE\IFCB14_Dock\ditylum\Manual\D20140731T171537_IFCB014.mat');
load ('\\QUEENROSE\IFCB14_Dock\ditylum\Manual\D20140731T173859_IFCB014.mat');

dityWflagInd = find(classlist(:,2)==1 | classlist(:,2) == 2 | classlist(:,2)==3| classlist(:,2) == 8 | classlist(:,2)==11 | classlist(:,2) == 12);%
%sperm_Ind = find(classlist(:,2)==3);

datadir = '\\QUEENROSE\IFCB14_Dock\ditylum\data\D01\31July_D01_14DegC\features\';
filelist = dir([datadir '*.csv']);

minorax=struct;
axes_handle=gca;

for i=1:length(filelist);
a=importdata([datadir filelist(i).name]);
ma=a.data(:,16);
roi=a.data(:,1);
minorax(i).minoraxis=ma;
minorax(i).roi=roi;
end
%

tempmat_minor=minorax(1).minoraxis;
tempmat_roi=minorax(1).roi;

%find(tempmat_roi==dityWflagInd(:,1));
tempA = nan(length(dityWflagInd),1);
for q=1:length(dityWflagInd);
    tempA(q) = find(tempmat_roi == dityWflagInd(q));
end;

% for i=1:length(sperm_Ind);
% sperm_temp(i)=find(tempmat_roi == sperm_Ind(i));
% end

minor_ditywFlag_1=tempmat_minor(tempA);


%---FILE 2

load ('\\QUEENROSE\IFCB14_Dock\ditylum\Manual\D20140731T174332_IFCB014.mat');
dityWflagInd = find(classlist(:,2)==1 | classlist(:,2) == 2 |  classlist(:,2) == 8 | classlist(:,2)==11 | classlist(:,2) == 12);

tempmat_minor=minorax(2).minoraxis;
tempmat_roi=minorax(2).roi; %2nd file

%find(tempmat_roi==dityWflagInd(:,1));

tempA = nan(length(dityWflagInd),1);

for q=1:length(dityWflagInd);
    tempA(q) = find(tempmat_roi == dityWflagInd(q));
end;
minor_ditywFlag_2=tempmat_minor(tempA);

total_minor_dity = [minor_ditywFlag_1 ;minor_ditywFlag_2];
bin=0:1:150;
hist(total_minor_dity, bin);

title('Treatment 2 :  3 Day Incubation', 'FontSize', 14);

set(gca, 'xlim', [0 150])
set(gca, 'xtick', [0:20:150]);
set(axes_handle, 'LineWidth', 2, 'FontSize', 14);

xlabel('Valve diameter (um)', 'FontSize', 14);
ylabel('Number of instances', 'FontSize', 14);
%title('Isolate Population I', 'FontSize', 14);


%%
clear all;

load ('\\QUEENROSE\IFCB14_Dock\ditylum\Manual\D20140714T142045_IFCB014.mat');
dityWflagInd = find(classlist(:,2) == 2 ); %sperm in frustule
%sperm_Ind = find(classlist(:,2)==3);

datadir = '\\QUEENROSE\IFCB14_Dock\ditylum\data\14July_D01Minus5\features\';
filelist = dir([datadir '*.csv']);

minorax=struct;
axes_handle=gca;

for i=1:length(filelist);
a=importdata([datadir filelist(i).name]);
ma=a.data(:,16);
roi=a.data(:,1);
minorax(i).minoraxis=ma;
minorax(i).roi=roi;
end
%

tempmat_minor=minorax(1).minoraxis;
tempmat_roi=minorax(1).roi;

%find(tempmat_roi==dityWflagInd(:,1));
tempA = nan(length(dityWflagInd),1);
for q=1:length(dityWflagInd);
    tempA(q) = find(tempmat_roi == dityWflagInd(q));
end;

% for i=1:length(sperm_Ind);
% sperm_temp(i)=find(tempmat_roi == sperm_Ind(i));
% end

minor_ditywFlag_1=tempmat_minor(tempA);


%---FILE 2

load ('\\QUEENROSE\IFCB14_Dock\ditylum\Manual\D20140714T142454_IFCB014.mat');
%dityWflagInd = find(classlist(:,2)==[1, 2 ,3 ,8 ,11, 12]);
dityWflagInd = find(classlist(:,2) == 2 );

tempmat_minor=minorax(2).minoraxis;
tempmat_roi=minorax(2).roi; %2nd file

%find(tempmat_roi==dityWflagInd(:,1));

tempA = nan(length(dityWflagInd),1);

for q=1:length(dityWflagInd);
    tempA(q) = find(tempmat_roi == dityWflagInd(q));
end;
minor_ditywFlag_2=tempmat_minor(tempA);


%FILE 3

load ('\\QUEENROSE\IFCB14_Dock\ditylum\Manual\D20140714T142907_IFCB014.mat');
%dityWflagInd = find(classlist(:,2)==[1, 2 ,3 ,8 ,11, 12]);
dityWflagInd = find(classlist(:,2) == 2 );

tempmat_minor=minorax(3).minoraxis;
tempmat_roi=minorax(3).roi; %2nd file

%find(tempmat_roi==dityWflagInd(:,1));

tempA = nan(length(dityWflagInd),1);

for q=1:length(dityWflagInd);
    tempA(q) = find(tempmat_roi == dityWflagInd(q));
end;
minor_ditywFlag_3=tempmat_minor(tempA);
% 
% %FILE 4
% 
% load ('\\QUEENROSE\IFCB14_Dock\ditylum\Manual\D20140714T143402_IFCB014.mat');
% %dityWflagInd = find(classlist(:,2)==[1, 2 ,3 ,8 ,11, 12]);
% dityWflagInd = find(classlist(:,2) == 2 );
% 
% tempmat_minor=minorax(4).minoraxis;
% tempmat_roi=minorax(4).roi; %2nd file
% 
% %find(tempmat_roi==dityWflagInd(:,1));
% 
% tempA = nan(length(dityWflagInd),1);
% 
% for q=1:length(dityWflagInd);
%     tempA(q) = find(tempmat_roi == dityWflagInd(q));
% end;
% minor_ditywFlag_4=tempmat_minor(tempA);
% 
%FILE 5

load ('\\QUEENROSE\IFCB14_Dock\ditylum\Manual\D20140714T143815_IFCB014.mat');
%dityWflagInd = find(classlist(:,2)==[1, 2 ,3 ,8 ,11, 12]);
dityWflagInd = find(classlist(:,2) == 2 );

tempmat_minor=minorax(5).minoraxis;
tempmat_roi=minorax(5).roi; %2nd file

%find(tempmat_roi==dityWflagInd(:,1));

tempA = nan(length(dityWflagInd),1);

for q=1:length(dityWflagInd);
    tempA(q) = find(tempmat_roi == dityWflagInd(q));
end;
minor_ditywFlag_5=tempmat_minor(tempA);
% 
%FILE 6

load ('\\QUEENROSE\IFCB14_Dock\ditylum\Manual\D20140714T144228_IFCB014.mat');
%dityWflagInd = find(classlist(:,2)==[1, 2 ,3 ,8 ,11, 12]);
dityWflagInd = find(classlist(:,2) == 2 );

tempmat_minor=minorax(6).minoraxis;
tempmat_roi=minorax(6).roi; %2nd file

%find(tempmat_roi==dityWflagInd(:,1));

tempA = nan(length(dityWflagInd),1);

for q=1:length(dityWflagInd);
    tempA(q) = find(tempmat_roi == dityWflagInd(q));
end;
minor_ditywFlag_6=tempmat_minor(tempA);

% hold on; 
% %FILE 7
% datadir = '\\QUEENROSE\IFCB14_Dock\ditylum\data\15July_D01Minus5\features\';
% 
% load ('\\QUEENROSE\IFCB14_Dock\ditylum\Manual\D20140715T151533_IFCB014.mat');
% %dityWflagInd = find(classlist(:,2)==[1, 2 ,3 ,8 ,11, 12]);
% dityWflagInd = find(classlist(:,2) == 2 );
% 
% tempmat_minor=minorax(7).minoraxis;
% tempmat_roi=minorax(7).roi; %2nd file
% 
% %find(tempmat_roi==dityWflagInd(:,1));
% 
% tempA = nan(length(dityWflagInd),1);
% 
% for q=1:length(dityWflagInd);
%     tempA(q) = find(tempmat_roi == dityWflagInd(q));
% end;
% minor_ditywFlag_7=tempmat_minor(tempA);
% 
% %FILE 8
% load ('\\QUEENROSE\IFCB14_Dock\ditylum\Manual\D20140715T151738_IFCB014.mat');
% %dityWflagInd = find(classlist(:,2)==[1, 2 ,3 ,8 ,11, 12]);
% dityWflagInd = find(classlist(:,2) == 2 );
% 
% tempmat_minor=minorax(8).minoraxis;
% tempmat_roi=minorax(8).roi; %2nd file
% 
% %find(tempmat_roi==dityWflagInd(:,1));
% 
% tempA = nan(length(dityWflagInd),1);
% 
% for q=1:length(dityWflagInd);
%     tempA(q) = find(tempmat_roi == dityWflagInd(q));
% end;
% minor_ditywFlag_8=tempmat_minor(tempA);
% 
% %FILE 9
% load ('\\QUEENROSE\IFCB14_Dock\ditylum\Manual\D20140715T151738_IFCB014.mat');
% %dityWflagInd = find(classlist(:,2)==[1, 2 ,3 ,8 ,11, 12]);
% dityWflagInd = find(classlist(:,2) == 2 );
% 
% tempmat_minor=minorax(9).minoraxis;
% tempmat_roi=minorax(9).roi; %2nd file
% 
% %find(tempmat_roi==dityWflagInd(:,1));
% 
% tempA = nan(length(dityWflagInd),1);
% 
% for q=1:length(dityWflagInd);
%     tempA(q) = find(tempmat_roi == dityWflagInd(q));
% end;
% minor_ditywFlag_9=tempmat_minor(tempA);
% 
% %FILE 10
% load ('\\QUEENROSE\IFCB14_Dock\ditylum\Manual\D20140715T152159_IFCB014.mat');
% %dityWflagInd = find(classlist(:,2)==[1, 2 ,3 ,8 ,11, 12]);
% dityWflagInd = find(classlist(:,2) == 2 );
% 
% tempmat_minor=minorax(10).minoraxis;
% tempmat_roi=minorax(10).roi; %2nd file
% 
% %find(tempmat_roi==dityWflagInd(:,1));
% 
% tempA = nan(length(dityWflagInd),1);
% 
% for q=1:length(dityWflagInd);
%     tempA(q) = find(tempmat_roi == dityWflagInd(q));
% end;
% minor_ditywFlag_10=tempmat_minor(tempA);
% 
% %FILE 11
% load ('\\QUEENROSE\IFCB14_Dock\ditylum\Manual\D20140715T152612_IFCB014.mat');
% %dityWflagInd = find(classlist(:,2)==[1, 2 ,3 ,8 ,11, 12]);
% dityWflagInd = find(classlist(:,2) == 2 );
% 
% tempmat_minor=minorax(11).minoraxis;
% tempmat_roi=minorax(11).roi; %2nd file
% 
% %find(tempmat_roi==dityWflagInd(:,1));
% 
% tempA = nan(length(dityWflagInd),1);
% 
% for q=1:length(dityWflagInd);
%     tempA(q) = find(tempmat_roi == dityWflagInd(q));
% end;
% minor_ditywFlag_11=tempmat_minor(tempA);
% 
% 





total_minor_dity = [minor_ditywFlag_1 ;minor_ditywFlag_2;minor_ditywFlag_3; minor_ditywFlag_5; minor_ditywFlag_6];

%total_minor_dity = [minor_ditywFlag_1 ;minor_ditywFlag_2;minor_ditywFlag_3; minor_ditywFlag_5; minor_ditywFlag_6; minor_ditywFlag_7; minor_ditywFlag_8; minor_ditywFlag_9; minor_ditywFlag_10; minor_ditywFlag_11];
%total_minor_dity = [minor_ditywFlag_1 ;minor_ditywFlag_2; minor_ditywFlag_3; minor_ditywFlag_4; minor_ditywFlag_5; minor_ditywFlag_6];
bin=0:1:150;
hist(total_minor_dity, bin);

title('Valve diameter of \itDitylum \rm containing sperm', 'FontSize', 14);

set(gca, 'xlim', [25 75])
set(gca, 'xtick', [25:5:75]);
set(axes_handle, 'LineWidth', 2, 'FontSize', 12);

xlabel('Valve diameter (um)', 'FontSize', 14);
ylabel('Number of instances', 'FontSize', 14);
%title('Isolate Population I', 'FontSize', 14);


mean_valve_diam = mean(total_minor_dity);

fprintf('%f', mean_valve_diam);
