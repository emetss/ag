function [sp_,targets1,targets2,targets3,targets4] = s_fz(xf1,yf1,xf2,yf2,xag,yag)
global explored_points;global total_points;global fish1_rec_counter;global targ1_fish1_x;global targ1_fish1_y;
global fish2_rec_counter;global targ1_fish2_x;global targ1_fish2_y;global grid_matrix;global ship_s1_rec_counter;
global ship_s2_rec_counter;global ship_l1_rec_counter;global ship_l2_rec_counter;
global plant1_rec_counter;global plant2_rec_counter;global plant3_rec_counter;
global plant1_smp_flag;global plant2_smp_flag;global plant3_smp_flag;
global trash1_flag;global trash2_flag;global trash3_flag;global targ2_fish1_x;global targ2_fish1_y;global targ3_fish1_x;global targ3_fish1_y;
global targ2_fish2_x;global targ2_fish2_y;global targ3_fish2_x;global targ3_fish2_y;global ship_l2_small_rec_counter;
global ship_l1_small_rec_counter;
global targ4_fish1_x;global targ4_fish2_x;global targ4_fish1_y;global targ4_fish2_y;
global targ_flags;
global fish1_flag;global fish2_flag;global scan_targets;global scan_pos;
% global targets1;global targets2;global targets3;global targets4;
global first_free;global second_free;global third_free;
global first_descending_scan;global second_descending_scan;global third_descending_scan;
global ymax;global ymin;global xmax;global xmin;
ag_v_rng{1}=[[xag(1)+1,yag(1)];[xag(1),yag(1)+1];[xag(1)+1,yag(1)+1];[xag(1)-1,yag(1)];[xag(1),yag(1)-1];[xag(1)-1,yag(1)-1];[xag(1)+2,yag(1)];[xag(1),yag(1)+2];[xag(1),yag(1)-2];[xag(1)-2,yag(1)];[xag(1)+1,yag(1)-1];[xag(1)-1,yag(1)+1]];
ag_v_rng{2}=[[xag(2)+1,yag(2)];[xag(2),yag(2)+1];[xag(2)+1,yag(2)+1];[xag(2)-1,yag(2)];[xag(2),yag(2)-1];[xag(2)-1,yag(2)-1];[xag(2)+2,yag(2)];[xag(2),yag(2)+2];[xag(2),yag(2)-2];[xag(2)-2,yag(2)];[xag(2)+1,yag(2)-1];[xag(2)-1,yag(2)+1]];
ag_v_rng{3}=[[xag(3)+1,yag(3)];[xag(3),yag(3)+1];[xag(3)+1,yag(3)+1];[xag(3)-1,yag(3)];[xag(3),yag(3)-1];[xag(3)-1,yag(3)-1];[xag(3)+2,yag(3)];[xag(3),yag(3)+2];[xag(3),yag(3)-2];[xag(3)-2,yag(3)];[xag(3)+1,yag(3)-1];[xag(3)-1,yag(3)+1]];
ag_v_rng{4}=[[xag(4)+1,yag(4)];[xag(4),yag(4)+1];[xag(4)+1,yag(4)+1];[xag(4)-1,yag(4)];[xag(4),yag(4)-1];[xag(4)-1,yag(4)-1];[xag(4)+2,yag(4)];[xag(4),yag(4)+2];[xag(4),yag(4)-2];[xag(4)-2,yag(4)];[xag(4)+1,yag(4)-1];[xag(4)-1,yag(4)+1]];
%=================================================================================
%====================================================================================
[~,found1_fish1_indx]=ismember(ag_v_rng{1},[xf1,yf1],'rows');
[~,found1_fish2_indx]=ismember(ag_v_rng{1},[xf2,yf2],'rows');
[~,found2_fish1_indx]=ismember(ag_v_rng{2},[xf1,yf1],'rows');
[~,found2_fish2_indx]=ismember(ag_v_rng{2},[xf2,yf2],'rows');
[~,found3_fish1_indx]=ismember(ag_v_rng{3},[xf1,yf1],'rows');
[~,found3_fish2_indx]=ismember(ag_v_rng{3},[xf2,yf2],'rows');
[~,found4_fish1_indx]=ismember(ag_v_rng{4},[xf1,yf1],'rows');
[~,found4_fish2_indx]=ismember(ag_v_rng{4},[xf2,yf2],'rows');
%====================================================================================
if (((xag(1)==xf1)&&(yag(1)==yf1))&&(fish1_rec_counter<5))
    switch grid_matrix(xag(1),yag(1))
        case 1
            if ship_s1_rec_counter<5
                sp_(1)=41;
                targ_flags(1,1)=true;
            else
                sp_(1)=4;
                targ_flags(1,1)=false;
            end
        case 2
            if ship_s2_rec_counter<5
                targ_flags(1,2)=true;
                sp_(1)=41;
            else
                sp_(1)=4;
                targ_flags(1,2)=false;
            end
        case 3
            if ship_l1_rec_counter<5
                sp_(1)=41;
                targ_flags(1,3)=true;
            else
                sp_(1)=4;
                targ_flags(1,3)=false;
            end
            if ship_l1_small_rec_counter<5
                targ_flags(1,14)=true;
            else
                targ_flags(1,14)=false;
            end
        case 4
            if ship_l2_rec_counter<5
                sp_(1)=41;
                targ_flags(1,4)=true;
            else
                sp_(1)=4;
                targ_flags(1,4)=false;
            end
            if ship_l2_small_rec_counter<5
                targ_flags(1,15)=true;
            else
                targ_flags(1,15)=false;
            end
        case 5
            if plant1_rec_counter<5
                sp_(1)=24;
                targ_flags(1,5)=true;
            else
                sp_(1)=4;
                targ_flags(1,5)=false;
            end
            if plant1_smp_flag==0
                targ_flags(1,8)=true;
            else
                targ_flags(1,8)=false;
            end
        case 6
            if plant2_rec_counter<5
                sp_(1)=24;
                targ_flags(1,6)=true;
            else
                sp_(1)=4;
                targ_flags(1,6)=false;
            end
            if plant2_smp_flag==0
                targ_flags(1,9)=true;
            else
                targ_flags(1,9)=false;
            end
        case 7
            if plant3_rec_counter<5
                sp_(1)=24;
                targ_flags(1,7)=true;
            else
                sp_(1)=4;
                targ_flags(1,7)=false;
            end
            if plant3_smp_flag==0
                targ_flags(1,10)=true;
            else
                targ_flags(1,10)=false;
            end
        case 10
            sp_(1)=4;
            if trash1_flag==0
                targ_flags(1,11)=true;
            else
                targ_flags(1,11)=false;
            end
        case 11
            sp_(1)=4;
            if trash2_flag==0
                targ_flags(1,12)=true;
            else
                targ_flags(1,12)=false;
            end
        case 12
            sp_(1)=4;
            if trash3_flag==0
                targ_flags(1,13)=true;
            else
                targ_flags(1,13)=false;
            end
        otherwise
            sp_(1)=4;
    end
    targ1_fish1_x=xf1;targ1_fish1_y=yf1;
%     targ1_fish2_x=-99;targ1_fish2_y=-99;
elseif (((xag(1)==xf2)&&(yag(1)==yf2))&&(fish2_rec_counter<5))
    switch grid_matrix(xag(1),yag(1))
        case 1
            if ship_s1_rec_counter<5
                targ_flags(1,1)=true;
                sp_(1)=41;
            else
                targ_flags(1,1)=false;
                sp_(1)=4;
            end
        case 2
            if ship_s2_rec_counter<5
                sp_(1)=41;
                targ_flags(1,2)=true;
            else
                sp_(1)=4;
                targ_flags(1,2)=false;
            end
        case 3
            if ship_l1_rec_counter<5
                sp_(1)=41;
                targ_flags(1,3)=true;
            else
                sp_(1)=4;
                targ_flags(1,3)=false;
            end
            if ship_l1_small_rec_counter<5
                targ_flags(1,14)=true;
            else
                targ_flags(1,14)=false;
            end
        case 4
            if ship_l2_rec_counter<5
                sp_(1)=41;
                targ_flags(1,4)=true;
            else
                sp_(1)=4;
                targ_flags(1,4)=false;
            end
            if ship_l2_small_rec_counter<5
                targ_flags(1,15)=true;
            else
                targ_flags(1,15)=false;
            end
        case 5
            if plant1_rec_counter<5
                sp_(1)=24;
                targ_flags(1,5)=true;
            else
                sp_(1)=4;
                targ_flags(1,5)=false;
            end
            if plant1_smp_flag==0
                targ_flags(1,8)=true;
            else
                targ_flags(1,8)=false;
            end
        case 6
            if plant2_rec_counter<5
                sp_(1)=24;
                targ_flags(1,6)=true;
            else
                sp_(1)=4;
                targ_flags(1,6)=false;
            end
            if plant2_smp_flag==0
                targ_flags(1,9)=true;
            else
                targ_flags(1,9)=false;
            end
        case 7
            if plant3_rec_counter<5
                sp_(1)=24;
                targ_flags(1,7)=true;
            else
                sp_(1)=4;
                targ_flags(1,7)=false;
            end
            if plant3_smp_flag==0
                targ_flags(1,10)=true;
            else
                targ_flags(1,10)=false;
            end
        case 10
            sp_(1)=4;
            if trash1_flag==0
                targ_flags(1,11)=true;
            else
                targ_flags(1,11)=false;
            end
        case 11
            sp_(1)=4;
            if trash2_flag==0
                targ_flags(1,12)=true;
            else
                targ_flags(1,12)=false;
            end
        case 12
            sp_(1)=4;
            if trash3_flag==0
                targ_flags(1,13)=true;
            else
                targ_flags(1,13)=false;
            end
        otherwise
            sp_(1)=4;
    end
    targ1_fish2_x=xf2;targ1_fish2_y=yf2;
