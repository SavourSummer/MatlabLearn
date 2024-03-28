clc,clear,close all;
P=[0.5 0.5];  N=400; 
mu1=[1 0];mu2=[-1 0];
sigma1=[1 0;0 1];sigma2=[2 0; 0 2];

rng('default');

training1=mvnrnd(mu1,sigma1,floor(N*P(1)));
training2=mvnrnd(mu2,sigma2,floor(N*P(2)));

training=[training1;training2]%生成两类样本

Y=ones(N,1);Y(N*P(1)+1:end)=2;
gscatter(training(:,1),training(:,2),Y,'gb','o++');
hold on
Mdl=fitcdiscr(training,Y,'DiscrimType','quadratic');
coeff=Mdl.Coeffs(1,2);
xMax=max(training);xMin=min(training);

[x1Grid,x2Grid] = meshgrid(xMin(1):0.1:xMax(1),xMin(2):0.1:xMax(2))
xGrid=[x1Grid(:),x2Grid(:)];

[label,score,cost]=predict(Mdl,xGrid);
contour(x1Grid,x2Grid,reshape(score(:,2),size(x1Grid)),[0.5 0.5],'k--');
hold off