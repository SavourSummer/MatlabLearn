clc,clear ,close all;
%剪枝分类器进行Adaboost学习
n=50;
x=randn(n,2);
b=5000;a=50;
Y=zeros(a,a);
y=2*(x(:,1)>x(:,2))-1;%将数据标签 2*1-1=1和2*0-1=-1
X0=linspace(-3,3,a);
[X(:,:,1) ,X(:,:,2)]=meshgrid(X0);%生成一个二维网格。中 X(:,:,1) 表示 x 坐标，X(:,:,2) 表示 y 坐标。
yy=zeros(size(y));
w=ones(n,1)/n;

for j=1:b
    wy=w.*y;
    d=ceil(2*rand);
    [xs,xi]=sort(x(:,d));
    el=cumsum(y(xi));eu=cumsum(wy(xi(end:-1:1)));
    e=eu(end-1:-1:1)-el(1:end-1);
    [em,ei]=max(abs(e));
    c=mean(xs(ei:ei+1));
    s=sign(e(ei));
    yh=sign(s*(x(:,d)-c));
    R=w'*(1-yh.*y)/2;
    t=log((1-R)/R)/2;
    yy=yy+yh*t;
    w=exp(-yy.*y);
    w=w/sum(w);
    Y=Y+sign(s*(X(:,:,d)-c))*t;
end

figure(1);clf;hold on;axis([-3 3 -3 3]);
% colormap 是 MATLAB 中用于设置颜色映射的函数。
% [1 0.7 1; 0.7 1 1] 是一个矩阵，其中每一行表示一种颜色，由 RGB 值组成。
% 在这段代码中，我们使用了两种颜色：
% 第一行的颜色是粉色（RGB 值为 [1 0.7 1]）。
% 第二行的颜色是浅蓝色（RGB 值为 [0.7 1 1]）
colormap([1 0.7 1;0.7 1 1]);


% X0 是之前生成的 x 坐标的向量。
% Y 是之前计算的分类器的输出，表示决策边界。
% 在这个等高线图中，不同颜色的区域表示不同的类别。
% 蓝色区域表示类别 1，红色区域表示类别 -1。
% 决策边界就是两个区域的分界线。
contour(X0,X0,sign(Y));
plot(x(y==1,1),x(y==1,2),'bo');
plot(x(y==-1,1),x(y==-1,2),'rx');