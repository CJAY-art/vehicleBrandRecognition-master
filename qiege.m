function image=qiege(bw) 
    [y,x] = size(bw);
%     figure(12);
%     imshow(bw);
%     bw(:,x)=1;
%     bw(:,1)=1;
    %垂直投影
    a = sum(bw);
    figure('NumberTitle','off','Name','投影'),bar(a),title('垂直投影');
    j = 1;
    jj = 1;
    m =0;
    %遍历列，提取独立的区域（字符）
    for i = 1:x-1
        if a(i)==0&&a(i+1)~=0
            j = i;
        end
        if a(i)~=0&&a(i+1)==0
            kk=i;
        else
            kk =0;
        end
        if kk~=0
            m = m+1;
            p(m) = j;
            q(m) = kk;
        else   
            if i==x-1
                m = m+1;
                p(m) = j;
                q(m) = x;
            end   
        end
    end
    for i = 1:m
        if p(i)<fix(x/8)
            p(i)=p(1);
        end
    end
    k =1;
    for i = 1:m
        if (q(i) - p(i))>(fix(x/10))
            gg(k) = q(i);
            ggg(k) = p(i);
            k = k+1;
        else 
            if i~=1&&i~=m
                gg(k)=p(i+1)-10;
                ggg(k)=q(i-1)+10;
                k=k+1;
            end
        end   
    end
% 
    figure('NumberTitle','off','Name','字符分割'),
    k =1;
    p = zeros(110,55);
    image = {};
    len = size(gg,2);
    for ii = 1:len
        image={image,p};
    end
    for ii = 1:len
        p = ~imresize(bw(:,ggg(ii):gg(ii)), [110 55],'bilinear');%对提取的字符规格化（双线性插值）
        image{ii} = mat2cell(p,[110 0],[55 0]);
        obj = subplot(1,7,ii); imshow(p),title(obj,ii);pause(0.5);
        k = k +1;
    end
end