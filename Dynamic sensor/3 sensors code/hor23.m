
clear all 
close all
clc
warning('off','all');

prev=[];
x1fin=[];
y1fin=[];
prevd=[];
x1find=[];
y1find=[];
error1=[];
error2=[];
i=0;
k=2;
flag=0;
time=1;

    while time>0
      if(flag==0)
        for i=0:2:50 
            if(k==30)
                finerrd1=mean(error1);
                finerrd2=mean(error2);
                
                finalerror=mean(finerrd1+finerrd2);
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
                xdd1=[(i-2):1:(i)];
                ydd1=[(k+30):1:k+32];
                [xd1,yd1]=meshgrid(xdd1,ydd1);
                x1find= cat(2,x1find,xd1);
                y1find= cat(2,y1find,yd1);
                [xdc,ydc]= calc(xd1,yd1,time);
                zdc=xdc+ydc;
                
            %declaring data points
            
                timevariable=([0:1:3])';
                timecor = 0:1:2;
                [timecor1] = meshgrid(timecor);
                
            %drone1 points
                xr =[i;i+1;i+2];
                yr = [k-2;k;k-2];
                [xc1,yc1]= calc(xr,yr,time);
                zc1=xc1+yc1;   
                F = scatfunc(xr,yr,zc1);
                vq1 = F(x1,y1);    
                prev=cat(2,prev,vq1);

            %drone 2 points
                
                xdr = [i-2;i;i-2];
                ydr =[k+30;k+31;k+32];
                [xcd1,ycd1]= calc(xdr,ydr,time);
                zcd1=xcd1+ycd1;             
                fF = scatfunc(xdr,ydr,zcd1);
                vdq1 = fF(xd1,yd1);    
                prevd=cat(2,prevd,vdq1);
           
            %plots
            
            %surface printing
                subplot(3,1,1) %subplot surface
                
                a= surf(x1,y1,z1);
                hold on 
                a1=surf(xd1,yd1,zdc);
                colorbar
                axis([0 50 0 50])
                Zval1 = a.ZData;
                Zval2= a1.ZData;
            
                subplot(3,1,2); %subplot points

                plot3(xr,yr,zc1,'mo')
                axis([0 50 0 50])
                hold on
                b= mesh(x1,y1,vq1);

                plot3(xdr,ydr,zcd1,'mo')
                axis([0 50 0 50])
                hold on
                b1=mesh(xd1,yd1,vdq1); 
            
                title('Nearest Neighbour')
                colorbar
                zival1 = b.ZData;
                zival2 = b1.ZData;

                subplot(3,1,3);  %subplot final
                
                mesh(x1fin,y1fin,prev)
                hold on 
                mesh(x1find,y1find,prevd)
                axis([0 50 0 50])
                colorbar
            %error calculations
                error1(time)= mean(mean((abs(zival1 - Zval1)).^2));
                error2(time)= mean(mean((abs(zival2 - Zval2)).^2));

        time=time+1;
        pause(-1)
        clf reset
        end 
      flag=1;
      k=k+2;
     else
          for i=50:-2:0  
              if(k==30)
                  finerrd1=mean(error1);
                finerrd2=mean(error2);
               
                finalerror=mean(finerrd1+finerrd2);
                  return
              end
              
            %Drone1 mesh
              
                x=[i:1:i+2];
                y=[k-2:1:k];
                [x1,y1]=meshgrid(x,y);
                x1fin= cat(2,x1fin,x1);
                y1fin= cat(2,y1fin,y1);
                subplot(3,1,1) 
                [xc,yc]= calc(x1,y1,time);
                z1=xc+yc;

            %Drone2 mesh
                ydd1=[(k+30):1:(k+32)];
                xdd1=[(i-2):1:i];
                [xd1,yd1]=meshgrid(xdd1,ydd1);
                x1find= cat(2,x1find,xd1);
                y1find= cat(2,y1find,yd1);
                [xdc,ydc]= calc(xd1,yd1,time);
                zdc=xdc+ydc;

            %declaring data points

            %drone1 points
                xr =[i;i+1;i+2];
                yr = [k-2;k;k-2];
                [xc1,yc1]= calc(xr,yr,time);
                zc1=xc1+yc1;   
                F = scatfunc(xr,yr,zc1);
                vq1 = F(x1,y1);    
                prev=cat(2,prev,vq1);
                
            %drone 2 points
                ydr =[k+30;k+31;k+32];
                xdr = [i-2;i;i-2];
                [xcd1,ycd1]= calc(xdr,ydr,time);
                zcd1=xcd1+ycd1;   
                fF = scatfunc(xdr,ydr,zcd1);
                vdq1 = fF(xd1,yd1);    
                prevd=cat(2,prevd,vdq1);

            %plots
            %surface plotting
            
                subplot(3,1,1) %subplot surface
                
                [xdc,ydc]= calc(xd1,yd1,time);
                zdc=xdc+ydc;
                a= surf(x1,y1,z1);
                hold on 
                a1= surf(xd1,yd1,zdc);
                colorbar
                axis([0 50 0 50])
                Zval1 = a.ZData;
                Zval2= a1.ZData;
               
                subplot(3,1,2); %subplot points
               
                %drone 1 data
                plot3(xr,yr,zc1,'mo')
                axis([0 50 0 50])
                hold on
                b= mesh(x1,y1,vq1); 
                
                %drone 2 data
                plot3(xdr,ydr,zcd1,'mo')
                axis([0 50 0 50])
                hold on
                b1=mesh(xd1,yd1,vdq1); 
                
                title('Nearest Neighbour')
                colorbar              
                
                zival1 = b.ZData;
                zival2 = b1.ZData;
                
                subplot(3,1,3); %subplot final

                mesh(x1fin,y1fin,prev)
                hold on 
                mesh(x1find,y1find,prevd)
                axis([0 50 0 50])
                colorbar
                
    %error calculations             
                error1(time)= mean(mean((abs(zival1 - Zval1)).^2));
                error2(time)= mean(mean((abs(zival2 - Zval2)).^2));
               
            time=time+1;
            pause(-1)
            clf reset
     end
        flag=0;
        k=k+2;
      end %if else end
      
    end
    
function [d1,d2] = calc(x,y,time)
            jtx=0.005*time;
            jty=0.004*time;    
            d1=(sin(3.2*3.14*jtx)+1)*(sin(2*0.1*x))+30;    
            d2=(sin(0.2*3.14*jty)+1)*sin(2*0.1*y)+20;
            
end
 
function F=scatfunc(xr,yr,zc1)
         F=scatteredInterpolant(xr,yr,zc1,'nearest');
end       

    