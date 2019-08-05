clear 
clc
width=linspace(3,15,100)';
for k=1:10
for i=1:size(width)
    err(i,k)=kpcr(width(i),k);
end
end
% plot(err)
% xlabel('width')
% ylabel('Error')
% title('Plot to obtain optimal width')