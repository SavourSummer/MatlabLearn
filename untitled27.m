clc
clear
syms fx x
fx=@(x) x^2-3;
fzero(fx,0)