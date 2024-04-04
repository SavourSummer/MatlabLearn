clc,clear,close all;
%剪枝分类器进行bagging学习
%从n个训练样本{(xi,ji)} 其中i=1:n选取n个，允许重复，生成若干与原始训练样本集有些许差异的新样本集
%使用上样本集求得多个学习器φj 其中j=1:b
%对多个学习器φj求平均值得到f
%数据生成
n=50;
x=randn(n,2);
b=5000;a=50;Y=zeros(a,a);
y=2*(x(:,1)>x(:,2))-1;%将数据标签 2*1-1=1和2*0-1=-1
X0=linspace(-3,3,a);
[X(:,:,1) ,X(:,:,2)]=meshgrid(X0);%生成一个二维网格。中 X(:,:,1) 表示 x 坐标，X(:,:,2) 表示 y 坐标。


for j=1:b
    db=ceil(2*rand);
    r=ceil(n*rand(n,1));
    xb=x(r,:);
    yb=y(r);
    [xs ,xi]=sort(xb(:,db));
el=cumsum(yb(xi));%cumsum（cumulative sum）计算累积和。el(i) 表示 y(xi(1)) + y(xi(2)) + ... + y(xi(i))。这个累积和在后续的步骤中用于计算误差
eu=cumsum(yb(xi(end:-1:1)));%eu(i) 表示 y(xi(end)) + y(xi(end-1)) + ... + y(xi(end-i+1))
e=eu(end-1:-1:1)-el(1:end-1);%误差（error），误差在后续的步骤中用于找到决策边界的位置
[em,ei]=max(abs(e));%em 是之前计算的误差向量 e 中的最大值。    ei 是最大值所在的索引

%xs(ei:ei+1) 表示在 xs 中取索引为 ei 和 ei+1 的两个数据点的 x 坐标
%mean(xs(ei:ei+1)) 计算了这两个数据点的 x 坐标的平均值，即决策边界的截距
c=mean(xs(ei:ei+1));

% %sign(e(ei)) 是一个函数，它返回 e(ei) 的符号：
% 如果 e(ei) 大于 0，那么 sign(e(ei)) 为 1。
% 如果 e(ei) 等于 0，那么 sign(e(ei)) 为 0。
% 如果 e(ei) 小于 0，那么 sign(e(ei)) 为 -1。
s=sign(e(ei));
Y=Y+sign(s*(X(:,:,db)-c))/b;

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
contour(X0,X0,Y);
plot(x(y==1,1),x(y==1,2),'bo');
plot(x(y==-1,1),x(y==-1,2),'rx');