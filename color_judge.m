function index = color_judge(stats,img)
j = 1; 
for i=1:length(stats)
    bb = stats(i).BoundingBox;  % 取预判断的区域
    I=img(floor(bb(2))+1:floor(bb(2)+bb(4)),floor(bb(1))+1:floor(bb(1)+bb(3)),:);
%     figure(8); imshow(I);
    hsv = rgb2hsv(I);
    [height,width,~] = size(hsv);
    count = 0;  % 统计蓝色像素值的数量
    for h=1:height
        for w=1:width
            h_judge = (hsv(h,w,1)>0.55) && (hsv(h,w,1)<0.73);
%             s_judge = (hsv(h,w,2)>0.05)  && (hsv(h,w,2)<0.7);
%             v_judge = (hsv(h,w,3)>0.2) && (hsv(h,w,3)<0.7);
            if h_judge
                count = count + 1;
            end
        end
    end
    pixel_sum = width*height;
    if count>0.6*pixel_sum
        index(j) = i;
        j = j+1;
    end
end