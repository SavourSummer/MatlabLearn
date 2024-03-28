N=200;
r0=1;
r=linspace(0,r0,N);
theta=linspace(0,4*pi,N);
[R,the]=meshgrid(r,theta);
Z=1*R.^0;
[x,y]=pol2cart(the,R);%极坐标转直角坐标
mesh(x,y,Z)