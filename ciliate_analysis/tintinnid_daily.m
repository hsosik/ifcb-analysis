

load '/Volumes/d_work/IFCB1/ifcb_data_mvco_jun06/Manual_fromClass/summary/count_manual_13Feb2015.mat'
laboea_classcount=classcount(:,86);
laboea_ml_analyzed=ml_analyzed_mat(:,86);


figure
plot(matdate(339:400),laboea_classcount(339:400)./laboea_ml_analyzed(339:400));
datetick('x',13)
title('2007-010')


figure
plot(matdate(339:400),laboea_classcount(339:400)./laboea_ml_analyzed(339:400));
datetick('x',13)
title('2007-010')

figure
plot(matdate(464:524),laboea_classcount(464:524)./laboea_ml_analyzed(464:524));
datetick('x',13)
title('2007-027')

figure
plot(matdate(539:599),laboea_classcount(539:599)./laboea_ml_analyzed(539:599));
datetick('x',13)
title('2007-045')

figure
plot(matdate(611:671),laboea_classcount(611:671)./laboea_ml_analyzed(611:671));
datetick('x',13)
title('2007-058')

%%

figure
plot(matdate(686:752),laboea_classcount(686:752)./laboea_ml_analyzed(686:752));
datetick('x',13)
title('2007-072')

figure
plot(matdate(767:829),laboea_classcount(767:829)./laboea_ml_analyzed(767:829));
datetick('x',13)
title('2007-089')

figure
plot(matdate(841:903),laboea_classcount(841:903)./laboea_ml_analyzed(841:903));
datetick('x',13)
title('2007-101')

figure
plot(matdate(918:980),laboea_classcount(918:980)./laboea_ml_analyzed(918:980));
hold on
plot(matdate(918:928),laboea_classcount(918:928)./laboea_ml_analyzed(918:928),'r');
datetick('x',13)
title('2007-114')

figure
plot(matdate(992:1050),laboea_classcount(992:1050)./laboea_ml_analyzed(992:1050));
datetick('x',13)
title('2007-129')

figure
plot(matdate(1068:1129),laboea_classcount(1068:1129)./laboea_ml_analyzed(1068:1129));
datetick('x',13)
title('2007-146')