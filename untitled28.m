clc
clear
syms e xL xR x xM
xL=1.0;
xR=7.0;

u=zeros(1,14);


e=0.0001;
%fx=@(x) x^3+x-3;
%dfx=diff(fx,x);
n=log(abs(xL-xR)/e)/log(2);
n=round(n);

fx(x)=x^3+x-3;
for i=1:n
    xM=(xL+xR)/2;
    u(i)=xM
    if fx(xL+e)*fx(xM-e)>0
        xL=xM;
    else
        xR=xM;
    end
    
end

plot(u,fx(u))