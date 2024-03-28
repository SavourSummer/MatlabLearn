clc,clear,close all;
P=[0.6 0.3 0.1];N=500;n=2;%先验概率以及样本总数

mu1=[1 1];           mu2=[7 7];           mu3=[15 1];%均值
sigma1=[12 0;0 1];      sigma2=[8 3;3 2];     sigma3=[2 0;0 2];

%各自的样本数
num1=floor(N*P(1));
num2=floor(N*P(2));
num3=floor(N*P(3));

rng('default');%设置随机数生成模式

%构建正态分布模型，即根据先验概率、均值、标准差生成样本
R1=mvnrnd(mu1,sqrt(sigma1),num1);
R2=mvnrnd(mu2,sqrt(sigma2),num2);
R3=mvnrnd(mu3,sqrt(sigma3),num3);

hold on
plot(R1(:,1),R1(:,2),'b*');
plot(R2(:,1),R2(:,2),'r.');
plot(R3(:,1),R3(:,2),'g+');
legend('1','2','3');
box on ;
hold off
x=linspace(-4,4,30);[x1,x2]=meshgrid(x,x);
X=[x1(:),x2(:)];
mu=[0,0];sigma=[1 0;0 1];
p=mvnpdf(X,mu,sigma);
figure,surf(x,x,reshape(p,size(x1)));
xlabel('x'),ylabel('x2'),zlabel('p(X)'),title('二维正态分布概率密度函数');
