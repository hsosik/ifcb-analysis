[name, dir] = uigetfile;
file1 = load([dir '/' name], 'features');

[name, dir] = uigetfile;
file2 = load([dir '/' name], 'features');

f1 = file1.features;
f2 = file2.features;

f1(isnan(f1))=0;
f2(isnan(f2))=0;

disp(find(f1-f2));
