
function [joint_states,joint_actions,Q] = joint_states_actions_Q()
global rewards;

a1_states=[0 1 2 3 4 41 24 31 32];
a2_states=[0 3 4 5 54 53];
a3_states=[0 3 4 6 64 63];
a4_states=[0 3 4 7 74 73];
info_state = [8 9 10 11]; 
info_ship_state=[12 13];
info_plant_state=[14 15];
info_smp_state=[16 17];
info_trash_state=[18 19];
info_fish_state=[20 21];
info_ship_small_state=[22 23];
joint_states=setprod(a1_states,a2_states,a3_states,a4_states,info_state,info_ship_state,...
    info_plant_state,info_smp_state,info_trash_state,info_fish_state,info_ship_small_state);

a1_actions=[0 1 2 3];
a2_actions=[0 1 3 4 5];
a3_actions=[0 1 3 4 5];
a4_actions=[0 1 2 3 5];

joint_actions=setprod(a1_actions,a2_actions,a3_actions,a4_actions);

global gamma;gamma=1;
% momo=load("Q1244");
% Q=momo.Q;
Q=(225*1+3*1*5+3*1*5+2*1*5+7*5*1+2*1.5*5-0.1)*ones(prod([9 6 6 6 4 2 2 2 2 2 2]), prod([4 5 5 5]));
rewards=[1 0 -1 1.5 -4];
%===================================================================================================

end