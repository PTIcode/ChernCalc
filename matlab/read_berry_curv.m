clc 
clear all
close all

x=load ("berry_curv_1.txt");
% x=load ("B_curv_vi0_5_5.txt");
kx0=x(:,1);
ky0=x(:,2);
berry_curv0=x(:,3);

Nx=length(kx0)^0.5;

kx=kx0(1:Nx:Nx^2);
% ky=ky0(1:1:Nx);

Chern=zeros(Nx,Nx);
for m=0:Nx-1
    Y(:,m+1)=ky0(Nx*m+1:Nx*(m+1));
    berry_curv(:,m+1)=berry_curv0(Nx*m+1:Nx*(m+1));
end

% [X,Y] = meshgrid(kx,ky);
figure(10),
[X] = meshgrid(kx);
surf(X,Y,berry_curv);
shading interp
view(0,90)
colorbar;
caxis([-0.5 0.5])

ylabel('k_y (2\pi/a)');xlabel('k_x (2\pi/a)')
set(gca,'FontName','Times New Roman','FontSize',28);
grid off;
% xlim([-0.1 1.1])

x0=500;
y0=500;
width=500;
height=300;
set(gcf,'position',[x0,y0,width,height])




% savefig('Berry_curv_pert4.fig')
% saveas(gcf,'Berry_curv_pert4.emf')


