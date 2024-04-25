%局部Fisher判别分析

clc,clear,close all
n=100;
x=randn(n,2);
x(1:n/2,1)=x(1:n/2,1)-4;
x(n/2+1:end,1)=x(n/2+1:end,1)+4;
%x(1:n/4,1)=x(1:n/4,1)-4;x(n/4+1:end,1)=x(n/4+1:end,1)+4;

x=x-repmat(mean(x),[n,1]);
y=[ones(n/2,1);2*ones(n/2,1)];% 创建一个分类向量，前一半为1，后一半为2

Sw=zeros(2,2);Sb=zeros(2,2);
for j=1:2
    p=x(y==j,:);
    p1=sum(p);
    p2=sum(p.^2,2);
    nj=sum(y==j);
    W=exp(-(repmat(p2,1,nj)+repmat(p2',nj,1)-2*p*p'));
    G=p'*(repmat(sum(W,2),[1 2]).*p)-p'*W*p;%G 是类间散布矩阵 Sb 的中间变量。它的计算基于 W 和数据点 p。第一项计算总，与p'*W*p相减获得离散差值
    Sb=Sb+G/n;
    %Sb=Sb+G/n+p'*p*(1-nj/n)+p1'*p1/n;%p'*p*(1-nj/n) 考虑了类别 j 的样本点与其他类别样本点之间的分散度，而 p1'*p1/n 考虑了类别 j 的样本点的总体分布情况。两者结合起来，有助于在降维后的空间中更好地区分不同的类别
    Sw=Sw+G/nj;
end
[t,v]=eigs((Sb+Sb')/2,(Sw+Sw')/2,1);
figure(1);clf;hold on;axis([-8 8 -6 6]);
plot(x(y==1,1),x(y==1,2),'bo');
plot(x(y==2,1),x(y==2,2),'rx');
plot(100*[-t(1) t(1)],100*[-t(2) t(2)],'k-');% 绘制特征向量表示的直线

