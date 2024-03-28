clc,clear,close all;
rng('default')
N=500;
mu0=0; sigma0=3;%μ先验分布参数
mu_value = -5:0.01:5;%μ取值范围
mu=2; sd=2;%对数正态分布参数,mu 和 sd：对数正态分布的参数，其中 mu 是对数均值，sd 是对数标准差

training=lognrnd(mu,sd,[N,1]);%lognrnd(mu, sd, [N,1]) 来生成一个大小为 N 的对数正态分布样本
Poster=zeros(length(mu_value),1);%Poster为来自总体分布为对数正态分布的概率密度，Poster=1/(σ*sqrt(2*pi))exp(-1/2 * (μ-μ0 / σ0)^2))

for j=1:length(mu_value)
    lpdf=lognDist(training,mu_value(j),sd);%lpdf为似然函数
    Poster(j)=lpdf+normalDist(mu_value(j),mu0,sigma0);%normalDist(mu_value(j),mu0,sigma0)即1/(σ*sqrt(2*pi))exp(-1/2 * (μ-μ0 / σ0)^2))
end
plot(mu_value,Poster);
xlabel('μ'),ylabel('p(μ/X');
%寻找最大值
[~,pos]=max(Poster);
mu_value(pos)

%函数如下
function lpdf = lognDist(X,Mu,Sigma)%X=样本,Mu=平均值,Sigma=方差,计算ln l( μ)
        Z=(log(X)-Mu)./Sigma;
        lpdf=sum(log(Sigma*X)-.5*log(2*pi)-.5*(Z.^2));
end
function lpdf=normalDist(X,Mu,Sigma) %计算lnP（μ）
        Z=(X-Mu)./Sigma;
        lpdf=sum(log(Sigma)-.5*log(2*pi)-.5*(Z.^2));
end