function bw = caijian(picture_6)
threshold =50 ;

picture_7=touying(picture_6);
picture_8=~picture_7;
picture_9 = bwareaopen(picture_8, threshold);
picture_10=~picture_9;
[y,x]=size(picture_10);%�Գ������¸�ֵ%1Ϊ��ɫ
bw = picture_10;
[y,x] = size(bw);
dd = fix(x/40);
ddd = fix(x/30);
dd = x - dd;
bw = bw(:,ddd:dd);
% figure('NumberTitle','off','Name','�߿�ȥ��'),imshow(bw),title('�߿�ȥ��');  