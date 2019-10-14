function [xf1,yf1,xf2,yf2] = fish_rand_mov(FishActions,xf1,xf2,yf1,yf2)
global xmin;global xmax;global ymin;global ymax;
fa1=randi(FishActions);
fa2=randi(FishActions);
if(fa1==1)
    yf1=yf1+1;
elseif(fa1==2)
    xf1=xf1+1;
elseif(fa1==3)
    yf1=yf1-1;
elseif(fa1==4)
    xf1=xf1-1;
elseif(fa1==5)
    xf1=xf1;
    yf1=yf1;
end

if(fa2==1)
    yf2=yf2+1;
elseif(fa2==2)
    xf2=xf2+1;
elseif(fa2==3)
    yf2=yf2-1;
elseif(fa2==4)
    xf2=xf2-1;
elseif(fa2==5)
    xf2=xf2;
    yf2=yf2;
end

xf1=min(xmax,xf1);xf2=min(xmax,xf2);yf1=min(ymax,yf1);yf2=min(ymax,yf2);
xf1=max(xmin,xf1);xf2=max(xmin,xf2);yf1=max(ymin,yf1);yf2=max(ymin,yf2);

end

