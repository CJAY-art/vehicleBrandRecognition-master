function bw =location(img)  %图像分割
    grayimg = rgb2gray(img);
    figure(2);imshow(grayimg);title("灰度图像");

    H = fspecial('gaussian',5,3);  % 高斯模糊
    blurred = imfilter(grayimg,H,'replicate'); 
    figure(3); imshow(blurred);title("高斯模糊");

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%% 2.垂直边缘检测和形态学处理
    bw = edge(blurred,'sobel','vertical'); 
    figure(4); imshow(bw);title("边缘图像");  % 垂直边缘检测

    se1 = strel('rectangle',[30,18]);
    bw_close=imclose(bw,se1);
    figure(5);imshow(bw_close);title("闭操作");  

    se2 = strel('rectangle',[21,19]);
    bw_open = imopen(bw_close, se2);
    figure(6);imshow(bw_open);title("开操作");

    bw_close = bwareaopen(bw_open,2500);  % 移除小对象
    figure(7);imshow(bw_close);title("去除噪声");

    se3 = strel('rectangle',[25,17]);
    bw_dilate = imdilate(bw_close,se3);
    figure(8);imshow(bw_dilate);title("膨胀操作");

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%% 3.取车牌候选区域并基于混合特征精确定位出车牌区域
    stats = regionprops(bw_dilate,'BoundingBox','Centroid');
    L = length(stats);
    figure(9);imshow(img);hold on
    for i=1:L
        rectangle('Position', stats(i).BoundingBox,'EdgeColor','red'); 
    end
    fprintf("车牌候选区域的数量:%d \n", L);
    
    judge=JudgeFun;
    
    index_area = judge.area(stats);
    index_color = judge.color(stats,img);
    index_ratio = judge.ratio(stats);

    index1 = intersect(index_area,index_color);
    index = intersect(index1, index_ratio);
    bb = stats(index).BoundingBox; 
    I=img(floor(bb(2))+1:floor(bb(2)+bb(4)),floor(bb(1))+1:floor(bb(1)+bb(3)),:);
    figure(9);imshow(I); title("车牌")
    bw=I;