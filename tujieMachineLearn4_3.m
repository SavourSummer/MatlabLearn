clc,clear,close all;
%生成数据，使用线性模型的部分空间约束最小二乘法，
%核为三角函数（1，sin(x/2),cos(x/2),sin(2x/2)......cos(15x/2)
n=50;N=1000;x=linspace(-3,3,n)';X=linspace(-3,3,N)';
%输入，生成一个新的向量y，y的每个元素是对应的pix元素的正弦值除以pix元素本身，
% 然后加上0.1倍的x元素值和一个随机噪声。
pix=pi*x;
y=sin(pix)./(pix)+0.1*x+0.05*randn(n,1);

p(:,1)=ones(n,1);P(:,1)=ones(N,1);
for j=1:15
    p(:,2*j)=sin(j/2*x);p(:,2*j+1)=cos(j/2*x);
    P(:,2*j)=sin(j/2*X);P(:,2*j+1)=cos(j/2*X);
end
%t1最小二乘法，t2部分空间约束最小二乘法
t1=p\y;F1=P*t1;%t=theta θ
%最小二乘法求解，最小二乘法J=（1/2）*||φ*θ-y||^2,
% 求导得▽J（θ）=φT*φ*θ-φ*y，基函数φ=p
%令▽J（θ）=0，得φ*θ=y
t2=(p*diag([ones(1,11) zeros(1,20)]))\y; F2=P*t2;


figure(1);clf;hold on;axis([-2.8 2.8 0.5 1.2]);
plot(X,F1,'g-');plot(x,y,'bo');plot(X,F2,'r--');
legend('LS',"SUbspace=Constained Ls");