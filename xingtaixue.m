function picture_6 = xingtaixue(picture_1)
    picture_2 = im2bw(picture_1,graythresh(picture_1)); %最大类间方差法 图像二值化
%     figure('NumberTitle','off','Name','车牌二值化'),imshow(picture_2);title('二值化');
    picture_2 = imresize(picture_2, [140,440],'bilinear');
    imshow(picture_2)
    threshold=50;
    
%     picture_3 = bwmorph(picture_2,'hbreak',inf); %对二值图像的形态学操作 移除H连通的像素
%     picture_4 = bwmorph(picture_3,'spur',inf);
%     [y1,x1,z1]=size(picture_4);
%     I3=picture_4;
%     %%%%%%%去除上下边框%%%%%
%     %% 
%     
%     Y1=zeros(y1,1);
%      for i=1:y1
%         for j=1:x1
%                  if(I3(i,j,1)==1) 
%                     Y1(i,1)= Y1(i,1)+1 ;
%                 end  
%          end       
%      end
%     mid=round(y1/2);
%     r1=mid;r2=mid;
% 
%     while ((Y1(r1,1)>=threshold)&&(r1<y1))
%           r1=r1-1;
%     end
%     while((Y1(r2,1)>=threshold)&&(r2<y1))
%              r2=r2+1;
%     end
%     
%     I3=picture_4(r1:r2,:); %得到去除上下边框的区域
%     [y1,x1,z1]=size(I3);
%     %% 
%     X1=zeros(x1,1);
%     for i=1:x1
%         for j=1:y1
%                  if(I3(j,i,1)==1) 
%                     X1(i,1)= X1(i,1)+1 ;
%                 end  
%          end       
%     end
%     H1=1;
%     while ((X1(H1,1)==0)&&(r1<y1))
%           H1=H1+1;
%     end
%     H2=H1;
%     while ((X1(H2,1)>threshold)&&(r1<y1))
%           H2=H2+1;
%     end
%     
%     if H2-H1>fix(x1/8)
%         H2=H1;
%     end
%     L1=x1;
%     while ((X1(H1,1)==0)&&(r1<y1))
%           L1=L1-1;
%     end
%     L2=L1;
%     while ((X1(H2,1)>threshold)&&(r1<y1))
%           L2=L2-1;
%     end
%     if L1-L2>fix(x1/8)
%         L2=L1;
%     end
%     %% 
%     picture_5=I3(:,H2:L2); %得到去除左右边框的区域
%     picture_6 = ~picture_5;
% end
    picture_3 = bwmorph(picture_2,'hbreak',inf); %对二值图像的形态学操作 移除H连通的像素
    picture_4 = bwmorph(picture_3,'spur',inf);
    picture_5 = bwmorph(picture_4,'open',inf);
    picture_6 = bwareaopen(picture_5,threshold);
    picture_6 = ~picture_6;
end
% figure('NumberTitle','off','Name','形态学操作'),imshow(picture_6);title('形态学操作'); 