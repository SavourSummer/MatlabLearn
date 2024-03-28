clc ,clear,close all;
rng("default")

N=[1 64 256 10000];%生成4种样本，且服从正态分布
mu=0;sigma=1;
x_values =-4:0.01:4;%确定采样点
h=1./(N.^0.5);      %设置带宽随样本数争夺而逐渐下降，带宽为h=1/根号5
R=zeros(length(N),N(4));

for m=1:length(N)
    R(m,1:N(m))=normrnd(mu,sigma,1,N(m)); %生成样本矩阵，每一行对应一种样本数
end
px=pdf('Normal',x_values,mu,sigma); %真实的概率密度函数

len=length(x_values);
for m=1:length(N) %针对不同样本，分别估计概率密度函数
    pxe=zeros(1,len);
    for i=1:len
        for j=1:N(m)
            if abs(x_values(i)-R(m,j))<=sqrt(5)*h(m)
                pxe(i)=pxe(i)+(1-((x_values(i)-R(m,j))/h(m))^2/5)*3/4/sqrt(5)/h(m);
            end%采用Epanechnikov核函数进行估计
        end
        pxe(i)=pxe(i)/N(m);
    end
    subplot(1,4,m),plot(x_values,px,'k');
    hold on
    plot(x_values,pxe,'r--','LineWidth',2),axis([-3 3 0.001 1.0]);
    str=strcat('N=',num2str(N(m)));
    legend('p(x)',str);
    hold off
end






