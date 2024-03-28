clc,clear,close all;
%生成数据，使用随机梯度算法对高斯核模型进行最小学习法，核带宽（方差）=0.3
%高斯核=exp(-(x-c)^2/(2*h^2))
n=50;N=1000;x=linspace(-3,3,n)';X=linspace(-3,3,N)';
%输入，生成一个新的向量y，y的每个元素是对应的pix元素的正弦值除以pix元素本身，
% 然后加上0.1倍的x元素值和一个随机噪声。
pix=pi*x;
y=sin(pix)./(pix)+0.1*x+0.05*randn(n,1);
%进行最小梯度，循环用于执行随机梯度下降。在每次迭代中，
% 它都会选择一个随机样本，计算高斯核，然后更新参数向量t
hh=2*0.3^2;t0=randn(n,1);e=0.1;
for o=1:1:10000
    i=ceil(rand*n);%ceil(rand*n)会生成一个1到n之间的随机整数（包含1和n）
    ki=exp(-(x-x(i)).^2/hh);%高斯核
    t=t0-e*ki*(ki'*t0-y(i));%梯度下降法更新，t=theta θ。θ-e*▽J（θ），梯度▽J（θ）=ki(ki'*t0-y(i))

    if norm(t-t0)<0.00000001,break,end
    t0=t;
end

%计算所有X和x之间的高斯核。
K=exp(-(repmat(X.^2,1,n)+repmat(x.^2',N,1)-2*X*x')/hh);
%拟合值向量F。
F=K*t;
figure(1);clf;hold on;axis([-2.8 2.8 0.5 1.2]);
plot(X,F,'g-');
plot(x,y,'bo');