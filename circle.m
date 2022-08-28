%% It is used to draw the trajectory of a point as the wheel rolls.
% Author: Zhang, Haowei, changhw@zju.edu.cn
clear all;
close all;
url='https://github.com/changhw/high-school-physics';
dir_name = 'circle';
mkdir(dir_name);
xmax=30;
tmax=30;
Nt = 200;
t1d=linspace(0,tmax,Nt);
plot(linspace(0,xmax,100), linspace(0,xmax,100)*0, 'k-', 'LineWidth', 2); hold on;

v=1;
R=2;
omega=v/R;
theta=linspace(0, 2*pi, 1000);
xCircle0=R+R*cos(theta);
yCircle0=R+R*sin(theta);

for i=1:1:Nt
    t=t1d(i);
    xCircle = xCircle0 + v*t;
    yCircle = yCircle0;
    h1=plot(xCircle, yCircle,'k-','LineWidth', 2);
    h=R*(1+sin(omega*t));
    x=v*t+R*(1-cos(omega*t));
    h2=plot(x,h,'b.','markersize',10);
    h3=plot(x,h,'b*','markersize',7);
    xlim([0,xmax]);
%     ylim([0,R]);
    axis equal;
    grid on;
    if i ==1
        annotation(gcf,'textbox',...
        [0.25 0.17 0.11 0.062],...
        'String',url,...
        'Color', 'red',...
        'LineStyle','none',...
        'Interpreter','latex',...
        'FontWeight','bold',...
        'FontSize',10,...
        'FontName','Times New Roman',...
        'FitBoxToText','off');
    end
    drawnow;
    xlabel('x');
    ylabel('y');    
    print('-dpng', [dir_name '\' 'fig' num2str(i,'%.4d')], '-r300');
    delete(h1);
    delete(h3);
end

%% make viedo
WriterObj=VideoWriter([dir_name '\' 'circle.avi']);
WriterObj.FrameRate = 20;
open(WriterObj);
for i=1:1:Nt
    frame=imread([dir_name '\' 'fig' num2str(i,'%.4d') '.png']);
    writeVideo(WriterObj,frame);% 将frame放到变量WriterObj中
end
close(WriterObj);
