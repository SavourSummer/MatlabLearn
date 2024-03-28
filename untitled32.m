clc
clear
% G=zpk([0],[-1-j -1+j],[1])
% figure(1)
% rlocus(G)
% 
% G2=zpk([-2],[-1-j -1+j -3],[1])
% figure(2)
% rlocus(G2)
% 
% G3=zpk([-2.5],[-1 -2 -3],[1])
% figure(3)
% rlocus(G3)
% 
% G4=zpk([],[-1 -2 -3],[1])
% figure(4)
% rlocus(G4)
% G=zpk([-1.5],[0 -1],[1])
% figure(1)
% rlocus(G)
% 
% G2=zpk([-2],[0 -1],[1])
% figure(2)
% rlocus(G2)
% 
% G3=zpk([-2.5],[0 -1],[1])
% figure(3)
% rlocus(G3)
% 
% G4=zpk([-5],[0 -1 -4],[1])
% figure(4)
% rlocus(G4)
G2=zpk([],[0 -5 -2],[60])
figure(2)
margin(G2) 