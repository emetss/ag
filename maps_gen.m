function [states_pos]=maps_gen(n)
global grid;global grid_matrix;global total_points

    total_points=zeros(225,2); grid=zeros(1,225); grid_matrix=reshape(grid,15,15);
    total_counter=0;
    for i=1:15
        for j=1:15
            total_counter=total_counter+1;
            total_points(total_counter,:)=[i j];
        end
    end
rng('shuffle');
random=randperm(n,n);
keeper=random(1);
states_pos(1)=keeper;
counter=1;
for k=2:225
    maximum=false;
    this(k)=random(k);
    if k==2
        dist=min(abs(states_pos-keeper));
        distmax=abs(states_pos-keeper);
        if(distmax==15||distmax==14||distmax==16||distmax==17||distmax==18||distmax==13 ...
                ||distmax==13+15||distmax==15+15||distmax==14+15||distmax==16+15)
            maximum=true;
        end
    else
        dist=min(abs(states_pos-this(k)));
        for kk=1:size(states_pos,2)
            distmax(kk)=abs(states_pos(kk)-this(k));
            if(distmax(kk)==15||distmax(kk)==14||distmax(kk)==16||distmax(kk)==17||distmax(kk)==18||distmax(kk)==13 ...
                    ||distmax(kk)==15+15||distmax(kk)==13+15||distmax(kk)==14+15||distmax(kk)==16+15)
                maximum=true;
            end
        end
    end
    if counter>=12
        break;
    end
    if ((dist>3)&&maximum==false&&this(k)~=1)
        counter=counter+1;
        keeper=this(k);
        states_pos(counter)=this(k);
    end
end
% disp(states_pos);



s_ship_s1=states_pos(1);s_ship_s2=states_pos(2);s_ship_l1=states_pos(3);s_ship_l2=states_pos(4);s_plant1=states_pos(5);s_plant2=states_pos(6);
s_plant3=states_pos(7);
s_smp2=states_pos(8);s_smp3=states_pos(9);
s_trash1=states_pos(10);s_trash2=states_pos(11);s_trash3=states_pos(12);
grid(s_ship_s1)=1;grid(s_ship_s2)=2;grid(s_ship_l1)=3;grid(s_ship_l2)=4;
grid(s_plant1)=5;grid(s_plant2)=6;grid(s_plant3)=7;
% grid(s_smp1)=7;
grid(s_smp2)=0;grid(s_smp3)=0;
grid(s_trash1)=10;grid(s_trash2)=11;grid(s_trash3)=12;
grid_matrix=reshape(grid,15,15);
end