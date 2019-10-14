function [xag,yag,r] = move_act(xag,yag,targets,targets_pos,xag_total,yag_total,xf1,yf1,xf2,yf2)
global plant1_smp_flag;global plant2_smp_flag;global plant3_smp_flag;
global trash1_flag;global trash2_flag;global trash3_flag;
        ag_v_rng{1}=[[xag_total(1)+1,yag_total(1)];[xag_total(1),yag_total(1)+1];[xag_total(1)+1,yag_total(1)+1];[xag_total(1)-1,yag_total(1)];[xag_total(1),yag_total(1)-1];[xag_total(1)-1,yag_total(1)-1];[xag_total(1)+2,yag_total(1)];[xag_total(1),yag_total(1)+2];[xag_total(1),yag_total(1)-2];[xag_total(1)-2,yag_total(1)];[xag_total(1)+1,yag_total(1)-1];[xag_total(1)-1,yag_total(1)+1]];
        ag_v_rng{2}=[[xag_total(2)+1,yag_total(2)];[xag_total(2),yag_total(2)+1];[xag_total(2)+1,yag_total(2)+1];[xag_total(2)-1,yag_total(2)];[xag_total(2),yag_total(2)-1];[xag_total(2)-1,yag_total(2)-1];[xag_total(2)+2,yag_total(2)];[xag_total(2),yag_total(2)+2];[xag_total(2),yag_total(2)-2];[xag_total(2)-2,yag_total(2)];[xag_total(2)+1,yag_total(2)-1];[xag_total(2)-1,yag_total(2)+1]];
        ag_v_rng{3}=[[xag_total(3)+1,yag_total(3)];[xag_total(3),yag_total(3)+1];[xag_total(3)+1,yag_total(3)+1];[xag_total(3)-1,yag_total(3)];[xag_total(3),yag_total(3)-1];[xag_total(3)-1,yag_total(3)-1];[xag_total(3)+2,yag_total(3)];[xag_total(3),yag_total(3)+2];[xag_total(3),yag_total(3)-2];[xag_total(3)-2,yag_total(3)];[xag_total(3)+1,yag_total(3)-1];[xag_total(3)-1,yag_total(3)+1]];
        ag_v_rng{4}=[[xag_total(4)+1,yag_total(4)];[xag_total(4),yag_total(4)+1];[xag_total(4)+1,yag_total(4)+1];[xag_total(4)-1,yag_total(4)];[xag_total(4),yag_total(4)-1];[xag_total(4)-1,yag_total(4)-1];[xag_total(4)+2,yag_total(4)];[xag_total(4),yag_total(4)+2];[xag_total(4),yag_total(4)-2];[xag_total(4)-2,yag_total(4)];[xag_total(4)+1,yag_total(4)-1];[xag_total(4)-1,yag_total(4)+1]];
        
        [~,found1_fish1_indx]=ismember(ag_v_rng{1},[xf1,yf1],'rows');
        [~,found1_fish2_indx]=ismember(ag_v_rng{1},[xf2,yf2],'rows');
        [~,found2_fish1_indx]=ismember(ag_v_rng{2},[xf1,yf1],'rows');
        [~,found3_fish1_indx]=ismember(ag_v_rng{3},[xf1,yf1],'rows');
        [~,found4_fish1_indx]=ismember(ag_v_rng{4},[xf1,yf1],'rows');
        [~,found2_fish2_indx]=ismember(ag_v_rng{2},[xf2,yf2],'rows');
        [~,found3_fish2_indx]=ismember(ag_v_rng{3},[xf2,yf2],'rows');
        [~,found4_fish2_indx]=ismember(ag_v_rng{4},[xf2,yf2],'rows');
        anyFoundFish1=any(found1_fish1_indx)|any(found2_fish1_indx)|any(found3_fish1_indx)|any(found4_fish1_indx)|...
    ((xag_total(1)==xf1)&&(yag_total(1)==yf1))|((xag_total(2)==xf1)&&(yag_total(2)==yf1))|((xag_total(3)==xf1)&&(yag_total(3)==yf1))|((xag_total(4)==xf1)&&(yag_total(4)==yf1));
        anyFoundFish2=any(found1_fish2_indx)|any(found2_fish2_indx)|any(found3_fish2_indx)|any(found4_fish2_indx)|...
    ((xag_total(1)==xf2)&&(yag_total(1)==yf2))|((xag_total(2)==xf2)&&(yag_total(2)==yf2))|((xag_total(3)==xf2)&&(yag_total(3)==yf2))|((xag_total(4)==xf2)&&(yag_total(4)==yf2));
