function [xag,yag,r] = scan_act(xag,yag,xag_total,yag_total)
global scan_pos;
global grid;global grid_matrix;
global xmax;global xmin;global ymax;global ymin;
global ship_l1_small_rec_counter;global ship_l2_small_rec_counter; global ship_s1_rec_counter;global ship_s2_rec_counter;
global ship_l1_rec_counter;global ship_l2_rec_counter;global plant1_rec_counter;global plant2_rec_counter;
global plant3_rec_counter;
global plant1_smp_flag;global plant2_smp_flag;global plant3_smp_flag;
global trash1_flag;global trash2_flag;global trash3_flag;

global fish1_rec_counter;global fish2_rec_counter;
global targ2_fish1_x;global targ3_fish1_x;global targ4_fish1_x;
global targ2_fish2_x;global targ3_fish2_x;global targ4_fish2_x;
global targ2_fish1_y;global targ3_fish1_y;global targ4_fish1_y;
global targ2_fish2_y;global targ3_fish2_y;global targ4_fish2_y;
global rewards;global scanning_process;
global ag2_descending_scan;global ag3_descending_scan;global ag4_descending_scan;
global first_free;global second_free;global third_free;global scan_targets;
xag_tot=[];
[~,xag_match]=ismember(xag_total(2:4),xag);
global ag2;global ag3;global ag4;
[~,scan_match1]=ismember(scan_pos(1,1),xag);
[~,scan_match2]=ismember(scan_pos(2,1),xag);
[~,scan_match3]=ismember(scan_pos(3,1),xag);

scan_match=scan_match1||scan_match2||scan_match3;
if xag_total(2)~=scan_pos(1,1)
    ag2(1)=false;
end
if xag_total(3)~=scan_pos(1,1)
    ag3(1)=false;
end
if xag_total(4)~=scan_pos(1,1)
    ag4(1)=false;
end
if xag_total(2)~=scan_pos(2,1)
    ag2(2)=false;
end
if xag_total(3)~=scan_pos(2,1)
    ag3(2)=false;
end
if xag_total(4)~=scan_pos(2,1)
    ag4(2)=false;
end
if xag_total(2)~=scan_pos(3,1)
    ag2(3)=false;
end
if xag_total(3)~=scan_pos(3,1)
    ag3(3)=false;
end
if xag_total(4)~=scan_pos(3,1)
    ag4(3)=false;
end

if ag2(1)==false&&ag3(1)==false&&ag4(1)==false
    scan_targets(1)=true;
end
if ag2(2)==false&&ag3(2)==false&&ag4(2)==false
    scan_targets(2)=true;
end
if ag2(3)==false&&ag3(3)==false&&ag4(3)==false
    scan_targets(3)=true;
end

if yag_total(2)==ymin
    ag2_descending_scan=false;
elseif yag_total(2)==ymax
    ag2_descending_scan=true;
end
if yag_total(3)==ymin
    ag3_descending_scan=false;
elseif yag_total(3)==ymax
    ag3_descending_scan=true;
end
if yag_total(4)==ymin
    ag4_descending_scan=false;
elseif yag_total(4)==ymax
    ag4_descending_scan=true;
