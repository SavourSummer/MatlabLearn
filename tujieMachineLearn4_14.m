clc,clear,close all;
%对使用高斯盒模型的L2约束最小二乘学习法进行交叉已验证法
%高斯核=exp(-(x-c)^2/(2*h^2))
n=50;N=1000;x=linspace(-3,3,n)';X=linspace(-3,3,N)';
%输入，生成一个新的向量y，y的每个元素是对应的pix元素的正弦值除以pix元素本身，
% 然后加上0.1倍的x元素值和一个随机噪声。
pix=pi*x;
y=sin(pix)./(pix)+0.1*x+0.05*randn(n,1);

x2=x.^2; xx =repmat(x2,1,n)+repmat(x2',n,1)-2*x*x';
hhs=2*[0.03 0.3 3].^2; ls=[0.0001 0.1 100];
m=5; 
u=floor(m*[0:n-1]/n)+1;u=u(randperm(n));
for hk=1:length(hhs)
    hh=hhs(hk);k=exp(-xx/hh);
    for i=1:m
        ki=k(u~=i,:);kc=k(u==i,:);yi=y(u~=i);yc=y(u==i);
        for lk=1:length(ls)
            l=ls(lk);
            t=(ki'*ki+l*eye(n))\(ki'*yi);
            fc=kc*t;
            g(hk,lk,i)=mean((fc-yc).^2);
        end
    end
end
[gl,ggl]=min(mean(g,3),[],2);[gh1,ggh1]=min(gl);
L=ls(ggl(ggh1));HH=hhs(ggh1);

K=exp(-(repmat(X.^2,1,n)+repmat(x2',N,1)-2*X*x')/HH);
k=exp(-xx/HH);
t=(k^2+L*eye(n))\(k*y);
F=K*t;

figure(1);clf;hold on;axis([-2.8 2.8 0.5 1.2]);
plot(X,F,'g-');
plot(x,y,'bo');