%=================================================================
global grid;global grid_matrix;
global xmax;global xmin;global ymax;global ymin;
global ship_l1_small_rec_counter;global ship_l2_small_rec_counter; global ship_s1_rec_counter;global ship_s2_rec_counter;
global ship_l1_rec_counter;global ship_l2_rec_counter;global plant1_rec_counter;global plant2_rec_counter;global plant3_rec_counter;

global targ1_fish1_x;global targ2_fish1_x;global targ3_fish1_x;global targ4_fish1_x;
global targ1_fish2_x;global targ2_fish2_x;global targ3_fish2_x;global targ4_fish2_x;
global targ1_fish1_y;global targ2_fish1_y;global targ3_fish1_y;global targ4_fish1_y;
global targ1_fish2_y;global targ2_fish2_y;global targ3_fish2_y;global targ4_fish2_y;
global rewards;
global fish1_rec_counter;global fish2_rec_counter;
global explored_points;global total_points;

targ_pos=[];

targ_fish1_pos_x=[abs(targ1_fish1_x),abs(targ2_fish1_x),abs(targ3_fish1_x),abs(targ4_fish1_x)];
targ_fish1_pos_y=[abs(targ1_fish1_y),abs(targ2_fish1_y),abs(targ3_fish1_y),abs(targ4_fish1_y)];

targ_fish2_pos_x=[abs(targ1_fish2_x),abs(targ2_fish2_x),abs(targ3_fish2_x),abs(targ4_fish2_x)];
targ_fish2_pos_y=[abs(targ1_fish2_y),abs(targ2_fish2_y),abs(targ3_fish2_y),abs(targ4_fish2_y)];

% if (~any(targets(1,:)))
%     r=rewards(3);
%     return;
% end