end
for i=1:size(scan_targets,2)
    if any(scan_targets(i))
        if xag==scan_pos(i,1)
            if xag==xag_total(2)&&ag2(i)==false&&ag3(i)==false&&ag4(i)==false&&xag~=xag_total(3)&&xag~=xag_total(4)&&xag_total(3)~=scan_pos(i,1)&&xag_total(4)~=scan_pos(i,1)
                ag2(i)=true;scan_targets(i)=false;
                if ag2_descending_scan==true
                    yag=yag-1;r=rewards(2);
                    yag=abs(yag);
                    yag=min(ymax,yag);yag=max(ymin,yag);return;
                else
                    yag=yag+1;r=rewards(2);
                    yag=abs(yag);
                    xag=min(xmax,xag);xag=max(xmin,xag);return;
                end
            elseif xag==xag_total(3)&&ag3(i)==false&&ag2(i)==false&&ag4(i)==false&&xag~=xag_total(2)&&xag~=xag_total(4)&&xag_total(2)~=scan_pos(i,1)&&xag_total(4)~=scan_pos(i,1)
                ag3(i)=true;scan_targets(i)=false;
                if ag3_descending_scan==true
                    yag=yag-1;r=rewards(2);
                    yag=abs(yag);
                    yag=min(ymax,yag);yag=max(ymin,yag);return;
                else
                    yag=yag+1;r=rewards(2);
                    yag=abs(yag);
                    yag=min(ymax,yag);yag=max(ymin,yag);return;
                end
            elseif xag==xag_total(4)&&ag4(i)==false&&ag2(i)==false&&ag3(i)==false&&xag~=xag_total(3)&&xag~=xag_total(2)&&xag_total(2)~=scan_pos(i,1)&&xag_total(3)~=scan_pos(i,1)
                ag4(i)=true;scan_targets(i)=false;
                if ag4_descending_scan==true
                    yag=yag-1;r=rewards(2);
                    yag=abs(yag);
                    yag=min(ymax,yag);yag=max(ymin,yag);return;
                else
                    yag=yag+1;r=rewards(2);
                    yag=abs(yag);
                    yag=min(ymax,yag);yag=max(ymin,yag);return;
                end
            elseif xag==xag_total(2)&&ag2(i)==true&&ag3(i)==false&&ag4(i)==false&&xag~=xag_total(3)&&xag~=xag_total(4)&&xag_total(3)~=scan_pos(i,1)&&xag_total(4)~=scan_pos(i,1)
                scan_targets(i)=false;
                if ag2_descending_scan==true
                    yag=yag-1;r=rewards(2);
                    yag=abs(yag);
                    yag=min(ymax,yag);yag=max(ymin,yag);return;
                else
                    yag=yag+1;r=rewards(2);
                    yag=abs(yag);
                    yag=min(ymax,yag);yag=max(ymin,yag);return;
                end
            elseif xag==xag_total(3)&&ag3(i)==true&&ag2(i)==false&&ag4(i)==false&&xag~=xag_total(2)&&xag~=xag_total(4)&&xag_total(2)~=scan_pos(i,1)&&xag_total(4)~=scan_pos(i,1)
                scan_targets(i)=false;
                if ag3_descending_scan==true
                    yag=yag-1;r=rewards(2);
                    yag=abs(yag);
                    yag=min(ymax,yag);yag=max(ymin,yag);return;
                else
                    yag=yag+1;r=rewards(2);
                    yag=abs(yag);
                    yag=min(ymax,yag);yag=max(ymin,yag);return;
                end
            elseif xag==xag_total(4)&&ag4(i)==true&&ag2(i)==false&&ag3(i)==false&&xag~=xag_total(2)&&xag~=xag_total(3)&&xag_total(2)~=scan_pos(i,1)&&xag_total(3)~=scan_pos(i,1)
                scan_targets(i)=false;
                if ag4_descending_scan==true
                    yag=yag-1;r=rewards(2);
                    yag=abs(yag);
                    yag=min(ymax,yag);yag=max(ymin,yag);return;
                else
                    yag=yag+1;r=rewards(2);
                    yag=abs(yag);
                    yag=min(ymax,yag);yag=max(ymin,yag);return;
                end
            end
        elseif ag2(i)==false&&ag3(i)==false&&ag4(i)==false&&scan_targets(i)==true
            scan_pos_dist=scan_pos(i,1)-xag;
            xag=abs(scan_pos_dist/abs(scan_pos_dist)+xag);r=rewards(2);
            xag=abs(xag);yag=abs(yag);
            xag=min(xmax,xag);yag=min(ymax,yag);
            xag=max(xmin,xag);yag=max(ymin,yag);
            if xag==scan_pos(i,1)&&xag==xag_total(2)&&xag~=xag_total(3)&&xag~=xag_total(4)
                ag2(i)=true;ag3(i)=false;ag4(i)=false;scan_targets(i)=false;return;
            elseif xag==scan_pos(i,1)&&xag==xag_total(3)&&xag~=xag_total(2)&&xag~=xag_total(4)
                ag3(i)=true;ag2(i)=false;ag4(i)=false;scan_targets(i)=false;return;
            elseif xag==scan_pos(i,1)&&xag==xag_total(4)&&xag~=xag_total(2)&&xag~=xag_total(3)
                ag4(i)=true;ag2(i)=false;ag3(i)=false;scan_targets(i)=false;return;
            end
            return;
        end
    elseif xag==xag_total(2)&&ag2(i)==true&&ag3(i)==false&&ag4(i)==false&&xag~=xag_total(3)&&xag~=xag_total(4)&&xag==scan_pos(i,1)
        if ag2_descending_scan==true
            yag=yag-1;r=rewards(2);
            yag=abs(yag);
            yag=min(ymax,yag);yag=max(ymin,yag);return;
        else
            yag=yag+1;r=rewards(2);
            yag=abs(yag);
            yag=min(ymax,yag);yag=max(ymin,yag);return;
        end
    elseif xag==xag_total(3)&&ag3(i)==true&&ag2(i)==false&&ag4(i)==false&&xag~=xag_total(2)&&xag~=xag_total(4)&&xag==scan_pos(i,1)
        if ag3_descending_scan==true
            yag=yag-1;r=rewards(2);
            yag=abs(yag);
            yag=min(ymax,yag);yag=max(ymin,yag);return;
        else
            yag=yag+1;r=rewards(2);
            yag=abs(yag);
            yag=min(ymax,yag);yag=max(ymin,yag);return;
        end
    elseif xag==xag_total(4)&&ag4(i)==true&&ag2(i)==false&&ag3(i)==false&&xag~=xag_total(3)&&xag~=xag_total(2)&&xag==scan_pos(i,1)
        if ag4_descending_scan==true
            yag=yag-1;r=rewards(2);
            yag=abs(yag);
            yag=min(ymax,yag);yag=max(ymin,yag);return;
        else
            yag=yag+1;r=rewards(2);
            yag=abs(yag);
            yag=min(ymax,yag);yag=max(ymin,yag);return;
        end
    end
end
end