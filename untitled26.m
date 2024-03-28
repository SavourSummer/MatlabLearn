clc
clear
syms e xL xR fx x xM
xL=1;
xR=2;

e=0.0001;
%fx=@(x) x^3+x-3;
dfx=diff(fx,x);
n=log(abs(xL-xR)/e)/log(2);
n=round(n);
fx=@(x) x^3+x-3;
for i=1:n
    xM=(xL+xR)/2;
    if fx(xL)*fx(xM)>0
        xL=xM;
    else
        xR=xM;
    end
end
    xM