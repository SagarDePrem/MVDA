
i=2
j=3
plot(H(i,:)/max(H(i,:)))
hold on
plot(P(j,:)/max(P(j,:)))
% plot(H(2,:)/max(P(2,:)))
%plot(H(3,:)/max(P(3,:)))
%legend('Estimated 1st component','Pure compenent of Co','Pure compenent of Cr','Pure compenent of Ni')
legend('Estimated 1st component','Pure compenent of Co')
title('Comparison of 1st estimated pure component with the known pure components (Scaled to 1)')
xlabel('Wavelenght')
ylabel('Pure component absorption')