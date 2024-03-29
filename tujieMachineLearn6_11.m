clc,clear,close all;
%对线性模型fe(x)=θ1 + θ2*x进行Tukey损失最小学习

n=50;N=1000;x=linspace(-3,3,n)';X=linspace(-3,3,N)';

y=x+0.2*randn(n,1);y(n)=-4;

% %当误差小于某个阈值e
% 时，使用平方误差：L(r)=r2
% 。
% Huber损失函数的数学表达式为：
%L(r)=r2e∣r∣−2e2​​ if∣r∣<e ，e*|r|- (e^2)/2 if ∣r∣≥e​
% 当误差大于等于e
% 时，使用绝对误差：L(r)=e∣r∣−2e2​
% 
% 残差r=f(x)-y
p(:,1)=ones(n,1);p(:,2)=x;t0=p\y;e=1;
for o =1:1000
    % 计算残差r和权重w,w=1 if∣r∣<η ,η/|r| if∣r∣>η
    r=abs(p*t0-y);
    w=zeros(n,1);
     % 如果残差大于阈值e，则调整权重
    w(r<=e)=(1-r(r<=e).^2/e^2).^2;
     % 更新模型参数t,t=(pT*w*p)^-1 *pT*w*y
    t=(p'*(repmat(w,1,2).*p))\(p'*(w.*y));
    if norm(t-t0)<0.001,break,end
    t0=t;
end

P(:,1)=ones(N,1);
P(:,2)=X;
F=P*t;
figure(1);clf;hold on;axis([-2.8 2.8 0.5 1.2]);
plot(X,F,'g-');
plot(x,y,'bo');