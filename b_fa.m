function [Q,xag,yag,r1,r2,r3,r4] = b_fa(a_,xag,yag,xf1,yf1,xf2,yf2,Q,targets1,targets2,targets3,targets4,targets1_pos,targets2_pos,targets3_pos,targets4_pos)
global explored_points;
global fish2_rec_counter;global grid_matrix;global ship_s1_rec_counter;
global ship_s2_rec_counter;global ship_l1_rec_counter;global ship_l2_rec_counter;
global plant1_rec_counter;global plant2_rec_counter;global plant3_rec_counter;global plant1_smp_flag;global plant2_smp_flag;global plant3_smp_flag;
global trash1_flag;global trash2_flag;global trash3_flag;global fish1_rec_counter;
global rewards;global gamma;global alpha;global ship_l1_small_rec_counter;global ship_l2_small_rec_counter;
global total_points;
global epsilon;global scan_pos;
global scanning_process;global descending_scan;global fish1_flag;global fish2_flag;
%============================================================================================================
global targ1_fish1_x;global targ2_fish1_x;global targ3_fish1_x;global targ4_fish1_x;
global targ1_fish2_x;global targ2_fish2_x;global targ3_fish2_x;global targ4_fish2_x;
global targ1_fish1_y;global targ2_fish1_y;global targ3_fish1_y;global targ4_fish1_y;
global targ1_fish2_y;global targ2_fish2_y;global targ3_fish2_y;global targ4_fish2_y;
%============================================================================================================

% ag_v_rng{1}=[[xag(1)+1,yag(1)];[xag(1),yag(1)+1];[xag(1)+1,yag(1)+1];[xag(1)-1,yag(1)];[xag(1),yag(1)-1];[xag(1)-1,yag(1)-1];[xag(1)+2,yag(1)];[xag(1),yag(1)+2];[xag(1),yag(1)-2];[xag(1)-2,yag(1)];[xag(1)+1,yag(1)-1];[xag(1)-1,yag(1)+1]];
% ag_v_rng{2}=[[xag(2)+1,yag(2)];[xag(2),yag(2)+1];[xag(2)+1,yag(2)+1];[xag(2)-1,yag(2)];[xag(2),yag(2)-1];[xag(2)-1,yag(2)-1];[xag(2)+2,yag(2)];[xag(2),yag(2)+2];[xag(2),yag(2)-2];[xag(2)-2,yag(2)];[xag(2)+1,yag(2)-1];[xag(2)-1,yag(2)+1]];
% ag_v_rng{3}=[[xag(3)+1,yag(3)];[xag(3),yag(3)+1];[xag(3)+1,yag(3)+1];[xag(3)-1,yag(3)];[xag(3),yag(3)-1];[xag(3)-1,yag(3)-1];[xag(3)+2,yag(3)];[xag(3),yag(3)+2];[xag(3),yag(3)-2];[xag(3)-2,yag(3)];[xag(3)+1,yag(3)-1];[xag(3)-1,yag(3)+1]];
% ag_v_rng{4}=[[xag(4)+1,yag(4)];[xag(4),yag(4)+1];[xag(4)+1,yag(4)+1];[xag(4)-1,yag(4)];[xag(4),yag(4)-1];[xag(4)-1,yag(4)-1];[xag(4)+2,yag(4)];[xag(4),yag(4)+2];[xag(4),yag(4)-2];[xag(4)-2,yag(4)];[xag(4)+1,yag(4)-1];[xag(4)-1,yag(4)+1]];
% [~,found1_fish1_indx]=ismember(ag_v_rng{1},[xf1,yf1],'rows');
% [~,found2_fish1_indx]=ismember(ag_v_rng{2},[xf1,yf1],'rows');
% [~,found3_fish1_indx]=ismember(ag_v_rng{3},[xf1,yf1],'rows');
% [~,found4_fish1_indx]=ismember(ag_v_rng{4},[xf1,yf1],'rows');
% [~,found1_fish2_indx]=ismember(ag_v_rng{1},[xf2,yf2],'rows');
% [~,found2_fish2_indx]=ismember(ag_v_rng{2},[xf2,yf2],'rows');
% [~,found3_fish2_indx]=ismember(ag_v_rng{3},[xf2,yf2],'rows');
% [~,found4_fish2_indx]=ismember(ag_v_rng{4},[xf2,yf2],'rows');
%                 a_=joint_actions(a,:);
%==========================================================

