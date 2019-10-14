function plot_func(xf1,yf1,xf2,yf2,xag1,yag1,xag2,yag2,xag3,yag3,xag4,yag4)
global grid_matrix;
global ship_l1_small_rec_counter;global ship_l2_small_rec_counter; global ship_s1_rec_counter;global ship_s2_rec_counter;
global ship_l1_rec_counter;global ship_l2_rec_counter;global plant1_rec_counter;global plant2_rec_counter;global plant3_rec_counter;
global fish1_rec_counter;global fish2_rec_counter;
global plant1_smp_flag;global plant2_smp_flag;global plant3_smp_flag;global trash1_flag;global trash2_flag;global trash3_flag;
%================Images=======================
agimgfiles = {'1.jpg', '2.jpg','3.jpg','4.jpg'};
targetimgfiles = {'s_ship.jpg', 'l_ship.jpg','plants.jpg','smp_collect.jpg','trash_collect.jpg','blue.jpg','dolph.jpg','whale.jpg'};
for i=1:8
    if i==7 || i==8
        img=imread(targetimgfiles{i});
        imgtrg{i}=imresize(img,[20 20]);
        
    else
        img=imread(targetimgfiles{i});
        I1 = flipdim(img ,1);
        imgtrg{i}=imresize(I1,[40 40]);
        
    end
end
imgh1=imread(agimgfiles{1});
imgaa1=imresize(imgh1,[20 20]);
%I1=imgaa1;
I1 = flipdim(imgaa1 ,1);
%I1 = imrotate(I1, 180);
imga{1}=I1;


%     imga{1} = imrotate(imgaa1, 180);

imgh2=imread(agimgfiles{2});
imgaa2=imresize(imgh2,[20 20]);
I2 = flipdim(imgaa2 ,1);
%I2 = imrotate(I2, 180);
imga{2}=I2;
%     imga{2} = imrotate(imgaa2, 180);

imgh3=imread(agimgfiles{3});
imgaa3=imresize(imgh3,[20 20]);
I3 = flipdim(imgaa3 ,1);
%I3 = imrotate(I3, 180);
imga{3}=I3;
%     imga{3} = imrotate(imgaa3, 180);

imgh4=imread(agimgfiles{4});
imgaa4=imresize(imgh4,[20 20]);
I4 = flipdim(imgaa4 ,1);
%I4 = imrotate(I4, 180);
imga{4}=I4;
%     imga{4} = imrotate(imgaa4, 180);




set(gca,'YTick',0:15,'YGrid','on',...
    'XTick',0:15,...
    'XGrid','on',...
    'XTickLabel',[],...
    'YTickLabel',[],...
    'PlotBoxAspectRatio',[15 15 10],...
    'GridLineStyle','-',...
    'DataAspectRatio',[1 1 1]);
xlim(gca,[0 15]);ylim(gca,[0 15]);
box(gca,'on');
hold on
[blankx blanky] = find(grid_matrix==0);
[x1 y1] = find(grid_matrix==1);
[x2 y2] = find(grid_matrix==2);
[x3 y3] = find(grid_matrix==3);
[x4 y4] = find(grid_matrix==4);
[x5 y5] = find(grid_matrix==5);
[x6 y6] = find(grid_matrix==6);
[x7 y7] = find(grid_matrix==7);
% [x8 y8] = find(grid_matrix==8);
% [x9 y9] = find(grid_matrix==9);
[x10 y10] = find(grid_matrix==10);
[x11 y11] = find(grid_matrix==11);
[x12 y12] = find(grid_matrix==12);
plot(blankx-0.5,blanky-0.5,'s','MarkerEdgeColor',[0 0 1],'MarkerFaceColor',[0 1 1],'MarkerSize',40);
% if ship_s1_rec_counter<5
    imagesc([x1-1 x1], [y1-1 y1],imgtrg{1});
% else
%     plot(x1-0.5,y1-0.5,'s','MarkerEdgeColor',[0 0 1],'MarkerFaceColor',[0 1 1],'MarkerSize',40);
% end
% if ship_s2_rec_counter<5
    imagesc([x2-1 x2], [y2-1 y2],imgtrg{1});
