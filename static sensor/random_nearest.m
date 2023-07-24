clear all 
clc
j=2;
warning('off','all');

x = [0:1:50];
y= [0:1:50];

[x1,y1]=meshgrid(x,y);
while j>1
        subplot(2,1,1) 
    jtx=0.005*j;
     jty=0.004*j;       
     tx = sin(3.2*3.14*jtx)+1;
     ty = sin(0.2*3.14*jty)+1;

     %disp("gotin")
     xc=tx*(sin(2*0.1*(x1)))+30;
     yc=ty*sin(2*0.1*y1)+20;
     z1=xc+yc;
     a= surf(x1,y1,z1);
        colorbar
    Zval1 = a.ZData;

     
    xr =randi([1 50], 1000,1);
    yr = randi([1 50],1000,1);
    
    xc1=tx*(sin(2*0.1*xr))+30;
    yc1=ty*(sin(2*0.1*yr))+20;
    zc1=xc1+yc1;   
 
    
    
    F = scatteredInterpolant(xr,yr,zc1);
    F.Method = 'nearest';
    vq1 = F(x1,y1);    

    subplot(2,1,2);

    plot3(xr,yr,zc1,'mo')
    hold on
    b= mesh(x1,y1,vq1); 
    zival = b.ZData;
    title('Nearest Neighbour')
    legend('Sensor placements','Interpolated Surface','Location','NorthWest')
    colorbar
    
    j=j+1;
    pause(0.05)
    clf reset
   
    end 




