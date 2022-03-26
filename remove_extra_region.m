function I=remove_extra_region(I2)
    projection_h = sum(I2,1);
    projection_v = sum(I2,2);
    for i=1:size(projection_v,1)
        if projection_v(i,1) >= 1
            new.rowa = i;
            break;
        end
    end

    for i=1:size(projection_v,1)
        j = size(projection_v,1) - i+1;
        if projection_v(j,1) >= 1
            new.rowb = j;
            break;
        end
    end

    for i=1:size(projection_h ,2)
        if projection_h(1,i) >= 1
            new.cola = i;
            break;
        end
    end

    for i=1:size(projection_h ,2)
        j = size(projection_h ,2)-i+1;
        if projection_h(1,j) >= 1
            new.colb = j;
            break;
        end
    end
    I = I2(new.rowa:new.rowb, new.cola:new.colb);
end