clear all
close all
clc
global epsilon;epsilon = 1;
global iteration;
global total_points;global xmax;
global xmin;global ymax;global ymin;
global ship_l1_small_rec_counter;global ship_l2_small_rec_counter; global ship_s1_rec_counter;global ship_s2_rec_counter;
global ship_l1_rec_counter;global ship_l2_rec_counter;global plant1_rec_counter;global plant2_rec_counter;
global plant3_rec_counter;
global fish1_rec_counter;global fish2_rec_counter;
global plant1_smp_flag;global plant2_smp_flag;global plant3_smp_flag;global trash1_flag;global trash2_flag;global trash3_flag;
global alphas;global gamma;global alpha;

global min_alpha;min_alpha=0.02;
alphas=linspace(1,min_alpha,5000);
%=======================================
global targ1_fish1_x;global targ2_fish1_x;global targ3_fish1_x;global targ4_fish1_x;
global targ1_fish2_x;global targ2_fish2_x;global targ3_fish2_x;global targ4_fish2_x;
global targ1_fish1_y;global targ2_fish1_y;global targ3_fish1_y;global targ4_fish1_y;
global targ1_fish2_y;global targ2_fish2_y;global targ3_fish2_y;global targ4_fish2_y;
targ2_fish1_x=-99;targ2_fish2_x=-99;targ2_fish1_y=-99;targ2_fish2_y=-99;
targ3_fish1_x=-99;targ3_fish2_x=-99;targ3_fish1_y=-99;targ3_fish2_y=-99;
targ4_fish1_x=-99;targ4_fish2_x=-99;targ4_fish1_y=-99;targ4_fish2_y=-99;
global targ_flags;
global scan_pos;global scan_targets;
global scanning_process;
global states_counter;
global fish1_flag;global fish2_flag;
global ag2_descending_scan;global ag3_descending_scan;global ag4_descending_scan;
global first_free;global second_free;global third_free;
global ag2;global ag3;global ag4;

M=15;N=15;xmax=15;ymax=15;xmin=1;ymin=1;n=15*15;iteration=100000000000000;imaps=1000000;

scan_pos=[[3,15];[8,15];[13,15]];
%======================================================================

[joint_states,joint_actions,Q] = joint_states_actions_Q();

states_counter=zeros(1,497664);
% soso=load("states_counter1244.mat");
% states_counter=soso.states_counter;
%=======================================================================
for imap=1:imaps
    global explored_points;
    alpha=alphas(imap+0);

    scan_targets=true(1,3);

    xf1_prim=randi(15);xf2_prim=randi(15);yf1_prim=randi(15);yf2_prim=randi(15);FishActions=5;
    %================================================================
    %     targets1=false(1,6);targets2=false(1,3);targets3=false(1,3);targets4=false(1,2);

    [states_pos]=maps_gen(n);

    ship_l1_small_rec_counter=0;ship_l2_small_rec_counter=0;
    ship_s1_rec_counter=0;ship_s2_rec_counter=0;
    ship_l1_rec_counter=0;ship_l2_rec_counter=0;
    plant1_rec_counter=0;plant2_rec_counter=0;plant3_rec_counter=0;
    fish1_rec_counter=0;fish2_rec_counter=0;
    plant1_smp_flag=false;
    plant2_smp_flag=false;
    plant3_smp_flag=false;
    trash1_flag=false;
    trash2_flag=false;
    trash3_flag=false;
    fish1_flag=false;fish2_flag=false;
    targ1_fish1_x=-99;targ2_fish1_x=-99;targ3_fish1_x=-99;targ4_fish1_x=-99;
    targ1_fish1_y=-99;targ2_fish1_y=-99;targ3_fish1_y=-99;targ4_fish1_y=-99;
    targ1_fish2_x=-99;targ2_fish2_x=-99;targ3_fish2_x=-99;targ4_fish2_x=-99;
    targ1_fish2_y=-99;targ2_fish2_y=-99;targ3_fish2_y=-99;targ4_fish2_y=-99;
    scanning_process=false;
    first_free=true;second_free=true;third_free=true;

    ntargets=12;targ_flags=false(1,ntargets+3+2);
    targets1_pos=[states_pos(1),states_pos(2),states_pos(3),states_pos(4),states_pos(5),states_pos(6),states_pos(7)];
    targets2_pos=[states_pos(5),states_pos(6),states_pos(7)];
    targets3_pos=[states_pos(10),states_pos(11),states_pos(12)];
    targets4_pos=[states_pos(3),states_pos(4)];
    %=======================================================
