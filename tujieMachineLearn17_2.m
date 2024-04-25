%Fisher判别分析

clc,clear,close all
n=100;
x=randn(n,2);
x(1:n/2,1)=x(1:n/2,1)-4;
x(n/2+1:end,1)=x(n/2+1:end,1)+4;
%x(1:n/4,1)=x(1:n/4,1)-4;x(n/4+1:end,1)=x(n/4+1:end,1)+4;
x=x-repmat(mean(x),[n,1]);
y=[ones(n/2,1);2*ones(n/2,1)];% 创建一个分类向量，前一半为1，后一半为2

m1=mean(x(y==1,:));% 计算分类1的样本均值
x1=x(y==1,:)-repmat(m1,[n/2,1]);% 中心化分类1的样本
m2=mean(x(y==2,:));x2=x(y==2,:)-repmat(m2,[n/2,1]);

[t,v]=eigs(n/2 * m1' *m1+n/2*m2'*m2,x1'*x1+x2'*x2,1);% % 计算最大特征值对应的特征向量
figure(1);clf;hold on;axis([-8 8 -6 6]);
plot(x(y==1,1),x(y==1,2),'bo');
plot(x(y==2,1),x(y==2,2),'rx');
plot(100*[-t(1) t(1)],100*[-t(2) t(2)],'k-');% 绘制特征向量表示的直线
