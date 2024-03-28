clc ,clear,close all;
load hospital
x= hospital.Weight;
gender=hospital.Sex;

x_female=x(gender=='Female');
x_male=x(gender=='Male');
[pxe_female,xv_female]=ksdensity(x_female,'Kernel','epanechnikov');
[pxe_male,xv_male]=ksdensity(x_male,'Kernel','epanechnikov');
plot(xv_female,pxe_female,'Color','r','LineWidth',2)
hold on
plot(xv_male,pxe_male,'Color','b','LineStyle','--','LineWidth',2)
xlabel('x'),ylabel('p(x)');
legend('Female','Male')
hold off