%         for isteps=1:maxsteps
switch a_(1) % a_ ist action vektor
    case 0
        [xag(1),yag(1),r1]=exp_act(xag(1),yag(1));
        [~,exp1_indx]=ismember(explored_points,[xag(1),yag(1)],'rows');
        if(~any(exp1_indx))
            explored_points(end+1,1:end)=[xag(1),yag(1)];
            explored_points=unique(explored_points,'rows');
            r1=rewards(1);
        end
    case 1
        [xag(1),yag(1),r1]=move_act(xag(1),yag(1),targets1,targets1_pos,xag,yag,xf1,yf1,xf2,yf2);
        [~,mov_indx]=ismember(explored_points,[xag(1),yag(1)],'rows');
        if(~any(mov_indx))
            explored_points(end+1,1:end)=[xag(1),yag(1)];
            explored_points=unique(explored_points,'rows');
            r1=rewards(1);
        end
    case 2
        if((xag(1)==xf1)&&(yag(1)==yf1)&&(fish1_rec_counter<5))
%             if(fish1_rec_counter<5)
                r1=rewards(4);
                fish1_rec_counter=fish1_rec_counter+1;
%             else
%                 r1=rewards(3);
%             end
        elseif((xag(1)==xf2)&&(yag(1)==yf2)&&(fish2_rec_counter<5))
%             if(fish2_rec_counter<5)
                r1=rewards(4);
                fish2_rec_counter=fish2_rec_counter+1;
%             else
%                 r1=rewards(3);
%             end
        else
            switch(grid_matrix(xag(1),yag(1)))
                case 1
                    if ship_s1_rec_counter<5
                        r1=rewards(1);
                        ship_s1_rec_counter=ship_s1_rec_counter+1;
                    else
                       % disp("recWrong");
                        r1=rewards(5);
                    end
                case 2
                    if ship_s2_rec_counter<5
                        r1=rewards(1);
                        ship_s2_rec_counter=ship_s2_rec_counter+1;
                    else
                        r1=rewards(5);
%                         disp("recWrong");
                    end
                case 3
                    if ship_l1_rec_counter<5
                        r1=rewards(1);
                        ship_l1_rec_counter=ship_l1_rec_counter+1;
                    else
                        r1=rewards(5);
%                         disp("recWrong");
                    end
                case 4
                    if ship_l2_rec_counter<5
                        r1=rewards(1);
                        ship_l2_rec_counter=ship_l2_rec_counter+1;
                    else
                        r1=rewards(5);
%                         disp("recWrong");
                    end
                case 5
                    if plant1_rec_counter<5
                        r1=rewards(1);
                        plant1_rec_counter=plant1_rec_counter+1;
                    else
                        r1=rewards(5);
%                         disp("recWrong");
                    end
                case 6
                    if plant2_rec_counter<5
                        r1=rewards(1);
                        plant2_rec_counter=plant2_rec_counter+1;
                    else
                        r1=rewards(5);
%                         disp("recWrong");
                    end
                case 7
                    if plant3_rec_counter<5
                        r1=rewards(1);
                        plant3_rec_counter=plant3_rec_counter+1;
                    else
                        r1=rewards(5);
%                         disp("recWrong");
                    end
                otherwise
                    r1=rewards(5);
            end
        end
    case 3
        ag_v_rng{1}=[[xag(1)+1,yag(1)];[xag(1),yag(1)+1];[xag(1)+1,yag(1)+1];[xag(1)-1,yag(1)];[xag(1),yag(1)-1];[xag(1)-1,yag(1)-1];[xag(1)+2,yag(1)];[xag(1),yag(1)+2];[xag(1),yag(1)-2];[xag(1)-2,yag(1)];[xag(1)+1,yag(1)-1];[xag(1)-1,yag(1)+1]];
        [~,found1_fish1_indx]=ismember(ag_v_rng{1},[xf1,yf1],'rows');
        [~,found1_fish2_indx]=ismember(ag_v_rng{1},[xf2,yf2],'rows');
        if ((fish1_rec_counter<5)&&(any(found1_fish1_indx)))
            [xag(1),yag(1),r1]=track_act(xag(1),yag(1),xf1,yf1,ag_v_rng{1});
            [~,exptrack1_indx]=ismember(explored_points,[xag(1),yag(1)],'rows');
            if(~any(exptrack1_indx))
                explored_points(end+1,1:end)=[xag(1),yag(1)];
                explored_points=unique(explored_points,'rows');
                r1=rewards(1);
            end
        elseif ((fish2_rec_counter<5)&&(any(found1_fish2_indx)))
            [xag(1),yag(1),r1]=track_act(xag(1),yag(1),xf2,yf2,ag_v_rng{1});
            [~,exptrack1_indx]=ismember(explored_points,[xag(1),yag(1)],'rows');
            if(~any(exptrack1_indx))
                explored_points(end+1,1:end)=[xag(1),yag(1)];
                explored_points=unique(explored_points,'rows');
                r1=rewards(1);
            end
        else
            r1=rewards(5);