trgcount=0;trgcountfish1=0;trgcountfish2=0;
for trg=1:size(targets,2)
    if targets(trg)==1&&trg<8&&trgcount==0
        trgcount=trgcount+1;
        [xtarg, ytarg]=find(grid_matrix==grid(targets_pos(trg)));
        targ_pos(1,:)=[xtarg,ytarg];
        clear xtarg;clear ytarg;
        targ_pos=unique(targ_pos,'rows');
        
    elseif targets(trg)==1&&trg<8&&trgcount>0
        [xtarg, ytarg]=find(grid_matrix==grid(targets_pos(trg)));
        targ_pos(end+1,1:end)=[xtarg,ytarg];
        clear xtarg;clear ytarg;
        targ_pos=unique(targ_pos,'rows');
        
    elseif (size(targets_pos,2)==7)&&fish1_rec_counter<5&&trg==8&&targets(1,8)==1&&(any(find(targ_fish1_pos_x<99)))&&(any(find(targ_fish1_pos_y<99)))&&trgcount==0&&trgcountfish2==0
        trgcountfish1=trgcountfish1+1;
        targ_pos(1,:)=[min(targ_fish1_pos_x),min(targ_fish1_pos_y)];
        targ_pos=unique(targ_pos,'rows');
        
    elseif (size(targets_pos,2)==7)&&fish2_rec_counter<5&&trg==9&&targets(1,9)==1&&(any(find(targ_fish2_pos_x<99)))&&(any(find(targ_fish2_pos_y<99)))&&trgcountfish1==0&&trgcount==0
        trgcountfish2=trgcountfish2+1;
        targ_pos(1,:)=[min(abs(targ_fish2_pos_x)),min(abs(targ_fish2_pos_y))];
        targ_pos=unique(targ_pos,'rows');
    elseif (size(targets_pos,2)==7)&&fish1_rec_counter<5&&trg==8&&targets(1,8)==1&&(any(find(targ_fish1_pos_x<99)))&&(any(find(targ_fish1_pos_y<99)))&&(trgcountfish2>0||trgcount>0)
        targ_pos(end+1,1:end)=[min(targ_fish1_pos_x),min(targ_fish1_pos_y)];
        targ_pos=unique(targ_pos,'rows');
        
    elseif (size(targets_pos,2)==7)&&fish2_rec_counter<5&&trg==9&&targets(1,9)==1&&(any(find(targ_fish2_pos_x<99)))&&(any(find(targ_fish2_pos_y<99)))&&(trgcountfish1>0||trgcount>0)
        targ_pos(end+1,1:end)=[min(targ_fish2_pos_x),min(targ_fish2_pos_y)];
        targ_pos=unique(targ_pos,'rows');
    elseif ((size(targets_pos,2)==7)&&((fish1_rec_counter<5)||(fish2_rec_counter<5))&&(plant1_rec_counter>=5)&&...
            (plant2_rec_counter>=5)&&(plant3_rec_counter>=5)&&...
            (ship_l1_rec_counter>=5)&&(ship_l2_rec_counter>=5)&&(ship_s1_rec_counter>=5)&&(ship_s2_rec_counter>=5)&&(size(explored_points,1)==size(total_points,1))&&...
            (~any(find(targ_fish1_pos_x<99)))&&(~any(find(targ_fish1_pos_y<99)))&&(~any(find(targ_fish2_pos_x<99)))&&(~any(find(targ_fish2_pos_y<99))))
        r=rewards(2);return;
    elseif ((size(targets_pos,2)==7)&&((fish1_rec_counter>=5)&&(fish2_rec_counter>=5))&&(plant1_rec_counter>=5)&&...
            (plant2_rec_counter>=5)&&(plant3_rec_counter>=5)&&...
            (ship_l1_rec_counter>=5)&&(ship_l2_rec_counter>=5)&&(ship_s1_rec_counter>=5)&&(ship_s2_rec_counter>=5)&&(size(explored_points,1)==size(total_points,1)))
        r=rewards(2);return;
    elseif((size(targets_pos,2)==3)&&(xag==xag_total(2))&&(yag==yag_total(2))&&(((anyFoundFish1)&&((fish1_rec_counter<5))&&~any(found2_fish1_indx))||((anyFoundFish2)&&(fish2_rec_counter<5)&&~any(found2_fish2_indx)))&&(size(explored_points,1)==size(total_points,1))&&(plant1_smp_flag&&plant2_smp_flag&&plant3_smp_flag))
        r=rewards(2);return;
    elseif((size(targets_pos,2)==3)&&(xag==xag_total(3))&&(yag==yag_total(3))&&(((anyFoundFish1)&&~any(found3_fish1_indx)&&((fish1_rec_counter<5)))||((anyFoundFish2)&&~any(found3_fish2_indx)&&(fish2_rec_counter<5)))&&(size(explored_points,1)==size(total_points,1))&&(trash1_flag&&trash2_flag&&trash3_flag))
        r=rewards(2);return;
    elseif((size(targets_pos,2)==2)&&(xag==xag_total(4))&&(yag==yag_total(4))&&(((anyFoundFish1)&&~any(found4_fish1_indx)&&((fish1_rec_counter<5)))||((anyFoundFish2)&&~any(found4_fish2_indx)&&(fish2_rec_counter<5)))&&(size(explored_points,1)==size(total_points,1))&&((ship_l1_small_rec_counter>=5)&&(ship_l2_small_rec_counter>=5)))
        r=rewards(2);return;
