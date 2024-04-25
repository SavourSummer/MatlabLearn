%与10近临相似度对应的拉普拉斯特征映射
clc,clear,close all;
n=1000;k=10;
a=3*pi*rand(n,1);
x=[a.*cos(a) 30*rand(n,1) a.*sin(a)];

x=x-repmat(mean(x),[n,1]);%数据中心化处理
x2=sum(x.^2,2);
d=repmat(x2,1,n)+repmat(x2',n,1)-2*x*x';%计算点之间的距离平方矩阵 d
[p,i]=sort(d);% 对每一行的距离进行排序
W=sparse(d<=ones(n,1)*p(k+1,:));%创建一个稀疏邻接矩阵 W，如果点 i 和点 j 的距离小于或等于点 i 的第 k+1 个最近邻居的距离，则 W(i,j) 为1
W=(W+W'~=0);%确保邻接矩阵 W 是对称的。
D=diag(sum(W,2));%创建度矩阵 
L=D-W;
[z,v]=eigs(L,D,3,'sm');


figure(1);clf;hold on ;view([15 10]);
scatter3(x(:,1),x(:,2),x(:,3),40,a,'o');
figure(2);clf;hold on ;
scatter(z(:,2),z(:,1),40,a,'o');



