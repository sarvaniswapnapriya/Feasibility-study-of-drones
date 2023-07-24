clear all 
clc
time=2;
warning('off','all');

x = [0:1:50];
y= [0:1:50];

[x1,y1]=meshgrid(x,y);
while time>1
    subplot(2,1,1) 
    jtx=0.005*time;
     jty=0.004*time;       
     tx = sin(3.2*3.14*jtx)+1;
     ty = sin(0.2*3.14*jty)+1;

     %disp("gotin")
     xc=tx*(sin(2*0.1*(x1)))+30;    
     yc=ty*sin(2*0.1*y1)+20;
     z1=xc+yc;
     
     a= surf(x1,y1,z1);
     colorbar
    Zval1 = a.ZData;

    %spiral
    pos = [25 25 ;    % startpoint
        7.3 7.3 ] ;  % endpoint
    nturns = 25 ;    % number of turns (integer value)
    % engine
    dp = diff(pos,1,1) ;
    R = hypot(dp(2), dp(2)) ;
    phi0 = atan2(dp(2), dp(2)) ;
    phi = linspace(0, nturns*2*pi, 1000) ; % 10000 = no of sensors 
    r = linspace(0, R, numel(phi)) ;
    xr = (pos(1,1) + r .* cos(phi + phi0))';
    yr = (pos(1,1) + r  .* sin(phi + phi0))' ;

    xc1=tx*(sin(2*0.1*xr))+30;
    yc1=ty*(sin(2*0.1*yr))+20;
    zc1=xc1+yc1;   
    
    timevar=([0:0.01:10])';

    F = scatteredInterpolant(xr,yr,timevar,zc1,'natural');
    timecor = 0:0.1:5;
    [timecor1] = meshgrid(timecor);
    vq1=F(x1,y1,timecor1);
   
    %what to print in graph   ?
    
%     subplot(2,1,2);
% 
%     plot3(xr,yr,zc1,'mo')
%     hold on
%     b= mesh(x1,y1,vq1); 
%     zival = b.ZData;
%     title('Natural Neighbour')
%     legend('Sensor placements','Interpolated Surface','Location','NorthWest')
%     colorbar
    
    time=time+1;
    pause(5)
    clf reset
   
    end 




