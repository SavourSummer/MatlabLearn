clc
clear

fn=@(x) x.^2;
a=0;
b=2;
h=1;
s=trap(fn,a,b,h)