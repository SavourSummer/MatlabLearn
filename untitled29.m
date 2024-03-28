clc
clear
syms x a b h
f(x)=x^3;
a=0;
b=1;
h=0.0001;
n=(b-a)/h;
x=a+[1:n-1]*h;
y=sum(feval(f,x))
y=(h/2)*(f(a)+f(b)+2*y);