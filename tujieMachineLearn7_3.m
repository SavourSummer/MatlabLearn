clc,clear,close all;
%对高斯核使用L2约束的最小二乘法进行模式识别
%生成了一些随机数据点。这些数据点位于二维平面上，
% 其中一半属于类别1，另一半属于类别-1。
% 这些数据点的坐标由 u 和 v 组成
%
n=200;a=linspace(0,4*pi,n/2);%使用 linspace 函数在区间 [0, 4\pi] 内生成了一些均匀分布的数据点
u=[a.*cos(a) (a+pi).*cos(a)]' + 1*rand(n,1);
v=[a.*sin(a) (a+pi).*sin(a)]' + 1*rand(n,1);
x=[u v];
%用1和-1标记数据点的类别,
y=[ones(1,n/2) -ones(1,n/2)]';

x2=sum(x.^2,2);hh=2*1^2;l=0.01;
k=exp(-(repmat(x2,1,n)+repmat(x2',n,1)-2*x*x')/hh);
t=(k^2+l*eye(n))\(k*y);    

m=1000;X=linspace(-15,15,m)';X2=X.^2;
U=exp(-(repmat(u.^2,1,m)+repmat(X2',n,1)-2*u*X')/hh);
V=exp(-(repmat(v.^2,1,m)+repmat(X2',n,1)-2*v*X')/hh);
figure(1);clf;hold on;axis([-15 15 -15 15]);

%绘制了一个决策边界，用于将数据点分为两个类别
%新的网格 X，其中包含了一些新的数据点。这些数据点的 x 坐标由 X 组成
%类别y=sign(f(x)).if f(x)>0 y=1  if f(x)<0 y=-1
contourf(X,X,sign(V'*(U.*repmat(t,1,m))));

plot(x(y==1,1),x(y==1,2),'bo');
plot(x(y==-1,1),x(y==-1,2),'rx');
colormap([1 0.7 1;0.7 1 1]);