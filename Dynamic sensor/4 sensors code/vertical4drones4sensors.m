
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

    while time>0
      if(flag==0)
        for k=2:2:50 
            if(i==14)
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
                xdd1=[(i+12):1:(i+14)];
                ydd1=[(k-2):1:k];
                [xd1,yd1]=meshgrid(xdd1,ydd1);
                x1find= cat(2,x1find,xd1);
                y1find= cat(2,y1find,yd1);
                [xdc,ydc]= calc(xd1,yd1,time);
                zd1=xdc+ydc;
             
             %drone 3 mesh
                xdd2=[(i+24):1:(i+26)];
                ydd2=[(k-2):1:k];
                [xd2,yd2]=meshgrid(xdd2,ydd2);
                x2find= cat(2,x2find,xd2);
                y2find= cat(2,y2find,yd2);
                [xdc2,ydc2]= calc(xd2,yd2,time);
                zd2=xdc2+ydc2; 
            %drone 4 mesh
                xdd3=[(i+36):1:(i+38)];
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
            
                xdr =[i+12;i+12;i+14;i+14];
                ydr = [k-2;k;k;k-2];
                [xcd1,ycd1]= calc(xdr,ydr,time);
                zcd1=xcd1+ycd1;             
                fF = scatfunc(xdr,ydr,timevariable,zcd1);
                vdq1 = fF(xd1,yd1,timecor1);    
                prevd=cat(2,prevd,vdq1);
             
            %drone 3 points
            
                xdr1 =[i+24;i+24;i+26;i+26];
                ydr1 = [k-2;k;k;k-2];
                [xcd2,ycd2]= calc(xdr1,ydr1,time);
                zcd2=xcd2+ycd2;             
                fF2 = scatfunc(xdr1,ydr1,timevariable,zcd2);
                vdq2 = fF2(xd2,yd2,timecor1);    
                prevd2=cat(2,prevd2,vdq2);
           
           %drone 4 points
            
                xdr2 =[i+36;i+36;i+38;i+38];
                ydr2 = [k-2;k;k;k-2];
                [xcd3,ycd3]= calc(xdr2,ydr2,time);
                zcd3=xcd3+ycd3;             
                fF3 = scatfunc(xdr2,ydr2,timevariable,zcd3);
                vdq3 = fF3(xd3,yd3,timecor1);    
                prevd3=cat(2,prevd3,vdq3);
           
            %plots
            
            %surface printing
                subplot(3,1,1) %subplot surface
                
                a= surf(x1,y1,z1);
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
                error2(time)= mean(mean((abs(zival2 - Zval2)).^2));
                error3(time)= mean(mean((abs(zival3 - Zval3)).^2));
                error4(time)= mean(mean((abs(zival4 - Zval4)).^2));
       
        time=time+1;
        pause(0)
        clf reset
        end 
      flag=1;
      i=i+2;
     else
          for k=50:-2:0  
              if(i==14)
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

            %drone 2 mesh
                xdd1=[(i+12):1:(i+14)];
                ydd1=[(k-2):1:k];
                [xd1,yd1]=meshgrid(xdd1,ydd1);
                x1find= cat(2,x1find,xd1);
                y1find= cat(2,y1find,yd1);
                [xdc,ydc]= calc(xd1,yd1,time);
                zd1=xdc+ydc;
             
             %drone 3 mesh
                xdd2=[(i+24):1:(i+26)];
                ydd2=[(k-2):1:k];
                [xd2,yd2]=meshgrid(xdd2,ydd2);
                x2find= cat(2,x2find,xd2);
                y2find= cat(2,y2find,yd2);
                [xdc2,ydc2]= calc(xd2,yd2,time);
                zd2=xdc2+ydc2; 
            %drone 4 mesh
                xdd3=[(i+36):1:(i+38)];
                ydd3=[(k-2):1:k];
                [xd3,yd3]=meshgrid(xdd3,ydd3);
                x3find= cat(2,x3find,xd3);
                y3find= cat(2,y3find,yd3);
                [xdc3,ydc3]= calc(xd3,yd3,time);
                zd3=xdc3+ydc3;
                

            %declaring data points

            %drone1 points
                xr =[i;i;i+2;i+2];
                yr = [k-2;k;k;k-2];
                [xc1,yc1]= calc(xr,yr,time);
                zc1=xc1+yc1;   
                F = scatfunc(xr,yr,timevariable,zc1);
                vq1 = F(x1,y1,timecor1);    
                prev=cat(2,prev,vq1);
            %drone 2 points          
                xdr =[i+12;i+12;i+14;i+14];
                ydr = [k-2;k;k;k-2];
                [xcd1,ycd1]= calc(xdr,ydr,time);
                zcd1=xcd1+ycd1;             
                fF = scatfunc(xdr,ydr,timevariable,zcd1);
                vdq1 = fF(xd1,yd1,timecor1);    
                prevd=cat(2,prevd,vdq1);             
            %drone 3 points            
                xdr1 =[i+24;i+24;i+26;i+26];
                ydr1 = [k-2;k;k;k-2];
                [xcd2,ycd2]= calc(xdr1,ydr1,time);
                zcd2=xcd2+ycd2;             
                fF2 = scatfunc(xdr1,ydr1,timevariable,zcd2);
                vdq2 = fF2(xd2,yd2,timecor1);    
                prevd2=cat(2,prevd2,vdq2);           
           %drone 4 points            
                xdr2 =[i+36;i+36;i+38;i+38];
                ydr2 = [k-2;k;k;k-2];
                [xcd3,ycd3]= calc(xdr2,ydr2,time);
                zcd3=xcd3+ycd3;             
                fF3 = scatfunc(xdr2,ydr2,timevariable,zcd3);
                vdq3 = fF3(xd3,yd3,timecor1);    
                prevd3=cat(2,prevd3,vdq3);

            %plots
            %surface plotting
            
                subplot(3,1,1) %subplot surface
              
                a= surf(x1,y1,z1);
                hold on 
                a1= surf(xd1,yd1,zd1);
                a2=surf(xd2,yd2,zd2);
                a3=surf(xd3,yd3,zd3);
                colorbar
                axis([0 50 0 50])
                Zval1 = a.ZData;
                Zval2= a1.ZData;
                Zval3= a2.ZData;
                Zval4= a3.ZData;
               
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
                axis([0 50 0 50])
                mesh(x3find,y3find,prevd3)
                axis([0 50 0 50])
                colorbar
                
            %error calculations
                
                error1(time)= mean(mean((abs(zival1 - Zval1)).^2));
                error2(time)= mean(mean((abs(zival2 - Zval2)).^2));
                error3(time)= mean(mean((abs(zival3 - Zval3)).^2));
                error4(time)= mean(mean((abs(zival4 - Zval4)).^2));

            time=time+1;
            pause(0)
            clf reset
     end
        flag=0;
        i=i+2;
      end %if else end
      
    end
    print("heya")

function [d1,d2] = calc(x,y,time)
            jtx=0.005*time;
            jty=0.004*time;    
            d1=(sin(3.2*3.14*jtx)+1)*(sin(2*0.1*x))+30;    
            d2=(sin(0.2*3.14*jty)+1)*sin(2*0.1*y)+20;
            
end
 
function F=scatfunc(xr,yr,timevariable,zc1)
         F=scatteredInterpolant(xr,yr,timevariable,zc1,'linear');
end       
    