%     targ1_fish1_x=-99;targ1_fish1_y=-99;
elseif (((any(found1_fish1_indx)))&&(fish1_rec_counter<5))
    switch grid_matrix(xag(1),yag(1))
        case 1
            if ship_s1_rec_counter<5
                sp_(1)=31;
                targ_flags(1,1)=true;
            else
                sp_(1)=3;
                targ_flags(1,1)=false;
            end
        case 2
            if ship_s2_rec_counter<5
                sp_(1)=31;
                targ_flags(1,2)=true;
            else
                sp_(1)=3;
                targ_flags(1,2)=false;
            end
        case 3
            if ship_l1_rec_counter<5
                sp_(1)=31;
                targ_flags(1,3)=true;
            else
                sp_(1)=3;
                targ_flags(1,3)=false;
            end
            if ship_l1_small_rec_counter<5
                targ_flags(1,14)=true;
            else
                targ_flags(1,14)=false;
            end
        case 4
            if ship_l2_rec_counter<5
                sp_(1)=31;
                targ_flags(1,4)=true;
            else
                sp_(1)=3;
                targ_flags(1,4)=false;
            end
            if ship_l2_small_rec_counter<5
                targ_flags(1,15)=true;
            else
                targ_flags(1,15)=false;
            end
        case 5
            if plant1_rec_counter<5
                sp_(1)=32;
                targ_flags(1,5)=true;
            else
                sp_(1)=3;
                targ_flags(1,5)=false;
            end
            if plant1_smp_flag==0
                targ_flags(1,8)=true;
            else
                targ_flags(1,8)=false;
            end
        case 6
            if plant2_rec_counter<5
                sp_(1)=32;
                targ_flags(1,6)=true;
            else
                sp_(1)=3;
                targ_flags(1,6)=false;
            end
            if plant2_smp_flag==0
                targ_flags(1,9)=true;
            else
                targ_flags(1,9)=false;
            end
        case 7
            if plant3_rec_counter<5
                sp_(1)=32;
                targ_flags(1,7)=true;
            else
                sp_(1)=3;
                targ_flags(1,7)=false;
            end
            if plant3_smp_flag==0
                targ_flags(1,10)=true;
            else
                targ_flags(1,10)=false;
            end
        case 10
            sp_(1)=3;
            if trash1_flag==0
                targ_flags(1,11)=true;
            else
                targ_flags(1,11)=false;
            end
        case 11
            sp_(1)=3;
            if trash2_flag==0
                targ_flags(1,12)=true;
            else
                targ_flags(1,12)=false;
            end
        case 12
            sp_(1)=3;
            if trash3_flag==0
                targ_flags(1,13)=true;
            else
                targ_flags(1,13)=false;
            end
        otherwise
            sp_(1)=3;
    end
    targ1_fish1_x=xf1;targ1_fish1_y=yf1;
%     targ1_fish2_x=-99;targ1_fish2_y=-99;
elseif (((any(found1_fish2_indx)))&&(fish2_rec_counter<5))
    switch grid_matrix(xag(1),yag(1))
        case 1
            if ship_s1_rec_counter<5
                sp_(1)=31;
                targ_flags(1,1)=true;
            else
                sp_(1)=3;
                targ_flags(1,1)=false;
            end
        case 2
            if ship_s2_rec_counter<5
                sp_(1)=31;
                targ_flags(1,2)=true;
            else
                sp_(1)=3;
                targ_flags(1,2)=false;
            end
        case 3
            if ship_l1_rec_counter<5
                sp_(1)=31;
                targ_flags(1,3)=true;
            else
                sp_(1)=3;
                targ_flags(1,3)=false;
            end
            if ship_l1_small_rec_counter<5
                targ_flags(1,14)=true;
            else
                targ_flags(1,14)=false;
            end
        case 4
            if ship_l2_rec_counter<5
                sp_(1)=31;
                targ_flags(1,4)=true;
            else
                sp_(1)=3;
                targ_flags(1,4)=false;
            end
            if ship_l2_small_rec_counter<5
                targ_flags(1,15)=true;
            else
                targ_flags(1,15)=false;
            end
        case 5
            if plant1_rec_counter<5
                sp_(1)=32;
                targ_flags(1,5)=true;
            else
                sp_(1)=3;
                targ_flags(1,5)=false;
            end
            if ~plant1_smp_flag
                targ_flags(1,8)=true;
            else
                targ_flags(1,8)=false;
            end
        case 6
            if plant2_rec_counter<5
                sp_(1)=32;
                targ_flags(1,6)=true;
            else
                sp_(1)=3;
                targ_flags(1,6)=false;
            end
            if ~plant2_smp_flag
                targ_flags(1,9)=true;
            else
                targ_flags(1,9)=false;
            end
        case 7
            if plant3_rec_counter<5
                sp_(1)=32;
                targ_flags(1,7)=true;
            else
                sp_(1)=3;
                targ_flags(1,7)=false;
            end
            if ~plant3_smp_flag
                targ_flags(1,10)=true;
            else
                targ_flags(1,10)=false;
            end
        case 10
            sp_(1)=3;
            if ~trash1_flag
                targ_flags(1,11)=true;
            else
                targ_flags(1,11)=false;
            end
        case 11
            sp_(1)=3;
            if ~trash2_flag
                targ_flags(1,12)=true;
            else
                targ_flags(1,12)=false;
            end
        case 12
            sp_(1)=3;
            if ~trash3_flag
                targ_flags(1,13)=true;
            else
                targ_flags(1,13)=false;
            end
        otherwise
            sp_(1)=3;
    end
    targ1_fish2_x=xf2;targ1_fish2_y=yf2;
%     targ1_fish1_x=-99;targ1_fish1_y=-99;
else
    targ1_fish1_x=-99;targ1_fish1_y=-99;
    targ1_fish2_x=-99;targ1_fish2_y=-99;
    switch grid_matrix(xag(1),yag(1))
        case 0
            sp_(1)=0;
        case 1
            if ship_s1_rec_counter<5
                sp_(1)=1;
                targ_flags(1,1)=true;
            else
                targ_flags(1,1)=false;
                sp_(1)=0;
            end
        case 2
            if ship_s2_rec_counter<5
                sp_(1)=1;
                targ_flags(1,2)=true;
            else
                targ_flags(1,2)=false;
                sp_(1)=0;
            end
        case 3
            if (ship_l1_rec_counter<5)&&(ship_l1_small_rec_counter>=5)
                sp_(1)=1;
                targ_flags(1,3)=true;targ_flags(1,14)=false;
            elseif (ship_l1_rec_counter>=5)&&(ship_l1_small_rec_counter>=5)
                sp_(1)=0;
                targ_flags(1,3)=false;targ_flags(1,14)=false;
            elseif (ship_l1_small_rec_counter<5)&&(ship_l1_rec_counter<5)
                sp_(1)=1;
                targ_flags(1,3)=true;targ_flags(1,14)=true;
            elseif (ship_l1_rec_counter>=5)&&(ship_l1_small_rec_counter<5)
                sp_(1)=0;
                targ_flags(1,14)=true;targ_flags(1,3)=false;
%             else
%                 sp_(1)=0;
            end
        case 4
            if (ship_l2_rec_counter<5)&&(ship_l2_small_rec_counter>=5)
                sp_(1)=1;
                targ_flags(1,4)=true;targ_flags(1,15)=false;
            elseif (ship_l2_rec_counter>=5)&&(ship_l2_small_rec_counter>=5)
                sp_(1)=0;
                targ_flags(1,4)=false;targ_flags(1,15)=false;
            elseif (ship_l2_small_rec_counter<5)&&(ship_l2_rec_counter>=5)
                sp_(1)=0;
                targ_flags(1,4)=false;targ_flags(1,15)=true;
            elseif (ship_l2_rec_counter<5)&&(ship_l2_small_rec_counter<5)
                sp_(1)=1;
                targ_flags(1,15)=true;targ_flags(1,4)=true;
%             else
%                 sp_(1)=0;
            end
        case 5
            if (plant1_rec_counter<5)&&(plant1_smp_flag)
                sp_(1)=2;
                targ_flags(1,5)=true;targ_flags(1,8)=false;
            elseif (plant1_rec_counter>=5)&&(plant1_smp_flag)
                targ_flags(1,5)=false;targ_flags(1,8)=false;
                sp_(1)=0;
            elseif (plant1_rec_counter>=5)&&(~plant1_smp_flag)
                targ_flags(1,5)=false;targ_flags(1,8)=true;
                sp_(1)=0;
            elseif (plant1_rec_counter<5)&&(~plant1_smp_flag)
                targ_flags(1,5)=true;targ_flags(1,8)=true;
                sp_(1)=2;
