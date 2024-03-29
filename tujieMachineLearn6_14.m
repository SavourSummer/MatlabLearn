clc,clear,close all;
%对使用高斯盒模型的L2约束最小二乘学习法进行交叉已验证法
%高斯核=exp(-(x-c)^2/(2*h^2))
n=50;N=1000;x=linspace(-3,3,n)';X=linspace(-3,3,N)';
%输入，生成一个新的向量y，y的每个元素是对应的pix元素的正弦值除以pix元素本身，
% 然后加上0.1倍的x元素值和一个随机噪声。
pix=pi*x;
y=sin(pix)./(pix)+0.1*x+0.05*randn(n,1);
y(n/2)=0.5;

hh=2*0.3^2;l=0.1;e=0.1;
t0=randn(n,1);
x2=x.^2;
k=exp(-(repmat(x2,1,n)+repmat(x2',n,1)-2*x*x')/hh);
for o =1:1000
    % 计算残差r和权重w,w=1 if∣r∣<η ,η/|r| if∣r∣>η
    r=abs(k*t0-y);
    w=ones(n,1);
     % 如果残差大于阈值e，则调整权重
    w(r>e)=e./r(r>e);
     % 更新模型参数t,t=(pT*w*p)^-1 *pT*w*y
    Z=k*(repmat(w,1,n).*k)+l*pinv(diag(abs(t0)));
    t=(Z+0.000001*eye(n))\(k*(w.*y));
    if norm(t-t0)<0.001,break,end
    t0=t;
end
%||x-c||.^2=(repmat(X.^2,1,n)+repmat(x2',N,1)-2*X*x')
K=exp(-(repmat(X.^2,1,n)+repmat(x2',N,1)-2*X*x')/hh);
F=K*t;
figure(1);clf;hold on;axis([-2.8 2.8 0.5 1.2]);
plot(X,F,'g-');
plot(x,y,'bo');