%             disp("track1Wrong");
        end
end
%======================================================================
switch a_(2)
    case 0
        [xag(2),yag(2),r2]=exp_act(xag(2),yag(2));
        [~,exp2_indx]=ismember(explored_points,[xag(2),yag(2)],'rows');
        if(~any(exp2_indx))
            r2=rewards(1);
            explored_points(end+1,1:end)=[xag(2),yag(2)];
            explored_points=unique(explored_points,'rows');
        end
    case 1
        [xag(2),yag(2),r2]=move_act(xag(2),yag(2),targets2,targets2_pos,xag,yag,xf1,yf1,xf2,yf2);
        [~,mov_indx]=ismember(explored_points,[xag(2),yag(2)],'rows');
        if(~any(mov_indx))
            explored_points(end+1,1:end)=[xag(2),yag(2)];
            explored_points=unique(explored_points,'rows');
            r2=rewards(1);
        end
    case 3
        ag_v_rng{2}=[[xag(2)+1,yag(2)];[xag(2),yag(2)+1];[xag(2)+1,yag(2)+1];[xag(2)-1,yag(2)];[xag(2),yag(2)-1];[xag(2)-1,yag(2)-1];[xag(2)+2,yag(2)];[xag(2),yag(2)+2];[xag(2),yag(2)-2];[xag(2)-2,yag(2)];[xag(2)+1,yag(2)-1];[xag(2)-1,yag(2)+1]];
        [~,found2_fish1_indx]=ismember(ag_v_rng{2},[xf1,yf1],'rows');
        [~,found2_fish2_indx]=ismember(ag_v_rng{2},[xf2,yf2],'rows');
        if ((fish1_rec_counter<5)&&((any(found2_fish1_indx))||((xag(2)==xf1)&&(yag(2)==yf1))))
            [xag(2),yag(2),r2]=track_act(xag(2),yag(2),xf1,yf1,ag_v_rng{2});
            [~,exptrack2_indx]=ismember(explored_points,[xag(2),yag(2)],'rows');
            if(~any(exptrack2_indx))
                explored_points(end+1,1:end)=[xag(2),yag(2)];
                explored_points=unique(explored_points,'rows');
                r2=rewards(1);
            end
        elseif ((fish2_rec_counter<5)&&((any(found2_fish2_indx))||((xag(2)==xf2)&&(yag(2)==yf2))))
            [xag(2),yag(2),r2]=track_act(xag(2),yag(2),xf2,yf2,ag_v_rng{2});
            [~,exptrack2_indx]=ismember(explored_points,[xag(2),yag(2)],'rows');
            if(~any(exptrack2_indx))
                explored_points(end+1,1:end)=[xag(2),yag(2)];
                explored_points=unique(explored_points,'rows');
                r2=rewards(1);
            end
        else
             r2=rewards(5);
%             disp("track2Wrong");
        end
    case 4
        switch grid_matrix(xag(2),yag(2))
            case 5
                if ~plant1_smp_flag
                    plant1_smp_flag=true;
                    r2=rewards(1);
                else
                    r2=rewards(5);
                    plant1_smp_flag=true;
%                     disp("col2Wrong");
                end
            case 6
                if ~plant2_smp_flag
                    plant2_smp_flag=true;
                    r2=rewards(1);
                else
                    r2=rewards(5);
                    plant2_smp_flag=true;
%                     disp("col2Wrong");
                end
            case 7
                if ~plant3_smp_flag
                    plant3_smp_flag=true;
                    r2=rewards(1);
                else
                    r2=rewards(5);
                    plant3_smp_flag=true;
%                     disp("col2Wrong");
                end
            otherwise
                 r2=rewards(5);
