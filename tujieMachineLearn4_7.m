clc,clear,close all;
%生成数据，使用L2最小二乘法算法对高斯核模型进行最小学习法，核带宽（方差）=0.3，参数λ=0.1
%高斯核=exp(-(x-c)^2/(2*h^2))
n=50;N=1000;x=linspace(-3,3,n)';X=linspace(-3,3,N)';
%输入，生成一个新的向量y，y的每个元素是对应的pix元素的正弦值除以pix元素本身，
% 然后加上0.1倍的x元素值和一个随机噪声。
pix=pi*x;
y=sin(pix)./(pix)+0.1*x+0.05*randn(n,1);

x2=x.^2;X2=X.^2;hh=2*0.3^2;L=0.1;
%计算所有X和x之间的高斯核。
k=exp(-(repmat(x2,1,n)+repmat(x2',n,1)-2*x*x')/hh);
%计算所有X和x之间的高斯核。
K=exp(-(repmat(X2,1,n)+repmat(x2',N,1)-2*X*x')/hh);

%最小二乘法求解，最小二乘法J=（1/2）*||φ*θ-y||^2,
% 求导得▽J（θ）=φT*φ*θ-φ*y，基函数φ=p
%令▽J（θ）=0，得φ*θ=y
t1=k\y;
F1=K*t1;
t2=(k^2+L*eye(n))\(k*y);%这个是L2最小二乘法 θ=（k/（k^2+λ））*φT*y*φ
F2=K*t2;
figure(1);clf;hold on;axis([-2.8 2.8 0.5 1.2]);
plot(X,F1,'g-');plot(x,y,'bo');plot(X,F2,'r--');
legend('LS',"L2=Constained Ls");