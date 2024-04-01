%高斯核L1约束最小二乘法求解
%拉格朗日求最优化，J（θ）=JLS（θ）+λ*||θ||
%|θ|可以转为|θ| < θ^2 /(2*c)  + c/2,c>0 。在c=θ时，相切。使用迭代求解
%J（θ）=JLS（θ）+λ*||θ|| => J（θ）=JLS（θ）+λ* 大θT* θ十* θ + C，大θ为θ的对角矩阵
%得θ=（φT*φ + λ*大θ十）^-1  * φT*y
clc,clear,close all;
n=50;N=1000;x=linspace(-3,3,n)';X=linspace(-3,3,N)';
pix=pi*x;y=sin(pix)./(pix)+0.1*x+0.2*randn(n,1);

hh=2*0.3^2;  l=0.1; t0=randn(n,1); x2=x.^2;
k=exp(-(repmat(x2,1,n)+repmat(x2',n,1)-2*x*x')/hh);

k2=k.^2;ky=k*y;
for o=1:10000
    t=(k2 + l*pinv(diag(abs(t0))))\ky;
    if norm(t-t0)<0.001 
        break
    end
    t0=t;
end

K=exp(-(repmat(X.^2,1,n)+repmat(x2',N,1)-2*X*x')/hh);
F=K*t;

figure(1);clf;hold on;axis([-2.8 2.8 0.5 1.2]);
plot(X,F,'g-');
plot(x,y,'bo');