%                 disp("col2Wrong");
        end
    case 5
        ag_v_rng{1}=[[xag(1)+1,yag(1)];[xag(1),yag(1)+1];[xag(1)+1,yag(1)+1];[xag(1)-1,yag(1)];[xag(1),yag(1)-1];[xag(1)-1,yag(1)-1];[xag(1)+2,yag(1)];[xag(1),yag(1)+2];[xag(1),yag(1)-2];[xag(1)-2,yag(1)];[xag(1)+1,yag(1)-1];[xag(1)-1,yag(1)+1]];
        ag_v_rng{2}=[[xag(2)+1,yag(2)];[xag(2),yag(2)+1];[xag(2)+1,yag(2)+1];[xag(2)-1,yag(2)];[xag(2),yag(2)-1];[xag(2)-1,yag(2)-1];[xag(2)+2,yag(2)];[xag(2),yag(2)+2];[xag(2),yag(2)-2];[xag(2)-2,yag(2)];[xag(2)+1,yag(2)-1];[xag(2)-1,yag(2)+1]];
        ag_v_rng{3}=[[xag(3)+1,yag(3)];[xag(3),yag(3)+1];[xag(3)+1,yag(3)+1];[xag(3)-1,yag(3)];[xag(3),yag(3)-1];[xag(3)-1,yag(3)-1];[xag(3)+2,yag(3)];[xag(3),yag(3)+2];[xag(3),yag(3)-2];[xag(3)-2,yag(3)];[xag(3)+1,yag(3)-1];[xag(3)-1,yag(3)+1]];
        ag_v_rng{4}=[[xag(4)+1,yag(4)];[xag(4),yag(4)+1];[xag(4)+1,yag(4)+1];[xag(4)-1,yag(4)];[xag(4),yag(4)-1];[xag(4)-1,yag(4)-1];[xag(4)+2,yag(4)];[xag(4),yag(4)+2];[xag(4),yag(4)-2];[xag(4)-2,yag(4)];[xag(4)+1,yag(4)-1];[xag(4)-1,yag(4)+1]];
%         ag_v_rng{2}=[[xag(2)+1,yag(2)];[xag(2),yag(2)+1];[xag(2)+1,yag(2)+1];[xag(2)-1,yag(2)];[xag(2),yag(2)-1];[xag(2)-1,yag(2)-1];[xag(2)+2,yag(2)];[xag(2),yag(2)+2];[xag(2),yag(2)-2];[xag(2)-2,yag(2)];[xag(2)+1,yag(2)-1];[xag(2)-1,yag(2)+1]];
        [~,found1_fish1_indx]=ismember(ag_v_rng{1},[xf1,yf1],'rows');
        [~,found1_fish2_indx]=ismember(ag_v_rng{1},[xf2,yf2],'rows');
        [~,found2_fish1_indx]=ismember(ag_v_rng{2},[xf1,yf1],'rows');
        [~,found3_fish1_indx]=ismember(ag_v_rng{3},[xf1,yf1],'rows');
        [~,found4_fish1_indx]=ismember(ag_v_rng{4},[xf1,yf1],'rows');
        [~,found2_fish2_indx]=ismember(ag_v_rng{2},[xf2,yf2],'rows');
        [~,found3_fish2_indx]=ismember(ag_v_rng{3},[xf2,yf2],'rows');
        [~,found4_fish2_indx]=ismember(ag_v_rng{4},[xf2,yf2],'rows');
        anyFoundFish1=any(found1_fish1_indx)|any(found2_fish1_indx)|any(found3_fish1_indx)|any(found4_fish1_indx)|...
    ((xag(1)==xf1)&&(yag(1)==yf1))|((xag(2)==xf1)&&(yag(2)==yf1))|((xag(3)==xf1)&&(yag(3)==yf1))|((xag(4)==xf1)&&(yag(4)==yf1));
        anyFoundFish2=any(found1_fish2_indx)|any(found2_fish2_indx)|any(found3_fish2_indx)|any(found4_fish2_indx)|...
    ((xag(1)==xf2)&&(yag(1)==yf2))|((xag(2)==xf2)&&(yag(2)==yf2))|((xag(3)==xf2)&&(yag(3)==yf2))|((xag(4)==xf2)&&(yag(4)==yf2));
%         if (fish1_rec_counter>=5)&&(fish2_rec_counter>=5)&&(size(explored_points,1)==size(total_points,1))&&...
%                 ((ship_l1_small_rec_counter<5)||(ship_l2_small_rec_counter<5))
%             r4=rewards(5);
        if(((anyFoundFish1)&&((fish1_rec_counter<5)))||((anyFoundFish2)&&(fish2_rec_counter<5)))
%         if((((any(found4_fish1_indx))||((xag(4)==xf1)&&(yag(4)==yf1)))&&(fish1_rec_counter<5))||(((any(found4_fish2_indx))||((xag(4)==xf2)&&(yag(4)==yf2)))&&(fish2_rec_counter<5)))
            r2=rewards(5);
            scanning_process=false;descending_scan=false;
        elseif (size(explored_points,1)==size(total_points,1))&&(~plant1_smp_flag||~plant2_smp_flag||~plant3_smp_flag)
            r2=rewards(5);scanning_process=false;descending_scan=false;
        else
            [xag(2),yag(2),r2] = scan_act(xag(2),yag(2),xag,yag);
            [~,expscan2_indx]=ismember(explored_points,[xag(2),yag(2)],'rows');
            if(~any(expscan2_indx))
                explored_points(end+1,1:end)=[xag(2),yag(2)];
                explored_points=unique(explored_points,'rows');
                r2=rewards(1);
            end
        end
