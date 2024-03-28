x=0:0.001:4;
semilogy(x,x.^2),grid on
hold on
semilogy(x,x.^3)
hold on
semilogy(x,x.^4)
hold on
semilogy(x,exp(x.^2))
