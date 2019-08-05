function OLS_1(x,y)
xbar=mean(x);
ybar=mean(y);
Sxy=0;
Sxx=0;
for i=1:numel(x)
    Sxy=Sxy+(x(i)-xbar)(y(i)-ybar);
end 
Sxy=Sxy/N;
for i=1:numel(x)
    Sxx=Sxx+(x(i)-xbar)^2;
end 
Sxx=Sxx/N;
alpha=Sxy/Sxx;
beta=ybar-alpah*xbar;

fprintf('\n\n--------------------------------------------------------\n\n')
fprintf('\n The linear OLS fit is  Y=%sX+%s  \n', alpha, beta)
fprintf('\n--------------------------------------------------------\n\n')

figure
plot(x,y)
xlabel('x')
ylabel('y')
title('y vs x')
