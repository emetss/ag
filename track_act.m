function [xag,yag,r] = track_act(xag,yag,xf,yf,ag_v_rng)

global rewards;global xmax;global xmin;global ymax;global ymin;
% global xf1;global yf1;global xf2;global yf2;
[~,findx]=ismember(ag_v_rng,[xf,yf],'rows');
if ~any(findx)
    r=rewards(2);
    return;
else
%     xfish=-99;
%     yfish=-99;

% else
%     xfish=xf;
%     yfish=yf;
    switch find(findx)
        case 1
            xag=xag+1;
            r=rewards(2);
        case 2
            yag=yag+1;
            r=rewards(2);
        case 3
            xag=xag+1;
            r=rewards(2);
        case 4
            xag=xag-1;
            r=rewards(2);
        case 5
            yag=yag-1;
            r=rewards(2);
        case 6
            yag=yag-1;
            r=rewards(2);
        case 7
            xag=xag+1;
            r=rewards(2);
        case 8
            yag=yag+1;
            r=rewards(2);
        case 9
            yag=yag-1;
            r=rewards(2);
        case 10
            xag=xag-1;
            r=rewards(2);
        case 11
            yag=yag-1;
            r=rewards(2);
        case 12
            xag=xag-1;
            r=rewards(2);
        otherwise
            r=rewards(2);
    end
xag=abs(xag);yag=abs(yag);
xag=min(xmax,xag);yag=min(ymax,yag);
xag=max(xmin,xag);yag=max(ymin,yag);

end
end