%             else
%                 sp_(1)=0;
            end
        case 6
            if (plant2_rec_counter<5)&&(plant2_smp_flag)
                sp_(1)=2;
                targ_flags(1,6)=true;targ_flags(1,9)=false;
            elseif (plant2_rec_counter>=5)&&(plant2_smp_flag)
                targ_flags(1,6)=false;targ_flags(1,9)=false;
                sp_(1)=0;
            elseif (plant2_rec_counter>=5)&&(~plant2_smp_flag)
                targ_flags(1,6)=false;targ_flags(1,9)=true;
                sp_(1)=0;
            elseif (plant2_rec_counter<5)&&(~plant2_smp_flag)
                targ_flags(1,6)=true;targ_flags(1,9)=true;
                sp_(1)=2;
%             else
%                 sp_(1)=0;
            end
        case 7
            if (plant3_rec_counter<5)&&(plant3_smp_flag)
                sp_(1)=2;
                targ_flags(1,7)=true;targ_flags(1,10)=false;
            elseif (plant3_rec_counter>=5)&&(plant3_smp_flag)
                targ_flags(1,7)=false;targ_flags(1,10)=false;
                sp_(1)=0;
            elseif (plant3_rec_counter>=5)&&(~plant3_smp_flag)
                targ_flags(1,7)=false;targ_flags(1,10)=true;
                sp_(1)=0;
            elseif (plant3_rec_counter<5)&&(~plant3_smp_flag)
                targ_flags(1,7)=true;targ_flags(1,10)=true;
                sp_(1)=2;
%             else
%                 sp_(1)=0;
            end
        case 10
            if ~trash1_flag
                targ_flags(1,11)=true;
                sp_(1)=0;
            elseif trash1_flag==true
                sp_(1)=0;
                targ_flags(1,11)=false;
            end
        case 11
            if ~trash2_flag
                targ_flags(1,12)=true;
                sp_(1)=0;
            elseif trash2_flag==true
                targ_flags(1,12)=false;
                sp_(1)=0;
            end
        case 12
            if ~trash3_flag
                targ_flags(1,13)=true;
                sp_(1)=0;
            elseif trash3_flag==true
                targ_flags(1,13)=false;
                sp_(1)=0;
            end
        otherwise
            sp_(1)=0;
    end
end
%====================================================================================
% [~,found2_fish1_indx]=ismember(ag_v_rng{2},[xf1,yf1],'rows');
% [~,found2_fish2_indx]=ismember(ag_v_rng{2},[xf2,yf2],'rows');
if (((xag(2)==xf1)&&(yag(2)==yf1))&&(fish1_rec_counter<5))
    switch grid_matrix(xag(2),yag(2))
        case 1
            sp_(2)=4;
            if ship_s1_rec_counter<5
                targ_flags(1,1)=true;
            else
                targ_flags(1,1)=false;
            end
        case 2
            sp_(2)=4;
            if ship_s2_rec_counter<5
                targ_flags(1,2)=true;
            else
                targ_flags(1,2)=false;
            end
        case 3
            sp_(2)=4;
            if ship_l1_rec_counter<5
                targ_flags(1,3)=true;
            else
                targ_flags(1,3)=false;
            end
            if ship_l1_small_rec_counter<5
                targ_flags(1,14)=true;
            else
                targ_flags(1,14)=false;
            end
        case 4
            sp_(2)=4;
            if ship_l2_rec_counter<5
                targ_flags(1,4)=true;
            else
                targ_flags(1,4)=false;
            end
            if ship_l2_small_rec_counter<5
                targ_flags(1,15)=true;
            else
                targ_flags(1,15)=false;
            end
        case 5
            if plant1_rec_counter<5
                targ_flags(1,5)=true;
            else
                targ_flags(1,5)=false;
            end
            if plant1_smp_flag==0
                sp_(2)=54;
                targ_flags(1,8)=true;
            else
                sp_(2)=4;
                targ_flags(1,8)=false;
            end
        case 6
            if plant2_rec_counter<5
                targ_flags(1,6)=true;
            else
                targ_flags(1,6)=false;
            end
            if plant2_smp_flag==0
                sp_(2)=54;
                targ_flags(1,9)=true;
            else
                sp_(2)=4;
                targ_flags(1,9)=false;
            end
        case 7
            if plant3_rec_counter<5
                targ_flags(1,7)=true;
            else
                targ_flags(1,7)=false;
            end
            if plant3_smp_flag==0
                sp_(2)=54;
                targ_flags(1,10)=true;
            else
                sp_(2)=4;
                targ_flags(1,10)=false;
            end
        case 10
            sp_(2)=4;
            if trash1_flag==0
                targ_flags(1,11)=true;
            else
                targ_flags(1,11)=false;
            end
        case 11
            sp_(2)=4;
            if trash2_flag==0
                targ_flags(1,12)=true;
            else
                targ_flags(1,12)=false;
            end
        case 12
            sp_(2)=4;
            if trash3_flag==0
                targ_flags(1,13)=true;
            else
                targ_flags(1,13)=false;
            end
        otherwise
            sp_(2)=4;
    end
    targ2_fish1_x=xf1;targ2_fish1_y=yf1;
%     targ2_fish2_x=-99;targ2_fish2_y=-99;
elseif (((xag(2)==xf2)&&(yag(2)==yf2))&&(fish2_rec_counter<5))
    switch grid_matrix(xag(2),yag(2))
        case 1
            sp_(2)=4;
            if ship_s1_rec_counter<5
                targ_flags(1,1)=true;
            else
                targ_flags(1,1)=false;
            end
        case 2
            sp_(2)=4;
            if ship_s2_rec_counter<5
                targ_flags(1,2)=true;
            else
                targ_flags(1,2)=false;
            end
        case 3
            sp_(2)=4;
            if ship_l1_rec_counter<5
                targ_flags(1,3)=true;
            else
                targ_flags(1,3)=false;
            end
            if ship_l1_small_rec_counter<5
                targ_flags(1,14)=true;
            else
                targ_flags(1,14)=false;
            end
        case 4
            sp_(2)=4;
            if ship_l2_rec_counter<5
                targ_flags(1,4)=true;
            else
                targ_flags(1,4)=false;
            end
            if ship_l2_small_rec_counter<5
                targ_flags(1,15)=true;
            else
                targ_flags(1,15)=false;
            end
        case 5
            if plant1_rec_counter<5
                targ_flags(1,5)=true;
            else
                targ_flags(1,5)=false;
            end
            if plant1_smp_flag==0
                sp_(2)=54;
                targ_flags(1,8)=true;
            else
                sp_(2)=4;
                targ_flags(1,8)=false;
            end
        case 6
            if plant2_rec_counter<5
                targ_flags(1,6)=true;
            else
                targ_flags(1,6)=false;
            end
            if plant2_smp_flag==0
                sp_(2)=54;
                targ_flags(1,9)=true;
            else
                sp_(2)=4;
                targ_flags(1,9)=false;
            end
        case 7
            if plant3_rec_counter<5
                targ_flags(1,7)=true;
            else
                targ_flags(1,7)=false;
            end
            if plant3_smp_flag==0
                sp_(2)=54;
                targ_flags(1,10)=true;
            else
                sp_(2)=4;
                targ_flags(1,10)=false;
            end
        case 10
            sp_(2)=4;
            if trash1_flag==0
                targ_flags(1,11)=true;
            else
                targ_flags(1,11)=false;
            end
        case 11
            sp_(2)=4;
            if trash2_flag==0
                targ_flags(1,12)=true;
            else
                targ_flags(1,12)=false;
            end
        case 12
            sp_(2)=4;
            if trash3_flag==0
                targ_flags(1,13)=true;
            else
                targ_flags(1,13)=false;
            end
        otherwise
            sp_(2)=4;
    end
    targ2_fish2_x=xf2;targ2_fish2_y=yf2;
%     targ2_fish1_x=-99;targ2_fish1_y=-99;
elseif (((any(found2_fish1_indx))==1)&&(fish1_rec_counter<5))
    switch grid_matrix(xag(2),yag(2))
        case 1
            sp_(2)=3;
            if ship_s1_rec_counter<5
                targ_flags(1,1)=true;
            else
                targ_flags(1,1)=false;
            end
        case 2
            sp_(2)=3;
            if ship_s2_rec_counter<5
                targ_flags(1,2)=true;
            else
                targ_flags(1,2)=false;
            end
        case 3
            sp_(2)=3;
            if ship_l1_rec_counter<5
                targ_flags(1,3)=true;
            else
                targ_flags(1,3)=false;
            end
            if ship_l1_small_rec_counter<5
                targ_flags(1,14)=true;
            else
                targ_flags(1,14)=false;
            end
        case 4
            sp_(2)=3;
            if ship_l2_rec_counter<5
                targ_flags(1,4)=true;
            else
                targ_flags(1,4)=false;
            end
            if ship_l2_small_rec_counter<5
                targ_flags(1,15)=true;
            else
                targ_flags(1,15)=false;
            end
        case 5
            if plant1_rec_counter<5
                targ_flags(1,5)=true;
            else
                targ_flags(1,5)=false;
            end
            if plant1_smp_flag==0
                sp_(2)=53;
                targ_flags(1,8)=true;
            else
                sp_(2)=3;
                targ_flags(1,8)=false;
            end
        case 6
            if plant2_rec_counter<5
                targ_flags(1,6)=true;
            else
                targ_flags(1,6)=false;
            end
            if plant2_smp_flag==0
                sp_(2)=53;
                targ_flags(1,9)=true;
            else
                sp_(2)=3;
                targ_flags(1,9)=false;
            end
        case 7
            if plant3_rec_counter<5
                targ_flags(1,7)=true;
            else
                targ_flags(1,7)=false;
            end
            if plant3_smp_flag==0
                sp_(2)=53;
                targ_flags(1,10)=true;
            else
                sp_(2)=3;
                targ_flags(1,10)=false;
            end
        case 10
            sp_(2)=3;
            if trash1_flag==0
                targ_flags(1,11)=true;
            else
                targ_flags(1,11)=false;
            end
        case 11
            sp_(2)=3;
            if trash2_flag==0
                targ_flags(1,12)=true;
            else
                targ_flags(1,12)=false;
            end
        case 12
            sp_(2)=3;
            if trash3_flag==0
                targ_flags(1,13)=true;
            else
                targ_flags(1,13)=false;
            end
        otherwise
            sp_(2)=3;
    end
    targ2_fish1_x=xf1;targ2_fish1_y=yf1;
