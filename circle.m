%% It is used to draw the trajectory of a point as the wheel rolls.
% Author: Zhang, Haowei, changhw@zju.edu.cn
clear all;
close all;
v=1;
R=2;
omega=v/R;

theta=linspace(0, 2*pi, 1000);
xCircle=R+R*cos(theta);xCircle0=xCircle;
yCircle=R+R*sin(theta);
xmax=30;
figure;
xlim([0,xmax]);
ylim([0,R]);
Nt = 100;
t1d=linspace(0,30,Nt);

dir_name = 'circle';
mkdir(dir_name);

for i=1:1:Nt
    t=t1d(i);
    xCircle = xCircle0 + v*t;
    h1=plot(xCircle, yCircle,'k-','LineWidth', 2);
    h=R*(1+sin(omega*t));
    x=v*t+R*(1-cos(omega*t));
    hold on;
    h2=plot(x,h,'r.','markersize',20);
    xlim([0,xmax]);
    ylim([0,R]);
    axis equal;
    grid on;
    drawnow;
    print('-dpng', [dir_name '\' 'fig' num2str(i,'%.4d')], '-r300');
    delete(h1);
end

%% make viedo
WriterObj=VideoWriter([dir_name '\' 'circle.avi']);
WriterObj.FrameRate = 10;
open(WriterObj);
for i=1:1:Nt
    frame=imread([dir_name '\' 'fig' num2str(i,'%.4d') '.png']);
    writeVideo(WriterObj,frame);% 将frame放到变量WriterObj中
end
close(WriterObj);
