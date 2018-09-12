mdate = [];
T = [];

for ii = 4:6
    eval(['load \\sosiknas1\Lab_data\MVCO\MVCO_Moxanode\code\CTDsmoothhr20' num2str(ii,'%02d')]);
    mdate = [mdate; CTDsmooth(:,1)];
    T = [T; CTDsmooth(:,2)];
end;

%early part of 2007 (from mininode period)
load \\sosiknas1\Lab_data\MVCO\MVCO_Moxanode\code\CTDsmoothhr2007a
mdate = [mdate; CTDsmooth(:,1)];
T = [T; CTDsmooth(:,2)];

%transition to moxanode
for ii = 7:15
    eval(['load \\sosiknas1\Lab_data\MVCO\MVCO_Moxanode\code\CTDsmoothhr20' num2str(ii,'%02d')]);
    mdate = [mdate; CTDsmooth(:,1)];
    T = [T; CTDsmooth(:,2)];
end;

[ mdate_mat, Tday_beam, yearlist, yd ] = timeseries2ydmat( mdate, T );

save \\sosiknas1\Lab_data\MVCO\EnvironmentalData\Tday_beam mdate_mat Tday_beam yearlist yd