%     targ2_fish2_x=-99;targ2_fish2_y=-99;
elseif (((any(found2_fish2_indx))==1)&&(fish2_rec_counter<5))
    switch grid_matrix(xag(2),yag(2))
        case 1
            sp_(2)=3;
            if ship_s1_rec_counter<5
                targ_flags(1,1)=true;
            else
                targ_flags(1,1)=false;
            end
        case 2
            sp_(2)=3;
            if ship_s2_rec_counter<5
                targ_flags(1,2)=true;
            else
                targ_flags(1,2)=false;
            end
        case 3
            sp_(2)=3;
            if ship_l1_rec_counter<5
                targ_flags(1,3)=true;
            else
                targ_flags(1,3)=false;
            end
            if ship_l1_small_rec_counter<5
                targ_flags(1,14)=true;
            else
                targ_flags(1,14)=false;
            end
        case 4
            sp_(2)=3;
            if ship_l2_rec_counter<5
                targ_flags(1,4)=true;
            else
                targ_flags(1,4)=false;
            end
            if ship_l2_small_rec_counter<5
                targ_flags(1,15)=true;
            else
                targ_flags(1,15)=false;
            end
        case 5
            if plant1_rec_counter<5
                targ_flags(1,5)=true;
            else
                targ_flags(1,5)=false;
            end
            if plant1_smp_flag==0
                sp_(2)=53;
                targ_flags(1,8)=true;
            else
                targ_flags(1,8)=false;
                sp_(2)=3;
            end
        case 6
            if plant2_rec_counter<5
                targ_flags(1,6)=true;
            else
                targ_flags(1,6)=false;
            end
            if plant2_smp_flag==0
                sp_(2)=53;
                targ_flags(1,9)=true;
            else
                sp_(2)=3;
                targ_flags(1,9)=false;
            end
        case 7
            if plant3_rec_counter<5
                targ_flags(1,7)=true;
            else
                targ_flags(1,7)=false;
            end
            if plant3_smp_flag==0
                sp_(2)=53;
                targ_flags(1,10)=true;
            else
                sp_(2)=3;
                targ_flags(1,10)=false;
            end
        case 10
            sp_(2)=3;
            if trash1_flag==0
                targ_flags(1,11)=true;
            else
                targ_flags(1,11)=false;
            end
        case 11
            sp_(2)=3;
            if trash2_flag==0
                targ_flags(1,12)=true;
            else
                targ_flags(1,12)=false;
            end
        case 12
            sp_(2)=3;
            if trash3_flag==0
                targ_flags(1,13)=true;
            else
                targ_flags(1,13)=false;
            end
        otherwise
            sp_(2)=3;
    end
    targ2_fish2_x=xf2;targ2_fish2_y=yf2;
%     targ2_fish1_x=-99;targ2_fish1_y=-99;
else
    targ2_fish1_x=-99;targ2_fish1_y=-99;
    targ2_fish2_x=-99;targ2_fish2_y=-99;
    switch grid_matrix(xag(2),yag(2))
        case 0
            sp_(2)=0;
        case 1
            if ship_s1_rec_counter<5
                sp_(2)=0;
                targ_flags(1,1)=true;
            else
                targ_flags(1,1)=false;
                sp_(2)=0;
            end
        case 2
            if ship_s2_rec_counter<5
                sp_(2)=0;
                targ_flags(1,2)=true;
            else
                targ_flags(1,2)=false;
                sp_(2)=0;
            end
        case 3
            if (ship_l1_rec_counter<5)&&(ship_l1_small_rec_counter>=5)
                sp_(2)=0;
                targ_flags(1,3)=true;targ_flags(1,14)=false;
            elseif (ship_l1_rec_counter>=5)&&(ship_l1_small_rec_counter>=5)
                sp_(2)=0;
                targ_flags(1,3)=false;targ_flags(1,14)=false;
            elseif (ship_l1_small_rec_counter<5)&&(ship_l1_rec_counter<5)
                sp_(2)=0;
                targ_flags(1,3)=true;targ_flags(1,14)=true;
            elseif (ship_l1_rec_counter>=5)&&(ship_l1_small_rec_counter<5)
                sp_(2)=0;
                targ_flags(1,14)=true;targ_flags(1,3)=false;
%             else
%                 sp_(2)=0;
            end
        case 4
            if (ship_l2_rec_counter<5)&&(ship_l2_small_rec_counter>=5)
                sp_(2)=0;
                targ_flags(1,4)=true;targ_flags(1,15)=false;
            elseif (ship_l2_rec_counter>=5)&&(ship_l2_small_rec_counter>=5)
                sp_(2)=0;
                targ_flags(1,4)=false;targ_flags(1,15)=false;
            elseif (ship_l2_small_rec_counter<5)&&(ship_l2_rec_counter>=5)
                sp_(2)=0;
                targ_flags(1,4)=false;targ_flags(1,15)=true;
            elseif (ship_l2_rec_counter<5)&&(ship_l2_small_rec_counter<5)
                sp_(2)=0;
                targ_flags(1,15)=true;targ_flags(1,4)=true;
%             else
%                 sp_(2)=0;
            end
        case 5
            if (plant1_rec_counter<5)&&(plant1_smp_flag==1)
                sp_(2)=0;
                targ_flags(1,5)=true;targ_flags(1,8)=false;
            elseif (plant1_rec_counter>=5)&&(plant1_smp_flag==1)
                targ_flags(1,5)=false;targ_flags(1,8)=false;
                sp_(2)=0;
            elseif (plant1_rec_counter>=5)&&(plant1_smp_flag==0)
                targ_flags(1,5)=false;targ_flags(1,8)=true;
                sp_(2)=5;
            elseif (plant1_rec_counter<5)&&(plant1_smp_flag==0)
                targ_flags(1,5)=true;targ_flags(1,8)=true;
                sp_(2)=5;
%             else
%                 sp_(2)=0;
            end
        case 6
            if (plant2_rec_counter<5)&&(plant2_smp_flag==1)
                sp_(2)=0;
                targ_flags(1,6)=true;targ_flags(1,9)=false;
            elseif (plant2_rec_counter>=5)&&(plant2_smp_flag==1)
                targ_flags(1,6)=false;targ_flags(1,9)=false;
                sp_(2)=0;
            elseif (plant2_rec_counter>=5)&&(plant2_smp_flag==0)
                targ_flags(1,6)=false;targ_flags(1,9)=true;
                sp_(2)=5;
            elseif (plant2_rec_counter<5)&&(plant2_smp_flag==0)
                targ_flags(1,6)=true;targ_flags(1,9)=true;
                sp_(2)=5;
%             else
%                 sp_(2)=0;
            end
        case 7
            if (plant3_rec_counter<5)&&(plant3_smp_flag==1)
                sp_(2)=0;
                targ_flags(1,7)=true;targ_flags(1,10)=false;
            elseif (plant3_rec_counter>=5)&&(plant3_smp_flag==1)
                targ_flags(1,7)=false;targ_flags(1,10)=false;
                sp_(2)=0;
            elseif (plant3_rec_counter>=5)&&(plant3_smp_flag==0)
                targ_flags(1,7)=false;targ_flags(1,10)=true;
                sp_(2)=5;
            elseif (plant3_rec_counter<5)&&(plant3_smp_flag==0)
                targ_flags(1,7)=true;targ_flags(1,10)=true;
                sp_(2)=5;
%             else
%                 sp_(2)=0;
            end
        case 10
            if ~trash1_flag
                targ_flags(1,11)=true;
                sp_(2)=0;
            elseif trash1_flag==true
                sp_(2)=0;
                targ_flags(1,11)=false;
            end
        case 11
            if ~trash2_flag
                targ_flags(1,12)=true;
                sp_(2)=0;
            elseif trash2_flag==true
                targ_flags(1,12)=false;
                sp_(2)=0;
            end
        case 12
            if ~trash3_flag
                targ_flags(1,13)=true;
                sp_(2)=0;
            elseif trash3_flag==true
                targ_flags(1,13)=false;
                sp_(2)=0;
            end
        otherwise
            sp_(2)=0;
    end
