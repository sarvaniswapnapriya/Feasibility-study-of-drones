clear all;
clc

x = [0:1:50];
y= [0:1:50];
[x1,y1]=meshgrid(x,y);
j=2;
   
     jtx=0.005*j;
     jty=0.004*j;   
     tx = sin(3.2*3.14*jtx)+1;
     ty = sin(0.2*3.14*jty)+1;

     %disp("gotin")
     xc=tx*(sin(2*0.1*(x1)))+30;
     yc=ty*sin(2*0.1*y1)+20;
     z1=xc+yc;  
    a= surf(x1,y1,z1);  
    Zval1 = a.ZData;   

    %spiral
    pos = [25 25 ;    % startpoint
        7.3 7.3 ] ;  % endpoint
    nturns = 35 ;    % number of turns (integer value)
 
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

    F = scatteredInterpolant(xr,yr,zc1);
    F.Method = 'nearest';
    vq1 = F(x1,y1);
    
      subplot(2,1,1);
     plot3(xr,yr,zc1,'mo')
    hold on
    b= mesh(x1,y1,vq1); 
    zival = b.ZData;
    title('Nearest Neighbour')
    legend('Sample Points','Interpolated Surface','Location','NorthWest')
    colorbar

    subplot(2,1,2);

    plot3(xr,yr,zc1,'mo')
    hold on
    b= mesh(x1,y1,vq1); 
    zival = b.ZData;
    title('Nearest Neighbour')
    legend('Sample Points','Interpolated Surface','Location','NorthWest')
    colorbar

