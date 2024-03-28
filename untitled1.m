[x y]=meshgrid(-2.1:0.25:2.1,-6:0.25:6)
z=80*(y.^2).*(exp(-x.^2-0.3*y.^2))


mesh(x,y,z)

hold on
contour3(x,y,z)