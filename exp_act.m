function [xag,yag,r] = exp_act(xag,yag)
global explored_points;
global total_points;global xmax;global xmin;global ymax;global ymin
global iteration;global rewards;global max_exp;
max_exp=0;
if size(explored_points,1)==size(total_points,1)
    r=rewards(5);
    return;
end

[not_explored,indx_2d_mat] = setdiff(total_points,explored_points,'rows');
not_explored_dist = not_explored-[xag,yag];
sum_dist_xy=sum(abs(not_explored_dist),2);
not_explored_dist_except_z=not_explored_dist;
%=============================================

%=============================================
dist_min_idx=find(sum_dist_xy==min(sum_dist_xy));

% dist_min_idx=find(sum_dist_except_zero==min(sum_dist_except_zero));
if (any(dist_min_idx>0))
    dist_min_idx_rand=dist_min_idx(randi(size(dist_min_idx')));
    if not_explored_dist_except_z(dist_min_idx_rand,1)==0 || not_explored_dist_except_z(dist_min_idx_rand,2)==0
        if not_explored_dist_except_z(dist_min_idx_rand,1)~=0&&abs(not_explored_dist_except_z(dist_min_idx_rand,1)+xag)>=(xmin)&&abs(not_explored_dist_except_z(dist_min_idx_rand,1)+xag)<=(xmax)
            xag=xag+round(not_explored_dist_except_z(dist_min_idx_rand,1)/abs(not_explored_dist_except_z(dist_min_idx_rand,1)));
            r=rewards(2);
        elseif not_explored_dist_except_z(dist_min_idx_rand,2)~=0&&abs(not_explored_dist_except_z(dist_min_idx_rand,2)+yag)>=(ymin)&&abs(not_explored_dist_except_z(dist_min_idx_rand,2)+yag)<=(ymax)
            yag=round(yag+not_explored_dist_except_z(dist_min_idx_rand,2)/abs(not_explored_dist_except_z(dist_min_idx_rand,2)));
            r=rewards(2);
%         elseif not_explored_dist_except_z(dist_min_idx_rand,1)==not_explored_dist_except_z(dist_min_idx_rand,2)&&not_explored_dist_except_z(dist_min_idx_rand,2)==0
%             r=rewards(3);
%             return;
%         else
%             r=rewards(3);
        end
    elseif abs(not_explored_dist_except_z(dist_min_idx_rand,1))==abs(not_explored_dist_except_z(dist_min_idx_rand,2))&&not_explored_dist_except_z(dist_min_idx_rand,2)~=0&&abs(round(xag+not_explored_dist_except_z(dist_min_idx_rand,1)/abs(not_explored_dist_except_z(dist_min_idx_rand,1))))>=(xmin)&&abs(round(xag+not_explored_dist_except_z(dist_min_idx_rand,1)/abs(not_explored_dist_except_z(dist_min_idx_rand,1))))<=(xmax)
        xag=xag+round(not_explored_dist_except_z(dist_min_idx_rand,1)/abs(not_explored_dist_except_z(dist_min_idx_rand,1)));
        r=rewards(2);
        %         yag=yag+not_explored_dist(dist_min_idx_rand,2);
    elseif abs(not_explored_dist_except_z(dist_min_idx_rand,1))>abs(not_explored_dist_except_z(dist_min_idx_rand,2))&&not_explored_dist_except_z(dist_min_idx_rand,1)~=0
        if abs(xag+not_explored_dist_except_z(dist_min_idx_rand,1)/abs(not_explored_dist_except_z(dist_min_idx_rand,1)))>=(xmin)&&abs(xag+not_explored_dist_except_z(dist_min_idx_rand,1)/abs(not_explored_dist_except_z(dist_min_idx_rand,1)))<=(xmax)
            xag=xag+round(not_explored_dist_except_z(dist_min_idx_rand,1)/abs(not_explored_dist_except_z(dist_min_idx_rand,1)));
            r=rewards(2);
%         else
%             r=rewards(3);
        end
    elseif abs(not_explored_dist_except_z(dist_min_idx_rand,1))<abs(not_explored_dist_except_z(dist_min_idx_rand,2))&&not_explored_dist_except_z(dist_min_idx_rand,2)~=0
        if abs(yag+not_explored_dist_except_z(dist_min_idx_rand,2)/abs(not_explored_dist_except_z(dist_min_idx_rand,2)))>=ymin&&abs(yag+not_explored_dist_except_z(dist_min_idx_rand,2)/abs(not_explored_dist_except_z(dist_min_idx_rand,2)))<=ymax
            yag=yag+round(not_explored_dist_except_z(dist_min_idx_rand,2)/abs(not_explored_dist_except_z(dist_min_idx_rand,2)));
            r=rewards(2);
%         else
%             r=rewards(3);
        end
%      else
%          r=rewards(3);
    end
else
    r=rewards(2);

%     return;
end
xag=min(xmax,xag);yag=min(ymax,yag);
xag=max(xmin,xag);yag=max(ymin,yag);
xag=abs(xag);yag=abs(yag);
end
