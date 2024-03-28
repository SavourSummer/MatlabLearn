clc,clear,close all;
rng('default')
N=300;
mu0=0;sigma0=3;%μ先验分布的参数
mu_value=-10:0.1:10;%μ的取值范围
Prior=pdf('Normal',mu_value,mu0,sigma0);%μ的先验概率密度函数
plot(mu_value,Prior);
prev=Prior;%P(μ）
mu=2;sd=2;
training=normrnd(mu,sd,[N 1])%生成正态分布样本集
hold on
for i=1:N
    tempdata=training(i);%当前样本xi
    npdf=normalDist(tempdata,mu_value,sd);%计算样本对应的p(xi|μ）
    numerator=npdf.*prev;%计算样本对应的p(X^i|μ）=p(xi|μ）p(X^(i-1)|μ）P(μ）
    prev=numerator;
    TotalP=sum(numerator);%贝叶斯公式分布
    Poster=numerator/TotalP;%计算P(μ|X^i）
    if i==10||i==50||i==100||i==200||i==300
        plot(mu_value,Poster);
    end
end
[value,pos]=max(Poster);
plot([mu_value(pos) mu_value(pos)],[0 value],'k-.');%绘制P(μ|X^N）尖峰
mu_value(pos)%P(μ|X^N）尖峰所对应的μ
hold off

function npdf=normalDist(X,Mu,Sigma)
    Z=(X-Mu)./Sigma;
    npdf=exp(-0.5*Z.^2)/(sqrt(2*pi)*Sigma);
end
