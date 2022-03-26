function bw =image_segmentation1(I)  %图像分割
img=I;
I1=im2double(I);
I2 = im2bw(I,graythresh(I)); %二值化
I=rgb2hsv(I1);       %RGB模型转换hsv模型
[y,x,z]=size(I);        %返回RGB彩色图像数据矩阵大小信息
p=[0.56 0.71 0.4 1 0.3 1 0];  
for i = 1 : y  
    for j = 1 : x  
        hij = I(i, j, 1);  
        sij = I(i, j, 2);  
        vij = I(i, j, 3);  
        if (hij>=p(1) && hij<=p(2)) &&( sij >=p(3)&& sij<=p(4))&&...  
                (vij>=p(5)&&vij<=p(6))  
            I2(i,j)=1;%蓝色区域提取五45
        else
            I2(i,j)=0;
        end  
    end  
end  

figure(1);
imshow(I2);title("颜色分割");
 
bw_b = bwareaopen(I2,500);  % 移除小对象
figure(2);imshow(bw_b);title("去除噪声");
 
se3 = strel('rectangle',[10,30]);
bw_dilate = imdilate(bw_b,se3);
figure(3);imshow(bw_dilate);title("膨胀操作");

stats = regionprops(bw_dilate,'BoundingBox','Centroid');%矩形区域提取
figure(10)
imshow(img)
hold on
L = length(stats);
for i=1:L
    rectangle('Position',stats(i).BoundingBox,'LineWidth',1,'EdgeColor','r');
end
fprintf("初步提取车牌候选区域的数量:%d \n", L);
hold off
try
    index = ratio_judge(stats);%区域筛选
catch
    %仅利用颜色特征提取失败，则再利用边缘信息进行定位
    gray = rgb2gray(img);
    bw = edge(gray,'sobel','vertical'); % 垂直边缘检测
    figure(4); imshow(bw);title("垂直边缘图像(sobel)");  

    se1 = strel('rectangle',[10,30]);
    bw_close=imclose(bw,se1);
    figure(5);imshow(bw_close);title("闭操作");  

    se2 = strel('rectangle',[10,30]);
    bw_open = imopen(bw_close, se2);
    figure(6);imshow(bw_open);title("开操作");
    
    bw_b = bwareaopen(bw_open,1000); 
    figure(7);imshow(bw_b);title("去除噪声");
 
    se3 = strel('rectangle',[10,30]);
    bw_dilate = imdilate(bw_b,se3);
    figure(8);imshow(bw_dilate);title("膨胀操作");
    
    stats = regionprops(bw_dilate,'BoundingBox','Centroid');
    L = length(stats);
    figure(10)
    imshow(img)
    hold on
    for i=1:L
    rectangle('Position',stats(i).BoundingBox,'LineWidth',1,'EdgeColor','r');
    end
    fprintf("二次提取车牌候选区域的数量:%d \n", L);
    index1 = ratio_judge(stats);%区域筛选(考虑尺寸和颜色）
    index2=color_judge(stats,img);
    index = intersect(index1, index2);
    hold off
end

bb = stats(index).BoundingBox; 
plate=img(floor(bb(2))+1:floor(bb(2)+bb(4)),floor(bb(1))+1:floor(bb(1)+bb(3)),:);%提取判定得到的最终车牌区域
figure(9);imshow(plate); title("车牌")
bw=plate;