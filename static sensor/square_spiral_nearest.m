clc
clear all; 
x = [0:1:50];
y= [0:1:50];
[x1,y1]=meshgrid(x,y);
j=2;
while j>1
subplot(2,1,1);

 %disp("gotin")
 jtx=0.005*j;
     jty=0.004*j;   
     tx = sin(3.2*3.14*jtx)+1;
     ty = sin(0.2*3.14*jty)+1;
     xc=tx*(sin(2*0.1*(x1)))+30;
     yc=ty*sin(2*0.1*y1)+20;
     z1=xc+yc;  
    a= surf(x1,y1,z1);  
    Zval1 = a.ZData;

    colorbar

    %spiral
    step = 1;  %// step size
    x0 = 25;    %// x coordinate of origin
    y0 = 25;   %// y coordinate of origin
    N = 998;    %// number of steps
    zch = x0+1j*y0 + step*cumsum([0 -1j.^(-floor(sqrt(2*(0:N)+1))-1)]);

    xr = (real(zch))';
    yr = (imag(zch))';

    xc1= tx*(sin(2*0.1*xr))+30;
    yc1= ty*(sin(2*0.1*yr))+20;
    zc1=xc1+yc1;   

    F = scatteredInterpolant(xr,yr,zc1);
    F.Method = 'natural';
    vq1 = F(x1,y1);

    subplot(2,1,2);

    plot3(xr,yr,zc1,'mo')
    hold on
    b= mesh(x1,y1,vq1); 
    zival = b.ZData;
    title('Nearest Neighbor')
    legend('Sample Points','Interpolated Surface','Location','NorthWest')
    colorbar

    abs_dy = abs(zival - Zval1) ;
    MeanSquaredError = mean(abs_dy.^2);
    mean_err= mean(MeanSquaredError);

  j=j+1;
    pause(0.0005)   
    clf reset
end 