end
%======================================================================
switch a_(3)
    case 0
        [xag(3),yag(3),r3]=exp_act(xag(3),yag(3));
        [~,exp3_indx]=ismember(explored_points,[xag(3),yag(3)],'rows');
        if(~any(exp3_indx))
            explored_points(end+1,1:end)=[xag(3),yag(3)];
            explored_points=unique(explored_points,'rows');
            r3=rewards(1);
        end
    case 1
        [xag(3),yag(3),r3]=move_act(xag(3),yag(3),targets3,targets3_pos,xag,yag,xf1,yf1,xf2,yf2);
        [~,mov_indx]=ismember(explored_points,[xag(3),yag(3)],'rows');
        if(~any(mov_indx))
            explored_points(end+1,1:end)=[xag(3),yag(3)];
            explored_points=unique(explored_points,'rows');
            r3=rewards(1);
        end
        
    case 3
        ag_v_rng{3}=[[xag(3)+1,yag(3)];[xag(3),yag(3)+1];[xag(3)+1,yag(3)+1];[xag(3)-1,yag(3)];[xag(3),yag(3)-1];[xag(3)-1,yag(3)-1];[xag(3)+2,yag(3)];[xag(3),yag(3)+2];[xag(3),yag(3)-2];[xag(3)-2,yag(3)];[xag(3)+1,yag(3)-1];[xag(3)-1,yag(3)+1]];
        [~,found3_fish1_indx]=ismember(ag_v_rng{3},[xf1,yf1],'rows');
        [~,found3_fish2_indx]=ismember(ag_v_rng{3},[xf2,yf2],'rows');
        if ((fish1_rec_counter<5)&&((any(found3_fish1_indx))||((xag(3)==xf1)&&(yag(3)==yf1))))
            [xag(3),yag(3),r3]=track_act(xag(3),yag(3),xf1,yf1,ag_v_rng{3});
            [~,exptrack3_indx]=ismember(explored_points,[xag(3),yag(3)],'rows');
            if(~any(exptrack3_indx))
                explored_points(end+1,1:end)=[xag(3),yag(3)];
                explored_points=unique(explored_points,'rows');
                r3=rewards(1);
            end
        elseif ((fish2_rec_counter<5)&&((any(found3_fish2_indx))||((xag(3)==xf2)&&(yag(3)==yf2))))
            [xag(3),yag(3),r3]=track_act(xag(3),yag(3),xf2,yf2,ag_v_rng{3});
            [~,exptrack3_indx]=ismember(explored_points,[xag(3),yag(3)],'rows');
            if(~any(exptrack3_indx))
                explored_points(end+1,1:end)=[xag(3),yag(3)];
                explored_points=unique(explored_points,'rows');
                r3=rewards(1);
            end
        else
              r3=rewards(5);
%             disp("track3Wrong");
        end
    case 4
        switch grid_matrix(xag(3),yag(3))
            case 10
                if ~trash1_flag
                    trash1_flag=true;
                    r3=rewards(1);
                else
                    r3=rewards(5);
                    trash1_flag=true;
%                     disp("col3Wrong");
                end
            case 11
                if ~trash2_flag
                    trash2_flag=true;
                    r3=rewards(1);
                else
                    r3=rewards(5);
                    trash2_flag=true;
%                     disp("col3Wrong");
                end
            case 12
                if ~trash3_flag
                    trash3_flag=true;
                    r3=rewards(1);
                else
                    r3=rewards(5);
                    trash3_flag=true;
%                     disp("col3Wrong");
                end
            otherwise
                  r3=rewards(5);