end
%====================================================================================
% [~,found3_fish1_indx]=ismember(ag_v_rng{3},[xf1,yf1],'rows');
% [~,found3_fish2_indx]=ismember(ag_v_rng{3},[xf2,yf2],'rows');
if (((xag(3)==xf1)&&(yag(3)==yf1))&&(fish1_rec_counter<5))
    switch grid_matrix(xag(3),yag(3))
        case 1
            sp_(3)=4;
            if ship_s1_rec_counter<5
                targ_flags(1,1)=true;
            else
                targ_flags(1,1)=false;
            end
        case 2
            sp_(3)=4;
            if ship_s2_rec_counter<5
                targ_flags(1,2)=true;
            else
                targ_flags(1,2)=false;
            end
        case 3
            sp_(3)=4;
            if ship_l1_rec_counter<5
                targ_flags(1,3)=true;
            else
                targ_flags(1,3)=false;
            end
            if ship_l1_small_rec_counter<5
                targ_flags(1,14)=true;
            else
                targ_flags(1,14)=false;
            end
        case 4
            sp_(3)=4;
            if ship_l2_rec_counter<5
                targ_flags(1,4)=true;
            else
                targ_flags(1,4)=false;
            end
            if ship_l2_small_rec_counter<5
                targ_flags(1,15)=true;
            else
                targ_flags(1,15)=false;
            end
        case 5
            sp_(3)=4;
            if plant1_rec_counter<5
                targ_flags(1,5)=true;
            else
                targ_flags(1,5)=false;
            end
            if plant1_smp_flag==0
                targ_flags(1,8)=true;
            else
                targ_flags(1,8)=false;
            end
        case 6
            sp_(3)=4;
            if plant2_rec_counter<5
                targ_flags(1,6)=true;
            else
                targ_flags(1,6)=false;
            end
            if plant2_smp_flag==0
                targ_flags(1,9)=true;
            else
                targ_flags(1,9)=false;
            end
        case 7
            sp_(3)=4;
            if plant3_rec_counter<5
                targ_flags(1,7)=true;
            else
                targ_flags(1,7)=false;
            end
            if plant3_smp_flag==0
                targ_flags(1,10)=true;
            else
                targ_flags(1,10)=false;
            end
        case 10
            if trash1_flag==0
                sp_(3)=64;
                targ_flags(1,11)=true;
            else
                targ_flags(1,11)=false;
                sp_(3)=4;
            end
        case 11
            if trash2_flag==0
                sp_(3)=64;
                targ_flags(1,12)=true;
            else
                sp_(3)=4;
                targ_flags(1,12)=false;
            end
        case 12
            if trash3_flag==0
                sp_(3)=64;
                targ_flags(1,13)=true;
            else
                sp_(3)=4;
                targ_flags(1,13)=false;
            end
        otherwise
            sp_(3)=4;
    end
    targ3_fish1_x=xf1;targ3_fish1_y=yf1;
%     targ3_fish2_x=-99;targ3_fish2_y=-99;
elseif (((xag(3)==xf2)&&(yag(3)==yf2))&&(fish2_rec_counter<5))
    switch grid_matrix(xag(3),yag(3))
        case 1
            sp_(3)=4;
            if ship_s1_rec_counter<5
                targ_flags(1,1)=true;
            else
                targ_flags(1,1)=false;
            end
        case 2
            sp_(3)=4;
            if ship_s2_rec_counter<5
                targ_flags(1,2)=true;
            else
                targ_flags(1,2)=false;
            end
        case 3
            sp_(3)=4;
            if ship_l1_rec_counter<5
                targ_flags(1,3)=true;
            else
                targ_flags(1,3)=false;
            end
            if ship_l1_small_rec_counter<5
                targ_flags(1,14)=true;
            else
                targ_flags(1,14)=false;
            end
        case 4
            sp_(3)=4;
            if ship_l2_rec_counter<5
                targ_flags(1,4)=true;
            else
                targ_flags(1,4)=false;
            end
            if ship_l2_small_rec_counter<5
                targ_flags(1,15)=true;
            else
                targ_flags(1,15)=false;
            end
        case 5
            sp_(3)=4;
            if plant1_rec_counter<5
                targ_flags(1,5)=true;
            else
                targ_flags(1,5)=false;
            end
            if plant1_smp_flag==0
                targ_flags(1,8)=true;
            else
                targ_flags(1,8)=false;
            end
        case 6
            sp_(3)=4;
            if plant2_rec_counter<5
                targ_flags(1,6)=true;
            else
                targ_flags(1,6)=false;
            end
            if plant2_smp_flag==0
                targ_flags(1,9)=true;
            else
                targ_flags(1,9)=false;
            end
        case 7
            sp_(3)=4;
            if plant3_rec_counter<5
                targ_flags(1,7)=true;
            else
                targ_flags(1,7)=false;
            end
            if plant3_smp_flag==0
                targ_flags(1,10)=true;
            else
                targ_flags(1,10)=false;
            end
        case 10
            if trash1_flag==0
                sp_(3)=64;
                targ_flags(1,11)=true;
            else
                sp_(3)=4;
                targ_flags(1,11)=false;
            end
        case 11
            if trash2_flag==0
                sp_(3)=64;
                targ_flags(1,12)=true;
            else
                sp_(3)=4;
                targ_flags(1,12)=false;
            end
        case 12
            if trash3_flag==0
                sp_(3)=64;
                targ_flags(1,13)=true;
            else
                sp_(3)=4;
                targ_flags(1,13)=false;
            end
        otherwise
            sp_(3)=4;
    end
    targ3_fish2_x=xf2;targ3_fish2_y=yf2;
%     targ3_fish1_x=-99;targ3_fish1_y=-99;
elseif (((any(found3_fish1_indx))==1)&&(fish1_rec_counter<5))
    switch grid_matrix(xag(3),yag(3))
        case 1
            sp_(3)=3;
            if ship_s1_rec_counter<5
                targ_flags(1,1)=true;
            else
                targ_flags(1,1)=false;
            end
        case 2
            sp_(3)=3;
            if ship_s2_rec_counter<5
                targ_flags(1,2)=true;
            else
                targ_flags(1,2)=false;
            end
        case 3
            sp_(3)=3;
            if ship_l1_rec_counter<5
                targ_flags(1,3)=true;
            else
                targ_flags(1,3)=false;
            end
            if ship_l1_small_rec_counter<5
                targ_flags(1,14)=true;
            else
                targ_flags(1,14)=false;
            end
        case 4
            sp_(3)=3;
            if ship_l2_rec_counter<5
                targ_flags(1,4)=true;
            else
                targ_flags(1,4)=false;
            end
            if ship_l2_small_rec_counter<5
                targ_flags(1,15)=true;
            else
                targ_flags(1,15)=false;
            end
        case 5
            sp_(3)=3;
            if plant1_rec_counter<5
                targ_flags(1,5)=true;
            else
                targ_flags(1,5)=false;
            end
            if plant1_smp_flag==0
                targ_flags(1,8)=true;
            else
                targ_flags(1,8)=false;
            end
        case 6
            sp_(3)=3;
            if plant2_rec_counter<5
                targ_flags(1,6)=true;
            else
                targ_flags(1,6)=false;
            end
            if plant2_smp_flag==0
                targ_flags(1,9)=true;
            else
                targ_flags(1,9)=false;
            end
        case 7
            sp_(3)=3;
            if plant3_rec_counter<5
                targ_flags(1,7)=true;
            else
                targ_flags(1,7)=false;
            end
            if plant3_smp_flag==0
                targ_flags(1,10)=true;
            else
                targ_flags(1,10)=false;
            end
        case 10
            if trash1_flag==0
                sp_(3)=63;
                targ_flags(1,11)=true;
            else
                targ_flags(1,11)=false;
                sp_(3)=3;
            end
        case 11
            if trash2_flag==0
                sp_(3)=63;
                targ_flags(1,12)=true;
            else
                sp_(3)=3;
                targ_flags(1,12)=false;
            end
        case 12
            if trash3_flag==0
                sp_(3)=63;
                targ_flags(1,13)=true;
            else
                sp_(3)=3;
                targ_flags(1,13)=false;
            end
        otherwise
            sp_(3)=3;
    end
    targ3_fish1_x=xf1;targ3_fish1_y=yf1;
