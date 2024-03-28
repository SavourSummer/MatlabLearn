clc
clear
x=0:0.01:1;
Y=-(x.^4-4*x.^3+6*x.^2);
Ye=0;

plot([0 1],[0 0],'--',x,Y,'LineWidth',2)
axis([0,1.5,-4,1]),title('Deflection of a cantilever beam')
xlabel('X'),ylabel('Y')
legend('Unloaded cantilever beam','Uniformly loaded beam')