%                 disp("col3Wrong");
        end
    case 5
        ag_v_rng{1}=[[xag(1)+1,yag(1)];[xag(1),yag(1)+1];[xag(1)+1,yag(1)+1];[xag(1)-1,yag(1)];[xag(1),yag(1)-1];[xag(1)-1,yag(1)-1];[xag(1)+2,yag(1)];[xag(1),yag(1)+2];[xag(1),yag(1)-2];[xag(1)-2,yag(1)];[xag(1)+1,yag(1)-1];[xag(1)-1,yag(1)+1]];
        ag_v_rng{2}=[[xag(2)+1,yag(2)];[xag(2),yag(2)+1];[xag(2)+1,yag(2)+1];[xag(2)-1,yag(2)];[xag(2),yag(2)-1];[xag(2)-1,yag(2)-1];[xag(2)+2,yag(2)];[xag(2),yag(2)+2];[xag(2),yag(2)-2];[xag(2)-2,yag(2)];[xag(2)+1,yag(2)-1];[xag(2)-1,yag(2)+1]];
        ag_v_rng{3}=[[xag(3)+1,yag(3)];[xag(3),yag(3)+1];[xag(3)+1,yag(3)+1];[xag(3)-1,yag(3)];[xag(3),yag(3)-1];[xag(3)-1,yag(3)-1];[xag(3)+2,yag(3)];[xag(3),yag(3)+2];[xag(3),yag(3)-2];[xag(3)-2,yag(3)];[xag(3)+1,yag(3)-1];[xag(3)-1,yag(3)+1]];
        ag_v_rng{4}=[[xag(4)+1,yag(4)];[xag(4),yag(4)+1];[xag(4)+1,yag(4)+1];[xag(4)-1,yag(4)];[xag(4),yag(4)-1];[xag(4)-1,yag(4)-1];[xag(4)+2,yag(4)];[xag(4),yag(4)+2];[xag(4),yag(4)-2];[xag(4)-2,yag(4)];[xag(4)+1,yag(4)-1];[xag(4)-1,yag(4)+1]];
%         ag_v_rng{3}=[[xag(3)+1,yag(3)];[xag(3),yag(3)+1];[xag(3)+1,yag(3)+1];[xag(3)-1,yag(3)];[xag(3),yag(3)-1];[xag(3)-1,yag(3)-1];[xag(3)+2,yag(3)];[xag(3),yag(3)+2];[xag(3),yag(3)-2];[xag(3)-2,yag(3)];[xag(3)+1,yag(3)-1];[xag(3)-1,yag(3)+1]];
        [~,found1_fish1_indx]=ismember(ag_v_rng{1},[xf1,yf1],'rows');
        [~,found1_fish2_indx]=ismember(ag_v_rng{1},[xf2,yf2],'rows');
        [~,found2_fish1_indx]=ismember(ag_v_rng{2},[xf1,yf1],'rows');
        [~,found3_fish1_indx]=ismember(ag_v_rng{3},[xf1,yf1],'rows');
        [~,found4_fish1_indx]=ismember(ag_v_rng{4},[xf1,yf1],'rows');
        [~,found2_fish2_indx]=ismember(ag_v_rng{2},[xf2,yf2],'rows');
        [~,found3_fish2_indx]=ismember(ag_v_rng{3},[xf2,yf2],'rows');
        [~,found4_fish2_indx]=ismember(ag_v_rng{4},[xf2,yf2],'rows');
        anyFoundFish1=any(found1_fish1_indx)|any(found2_fish1_indx)|any(found3_fish1_indx)|any(found4_fish1_indx)|...
    ((xag(1)==xf1)&&(yag(1)==yf1))|((xag(2)==xf1)&&(yag(2)==yf1))|((xag(3)==xf1)&&(yag(3)==yf1))|((xag(4)==xf1)&&(yag(4)==yf1));
        anyFoundFish2=any(found1_fish2_indx)|any(found2_fish2_indx)|any(found3_fish2_indx)|any(found4_fish2_indx)|...
    ((xag(1)==xf2)&&(yag(1)==yf2))|((xag(2)==xf2)&&(yag(2)==yf2))|((xag(3)==xf2)&&(yag(3)==yf2))|((xag(4)==xf2)&&(yag(4)==yf2));
%         if (fish1_rec_counter>=5)&&(fish2_rec_counter>=5)&&(size(explored_points,1)==size(total_points,1))&&...
%                 ((ship_l1_small_rec_counter<5)||(ship_l2_small_rec_counter<5))
%             r4=rewards(5);
        if(((anyFoundFish1)&&((fish1_rec_counter<5)))||((anyFoundFish2)&&(fish2_rec_counter<5)))
%         if((((any(found4_fish1_indx))||((xag(4)==xf1)&&(yag(4)==yf1)))&&(fish1_rec_counter<5))||(((any(found4_fish2_indx))||((xag(4)==xf2)&&(yag(4)==yf2)))&&(fish2_rec_counter<5)))
            r3=rewards(5);
            scanning_process=false;descending_scan=false;
        elseif (size(explored_points,1)==size(total_points,1))&&(~trash1_flag||~trash2_flag||~trash3_flag)
            r3=rewards(5);scanning_process=false;descending_scan=false;
        else
            [xag(3),yag(3),r3] = scan_act(xag(3),yag(3),xag,yag);
            [~,expscan3_indx]=ismember(explored_points,[xag(3),yag(3)],'rows');
            if(~any(expscan3_indx))
                explored_points(end+1,1:end)=[xag(3),yag(3)];
                explored_points=unique(explored_points,'rows');
                r3=rewards(1);
            end
        end
