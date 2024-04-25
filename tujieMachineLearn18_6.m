%与高斯核模型相对应的最小二乘法相对密度估计法

clc,clear,close all
n=100;
x=randn(n,1);
y=randn(n,1)+0.5;

hhs=2*[1 5 10].^2;
ls=10.^[-3 -2 -1];
m=5;
b=0.5;
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
    for i=1:m % 计算核矩阵k
        ki=k(u~=i,:); % 除了第i组的所有样本的核矩阵
        ri=r(u~=i,:);
        h=mean(ki)';
        kc=k(u==i,:);% 第i组的核矩阵
        rj=r(v==i,:);
        G=b*ki'*ki/sum(u~=i)+(1-b)*ri'*ri/sum(v~=i);%b是β
        for lk=1:length(ls)% 遍历所有正则化参数
            l=ls(lk); % 当前正则化参数
            a=(G+l*eye(n))\h; % 解线性方程组得到a
            kca=kc*a;
            g(hk,lk,i)=b*mean(kca.^2)+(1-b)*mean((rj*a).^2);
            g(hk,lk,i)= g(hk,lk,i)/2-mean(kca);
        end
    end
end
[gl,ggl]=min(mean(g,3),[],2); % 计算g的均值并找到最小值
[ghl,gghl]=min(gl);
L=ls(ggl(gghl)); % 最优的正则化参数
HH=hhs(gghl);
k=exp(-xx/HH); % 使用最优参数计算核矩阵k
r=exp(-yx/HH);
s=r*((b*k'*k/n+(1-b)*r'*r/n+L*eye(n))\(mean(k)'));% 计算密度估计
figure(1);clf;hold on;plot(y,s,'rx');
