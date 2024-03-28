syms i V R L t
i=(V/R)*(1-exp(-R*t/L));
didt=diff(i,t);
ans=didt+(R/L)*i-V/L;

simplify(ans)

subs(i,t,0)

V=1;R=1;L=1;
t=0:0.01:6;
i=(V/R)*(1-exp(-R.*t/L));
plot(t,i,'ro'),title('circuit problem example')
xlabel('time t'),ylabel('current i')