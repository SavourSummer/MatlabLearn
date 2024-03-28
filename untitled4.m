clear all
clc
n=3;
L=zeros(n);
L(1,2)=9;
L(1,3)=12;
L(2,1)=1/3;
L(3,2)=1/2;
x=[0 0 1]';
for t=1:24
    x=L*x;
    p(t)=sum(x);
    disp([t x' sum(x)])
end
plot(1:15,p(1:15),xlabel('months'),ylabel('rabbits'))
hold,plot(1:15,p(1:15),'o')