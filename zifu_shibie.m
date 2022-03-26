function bb =zifu_shibie(image)
    liccode=char(['0':'9' 'A':'Z' '贵鄂桂京鲁陕苏渝豫粤']); %建立自动识别字符代码表 
    len = size(image,2);
    %% 
    
    for ii=1:len
        tu = double(cell2mat(image{ii}));
        if ii==1                 %第一位汉字识别
            kmin=37;
            kmax=46;
        elseif ii==2             %第二位 A~Z 字母识别
            kmin=11;
            kmax=36;
        elseif ii>=3
            kmin=1;
            kmax=36; 
        end
         k = 1;
        for k1 = kmin:kmax
            k2 = k1-kmin+1;
            fname=strcat('字符模板\',liccode(k1),'.bmp');
            picture = imread(fname);%读取模板
            bw(:,:,k2) = imresize(im2bw(picture,graythresh(rgb2gray(picture))),[110 55],'bilinear');
            baifenbi(1,k)=corr2(tu,bw(:,:,k2));%计算字符与模板的相关性

            k = k+1;
        end
        chepai= find(baifenbi>=max(baifenbi));%取相关性最大字符作为识别结果
        jj =kmin+chepai-1;
        bb(ii) =' ';
        bb(ii)  = liccode(jj);
    end
end
% figure('NumberTitle','off','Name','车牌号码'),title (['识别车牌号码:', bb],'Color','r');