%     elseif ((size(targets_pos,2)==2)&&(fish1_rec_counter>=5)&&(fish2_rec_counter>=5)&&(ship_l1_small_rec_counter>=5)&&(ship_l2_small_rec_counter>=5)&&(size(explored_points,1)==size(total_points,1)))
%         r=rewards(2);return;
%     elseif ((size(targets_pos,2)==2)&&((fish1_rec_counter<5)||(fish2_rec_counter<5))&&(ship_l1_small_rec_counter>=5)&&(ship_l2_small_rec_counter>=5)&&(size(explored_points,1)==size(total_points,1)))
%         r=rewards(2);return;
%     elseif ((size(targets_pos,2)==3)&&(fish1_rec_counter>=5)&&(fish2_rec_counter>=5)&&(xag==xag_total(2))&&(yag==yag_total(2))&&plant1_smp_flag&&plant2_smp_flag&&plant3_smp_flag&&(size(explored_points,1)==size(total_points,1)))
%         r=rewards(2);return;
%     elseif ((size(targets_pos,2)==3)&&((fish1_rec_counter<5)||(fish2_rec_counter<5))&&(xag==xag_total(2))&&(yag==yag_total(2))&&plant1_smp_flag&&plant2_smp_flag&&plant3_smp_flag&&(size(explored_points,1)==size(total_points,1)))
%         r=rewards(2);return;
%     elseif ((size(targets_pos,2)==3)&&(fish1_rec_counter>=5)&&(fish2_rec_counter>=5)&&(xag==xag_total(3))&&(yag==yag_total(3))&&trash1_flag&&trash2_flag&&trash3_flag&&(size(explored_points,1)==size(total_points,1)))
%         r=rewards(2);return;
%     elseif ((size(targets_pos,2)==3)&&((fish1_rec_counter<5)||(fish2_rec_counter<5))&&(xag==xag_total(3))&&(yag==yag_total(3))&&trash1_flag&&trash2_flag&&trash3_flag&&(size(explored_points,1)==size(total_points,1)))
%         r=rewards(2);return;
    elseif (~any(targets(1,:)))
        r=rewards(5);return;
    end
end
targ_pos=unique(targ_pos,'rows');

if any(targ_pos(1:end,:))
    targ_dist = targ_pos-[xag,yag];
%     clear targ_pos;clear targ_fish1_pos_x; clear targ_fish1_pos_y; clear targ_fish2_pos_x; clear targ_fish2_pos_y;
    sum_xytarg_dist=sum(abs(targ_dist),2);
    %================================================================

    sum_xytarg_dist_ex_z=sum_xytarg_dist>0;
    sum_xytarg_dist_ex_zeros=sum_xytarg_dist(sum_xytarg_dist_ex_z);
    %================================================================
