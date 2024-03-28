clc,clear,close all;
P=[0.4 0.2 0.4];N=500;%先验概率以及样本总数

mu1=1;           mu2=7;           mu3=15;%均值
sigma1=0.5;      sigma2=0.1;     sigma3=2;

%各自的样本数
num1=floor(N*P(1));
num2=floor(N*P(2));
num3=floor(N*P(3));

rng('default');%设置随机数生成模式

%构建正态分布模型，即根据先验概率、均值、标准差生成样本
R1=normrnd(mu1,sqrt(sigma1),1,num1);
R2=normrnd(mu2,sqrt(sigma2),1,num2);
R3=normrnd(mu3,sqrt(sigma3),1,num3);
%计算概率密度
p1=exp(-0.5*(R1-mu1).^2/sigma1)/sqrt(2*pi*sigma1);
p2=exp(-0.5*(R2-mu2).^2/sigma2)/sqrt(2*pi*sigma2);
p3=exp(-0.5*(R3-mu3).^2/sigma3)/sqrt(2*pi*sigma3);

hold on
plot(R1,p1,'bo');
plot(R2,p2,'r.');
plot(R3,p3,'g+');
legend('1','2','3');
box on;

xlabel('x'),ylabel('p(x)'),title('单变量正态分布于');
hold off