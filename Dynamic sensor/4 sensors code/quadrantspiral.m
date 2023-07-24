
clear all 
close all
clc
warning('off','all');

prev=[];
x1fin=[];
y1fin=[];

xdata=[];
ydata=[];
zdata=[];

xdata1=[];
ydata1=[];
zdata1=[];

xdata2=[];
ydata2=[];
zdata2=[];

xdata3=[];
ydata3=[];
zdata3=[];

prevd=[];
x1find=[];
y1find=[];

prevd2=[];
x2find=[];
y2find=[];

prevd3=[];
x3find=[];
y3find=[];

error1=[];
error2=[];
error3=[];
error4=[];



i=0;
k=2;
flag=0;
time=1;
vi=50;
hi=50;
vi1=2;
hi1=2;

    while time>0
      if(flag==0)
        for k=vi1:2:vi 
                       
                timevariable=([0:1:3])';
                timecor = 0:1:2;
                [timecor1] = meshgrid(timecor);
                if(hi1==26||vi1==26)
                    disp("loop1")
                    return
                end
           %Drone1 mesh 
            
                x=[i:1:i+2];
                y=[k-2:1:k];
                [x1,y1]=meshgrid(x,y);
                x1fin= cat(2,x1fin,x1);
                y1fin= cat(2,y1fin,y1);
                [xc,yc]= calc(x1,y1,time);
                z1=xc+yc;             
                
             %drone 2 mesh
                xdd1=[i:1:(i+2)];
                ydd1=[(k+24):1:(k+26)];
                [xd1,yd1]=meshgrid(xdd1,ydd1);
                x1find= cat(2,x1find,xd1);
                y1find= cat(2,y1find,yd1);
                [xdc,ydc]= calc(xd1,yd1,time);
                zd1=xdc+ydc;
             
             %drone 3 mesh
                xdd2=[(i+24):1:(i+26)];
                ydd2=[(k+24):1:k+26];
                [xd2,yd2]=meshgrid(xdd2,ydd2);
                x2find= cat(2,x2find,xd2);
                y2find= cat(2,y2find,yd2);
                [xdc2,ydc2]= calc(xd2,yd2,time);
                zd2=xdc2+ydc2; 
            %drone 4 mesh
                xdd3=[(i+24):1:(i+26)];
                ydd3=[(k-2):1:k];
                [xd3,yd3]=meshgrid(xdd3,ydd3);
                x3find= cat(2,x3find,xd3);
                y3find= cat(2,y3find,yd3);
                [xdc3,ydc3]= calc(xd3,yd3,time);
                zd3=xdc3+ydc3;
            
                
            %declaring data points
            
                timevariable=([0:1:3])';
                timecor = 0:1:2;
                [timecor1] = meshgrid(timecor);
                
            %drone1 points
                xr =[i;i;i+2;i+2];
                yr = [k-2;k;k;k-2];
                [xc1,yc1]= calc(xr,yr,time);
                zc1=xc1+yc1;   
                F = scatfunc(xr,yr,timevariable,zc1);
                vq1 = F(x1,y1,timecor1);    
                prev=cat(2,prev,vq1);

            %drone 2 points
            
                xdr =[i;i;i+2;i+2];
                ydr = [k+24;k+26;k+26;k+24];
                [xcd1,ycd1]= calc(xdr,ydr,time);
                zcd1=xcd1+ycd1;             
                fF = scatfunc(xdr,ydr,timevariable,zcd1);
                vdq1 = fF(xd1,yd1,timecor1);    
                prevd=cat(2,prevd,vdq1);
