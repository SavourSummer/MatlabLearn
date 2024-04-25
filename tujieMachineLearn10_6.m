%最小二乘概率分类器
%
clc,clear , close all;
n=90;
c=3;
y=ones(n/c,1)*[1:c];
y=y(:);
x=randn(n/c,c) + repmat(linspace(-3,3,c),n/c,1); % 生成正态分布的随机数，并平移.每一列的数据都围绕着不同的中心点分布，这些中心点由 linspace(-3,3,c) 确定
x=x(:);

hh=2*1^2;
x2=x.^2;
l=0.1;
N=100;
X=linspace(-5 ,5,N)';
k=exp(-(repmat(x2,1,n)+repmat(x2',n,1)-2*x*x')/hh);
K=exp(-(repmat(X.^2,1,n)+repmat(x2',N,1)-2*X*x')/hh);

for yy=1:c
    yk=(y==yy);ky=k(:,yk);
    ty=(ky' * ky +l*eye(sum(yk)))\(ky'*yk);
    Kt(:,yy)=max(0,K(:,yk)*ty);
end
ph=Kt./repmat(sum(Kt,2),1,c);

figure(1);clf;hold on;
axis([-5 5 -0.3 1.8]);


plot(X,ph(:,1),'b-');plot(X,ph(:,2),'r--');
plot(X,ph(:,3),'g:');% 类别1 2 3的概率曲线
plot(x(y==1),-0.1*ones(n/c,1),'bo'); % 类别1的数据点
plot(x(y==2),-0.2*ones(n/c,1),'rx');
plot(x(y==3),-0.1*ones(n/c,1),'gv');
legend('q(y=1|x)','q(y=2|x)','q(y=3|x)')



