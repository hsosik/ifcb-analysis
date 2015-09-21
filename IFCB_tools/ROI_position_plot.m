%Emily Peacock
%plot in sequence (akin to animation) xpos vs ypos of IFCB rois @MVCO
%a useful way to check roi position over time in case there is drift

%adjust dirlist to specify days or specific day
dirlist = dir(( '\\demi\vol1\IFCB5_2014_1*'));%adjust to folder(s) of interest
dirlist = {dirlist(:).name}';


for i = 1:length(dirlist);
adc_location = char(strcat('\\demi\vol1\', dirlist(i), '\'));
adclist = dir(strcat(adc_location, '*.adc')); 
adclist = {adclist(:).name}';
    for j = 1:length(adclist);
        adcdata = load(strcat(adc_location,  char(adclist(j))));
        plot(adcdata(:,10), adcdata(:,11), 'r.')
        title(adclist(j));
        pause(.3);
    end
end



%plot(IFCB5_2014_251_002250(:,10), IFCB5_2014_251_002250(:,11), '.')