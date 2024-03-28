[x y]=meshgrid(-5:1:5,-5:1:5);
v=x.^2+y;
dx=2*x;
dy=dx
dy(:,:)=10
contour(x,y,v), hold on
quiver(x,y,dx,dy), hold on