%     xag(1)=8;yag(1)=8;xag(2)=8;yag(2)=8;xag(3)=8;yag(3)=8;xag(4)=8;yag(4)=8;
    xag1=randi(15);yag1=randi(15);xag2=randi(15);yag2=randi(15);xag3=randi(15);yag3=randi(15);xag4=randi(15);yag4=randi(15);
    xag_prim=[xag1,xag2,xag3,xag4];yag_prim=[yag1,yag2,yag3,yag4];
    [sp_,targets1,targets2,targets3,targets4]=s_fz(xf1_prim,yf1_prim,xf2_prim,yf2_prim,xag_prim,yag_prim);
    [~,sp]=ismember(sp_,joint_states,'rows');
    s=sp;
    %=======================================================
    for j=1:iteration
        if j==1 xag(1)=xag1;yag(1)=yag1;xag(2)=xag2;yag(2)=yag2;xag(3)=xag3;yag(3)=yag3;xag(4)=xag4;yag(4)=yag4;
            explored_points(1,:)=[xag(1),yag(1)];
            explored_points(2,:)=[xag(2),yag(2)];
            explored_points(3,:)=[xag(3),yag(3)];
            explored_points(4,:)=[xag(4),yag(4)];
            explored_points=unique(explored_points,'rows');
            first_free=true;second_free=true;third_free=true; ag2=false(1,3);ag3=false(1,3);ag4=false(1,3);...
                xf1=xf1_prim;yf1=yf1_prim;xf2=xf2_prim;yf2=yf2_prim;
            ag2_descending_scan=true;ag3_descending_scan=true;ag4_descending_scan=true;r_total=0;
        end

        [xf1,yf1,xf2,yf2] = fish_rand_mov(FishActions,xf1,xf2,yf1,yf2);


        [sp_,targets1,targets2,targets3,targets4]=s_fz(xf1,yf1,xf2,yf2,xag,yag);
        %======================================================================================================
        
        states_counter(1,s)=states_counter(1,s)+1;
