%局部保持投影
clc,clear,close all;
n=100;
x=[2*randn(n,1) randn(n,1)];
X = [2*rand(n,1) 2*round(rand(n,1))-1+randn(n,1)/3];
x=x-repmat(mean(x),[n,1]);%数据中心化处理
x2=sum(x.^2,2);
W=exp(-(repmat(x2,1,n)+repmat(x2',n,1)-2*x*x'));%用高斯核构造识别函数W
D=diag(sum(W,2));
L=D-W;
z=x'*D*x;
z=(z+z')/2
[t,v]=eigs(x'*X,1);%求正交投影矩阵T

figure(1);clf;hold on ;axis([-6 6 -6 6]);
plot(X(:,1),x(:,2),'rx');
plot(9*[-t(1) t(1)],9*[-t(2) t(2)]);