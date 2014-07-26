function []=xyerrorbar(x,y,errx,erry,s)
if length(x)~=length(y)
    disp('x and y must have the same number of elements')
    return
end
if nargin<5
    s='';
end
hold on
for k=1:length(x)
    l1=line([x(k)-errx(k) x(k)+errx(k)],[y(k) y(k)]);
    set(l1,'color',[0.7 0.05 0.4])
    l2=line([x(k)-errx(k) x(k)-errx(k)],[y(k)-0.1*errx(k) y(k)+0.1*errx(k)]);
    l3=line([x(k)+errx(k) x(k)+errx(k)],[y(k)-0.1*errx(k) y(k)+0.1*errx(k)]);
    l4=line([x(k) x(k)],[y(k)-erry(k) y(k)+erry(k)]);
    set(l4,'color',[0.7 0.05 0.4])
    l5=line([x(k)-0.1*errx(k) x(k)+0.1*errx(k)],[y(k)-erry(k) y(k)-erry(k)]);
    l6=line([x(k)-0.1*errx(k) x(k)+0.1*errx(k)],[y(k)+erry(k) y(k)+erry(k)]);
end
plot(x,y,s)
hold off