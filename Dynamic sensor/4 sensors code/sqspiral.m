
clear all 
close all
clc
warning('off','all');

prev=[];
x1fin=[];
y1fin=[];
error1=[];
xdata=[];
ydata=[];
data=[];

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
                     figure
                    [xmesh,ymesh]=meshgrid(x1fin,y1fin);
                    prevmesh=meshgrid(prev);                   
                    surf(xmesh,ymesh,prev)
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
                           
            %drone1 points
                xr =[i;i;i+2;i+2];
                yr = [k-2;k;k;k-2];
                [xc1,yc1]= calc(xr,yr,time);
                zc1=xc1+yc1;   
                F = scatfunc(xr,yr,timevariable,zc1);
                vq1 = F(x1,y1,timecor1);    
                prev=cat(2,prev,vq1);

            
            %plots
            
            %surface printing
                subplot(3,1,1) %subplot surface
                
                a= surf(x1,y1,z1);
                hold on 
                colorbar
                axis([0 50 0 50])
                Zval1 = a.ZData;
                xdata=a.XData;
                ydata=a.YData;
                data=a.ZData;
                
            
                subplot(3,1,2); %subplot points

                plot3(xr,yr,zc1,'mo')
                axis([0 50 0 50])
                hold on
                b= mesh(x1,y1,vq1);

                title('Nearest Neighbour')
                colorbar
                zival1 = b.ZData;

                subplot(3,1,3);  %subplot final
                
                mesh(x1fin,y1fin,prev)
                hold on
                axis([0 50 0 50])

                
                colorbar
            %error calculations
                error1(time)= mean(mean((abs(zival1 - Zval1)).^2));

        time=time+1;
        pause(-1)
        clf reset
        end 
      flag=1;
      vi=vi-2;
      elseif(flag==1)
      for i=hi1:2:hi               
              if(hi1==26||vi1==26)
                    disp("loop2")
                     figure
                    [xmesh,ymesh]=meshgrid(x1fin,y1fin);
                    prevmesh=meshgrid(prev);            
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
            pause(-1)
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
                
                
                
                title('Interpolated surface')
                colorbar              
                
                zival1 = b.ZData;
                
                subplot(3,1,2); %subplot final

                mesh(x1fin,y1fin,prev)
                hold on 
                axis([0 50 0 50])
                colorbar
                title("Linear Interpolation")
                
                subplot(3,1,3); %subplot final

                mesh(x1fin,y1fin,prev)
                hold on 
                axis([0 50 0 50])
                colorbar
                title("Trajectory of Movement")
                
                

                
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
         F=scatteredInterpolant(xr,yr,timevariable,zc1,'linear');
end       

    