% else
%     plot(x2-0.5,y2-0.5,'s','MarkerEdgeColor',[0 0 1],'MarkerFaceColor',[0 1 1],'MarkerSize',40);
% end
% if ship_l1_rec_counter<5 || ship_l1_small_rec_counter<5
    imagesc([x3-1 x3], [y3-1 y3],imgtrg{2});
% elseif ship_l1_rec_counter>=5&&ship_l1_small_rec_counter>=5
%     plot(x3-0.5,y3-0.5,'s','MarkerEdgeColor',[0 0 1],'MarkerFaceColor',[0 1 1],'MarkerSize',40);
% end
% if ship_l2_rec_counter<5 || ship_l2_small_rec_counter<5
    imagesc([x4-1 x4], [y4-1 y4],imgtrg{2});
% elseif ship_l2_rec_counter>=5&&ship_l2_small_rec_counter>=5
%     plot(x4-0.5,y4-0.5,'s','MarkerEdgeColor',[0 0 1],'MarkerFaceColor',[0 1 1],'MarkerSize',40);
% end
% if plant1_rec_counter<5
%     if plant1_smp_flag==false
        imagesc([x5-1 x5], [y5-1 y5],imgtrg{3});
%     end
% else
%     plot(x5-0.5,y5-0.5,'s','MarkerEdgeColor',[0 0 1],'MarkerFaceColor',[0 1 1],'MarkerSize',40);
% end
% if plant2_rec_counter<5
%     if plant2_smp_flag==false
        imagesc([x6-1 x6], [y6-1 y6],imgtrg{3});
%     end
% else
%     plot(x6-0.5,y6-0.5,'s','MarkerEdgeColor',[0 0 1],'MarkerFaceColor',[0 1 1],'MarkerSize',40);
% end
% if plant3_rec_counter<5
%     if plant3_smp_flag==false
        imagesc([x7-1 x7], [y7-1 y7],imgtrg{3});
%     end
% else
%     plot(x7-0.5,y7-0.5,'s','MarkerEdgeColor',[0 0 1],'MarkerFaceColor',[0 1 1],'MarkerSize',40);
% end
% if ~smp2_flag
%     imagesc([x8-1 x8], [y8-1 y8],imgtrg{4});
% else
%     plot(x8-0.5,y8-0.5,'s','MarkerEdgeColor',[0 0 1],'MarkerFaceColor',[0 1 1],'MarkerSize',40);
% end
% if ~smp3_flag
%     imagesc([x9-1 x9], [y9-1 y9],imgtrg{4});
% else
%     plot(x9-0.5,y9-0.5,'s','MarkerEdgeColor',[0 0 1],'MarkerFaceColor',[0 1 1],'MarkerSize',40);
% end
% if ~trash1_flag
    imagesc([x10-1 x10], [y10-1 y10],imgtrg{5});
% else
%     plot(x10-0.5,y10-0.5,'s','MarkerEdgeColor',[0 0 1],'MarkerFaceColor',[0 1 1],'MarkerSize',40);
% end
% if ~trash2_flag
    imagesc([x11-1 x11], [y11-1 y11],imgtrg{5});
% else
%     plot(x11-0.5,y11-0.5,'s','MarkerEdgeColor',[0 0 1],'MarkerFaceColor',[0 1 1],'MarkerSize',40);
% end
% if ~trash3_flag
    imagesc([x12-1 x12], [y12-1 y12],imgtrg{5});
% else
%     plot(x12-0.5,y12-0.5,'s','MarkerEdgeColor',[0 0 1],'MarkerFaceColor',[0 1 1],'MarkerSize',40);
% end


% if fish1_rec_counter<5
    imagesc([xf1-0.25 xf1-0.75], [yf1-0.25 yf1-0.75],imgtrg{7});
% end
% if fish2_rec_counter<5
     imagesc([xf2-0.25 xf2-0.75], [yf2-0.25 yf2-0.75],imgtrg{8});
% end
imagesc([xag1-0.5 xag1], [yag1-0.5 yag1],imga{1});
imagesc([xag2-1 xag2-0.5], [yag2-1 yag2-0.5],imga{2});
imagesc([xag3-1 xag3-0.5], [yag3-0.5 yag3],imga{3});
imagesc([xag4-0.5 xag4], [yag4-1 yag4-0.5],imga{4});
end