%              
            %drone 3 points
            
                xdr1 =[i+24;i+24;i+26;i+26];
                ydr1 = [k+24;k+26;k+26;k+24];
                [xcd2,ycd2]= calc(xdr1,ydr1,time);
                zcd2=xcd2+ycd2;             
                fF2 = scatfunc(xdr1,ydr1,timevariable,zcd2);
                vdq2 = fF2(xd2,yd2,timecor1);    
                prevd2=cat(2,prevd2,vdq2);
           
           %drone 4 points
            
                xdr2 =[i+24;i+24;i+26;i+26];
                ydr2 = [k-2;k;k;k-2];
                [xcd3,ycd3]= calc(xdr2,ydr2,time);
                zcd3=xcd3+ycd3;             
                fF3 = scatfunc(xdr2,ydr2,timevariable,zcd3);
                vdq3 = fF3(xd3,yd3,timecor1);    
                prevd3=cat(2,prevd3,vdq3);
            %plots
            
             %plots
            
            %surface printing
                subplot(3,1,1) %subplot surface
                
                a= surf(x1,y1,z1);
                xdata= cat(2,xdata,a);
                
                hold on
                a1=surf(xd1,yd1,zd1);
                a2=surf(xd2,yd2,zd2);                
                a3=surf(xd3,yd3,zd3);
                colorbar
                axis([0 50 0 50])
                Zval1 = a.ZData;
                Zval2= a1.ZData;
                Zval3= a2.ZData;
                Zval4= a3.ZData;
                
                subplot(3,1,2); %subplot points

                plot3(xr,yr,zc1,'mo')
                axis([0 50 0 50])
                hold on
                b= mesh(x1,y1,vq1);

                %drone2 
                plot3(xdr,ydr,zcd1,'mo')
                axis([0 50 0 50])
                hold on
                b1=mesh(xd1,yd1,vdq1); 
                
                %drone3
                plot3(xdr1,ydr1,zcd2,'mo')
                axis([0 50 0 50])
                hold on
                b2=mesh(xd2,yd2,vdq2); 
                
                %drone4
                plot3(xdr2,ydr2,zcd3,'mo')
                axis([0 50 0 50])
                hold on
                b3=mesh(xd3,yd3,vdq3);                 
            
                title('Nearest Neighbour')
                legend('Sensor placements','Interpolated Surface','Location','NorthWest')
                colorbar
                zival1 = b.ZData;
                zival2 = b1.ZData;
                zival3 = b2.ZData;
                zival4 = b3.ZData;
                
                subplot(3,1,3);  %subplot final
                
                mesh(x1fin,y1fin,prev)
                hold on 
                mesh(x1find,y1find,prevd)
                hold on
                mesh(x2find,y2find,prevd2)
                hold on
                mesh(x3find,y3find,prevd3)
                axis([0 50 0 50])
                colorbar
            %error calculations
                error1(time)= mean(mean((abs(zival1 - Zval1)).^2));

        time=time+1;
        pause(0)
        clf reset
        end 
      flag=1;
      vi=vi-2;
      elseif(flag==1)
      for i=hi1:2:hi               
              if(hi1==26||vi1==26)
                    disp("loop2")
                  return
                end
            %Drone1 mesh
              
                x=[i-2:1:i];
                y=[k-2:1:k];
                [x1,y1]=meshgrid(x,y);
                x1fin= cat(2,x1fin,x1);
                y1fin= cat(2,y1fin,y1);
                subplot(3,1,1) 
                [xc,yc]= calc(x1,y1,time);
                z1=xc+yc;

           
            %declaring data points

            %drone1 points
                xr =[i-2;i-2;i;i];
                yr = [k-2;k;k;k-2];
                [xc1,yc1]= calc(xr,yr,time);
                zc1=xc1+yc1;   
                F = scatfunc(xr,yr,timevariable,zc1);
                vq1 = F(x1,y1,timecor1);    
                prev=cat(2,prev,vq1);


            %plots
            %surface plotting
            
                subplot(3,1,1) %subplot surface
                a= surf(x1,y1,z1);
                hold on 
               
                colorbar
                axis([0 50 0 50])
                
                subplot(3,1,2); %subplot points
               
                %drone 1 data
                plot3(xr,yr,zc1,'mo')
                axis([0 50 0 50])
                hold on
                b= mesh(x1,y1,vq1); 
                
                
                
                title('Nearest Neighbour')
                colorbar              
                
                zival1 = b.ZData;
                
                subplot(3,1,3); %subplot final

                mesh(x1fin,y1fin,prev)
                axis([0 50 0 50])

                hold on 
              
                colorbar
                
    %error calculations             
                error1(time)= mean(mean((abs(zival1 - Zval1)).^2));
               
            time=time+1;
            pause(0)
            clf reset
     end
        flag=2;
        hi=hi-2;
      elseif (flag==2)
    for k=vi:-2:vi1  
              if(hi1==26||vi1==26)
                    disp("loop3")
                    figure
                    [xmesh,ymesh]=meshgrid(x1fin,y1fin);
                    prevmesh= meshgrid(prev)              
                    surf(xmesh,ymesh,prevmesh)
                    return
                end
              
            %Drone1 mesh
              
                x=[i-2:1:i];
                y=[k-2:1:k];
                [x1,y1]=meshgrid(x,y);
                x1fin= cat(2,x1fin,x1);
                y1fin= cat(2,y1fin,y1);
                subplot(3,1,1) 
                [xc,yc]= calc(x1,y1,time);
                z1=xc+yc;


            %declaring data points

            %drone1 points
                xr =[i-2;i-2;i;i];
                yr = [k-2;k;k;k-2];
                [xc1,yc1]= calc(xr,yr,time);
                zc1=xc1+yc1;   
                F = scatfunc(xr,yr,timevariable,zc1);
                vq1 = F(x1,y1,timecor1);    
                prev=cat(2,prev,vq1);

            %plots
            %surface plotting
            
                subplot(3,1,1) %subplot surface
                
                a= surf(x1,y1,z1);
                hold on 
                
                axis([0 50 0 50])
                Zval1 = a.ZData;
               
                subplot(3,1,2); %subplot points
               
                %drone 1 data
                plot3(xr,yr,zc1,'mo')
                axis([0 50 0 50])
                hold on
                b= mesh(x1,y1,vq1); 
                
                
                title('Nearest Neighbour')
                colorbar              
                
                zival1 = b.ZData;
                
                subplot(3,1,3); %subplot final

                mesh(x1fin,y1fin,prev)
                hold on 
                colorbar
                
    %error calculations             
                error1(time)= mean(mean((abs(zival1 - Zval1)).^2));
               
            time=time+1;
            pause(0)
            clf reset
                end
     flag=3;
     vi1=vi1+2;
      elseif(flag==3)
    for i=hi:-2:hi1  
                 if(hi1==26||vi1==26)
                    disp("loop4")
                   return
                 end   
              %Drone1 mesh
              
                x=[i-2:1:i];
                y=[k-2:1:k];
                [x1,y1]=meshgrid(x,y);
                x1fin= cat(2,x1fin,x1);
                y1fin= cat(2,y1fin,y1);
                subplot(3,1,1) 
                [xc,yc]= calc(x1,y1,time);
                z1=xc+yc;


            %declaring data points

            %drone1 points
                xr =[i-2;i-2;i;i];
                yr = [k-2;k;k;k-2];
                [xc1,yc1]= calc(xr,yr,time);
                zc1=xc1+yc1;   
                F = scatfunc(xr,yr,timevariable,zc1);
                vq1 = F(x1,y1,timecor1);    
                prev=cat(2,prev,vq1);


            %plots
            %surface plotting
            