%     min_xytarg_dist_idx=find(sum_xytarg_dist_ex_zeros==min(sum_xytarg_dist_ex_zeros));
min_xytarg_dist_idx=find(sum_xytarg_dist==min(sum_xytarg_dist));
    if (min_xytarg_dist_idx>0)
        min_xytarg_dist_idx_rand=min_xytarg_dist_idx(randi(size(min_xytarg_dist_idx')));
        if targ_dist(min_xytarg_dist_idx_rand,1)==0 || targ_dist(min_xytarg_dist_idx_rand,2)==0
            if targ_dist(min_xytarg_dist_idx_rand,1)~=0&&abs(targ_dist(min_xytarg_dist_idx_rand,1)+xag)>=(xmin)&&abs(targ_dist(min_xytarg_dist_idx_rand,1)+xag)<=(xmax)
                xag=abs(xag+round(targ_dist(min_xytarg_dist_idx_rand,1)/abs(targ_dist(min_xytarg_dist_idx_rand,1))));
                r=rewards(2);
            elseif targ_dist(min_xytarg_dist_idx_rand,2)~=0&&abs(yag+round(targ_dist(min_xytarg_dist_idx_rand,2)/abs(targ_dist(min_xytarg_dist_idx_rand,2))))>=(ymin)&&abs(yag+round(targ_dist(min_xytarg_dist_idx_rand,2)/abs(targ_dist(min_xytarg_dist_idx_rand,2))))<=(ymax)
                yag=abs(yag+round(targ_dist(min_xytarg_dist_idx_rand,2)/abs(targ_dist(min_xytarg_dist_idx_rand,2))));
                r=rewards(2);
            elseif targ_dist(min_xytarg_dist_idx_rand,1)==targ_dist(min_xytarg_dist_idx_rand,2)&&targ_dist(min_xytarg_dist_idx_rand,2)==0
                r=rewards(5);
                return;
            else
                r=rewards(2);
            end
        elseif abs(targ_dist(min_xytarg_dist_idx_rand,1))==abs(targ_dist(min_xytarg_dist_idx_rand,2))&&targ_dist(min_xytarg_dist_idx_rand,2)~=0&&abs(xag+round(targ_dist(min_xytarg_dist_idx_rand,1)/abs(targ_dist(min_xytarg_dist_idx_rand,1))))>=(xmin)&&abs(xag+round(targ_dist(min_xytarg_dist_idx_rand,1)/abs(targ_dist(min_xytarg_dist_idx_rand,1))))<=(xmax)
            xag=abs(xag+round(targ_dist(min_xytarg_dist_idx_rand,1)/abs(targ_dist(min_xytarg_dist_idx_rand,1))));
            r=rewards(2);
        elseif abs(targ_dist(min_xytarg_dist_idx_rand,1))>abs(targ_dist(min_xytarg_dist_idx_rand,2))
            if abs(xag+round(targ_dist(min_xytarg_dist_idx_rand,1)/abs(targ_dist(min_xytarg_dist_idx_rand,1))))>=(xmin)&&abs(xag+round(targ_dist(min_xytarg_dist_idx_rand,1)/abs(targ_dist(min_xytarg_dist_idx_rand,1))))<=(xmax)
                xag=abs(xag+round(targ_dist(min_xytarg_dist_idx_rand,1)/abs(targ_dist(min_xytarg_dist_idx_rand,1))));
                r=rewards(2);
%             else
%                 r=rewards(3);
%                 disp("moveFailed");
            end
        elseif abs(targ_dist(min_xytarg_dist_idx_rand,1))<abs(targ_dist(min_xytarg_dist_idx_rand,2))
            if abs(yag+round(targ_dist(min_xytarg_dist_idx_rand,2)/abs(targ_dist(min_xytarg_dist_idx_rand,2))))>=ymin&&abs(yag+round(targ_dist(min_xytarg_dist_idx_rand,2)/abs(targ_dist(min_xytarg_dist_idx_rand,2))))<=ymax
                yag=abs(yag+round(targ_dist(min_xytarg_dist_idx_rand,2)/abs(targ_dist(min_xytarg_dist_idx_rand,2))));
                r=rewards(2);
%             else
%                 r=rewards(3);
%                 disp("moveFailed");
            end
%         else
%             r=rewards(3);
%             disp("moveFailed");
        end
%     else
%         r=rewards(3);
%         disp("moveFailed");
    end
else

    r=rewards(5);
    xag=abs(xag);yag=abs(yag);
    xag=min(xmax,xag);yag=min(ymax,yag);
    xag=max(xmin,xag);yag=max(ymin,yag);
end
end

%             (~any(found1_fish1_indx))&&(~any(found2_fish1_indx))&&(~any(found3_fish1_indx))&&(~any(found4_fish1_indx))&&...
%             (~any(found1_fish2_indx))&&(~any(found2_fish2_indx))&&(~any(found3_fish2_indx))&&(~any(found4_fish2_indx)))&&...