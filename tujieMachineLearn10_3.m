%使用概率梯度下降的Logustic回归学习
%使用线性对数对分类后验概率q(y|x)进行模拟化
%           exp(∑j=1~b  θj*φj(x) ）
%q(y|x:θ) = ————————————————————————
%          ∑( expj=1~b  θj*φj(x) ）
clc,clear , close all;
n=90;
c=3;
y=ones(n/c,1)*[1:c];
y=y(:);
x=randn(n/c,c) + repmat(linspace(-3,3,c),n/c,1); % 生成正态分布的随机数，并平移.每一列的数据都围绕着不同的中心点分布，这些中心点由 linspace(-3,3,c) 确定
x=x(:);

hh=2*1^2;t0=randn(n,c);
for o=1:n*1000
    i=ceil(rand*n); % 随机选择一个样
    yi=y(i);        % 获取该样本的标签
    ki=exp(-(x-x(i)).^2/hh); % 计算高斯核
    ci=exp(ki'*t0); % 计算类别概率
    t=t0-0.1*(ki*ci)/(1+sum(ci));% 梯度上升的方向更新参数
    t(:,yi)=t(:,yi)+0.1*ki;% 对正确类别的参数进行正向更新
    if norm(t-t0)<0.000001,break,end% 检查收敛性
    t0=t; % 更新参数
end
% 生成新的输入数据X，用于绘制分类概率曲线
N=100;X=linspace(-5,5,N)';% 数据点数
K=exp(-(repmat(X.^2,1,n)+repmat(x.^2',N,1)-2*X*x')/hh);% 计算高斯核

figure(1);clf;hold on;
axis([-5 5 -0.3 1.8]);
C=exp(K*t);C=C./repmat(sum(C,2),1,c);

plot(X,C(:,1),'b-');plot(X,C(:,2),'r--');
plot(X,C(:,3),'g:');% 类别1 2 3的概率曲线
plot(x(y==1),-0.1*ones(n/c,1),'bo'); % 类别1的数据点
plot(x(y==2),-0.2*ones(n/c,1),'rx');
plot(x(y==3),-0.1*ones(n/c,1),'gv');
legend('q(y=1|x)','q(y=2|x)','q(y=3|x)')