%     targ3_fish2_x=-99;targ3_fish2_y=-99;
elseif (((any(found3_fish2_indx))==1)&&(fish2_rec_counter<5))
    switch grid_matrix(xag(3),yag(3))
        case 1
            sp_(3)=3;
            if ship_s1_rec_counter<5
                targ_flags(1,1)=true;
            else
                targ_flags(1,1)=false;
            end
        case 2
            sp_(3)=3;
            if ship_s2_rec_counter<5
                targ_flags(1,2)=true;
            else
                targ_flags(1,2)=false;
            end
        case 3
            sp_(3)=3;
            if ship_l1_rec_counter<5
                targ_flags(1,3)=true;
            else
                targ_flags(1,3)=false;
            end
            if ship_l1_small_rec_counter<5
                targ_flags(1,14)=true;
            else
                targ_flags(1,14)=false;
            end
        case 4
            sp_(3)=3;
            if ship_l2_rec_counter<5
                targ_flags(1,4)=true;
            else
                targ_flags(1,4)=false;
            end
            if ship_l2_small_rec_counter<5
                targ_flags(1,15)=true;
            else
                targ_flags(1,15)=false;
            end
        case 5
            sp_(3)=3;
            if plant1_rec_counter<5
                targ_flags(1,5)=true;
            else
                targ_flags(1,5)=false;
            end
            if plant1_smp_flag==0
                targ_flags(1,8)=true;
            else
                targ_flags(1,8)=false;
            end
        case 6
            sp_(3)=3;
            if plant2_rec_counter<5
                targ_flags(1,6)=true;
            else
                targ_flags(1,6)=false;
            end
            if plant2_smp_flag==0
                targ_flags(1,9)=true;
            else
                targ_flags(1,9)=false;
            end
        case 7
            sp_(3)=3;
            if plant3_rec_counter<5
                targ_flags(1,7)=true;
            else
                targ_flags(1,7)=false;
            end
            if plant3_smp_flag==0
                targ_flags(1,10)=true;
            else
                targ_flags(1,10)=false;
            end
        case 10
            if trash1_flag==0
                sp_(3)=63;
                targ_flags(1,11)=true;
            else
                sp_(3)=3;
                targ_flags(1,11)=false;
            end
        case 11
            if trash2_flag==0
                sp_(3)=63;
                targ_flags(1,12)=true;
            else
                sp_(3)=3;
            end
        case 12
            if trash3_flag==0
                sp_(3)=63;
                targ_flags(1,13)=true;
            else
                sp_(3)=3;
                targ_flags(1,13)=false;
            end
        otherwise
            sp_(3)=3;
    end
    targ3_fish2_x=xf2;targ3_fish2_y=yf2;
%     targ3_fish1_x=-99;targ3_fish1_y=-99;
else
    targ3_fish1_x=-99;targ3_fish1_y=-99;
    targ3_fish2_x=-99;targ3_fish2_y=-99;
    switch grid_matrix(xag(3),yag(3))
        case 0
            sp_(3)=0;
        case 1
            if ship_s1_rec_counter<5
                sp_(3)=0;
                targ_flags(1,1)=true;
            else
                targ_flags(1,1)=false;
                sp_(3)=0;
            end
        case 2
            if ship_s2_rec_counter<5
                sp_(3)=0;
                targ_flags(1,2)=true;
            else
                targ_flags(1,2)=false;
                sp_(3)=0;
            end
        case 3
            if (ship_l1_rec_counter<5)&&(ship_l1_small_rec_counter>=5)
                sp_(3)=0;
                targ_flags(1,3)=true;targ_flags(1,14)=false;
            elseif (ship_l1_rec_counter>=5)&&(ship_l1_small_rec_counter>=5)
                sp_(3)=0;
                targ_flags(1,3)=false;targ_flags(1,14)=false;
            elseif (ship_l1_small_rec_counter<5)&&(ship_l1_rec_counter<5)
                sp_(3)=0;
                targ_flags(1,3)=true;targ_flags(1,14)=true;
            elseif (ship_l1_rec_counter>=5)&&(ship_l1_small_rec_counter<5)
                sp_(3)=0;
                targ_flags(1,14)=true;targ_flags(1,3)=false;
%             else
%                 sp_(3)=0;
            end
        case 4
            if (ship_l2_rec_counter<5)&&(ship_l2_small_rec_counter>=5)
                sp_(3)=0;
                targ_flags(1,4)=true;targ_flags(1,15)=false;
            elseif (ship_l2_rec_counter>=5)&&(ship_l2_small_rec_counter>=5)
                sp_(3)=0;
                targ_flags(1,4)=false;targ_flags(1,15)=false;
            elseif (ship_l2_small_rec_counter<5)&&(ship_l2_rec_counter>=5)
                sp_(3)=0;
                targ_flags(1,4)=false;targ_flags(1,15)=true;
            elseif (ship_l2_rec_counter<5)&&(ship_l2_small_rec_counter<5)
                sp_(3)=0;
                targ_flags(1,15)=true;targ_flags(1,4)=true;
%             else
%                 sp_(3)=0;
            end
        case 5
            if (plant1_rec_counter<5) && (plant1_smp_flag==1)
                sp_(3)=0;
                targ_flags(1,5)=true;targ_flags(1,8)=false;
            elseif (plant1_rec_counter>=5) && (plant1_smp_flag==1)
                targ_flags(1,5)=false;targ_flags(1,8)=false;
                sp_(3)=0;
            elseif (plant1_rec_counter>=5) && (plant1_smp_flag==0)
                targ_flags(1,5)=false;targ_flags(1,8)=true;
                sp_(3)=0;
            elseif (plant1_rec_counter<5) && (plant1_smp_flag==0)
                targ_flags(1,5)=true;targ_flags(1,8)=true;
                sp_(3)=0;
%             else
%                 sp_(3)=0;
            end
        case 6
            if (plant2_rec_counter<5) && (plant2_smp_flag==1)
                sp_(3)=0;
                targ_flags(1,6)=true;targ_flags(1,9)=false;
            elseif (plant2_rec_counter>=5) && (plant2_smp_flag==1)
                targ_flags(1,6)=false;targ_flags(1,9)=false;
                sp_(3)=0;
            elseif (plant2_rec_counter>=5) && (plant2_smp_flag==0)
                targ_flags(1,6)=false;targ_flags(1,9)=true;
                sp_(3)=0;
            elseif (plant2_rec_counter<5) && (plant2_smp_flag==0)
                targ_flags(1,6)=true;targ_flags(1,9)=true;
                sp_(3)=0;
%             else
%                 sp_(3)=0;
            end
        case 7
            if (plant3_rec_counter<5) && (plant3_smp_flag==1)
                sp_(3)=0;
                targ_flags(1,7)=true;targ_flags(1,10)=false;
            elseif (plant3_rec_counter>=5) && (plant3_smp_flag==1)
                targ_flags(1,7)=false;targ_flags(1,10)=false;
                sp_(3)=0;
            elseif (plant3_rec_counter>=5) && (plant3_smp_flag==0)
                targ_flags(1,7)=false;targ_flags(1,10)=true;
                sp_(3)=0;
            elseif (plant3_rec_counter<5) && (plant3_smp_flag==0)
                targ_flags(1,7)=true;targ_flags(1,10)=true;
                sp_(3)=0;
%             else
%                 sp_(3)=0;
            end
        case 10
            if ~trash1_flag
                targ_flags(1,11)=true;
                sp_(3)=6;
            elseif trash1_flag==true
                sp_(3)=0;
                targ_flags(1,11)=false;
            end
        case 11
            if ~trash2_flag
                targ_flags(1,12)=true;
                sp_(3)=6;
            elseif trash2_flag==true
                targ_flags(1,12)=false;
                sp_(3)=0;
            end
        case 12
            if ~trash3_flag
                targ_flags(1,13)=true;
                sp_(3)=6;
            elseif trash3_flag==true
                targ_flags(1,13)=false;
                sp_(3)=0;
            end
        otherwise
            sp_(3)=0;
    end
end
%====================================================================================
% [~,found4_fish1_indx]=ismember(ag_v_rng{4},[xf1,yf1],'rows');
% [~,found4_fish2_indx]=ismember(ag_v_rng{4},[xf2,yf2],'rows');
if (((xag(4)==xf1)&&(yag(4)==yf1))&&(fish1_rec_counter<5))
    switch grid_matrix(xag(4),yag(4))
        case 1
            sp_(4)=4;
            if ship_s1_rec_counter<5
                targ_flags(1,1)=true;
            else
                targ_flags(1,1)=false;
            end
        case 2
            sp_(4)=4;
            if ship_s2_rec_counter<5
                targ_flags(1,2)=true;
            else
                targ_flags(1,2)=false;
            end
        case 3
            if ship_l1_rec_counter<5
                targ_flags(1,3)=true;
            else
                targ_flags(1,3)=false;
            end
            if ship_l1_small_rec_counter<5
                sp_(4)=74;
                targ_flags(1,14)=true;
            else
                sp_(4)=4;
                targ_flags(1,14)=false;
            end
        case 4
            if ship_l2_rec_counter<5
                targ_flags(1,4)=true;
            else
                targ_flags(1,4)=false;
            end
            if ship_l2_small_rec_counter<5
                sp_(4)=74;
                targ_flags(1,15)=true;
            else
                sp_(4)=4;
                targ_flags(1,15)=false;
            end
        case 5
            sp_(4)=4;
            if plant1_rec_counter<5
                targ_flags(1,5)=true;
            else
                targ_flags(1,5)=false;
            end
            if plant1_smp_flag==0
                targ_flags(1,8)=true;
            else
                targ_flags(1,8)=false;
            end
        case 6
            sp_(4)=4;
            if plant2_rec_counter<5
                targ_flags(1,6)=true;
            else
                targ_flags(1,6)=false;
            end
            if plant2_smp_flag==0
                targ_flags(1,9)=true;
            else
                targ_flags(1,9)=false;
            end
        case 7
            sp_(4)=4;
            if plant3_rec_counter<5
                targ_flags(1,7)=true;
            else
                targ_flags(1,7)=false;
            end
            if plant3_smp_flag==0
                targ_flags(1,10)=true;
            else
                targ_flags(1,10)=false;
            end
        case 10
            sp_(4)=4;
            if trash1_flag==0
                targ_flags(1,11)=true;
            else
                targ_flags(1,11)=false;
            end
        case 11
            sp_(4)=4;
            if trash2_flag==0
                targ_flags(1,12)=true;
            else
                targ_flags(1,12)=false;
            end
        case 12
            sp_(4)=4;
            if trash3_flag==0
                targ_flags(1,13)=true;
            else
                targ_flags(1,13)=false;
            end
        otherwise
            sp_(4)=4;
    end
    targ4_fish1_x=xf1;targ4_fish1_y=yf1;