%         mimo=states_counter(1,s)+1;
%         siso=states_counter(s)+1;
        GLIE=epsilon/states_counter(s);

        if(rand()>GLIE)
            [v idx]=sort(Q(s,:),'descend');
            dif= diff(v);
            ii=find(diff(v),1);
            if isempty(ii)
                a=randi(500);
            else
                a=idx(randi(ii));
            end
        else
            a=randi(500);
        end
        a_=joint_actions(a,:);
        if(s==72)&&(a==1)
            kookoo=1;
        end


        [Q,xag,yag,r1,r2,r3,r4] = b_fa(a_,xag,yag,xf1,yf1,xf2,yf2,Q,targets1,targets2,targets3,targets4,targets1_pos,targets2_pos,targets3_pos,targets4_pos);

        [sp_,targets1,targets2,targets3,targets4]=s_fz(xf1,yf1,xf2,yf2,xag,yag);
        [~,sp]=ismember(sp_,joint_states,'rows');

        r=r1+r2+r3+r4;
        Q(s,a)=Q(s,a)+alpha*((r+gamma*max(Q(sp,:)))-Q(s,a));
        r_total=r_total+r;

        s=sp;

        %if ((imap>5000))
            % (size(explored_points,1)==size(total_points,1))&&
        plot_func(xf1,yf1,xf2,yf2,xag(1),yag(1),xag(2),yag(2),xag(3),yag(3),xag(4),yag(4));
        drawnow
        %end
        if fish1_rec_counter<5
                disp("targ1_f1_x");disp(targ1_fish1_x);disp("targ1_f1_y");disp(targ1_fish1_y);
                disp("targ2_f1_x");disp(targ2_fish1_x);disp("targ2_f1_y");disp(targ2_fish1_y);
                disp("targ3_f1_x");disp(targ3_fish1_x);disp("targ3_f1_y");disp(targ3_fish1_y);
                disp("targ4_f1_x");disp(targ4_fish1_x);disp("targ4_f1_y");disp(targ4_fish1_y);
        end
        if fish2_rec_counter<5
                disp("targ1_f2_x");disp(targ1_fish2_x);disp("targ1_f2_y");disp(targ1_fish2_y);
                disp("targ2_f2_x");disp(targ2_fish2_x);disp("targ2_f2_y");disp(targ2_fish2_y);
                disp("targ3_f2_x");disp(targ3_fish2_x);disp("targ3_f2_y");disp(targ3_fish2_y);
                disp("targ4_f2_x");disp(targ4_fish2_x);disp("targ4_f2_y");disp(targ4_fish2_y);
        end
                if ship_l1_small_rec_counter<5 disp("ship_l1_s_counter:");disp(ship_l1_small_rec_counter);end
                if ship_l2_small_rec_counter<5 disp("ship_l2_s_counter:");disp(ship_l2_small_rec_counter);end
                if ship_s1_rec_counter<5 disp("ship_s1_rec_counter:");disp(ship_s1_rec_counter);end
                if ship_s2_rec_counter<5 disp("ship_s2_rec_counter:");disp(ship_s2_rec_counter);end
                if ship_l1_rec_counter<5 disp("ship_l1_rec_counter:");disp(ship_l1_rec_counter);end
                if ship_l2_rec_counter<5 disp("ship_l2_rec_counter:");disp(ship_l2_rec_counter);end
                if plant1_rec_counter<5 disp("plant1_rec_counter:");disp(plant1_rec_counter);end
                if plant2_rec_counter<5 disp("plant2_rec_counter:");disp(plant2_rec_counter);end
                if plant3_rec_counter<5 disp("plant3_rec_counter:");disp(plant3_rec_counter);end
                if fish1_rec_counter<5 disp("fish1_rec_counter:");disp(fish1_rec_counter);end
                if fish2_rec_counter<5 disp("fish2_rec_counter:");disp(fish2_rec_counter);end
                if ~plant1_smp_flag disp("plant1_smp_flag:");disp(plant1_smp_flag);end
                if ~plant2_smp_flag disp("plant2_smp_flag:");disp(plant2_smp_flag);end
                if ~plant3_smp_flag disp("plant3_smp_flag:");disp(plant3_smp_flag);end
                if ~trash1_flag disp("trash1_flag:"); disp(trash1_flag);end
                if ~trash2_flag disp("trash2_flag:");disp(trash2_flag);end
                if ~trash3_flag disp("trash3_flag:"); disp(trash3_flag);end
                if (size(explored_points,1)~=size(total_points,1)) disp("expPoints");disp(size(explored_points,1));end
        
        if(ship_l1_small_rec_counter==5&&ship_l2_small_rec_counter==5&&...
                ship_s1_rec_counter==5&&ship_s2_rec_counter==5&&...
                ship_l1_rec_counter==5&&ship_l2_rec_counter==5&&...
                plant1_rec_counter==5&&plant2_rec_counter==5&&...
                plant3_rec_counter==5&&...
                fish1_rec_counter==5&&fish2_rec_counter==5&&...
                plant1_smp_flag==true&&plant2_smp_flag==true&&plant3_smp_flag==true&&...
                trash1_flag==true&&trash2_flag==true&&trash3_flag==true&&...
                size(explored_points,1)==size(total_points,1))
%             r_total_all=r_total_all+r_total;
%             save(['Q',num2str(0+imap) '.mat'],'Q')
%             save(['states_counter',num2str(0+imap) '.mat'],'states_counter')
%             save(['r_total',num2str(0+imap) '.mat'],'r_total')
%             save(['r_total_all',num2str(2553+imap) '.mat'],'r_total_all')
%             save(['iteration',num2str(0+imap) '.mat'],'j')
%             save(['states_pos',num2str(0+imap) '.mat'],'states_pos')
            clear global explored_points;
            break;
        end
    end
end