clc ,clear,close all;
rng('default')
N=1000;mu=0;sigma=0.8;

x=normrnd(mu,sigma,[N 1]);
x_values=-3:0.01:3;
kn1=10;kn2=50;kn3=100;%生成三个不同的kn
px=pdf('Normal',x_values,mu,sigma);
len=length(x_values);
pxe1=zeros(1,len);
pxe2=zeros(1,len);
pxe3=zeros(1,len);

index=1;
for j=-3:0.01:3
    distance=pdist2(j,x);  %计算当前点和样本点之间的距离
    D=sort(distance);     %计算升序排列
    V1=2*D(kn1);V2=2*D(kn2);V3=2*D(kn3);%第kn个距离作为半径，一维空间，确定长度2r
    pxe1(index)=kn1/N/V1;
    pxe2(index)=kn2/N/V2;
    pxe3(index)=kn3/N/V3;
    index=index+1;
end
figure,plot(x_values,px,'Color','k');
hold on
plot(x_values,pxe1,'r:');
hold off
figure,plot(x_values,px,'Color','k');
hold on
plot(x_values,pxe2,'g--');
hold off
figure,plot(x_values,px,'Color','k');
hold on
plot(x_values,pxe3,'b--');
hold off