%     targ4_fish2_x=-99;targ4_fish2_y=-99;
elseif (((xag(4)==xf2)&&(yag(4)==yf2))&&(fish2_rec_counter<5))
    switch grid_matrix(xag(4),yag(4))
        case 1
            sp_(4)=4;
            if ship_s1_rec_counter<5
                targ_flags(1,1)=true;
            else
                targ_flags(1,1)=false;
            end
        case 2
            sp_(4)=4;
            if ship_s2_rec_counter<5
                targ_flags(1,2)=true;
            else
                targ_flags(1,2)=false;
            end
        case 3
            if ship_l1_rec_counter<5
                targ_flags(1,3)=true;
            else
                targ_flags(1,3)=false;
            end
            if ship_l1_small_rec_counter<5
                sp_(4)=74;
                targ_flags(1,14)=true;
            else
                sp_(4)=4;
                targ_flags(1,14)=false;
            end
        case 4
            if ship_l2_rec_counter<5
                targ_flags(1,4)=true;
            else
                targ_flags(1,4)=false;
            end
            if ship_l2_small_rec_counter<5
                sp_(4)=74;
                targ_flags(1,15)=true;
            else
                sp_(4)=4;
                targ_flags(1,15)=false;
            end
        case 5
            sp_(4)=4;
            if plant1_rec_counter<5
                targ_flags(1,5)=true;
            else
                targ_flags(1,5)=false;
            end
            if plant1_smp_flag==0
                targ_flags(1,8)=true;
            else
                targ_flags(1,8)=false;
            end
        case 6
            sp_(4)=4;
            if plant2_rec_counter<5
                targ_flags(1,6)=true;
            else
                targ_flags(1,6)=false;
            end
            if plant2_smp_flag==0
                targ_flags(1,9)=true;
            else
                targ_flags(1,9)=false;
            end
        case 7
            sp_(4)=4;
            if plant3_rec_counter<5
                targ_flags(1,7)=true;
            else
                targ_flags(1,7)=false;
            end
            if plant3_smp_flag==0
                targ_flags(1,10)=true;
            else
                targ_flags(1,10)=false;
            end
        case 10
            sp_(4)=4;
            if trash1_flag==0
                targ_flags(1,11)=true;
            else
                targ_flags(1,11)=false;
            end
        case 11
            sp_(4)=4;
            if trash2_flag==0
                targ_flags(1,12)=true;
            else
                targ_flags(1,12)=false;
            end
        case 12
            sp_(4)=4;
            if trash3_flag==0
                targ_flags(1,13)=true;
            else
                targ_flags(1,13)=false;
            end
        otherwise
            sp_(4)=4;
    end
    targ4_fish2_x=xf2;targ4_fish2_y=yf2;
%     targ4_fish1_x=-99;targ4_fish1_y=-99;
elseif (((any(found4_fish1_indx))==1)&&(fish1_rec_counter<5))
    switch grid_matrix(xag(4),yag(4))
        case 1
            sp_(4)=3;
            if ship_s1_rec_counter<5
                targ_flags(1,1)=true;
            else
                targ_flags(1,1)=false;
            end
        case 2
            sp_(4)=3;
            if ship_s2_rec_counter<5
                targ_flags(1,2)=true;
            else
                targ_flags(1,2)=false;
            end
        case 3
            if ship_l1_rec_counter<5
                targ_flags(1,3)=true;
            else
                targ_flags(1,3)=false;
            end
            if ship_l1_small_rec_counter<5
                sp_(4)=73;
                targ_flags(1,14)=true;
            else
                sp_(4)=3;
                targ_flags(1,14)=false;
            end
        case 4
            if ship_l2_rec_counter<5
                targ_flags(1,4)=true;
            else
                targ_flags(1,4)=false;
            end
            if ship_l2_small_rec_counter<5
                sp_(4)=73;
                targ_flags(1,15)=true;
            else
                sp_(4)=3;
                targ_flags(1,15)=false;
            end
        case 5
            sp_(4)=3;
            if plant1_rec_counter<5
                targ_flags(1,5)=true;
            else
                targ_flags(1,5)=false;
            end
            if plant1_smp_flag==0
                targ_flags(1,8)=true;
            else
                targ_flags(1,8)=false;
            end
        case 6
            sp_(4)=3;
            if plant2_rec_counter<5
                targ_flags(1,6)=true;
            else
                targ_flags(1,6)=false;
            end
            if plant2_smp_flag==0
                targ_flags(1,9)=true;
            else
                targ_flags(1,9)=false;
            end
        case 7
            sp_(4)=3;
            if plant3_rec_counter<5
                targ_flags(1,7)=true;
            else
                targ_flags(1,7)=false;
            end
            if plant3_smp_flag==0
                targ_flags(1,10)=true;
            else
                targ_flags(1,10)=false;
            end
        case 10
            sp_(4)=3;
            if trash1_flag==0
                targ_flags(1,11)=true;
            else
                targ_flags(1,11)=false;
            end
        case 11
            sp_(4)=3;
            if trash2_flag==0
                targ_flags(1,12)=true;
            else
                targ_flags(1,12)=false;
            end
        case 12
            sp_(4)=3;
            if trash3_flag==0
                targ_flags(1,13)=true;
            else
                targ_flags(1,13)=false;
            end
        otherwise
            sp_(4)=3;
    end
    targ4_fish1_x=xf1;targ4_fish1_y=yf1;
%     targ4_fish2_x=-99;targ4_fish2_y=-99;
elseif (((any(found4_fish2_indx))==1)&&(fish2_rec_counter<5))
    switch grid_matrix(xag(4),yag(4))
        case 1
            sp_(4)=3;
            if ship_s1_rec_counter<5
                targ_flags(1,1)=true;
            else
                targ_flags(1,1)=false;
            end
        case 2
            sp_(4)=3;
            if ship_s2_rec_counter<5
                targ_flags(1,2)=true;
            else
                targ_flags(1,2)=false;
            end
        case 3
            if ship_l1_rec_counter<5
                targ_flags(1,3)=true;
            else
                targ_flags(1,3)=false;
            end
            if ship_l1_small_rec_counter<5
                targ_flags(1,14)=true;
                sp_(4)=73;
            else
                targ_flags(1,14)=false;
                sp_(4)=3;
            end
        case 4
            if ship_l2_rec_counter<5
                targ_flags(1,4)=true;
            else
                targ_flags(1,4)=false;
            end
            if ship_l2_small_rec_counter<5
                targ_flags(1,15)=true;
                sp_(4)=73;
            else
                targ_flags(1,15)=false;
                sp_(4)=3;
            end
        case 5
            sp_(4)=3;
            if plant1_rec_counter<5
                targ_flags(1,5)=true;
            else
                targ_flags(1,5)=false;
            end
            if plant1_smp_flag==0
                targ_flags(1,8)=true;
            else
                targ_flags(1,8)=false;
            end
        case 6
            sp_(4)=3;
            if plant2_rec_counter<5
                targ_flags(1,6)=true;
            else
                targ_flags(1,6)=false;
            end
            if plant2_smp_flag==0
                targ_flags(1,9)=true;
            else
                targ_flags(1,9)=false;
            end
        case 7
            sp_(4)=3;
            if plant3_rec_counter<5
                targ_flags(1,7)=true;
            else
                targ_flags(1,7)=false;
            end
            if plant3_smp_flag==0
                targ_flags(1,10)=true;
            else
                targ_flags(1,10)=false;
            end
        case 10
            sp_(4)=3;
            if trash1_flag==0
                targ_flags(1,11)=true;
            else
                targ_flags(1,11)=false;
            end
        case 11
            sp_(4)=3;
            if trash2_flag==0
                targ_flags(1,12)=true;
            else
                targ_flags(1,12)=false;
            end
        case 12
            sp_(4)=3;
            if trash3_flag==0
                targ_flags(1,13)=true;
            else
                targ_flags(1,13)=false;
            end
        otherwise
            sp_(4)=3;
    end
    targ4_fish2_x=xf2;targ4_fish2_y=yf2;
%     targ4_fish1_x=-99;targ4_fish1_y=-99;
else
    targ4_fish1_x=-99;targ4_fish1_y=-99;
    targ4_fish2_x=-99;targ4_fish2_y=-99;
    switch grid_matrix(xag(4),yag(4))
        case 0
            sp_(4)=0;
        case 1
            if ship_s1_rec_counter<5
                sp_(4)=0;
                targ_flags(1,1)=true;
            else
                targ_flags(1,1)=false;
                sp_(4)=0;
            end
        case 2
            if ship_s2_rec_counter<5
                sp_(4)=0;
                targ_flags(1,2)=true;
            else
                targ_flags(1,2)=false;
                sp_(4)=0;
            end
        case 3
            if (ship_l1_rec_counter<5)&&(ship_l1_small_rec_counter>=5)
                sp_(4)=0;
                targ_flags(1,3)=true;targ_flags(1,14)=false;
            elseif (ship_l1_rec_counter>=5)&&(ship_l1_small_rec_counter>=5)
                sp_(4)=0;
                targ_flags(1,3)=false;targ_flags(1,14)=false;
            elseif (ship_l1_small_rec_counter<5)&&(ship_l1_rec_counter<5)
                sp_(4)=7;
                targ_flags(1,3)=true;targ_flags(1,14)=true;
            elseif (ship_l1_rec_counter>=5)&&(ship_l1_small_rec_counter<5)
                sp_(4)=7;
                targ_flags(1,14)=true;targ_flags(1,3)=false;
