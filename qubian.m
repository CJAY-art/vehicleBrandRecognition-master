function image=qubian(bw)
    I = rgb2gray(bw);
    I1 = imbinarize(I);
    I2 = bwareaopen(I1,50);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%% 2.水平和垂直投影(去掉车牌以外的区域)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    I3=remove_extra_region(I2);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%% 3.去掉上下边框和铆钉（统计跳变次数）
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% 定位行的起始位置(从1/3处先上扫描行)
    %%% 定位行的结束位置(从2/3处先下扫描行)
    diff_row = diff(I3,1,2);  % 前一列减后一列
    diff_row_sum = sum(abs(diff_row), 2);  
    [rows, columns] = size(I3);
    trows = ceil(rows*(1/3));
    j = trows;
    for i=1:trows
        if diff_row_sum(j,1)<10
            plate.rowa = j;
            break;
        end
        j = trows-i;
    end

    for i=2*trows:size(diff_row_sum,1)
        if diff_row_sum(i,1)<10
            plate.rowb = i;
            break;
        end
    end
    I4 = I3(plate.rowa:plate.rowb, :);
    I4=remove_extra_region(I4);
    figure(10);
    imshow(I4);title('去除上下边框/铆钉');
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%% 4.去除左右边框（投影法）
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    plate_projection_v = sum(I4,1);
    for i=1:size(plate_projection_v, 2)
        if plate_projection_v(1,i) == 0
            plate.cola = i;
            break;
        end
    end

    for i=1:size(plate_projection_v, 2)
        j = size(plate_projection_v, 2) - i + 1;
        if plate_projection_v(1,j) == 0
            plate.colb = j;
            break;
        end
    end
    I5 = I4(:,plate.cola:plate.colb);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%% 5.去除字符左右背景（投影法）
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    ppv1 = sum(I5,1);
    for i=1:size(ppv1, 2)
        if ppv1(1,i) ~= 0
            pl.cola = i;
            break;
        end
    end

    for i=1:size(ppv1, 2)
        j = size(ppv1, 2) - i + 1;
        if ppv1(1,j) ~= 0
            pl.colb = j;
            break;
        end
    end
    I6 = I5(:,pl.cola:pl.colb);
    I6 = bwareaopen(I6,100);
    figure(11);
    imshow(I6);title('去除左右边框');
    image=I6;
end