clc
clear
syms x fx
fx=x^3+x-3;
dfx=diff(fx,x)
x=zeros(1,101);
x(1)=1;
e=0.0001;
for i=1:100
    x(i+1)=x(i)-((x(i)^3+x(i)-3)/(3*x(i)^2+1));
    if abs((x(i+1)-x(i)))/x(i)>=e
        disp([i x]);
    end
end;
n=1:101;
plot(n,x),grid on