%             else
%                 sp_(4)=0;
            end
        case 4
            if (ship_l2_rec_counter<5)&&(ship_l2_small_rec_counter>=5)
                sp_(4)=0;
                targ_flags(1,4)=true;targ_flags(1,15)=false;
            elseif (ship_l2_rec_counter>=5)&&(ship_l2_small_rec_counter>=5)
                sp_(4)=0;
                targ_flags(1,4)=false;targ_flags(1,15)=false;
            elseif (ship_l2_small_rec_counter<5)&&(ship_l2_rec_counter>=5)
                sp_(4)=7;
                targ_flags(1,4)=false;targ_flags(1,15)=true;
            elseif (ship_l2_rec_counter<5)&&(ship_l2_small_rec_counter<5)
                sp_(4)=7;
                targ_flags(1,15)=true;targ_flags(1,4)=true;
%             else
%                 sp_(4)=0;
            end
        case 5
            if (plant1_rec_counter<5) && (plant1_smp_flag==1)
                sp_(4)=0;
                targ_flags(1,5)=true;targ_flags(1,8)=false;
            elseif (plant1_rec_counter>=5) && (plant1_smp_flag==1)
                targ_flags(1,5)=false;targ_flags(1,8)=false;
                sp_(4)=0;
            elseif (plant1_rec_counter>=5) && (plant1_smp_flag==0)
                targ_flags(1,5)=false;targ_flags(1,8)=true;
                sp_(4)=0;
            elseif (plant1_rec_counter<5) && (plant1_smp_flag==0)
                targ_flags(1,5)=true;targ_flags(1,8)=true;
                sp_(4)=0;
%             else
%                 sp_(4)=0;
            end
        case 6
            if (plant2_rec_counter<5) && (plant2_smp_flag==1)
                sp_(4)=0;
                targ_flags(1,6)=true;targ_flags(1,9)=false;
            elseif (plant2_rec_counter>=5) && (plant2_smp_flag==1)
                targ_flags(1,6)=false;targ_flags(1,9)=false;
                sp_(4)=0;
            elseif (plant2_rec_counter>=5) && (plant2_smp_flag==0)
                targ_flags(1,6)=false;targ_flags(1,9)=true;
                sp_(4)=0;
            elseif (plant2_rec_counter<5) && (plant2_smp_flag==0)
                targ_flags(1,6)=true;targ_flags(1,9)=true;
                sp_(4)=0;
%             else
%                 sp_(4)=0;
            end
        case 7
            if (plant3_rec_counter<5) && (plant3_smp_flag==1)
                sp_(4)=0;
                targ_flags(1,7)=true;targ_flags(1,10)=false;
            elseif (plant3_rec_counter>=5) && (plant3_smp_flag==1)
                targ_flags(1,7)=false;targ_flags(1,10)=false;
                sp_(4)=0;
            elseif (plant3_rec_counter>=5) && (plant3_smp_flag==0)
                targ_flags(1,7)=false;targ_flags(1,10)=true;
                sp_(4)=0;
            elseif (plant3_rec_counter<5) && (plant3_smp_flag==0)
                targ_flags(1,7)=true;targ_flags(1,10)=true;
                sp_(4)=0;
%             else
%                 sp_(4)=0;
            end
        case 10
            if ~trash1_flag
                targ_flags(1,11)=true;
                sp_(4)=0;
            else
                sp_(4)=0;
                targ_flags(1,11)=false;
            end
        case 11
            if ~trash2_flag
                targ_flags(1,12)=true;
                sp_(4)=0;
            else
                targ_flags(1,12)=false;
                sp_(4)=0;
            end
        case 12
            if ~trash3_flag
                targ_flags(1,13)=true;
                sp_(4)=0;
            else
                targ_flags(1,13)=false;
                sp_(4)=0;
            end
        otherwise
            sp_(4)=0;
    end
end
%====================================================================================
%==========================================================================================
if fish1_rec_counter<5
    fish1_flag=true;
    targ_flags(1,16)=true;
else
    fish1_flag=false;
    targ_flags(1,16)=false;
end
if fish2_rec_counter<5
    fish2_flag=true;
    targ_flags(1,17)=true;
else
    fish2_flag=false;
    targ_flags(1,17)=false;
end
%======================================================================
if plant1_smp_flag==1
    targ_flags(1,8)=false;
end
if plant2_smp_flag==1
    targ_flags(1,9)=false;
end
if plant3_smp_flag==1
    targ_flags(1,10)=false;
end
if plant1_rec_counter>=5
    targ_flags(1,5)=false;
end
if plant2_rec_counter>=5
    targ_flags(1,6)=false;
end
if plant3_rec_counter>=5
    targ_flags(1,7)=false;
end
if trash1_flag==1
    targ_flags(1,11)=false;
end
if trash2_flag==1
    targ_flags(1,12)=false;
end
if trash3_flag==1
    targ_flags(1,13)=false;
end
if ship_l1_small_rec_counter>=5
    targ_flags(1,14)=false;
end
if ship_l2_small_rec_counter>=5
    targ_flags(1,15)=false;
end
if ship_s1_rec_counter>=5
    targ_flags(1,1)=false;
end
if ship_s2_rec_counter>=5
    targ_flags(1,2)=false;
end
if ship_l1_rec_counter>=5
    targ_flags(1,3)=false;
end
if ship_l2_rec_counter>=5
    targ_flags(1,4)=false;
end

if (size(explored_points,1)/size(total_points,1))<0.5
    sp_(5)=8;
elseif ((size(explored_points,1)/size(total_points,1))<0.75)&&((size(explored_points,1)/size(total_points,1))>0.5)
    sp_(5)=9;
elseif ((size(explored_points,1)/size(total_points,1))>0.75)&&((size(explored_points,1)/size(total_points,1))<1)
    sp_(5)=10;
elseif (size(explored_points,1)==size(total_points,1))%*10000000==10000000
    sp_(5)=11;
end

if ((targ_flags(1,1)&&(ship_s1_rec_counter<5))||(targ_flags(1,2)&&(ship_s2_rec_counter<5))||(targ_flags(1,3)&&(ship_l1_rec_counter<5))||(targ_flags(1,4)&&(ship_l2_rec_counter<5)))
    sp_(6)=12;
else
    sp_(6)=13;
end

if ((targ_flags(1,5)&&(plant1_rec_counter<5))||(targ_flags(1,6)&&(plant2_rec_counter<5))||(targ_flags(1,7)&&(plant3_rec_counter<5)))
    sp_(7)=14;
else
    sp_(7)=15;
end

if ((targ_flags(1,8)&&~plant1_smp_flag)||(targ_flags(1,9)&&~plant2_smp_flag)||(targ_flags(1,10)&&~plant3_smp_flag))
    sp_(8)=16;
else
    sp_(8)=17;
end

if ((targ_flags(1,13)&&~trash1_flag)||(targ_flags(1,11)&&~trash2_flag)||(targ_flags(1,12)&&~trash3_flag))
    sp_(9)=18;
else
    sp_(9)=19;
end


anyFoundFish1=any(found1_fish1_indx)|any(found2_fish1_indx)|any(found3_fish1_indx)|any(found4_fish1_indx)|...
    ((xag(1)==xf1)&&(yag(1)==yf1))|((xag(2)==xf1)&&(yag(2)==yf1))|((xag(3)==xf1)&&(yag(3)==yf1))|((xag(4)==xf1)&&(yag(4)==yf1));
anyFoundFish2=any(found1_fish2_indx)|any(found2_fish2_indx)|any(found3_fish2_indx)|any(found4_fish2_indx)|...
    ((xag(1)==xf2)&&(yag(1)==yf2))|((xag(2)==xf2)&&(yag(2)==yf2))|((xag(3)==xf2)&&(yag(3)==yf2))|((xag(4)==xf2)&&(yag(4)==yf2));
if(((anyFoundFish1)&&((fish1_rec_counter<5)))||((anyFoundFish2)&&(fish2_rec_counter<5)))
    sp_(10)=20;
else
    sp_(10)=21;
end

if ((targ_flags(1,14)&&(ship_l1_small_rec_counter<5))||(targ_flags(1,15)&&(ship_l2_small_rec_counter<5)))
    sp_(11)=22;
else
    sp_(11)=23;
end
%======================================================================
targets1=[targ_flags(1,1),targ_flags(1,2),targ_flags(1,3),targ_flags(1,4),targ_flags(1,5),targ_flags(1,6),targ_flags(1,7),targ_flags(1,16),targ_flags(1,17)];
targets2=[targ_flags(1,8),targ_flags(1,9),targ_flags(1,10)];
targets3=[targ_flags(1,11),targ_flags(1,12),targ_flags(1,13)];
targets4=[targ_flags(1,14),targ_flags(1,15)];
%======================================================================
end