clc ,clear,close all;
rng("default")
N=1000;mu=0;sigma=1;
x=normrnd(mu,sigma,[N 1]);                  %生成1000个样本


minx=min(x);maxx=max(x);dx=(maxx-minx)/N;
x_values = minx:dx:maxx-dx;                  %确定采样点
px=pdf('Normal',x_values,mu,sigma);
plot(x_values,px,'Color','k','LineWidth',2);
hold on
h=0.01 ;         %定义窗函数
pxe1=kde(x,x_values,h,N);
plot(x_values,pxe1,'r','LineWidth',2);
h=2 ;         %定义窗函数
pxe3=kde(x,x_values,h,N);
plot(x_values,pxe3,'b--','LineWidth',2);
xlabel('x'),ylabel('p(x)');
legend('p(x)','h=0.01','h=2');
hold off

figure,plot(x_values,px,'Color','k','LineWidth',2);
h=0.3 ;         %定义窗函数
pxe2=kde(x,x_values,h,N);
hold on
plot(x_values,pxe2,'g--','LineWidth',2);
xlabel('x'),ylabel('p(x)');
legend('p(x)','h=0.3');
hold off





function pxe=kde(x,x_values,h,N)%利用高斯窗进行估计的窗函数
        pxe=zeros(1,N);
        for j=1:N
            for i=1:N
            pxe(j)=pxe(j)+exp(-0.5*(x_values(j)-x(i))^2/h^2)/sqrt(2*pi);
            end
            pxe(j)=pxe(j)/N/h;
        end
end