%                 subplot(3,1,1) %subplot surface
%                                 
%                 a= surf(x1,y1,z1);
%                 hold on 
%                 colorbar
%                 axis([0 50 0 50])
%                 Zval1 = a.ZData;
               
                subplot(3,1,1); %subplot points
               
                %drone 1 data
                plot3(xr,yr,zc1,'mo')
                axis([0 50 0 50])
                hold on
                b= mesh(x1,y1,vq1);
                title('Interpolated Surface')
                colorbar              
                
                zival1 = b.ZData;
                subplot(3,1,2); %subplot final

                mesh(x1fin,y1fin,prev)
                hold on 
                axis([0 50 0 50])
                colorbar
                title("Natural Neighbour Interpolation")

                
                subplot(3,1,3); %subplot final

                mesh(x1fin,y1fin,prev)
                hold on 
                axis([0 50 0 50])
                colorbar
                title("Trajectory of drone")
                
    %error calculations             
%                 error1(time)= mean(mean((abs(zival1 - Zval1)).^2));
               
            time=time+1;
            
                pause(10)
            
                clf reset
     end

    flag=0;
    hi1=hi1+2;  

      end %if else end
      
    end
    
function [d1,d2] = calc(x,y,time)
            jtx=0.005*time;
            jty=0.004*time;    
            d1=(sin(3.2*3.14*jtx)+1)*(sin(2*0.1*x))+30;    
            d2=(sin(0.2*3.14*jty)+1)*sin(2*0.1*y)+20;
            
end
 
function F=scatfunc(xr,yr,timevariable,zc1)
         F=scatteredInterpolant(xr,yr,timevariable,zc1,'natural');
end       

    