%最小二乘密度差估计法

clc,clear,close all
n=200;
x=randn(n,1);
y=randn(n,1)+1;

hhs=2*[0.5 1 3].^2;
ls=10.^[-2 -1 0];
m=5;
x2=x.^2;
xx=repmat(x2,1,n)+repmat(x2',n,1)-2*x*x';% 计算x的距离矩阵
y2=y.^2;
yx=repmat(y2,1,n)+repmat(x2',n,1)-2*y*x';

u=floor(m*[0:n-1]/n)+1;% 生成分组索引u
u=u(randperm(n));
v=floor(m*[0:n-1]/n)+1;
v=v(randperm(n));

g=zeros(length(hhs),length(ls),m); % 初始化g矩阵
for hk=1:length(hhs)% 遍历所有核宽度参数
    hh=hhs(hk); % 当前核宽度参数
    k=exp(-xx/hh); % 计算核矩阵k
    r=exp(-yx/hh);
    U=(pi*hh/2)^(1/2)*exp(-xx/(2*hh));
    for i=1:m % 计算核矩阵k
        vh=mean(k(u~=i,:))'-mean(k(v~=i,:))';
        z=mean(k(u==i,:))-mean(r(v==i,:));
        for lk=1:length(ls)
            l=ls(lk);
            a=(U+l*eye(n))\vh;
            g(hk,lk,i)=a'*U*a-2*z*a;
        end
    end
end

[gl,ggl]=min(mean(g,3),[],2); % 计算g的均值并找到最小值
[ghl,gghl]=min(gl);
L=ls(ggl(gghl)); % 最优的正则化参数
HH=hhs(gghl);
k=exp(-xx/HH); % 使用最优参数计算核矩阵k
r=exp(-yx/HH);

U=(pi*HH/2)^(1/2)*exp(-xx/(2*HH));
a=(U+L*eye(n))\vh;
s=[k;r]*a;
L2=2*a'*vh-a'*U*a;

figure(1);clf;hold on;plot([x;y],s,'rx');