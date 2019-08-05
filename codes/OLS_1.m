function OLS_1(x,y)
[xsorted,I]=sort(x);
ysorted=y(I);
xbar=mean(x);
ybar=mean(y);
Sxy=0;
Sxx=0;
for i=1:numel(x)
    Sxy=Sxy+(xsorted(i)-xbar)*(ysorted(i)-ybar);
end 
Sxy=Sxy/numel(x);
for i=1:numel(x)
    Sxx=Sxx+(xsorted(i)-xbar)^2;
end 
Sxx=Sxx/numel(x);
alpha=Sxy/Sxx;
beta=ybar-alpha*xbar;

fprintf('\n\n--------------------------------------------------------\n\n')
fprintf('\n The linear OLS fit is  Y=%sX+%s  \n', alpha, beta)
fprintf('\n--------------------------------------------------------\n\n')

 
plot(xsorted,ysorted,'DisplayName','data1','MarkerSize',10,'Marker','x',...
    'LineStyle','none')
 
xlabel('x')
ylabel('y')
title('y vs x')
