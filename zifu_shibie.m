function bb =zifu_shibie(image)
    liccode=char(['0':'9' 'A':'Z' '�����³������ԥ��']); %�����Զ�ʶ���ַ������ 
    len = size(image,2);
    %% 
    
    for ii=1:len
        tu = double(cell2mat(image{ii}));
        if ii==1                 %��һλ����ʶ��
            kmin=37;
            kmax=46;
        elseif ii==2             %�ڶ�λ A~Z ��ĸʶ��
            kmin=11;
            kmax=36;
        elseif ii>=3
            kmin=1;
            kmax=36; 
        end
         k = 1;
        for k1 = kmin:kmax
            k2 = k1-kmin+1;
            fname=strcat('�ַ�ģ��\',liccode(k1),'.bmp');
            picture = imread(fname);%��ȡģ��
            bw(:,:,k2) = imresize(im2bw(picture,graythresh(rgb2gray(picture))),[110 55],'bilinear');
            baifenbi(1,k)=corr2(tu,bw(:,:,k2));%�����ַ���ģ��������

            k = k+1;
        end
        chepai= find(baifenbi>=max(baifenbi));%ȡ���������ַ���Ϊʶ����
        jj =kmin+chepai-1;
        bb(ii) =' ';
        bb(ii)  = liccode(jj);
    end
end
% figure('NumberTitle','off','Name','���ƺ���'),title (['ʶ���ƺ���:', bb],'Color','r');