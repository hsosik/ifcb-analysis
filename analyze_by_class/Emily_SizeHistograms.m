classes = fields(ml_analyzed_struct);

diambins = 0:2:150;

for classcount = 1:length(classes),
    test=eqdiam.(classes{classcount});
    t=cellfun('isempty', test);
    ind=find(t==0);
    data_hist=[];
        for j=1:length(ind)
            temp=test{ind(j)};
            data_hist=[data_hist; temp];
        end; 
     figure
     hist(data_hist,diambins)
     
end;



test=eqdiam.Ciliate_mix;
t=cellfun('isempty',test);
ind=find(t==0);
data_hist=[];

for j=1:length(ind)
    temp=test{ind(j)};
    data_hist=[data_hist; temp];
end

figure
hist(data_hist,diambins)
title('Ciliate Mix')

test=eqdiam.Strombidium_morphotype1;
t=cellfun('isempty',test);
ind=find(t==0);

data_hist=[];
for j=1:length(ind)
    temp=test{ind(j)};
    data_hist=[data_hist; temp];
end

figure
hist(data_hist,diambins)
title('Strombidium morphotype 1')

test=eqdiam.Didinium_sp;
t=cellfun('isempty',test);
ind=find(t==0);

data_hist=[];
for j=1:length(ind)
    temp=test{ind(j)};
    data_hist=[data_hist; temp];
end

figure
hist(data_hist,diambins)
title('Didinium sp')

test=eqdiam.Euplotes_sp;
t=cellfun('isempty',test);
ind=find(t==0);

data_hist=[];
for j=1:length(ind)
    temp=test{ind(j)};
    data_hist=[data_hist; temp];
end

figure
hist(data_hist,diambins)
title('Euplotes')

test=eqdiam.Laboea_strobila;
t=cellfun('isempty',test);
ind=find(t==0);

data_hist=[];
for j=1:length(ind)
    temp=test{ind(j)};
    data_hist=[data_hist; temp];
end

figure
hist(data_hist,diambins)
title('Laboea strobila')

test=eqdiam.Leegaardiella_ovalis;
t=cellfun('isempty',test);
ind=find(t==0);

data_hist=[];
for j=1:length(ind)
    temp=test{ind(j)};
    data_hist=[data_hist; temp];
end

figure
hist(data_hist,diambins)
title('Leegaardiella ovalis')

test=eqdiam.Mesodinium_sp;
t=cellfun('isempty',test);
ind=find(t==0);

data_hist=[];
for j=1:length(ind)
    temp=test{ind(j)};
    data_hist=[data_hist; temp];
end

figure
hist(data_hist,diambins)
title('Mesodinium sp')

test=eqdiam.Pleuronema_sp;
t=cellfun('isempty',test);
ind=find(t==0);

data_hist=[];
for j=1:length(ind)
    temp=test{ind(j)};
    data_hist=[data_hist; temp];
end

figure
hist(data_hist,diambins)
title('Pleuronema sp')

test=eqdiam.Strobilidium_morphotype1;
t=cellfun('isempty',test);
ind=find(t==0);

data_hist=[];
for j=1:length(ind)
    temp=test{ind(j)};
    data_hist=[data_hist; temp];
end

figure
hist(data_hist,diambins)
title('Strobilidium morphotype1')

test=eqdiam.Strobilidium_morphotype2;
t=cellfun('isempty',test);
ind=find(t==0);

data_hist=[];
for j=1:length(ind)
    temp=test{ind(j)};
    data_hist=[data_hist; temp];
end

figure
hist(data_hist,diambins)
title('Strobilidium morphotype2')

test=eqdiam.Strombidium_capitatum;
t=cellfun('isempty',test);
ind=find(t==0);

data_hist=[];
for j=1:length(ind)
    temp=test{ind(j)};
    data_hist=[data_hist; temp];
end

figure
hist(data_hist,diambins)
title('Strombidium capitatum')

test=eqdiam.Strombidium_caudatum;
t=cellfun('isempty',test);
ind=find(t==0);

data_hist=[];
for j=1:length(ind)
    temp=test{ind(j)};
    data_hist=[data_hist; temp];
end

figure
hist(data_hist,diambins)
title('Strombidium caudatum')

test=eqdiam.Strombidium_conicum;
t=cellfun('isempty',test);
ind=find(t==0);

data_hist=[];
for j=1:length(ind)
    temp=test{ind(j)};
    data_hist=[data_hist; temp];
end

figure
hist(data_hist,diambins)
title('Strombidium conicum')

test=eqdiam.Strombidium_inclinatum;
t=cellfun('isempty',test);
ind=find(t==0);

data_hist=[];
for j=1:length(ind)
    temp=test{ind(j)};
    data_hist=[data_hist; temp];
end

figure
hist(data_hist,diambins)
title('Strombidium inclinatum')

test=eqdiam.Strombidium_morphotype2;
t=cellfun('isempty',test);
ind=find(t==0);

data_hist=[];
for j=1:length(ind)
    temp=test{ind(j)};
    data_hist=[data_hist; temp];
end

figure
hist(data_hist,diambins)
title('Strombidium morphotype2')

test=eqdiam.Strombidium_oculatum;
t=cellfun('isempty',test);
ind=find(t==0);

data_hist=[];
for j=1:length(ind)
    temp=test{ind(j)};
    data_hist=[data_hist; temp];
end

figure
hist(data_hist,diambins)
title('Strombidium oculatum')

test=eqdiam.Strombidium_wulffi;
t=cellfun('isempty',test);
ind=find(t==0);

data_hist=[];
for j=1:length(ind)
    temp=test{ind(j)};
    data_hist=[data_hist; temp];
end

figure
hist(data_hist,diambins)
title('Strombidium wulffi')

test=eqdiam.Tiarina_fusus;
t=cellfun('isempty',test);
ind=find(t==0);

data_hist=[];
for j=1:length(ind)
    temp=test{ind(j)};
    data_hist=[data_hist; temp];
end

figure
hist(data_hist,diambins)
title('Tiarina fusus')

test=eqdiam.Tintinnid;
t=cellfun('isempty',test);
ind=find(t==0);

data_hist=[];
for j=1:length(ind)
    temp=test{ind(j)};
    data_hist=[data_hist; temp];
end

figure
hist(data_hist,diambins)
title('Tintinnid')

test=eqdiam.Tontonia_appendiculariformis;
t=cellfun('isempty',test);
ind=find(t==0);

data_hist=[];
for j=1:length(ind)
    temp=test{ind(j)};
    data_hist=[data_hist; temp];
end

figure
hist(data_hist,diambins)
title('Tontonia appendiculariformis')

test=eqdiam.Tontonia_gracillima;
t=cellfun('isempty',test);
ind=find(t==0);

data_hist=[];
for j=1:length(ind)
    temp=test{ind(j)};
    data_hist=[data_hist; temp];
end

figure
hist(data_hist,diambins)
title('Tontonia gracillima')
