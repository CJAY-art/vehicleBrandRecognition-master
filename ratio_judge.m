function index = ratio_judge(stats)
    j = 1;
    for i=1:length(stats)
        bb = stats(i).BoundingBox;
        r = bb(3)/bb(4); 
        ratio_std = 440/140;
        if (r>ratio_std-1.1) && (r<ratio_std+2)
            index(j)=i;
            j = j+1;
        end
    end
end