end
%======================================================================
switch a_(4)
    case 0
        [xag(4),yag(4),r4]=exp_act(xag(4),yag(4));
        [~,exp4_indx]=ismember(explored_points,[xag(4),yag(4)],'rows');
        if(~any(exp4_indx))
            explored_points(end+1,1:end)=[xag(4),yag(4)];
            explored_points=unique(explored_points,'rows');
            r4=rewards(1);
        end
    case 1
        [xag(4),yag(4),r4]=move_act(xag(4),yag(4),targets4,targets4_pos,xag,yag,xf1,yf1,xf2,yf2);
        [~,mov_indx]=ismember(explored_points,[xag(4),yag(4)],'rows');
        if(~any(mov_indx))
            r4=rewards(1);
            explored_points(end+1,1:end)=[xag(4),yag(4)];
            explored_points=unique(explored_points,'rows');
        end
    case 2
        switch(grid_matrix(xag(4),yag(4)))
            case 3
                if ship_l1_small_rec_counter<5
                    r4= rewards(1);
                    ship_l1_small_rec_counter=ship_l1_small_rec_counter+1;
                else
                    r4=rewards(5);
                end
            case 4
                if ship_l2_small_rec_counter<5
                    r4=rewards(1);
                    ship_l2_small_rec_counter=ship_l2_small_rec_counter+1;
                else
                    r4=rewards(5);
                end
            otherwise
                 r4=rewards(5);
%                 disp("rec4Wrong");
        end
    case 3
        ag_v_rng{4}=[[xag(4)+1,yag(4)];[xag(4),yag(4)+1];[xag(4)+1,yag(4)+1];[xag(4)-1,yag(4)];[xag(4),yag(4)-1];[xag(4)-1,yag(4)-1];[xag(4)+2,yag(4)];[xag(4),yag(4)+2];[xag(4),yag(4)-2];[xag(4)-2,yag(4)];[xag(4)+1,yag(4)-1];[xag(4)-1,yag(4)+1]];
        [~,found4_fish1_indx]=ismember(ag_v_rng{4},[xf1,yf1],'rows');
        [~,found4_fish2_indx]=ismember(ag_v_rng{4},[xf2,yf2],'rows');
        if ((fish1_rec_counter<5)&&((any(found4_fish1_indx))||((xag(4)==xf1)&&(yag(4)==yf1))))
            [xag(4),yag(4),r4]=track_act(xag(4),yag(4),xf1,yf1,ag_v_rng{4});
            [~,exptrack4_indx]=ismember(explored_points,[xag(4),yag(4)],'rows');
            if(~any(exptrack4_indx))
                explored_points(end+1,1:end)=[xag(4),yag(4)];
                explored_points=unique(explored_points,'rows');
                r4=rewards(1);
            end
        elseif ((fish2_rec_counter<5)&&((any(found4_fish2_indx))||((xag(4)==xf2)&&(yag(4)==yf2))))
            [xag(4),yag(4),r4]=track_act(xag(4),yag(4),xf2,yf2,ag_v_rng{4});
            [~,exptrack4_indx]=ismember(explored_points,[xag(4),yag(4)],'rows');
            if(~any(exptrack4_indx))
                explored_points(end+1,1:end)=[xag(4),yag(4)];
                explored_points=unique(explored_points,'rows');
                r4=rewards(1);
            end
        else
             r4=rewards(5);
%             disp("track4Wrong");
        end
    case 5
        ag_v_rng{1}=[[xag(1)+1,yag(1)];[xag(1),yag(1)+1];[xag(1)+1,yag(1)+1];[xag(1)-1,yag(1)];[xag(1),yag(1)-1];[xag(1)-1,yag(1)-1];[xag(1)+2,yag(1)];[xag(1),yag(1)+2];[xag(1),yag(1)-2];[xag(1)-2,yag(1)];[xag(1)+1,yag(1)-1];[xag(1)-1,yag(1)+1]];
        ag_v_rng{2}=[[xag(2)+1,yag(2)];[xag(2),yag(2)+1];[xag(2)+1,yag(2)+1];[xag(2)-1,yag(2)];[xag(2),yag(2)-1];[xag(2)-1,yag(2)-1];[xag(2)+2,yag(2)];[xag(2),yag(2)+2];[xag(2),yag(2)-2];[xag(2)-2,yag(2)];[xag(2)+1,yag(2)-1];[xag(2)-1,yag(2)+1]];
        ag_v_rng{3}=[[xag(3)+1,yag(3)];[xag(3),yag(3)+1];[xag(3)+1,yag(3)+1];[xag(3)-1,yag(3)];[xag(3),yag(3)-1];[xag(3)-1,yag(3)-1];[xag(3)+2,yag(3)];[xag(3),yag(3)+2];[xag(3),yag(3)-2];[xag(3)-2,yag(3)];[xag(3)+1,yag(3)-1];[xag(3)-1,yag(3)+1]];
        ag_v_rng{4}=[[xag(4)+1,yag(4)];[xag(4),yag(4)+1];[xag(4)+1,yag(4)+1];[xag(4)-1,yag(4)];[xag(4),yag(4)-1];[xag(4)-1,yag(4)-1];[xag(4)+2,yag(4)];[xag(4),yag(4)+2];[xag(4),yag(4)-2];[xag(4)-2,yag(4)];[xag(4)+1,yag(4)-1];[xag(4)-1,yag(4)+1]];
