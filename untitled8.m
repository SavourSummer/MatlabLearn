[x y]=meshgrid(-10:.2:10,-10:.2:10);
z=x+2.*y-2;
[x1,y1,u]=cylinder(4);
u=100*u
mesh(x,y,z),hold on
surf(x1,y1,u),hold on