%         ag_v_rng{4}=[[xag(4)+1,yag(4)];[xag(4),yag(4)+1];[xag(4)+1,yag(4)+1];[xag(4)-1,yag(4)];[xag(4),yag(4)-1];[xag(4)-1,yag(4)-1];[xag(4)+2,yag(4)];[xag(4),yag(4)+2];[xag(4),yag(4)-2];[xag(4)-2,yag(4)];[xag(4)+1,yag(4)-1];[xag(4)-1,yag(4)+1]];
        [~,found1_fish1_indx]=ismember(ag_v_rng{1},[xf1,yf1],'rows');
        [~,found1_fish2_indx]=ismember(ag_v_rng{1},[xf2,yf2],'rows');
        [~,found2_fish1_indx]=ismember(ag_v_rng{2},[xf1,yf1],'rows');
        [~,found3_fish1_indx]=ismember(ag_v_rng{3},[xf1,yf1],'rows');
        [~,found4_fish1_indx]=ismember(ag_v_rng{4},[xf1,yf1],'rows');
        [~,found2_fish2_indx]=ismember(ag_v_rng{2},[xf2,yf2],'rows');
        [~,found3_fish2_indx]=ismember(ag_v_rng{3},[xf2,yf2],'rows');
        [~,found4_fish2_indx]=ismember(ag_v_rng{4},[xf2,yf2],'rows');
        anyFoundFish1=any(found1_fish1_indx)|any(found2_fish1_indx)|any(found3_fish1_indx)|any(found4_fish1_indx)|...
    ((xag(1)==xf1)&&(yag(1)==yf1))|((xag(2)==xf1)&&(yag(2)==yf1))|((xag(3)==xf1)&&(yag(3)==yf1))|((xag(4)==xf1)&&(yag(4)==yf1));
        anyFoundFish2=any(found1_fish2_indx)|any(found2_fish2_indx)|any(found3_fish2_indx)|any(found4_fish2_indx)|...
    ((xag(1)==xf2)&&(yag(1)==yf2))|((xag(2)==xf2)&&(yag(2)==yf2))|((xag(3)==xf2)&&(yag(3)==yf2))|((xag(4)==xf2)&&(yag(4)==yf2));
%         if (fish1_rec_counter>=5)&&(fish2_rec_counter>=5)&&(size(explored_points,1)==size(total_points,1))&&...
%                 ((ship_l1_small_rec_counter<5)||(ship_l2_small_rec_counter<5))
%             r4=rewards(5);
        if(((anyFoundFish1)&&((fish1_rec_counter<5)))||((anyFoundFish2)&&(fish2_rec_counter<5)))
%         if((((any(found4_fish1_indx))||((xag(4)==xf1)&&(yag(4)==yf1)))&&(fish1_rec_counter<5))||(((any(found4_fish2_indx))||((xag(4)==xf2)&&(yag(4)==yf2)))&&(fish2_rec_counter<5)))
            r4=rewards(5);
            scanning_process=false;descending_scan=false;
        elseif (size(explored_points,1)==size(total_points,1))&&((ship_l1_small_rec_counter<5)||(ship_l2_small_rec_counter<5))
            r4=rewards(5);scanning_process=false;descending_scan=false;
        else
            [xag(4),yag(4),r4] = scan_act(xag(4),yag(4),xag,yag);
            [~,expscan4_indx]=ismember(explored_points,[xag(4),yag(4)],'rows');
            if(~any(expscan4_indx))
                explored_points(end+1,1:end)=[xag(4),yag(4)];
                explored_points=unique(explored_points,'rows');
                r4=rewards(1);
            end
        end
end
end